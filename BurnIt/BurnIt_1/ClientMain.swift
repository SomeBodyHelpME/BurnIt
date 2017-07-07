//
//  ClientMain.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 6. 28..
//  Copyright © 2017년 김혜민. All rights reserved.
//
//
import UIKit
import GoogleMaps
import GooglePlaces

/*첫 화면.
 내 개인정보를 햄버거로 띄우고
 내 위치 버튼이 오른쪽 상단에 위치
 '수행할 목적지를 입력해주세요.'를 누르면 검색 창 뜨고 검색까지
 */

class ClientMain: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate {
    
    var menuShowing = false
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var openMenu: UIBarButtonItem!
    @IBAction func openMenu(_ sender: UIBarButtonItem) {
        if(menuShowing){
            leadingConstraint.constant = -280
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
            
        }else{
            leadingConstraint.constant = 0
            UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        }
        menuShowing = !menuShowing
    }
    
    
    //outlets
    @IBOutlet weak var search1: UIImageView!
    @IBOutlet weak var search2: UIImageView!
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var openDestinationLocation: UIButton!
    @IBOutlet weak var openStartLocation: UIButton!
    @IBOutlet weak var myLocation: UIBarButtonItem!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var endLocation: UITextField!
    @IBOutlet weak var showTasks: UIButton!
    
    @IBOutlet weak var changeToSupporter: UIButton!
    
    
    
    //variables
    var locationManager = CLLocationManager()
    
    var locationSelected = Location.startLocation
   
    //위치
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    //이름 받을라고
    var startPlace : String?
    var endPlace : String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //햄버거 메뉴 animate
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 0
        //
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
        
        
        //지도 위로 보이도록 설정
        self.view.insertSubview(googleMapsView, at: 0)
        self.view.insertSubview(search1, at: 1)
        self.view.insertSubview(search2, at: 1)
        
        
    }
    
    
        //CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        //출발지 현재위치로 initialize
        locationStart = locations.last!
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 10.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapsView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.googleMapsView.isMyLocationEnabled = true
        if(gesture){
            mapView.selectedMarker = nil
        }
    }
    
    
    //google auto complete
    //여기서 어떤 오토가 눌렷는지 판별해서 그에 맞게 작동
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Change map location
        let camera = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 16.0
        )

        // 어떤게 선택되었는지 보고 그 위치 받아서 location으로 저장
        if locationSelected == .startLocation {
            startLocation.text = "\(place.name)"
            locationStart = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            startPlace = place.name
        } else {
            endLocation.text = "\(place.name)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            endPlace = place.name
        }
        
        self.googleMapsView.camera = camera
        self.dismiss(animated: true, completion: nil)//dismiss after selecting
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("ERROR AUTO COMPLETE \(error)")
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.dismiss(animated: true, completion: nil)//when cancel search
    }
    
    
    //button Version
    //이게 뭔지 모르겟네
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
    //actions
    // MARK: when start location tap, this will open the search location
    @IBAction func openStartLocation(_ sender: UIButton) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.stopUpdatingLocation()
        
        // selected location
        locationSelected = .startLocation
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    
    // MARK: when destination location tap, this will open the search location
    @IBAction func openDestinationLocation(_ sender: UIButton) {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        
        self.locationManager.stopUpdatingLocation()
        
        // selected location
        locationSelected = .destinationLocation
        
        self.present(autoCompleteController, animated: true, completion: nil)
    }
    
    
    //의뢰 보이기 누르면 showTask
    @IBAction func showTask(_ sender: Any) {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRegisterMap" {
            let sdvc = segue.destination as! RegisterTaskMap
            
            sdvc.startPlace = startPlace
            sdvc.endPlace = endPlace
            sdvc.locationStart = locationStart
            sdvc.locationEnd = locationEnd
        }
    }
    
    
    
    @IBAction func myLocation(_ sender: UIBarButtonItem)
    {
        guard let lat = self.googleMapsView.myLocation?.coordinate.latitude,
            let lng = self.googleMapsView.myLocation?.coordinate.longitude else { return }
        
        //내 위치 누르면 startlocation 내 위치로
        locationStart = self.googleMapsView.myLocation!
        startLocation.text = "내 위치"
        
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 10.0)
        self.googleMapsView.animate(to: camera)
    }
    
    
    
    @IBAction func changeToSupporter(_ sender: Any) {
        leadingConstraint.constant = -280
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        
        if let supporterMain = storyboard?.instantiateViewController(withIdentifier: "SupporterMain") as? SupporterMain {
            
            //전환하면서 데이터 넘기고 전환
            UserDefaults.standard.set("helper", forKey: "user_role")

            
            navigationController?.pushViewController(supporterMain, animated: false)
        }

    }
    
    
    //돌아오기 위한 함수
    @IBAction func unwindToClient(_ sender: UIStoryboardSegue){
        
    }

    
}
