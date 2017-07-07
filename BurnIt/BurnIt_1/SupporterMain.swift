//
//  Start_current_loc.swift
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
 일단 */

enum Location {
    case startLocation
    case destinationLocation
}


class SupporterMain: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, GMSAutocompleteViewControllerDelegate, NetworkCallback {
    //아이디 가져오기
    let user_id = UserDefaults.standard.string(forKey: "user_id")!
    
    //햄버거
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
    //햄버거 여기까지
    
    
    //outlets
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var openDestinationLocation: UIButton!
    @IBOutlet weak var openStartLocation: UIButton!
    
    //결과 버튼
    @IBOutlet weak var showTasks: UIButton!
    
    //내 위치 버튼 custom
    @IBOutlet weak var myLocation: UIBarButtonItem!
    @IBOutlet weak var startLocation: UITextField!
    @IBOutlet weak var endLocation: UITextField!
    @IBOutlet weak var changeToClient: UIButton!
    
    @IBOutlet weak var search1: UIImageView!
    @IBOutlet weak var search2: UIImageView!
    
    //variables
    var locationManager = CLLocationManager()
    
    var locationSelected = Location.startLocation
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    

    var taskList : [SpecificVO] = [SpecificVO]()

    
    //현재 위치 받아둬야 해
    //화면 넘어갈라고 목적지 저장해놔야돼
    //var startLocation = CLLocation()
    //목적지도 location 타입이야 이제!!
    //drawpath 하고 create marker도 바꿔둬야해
    //var endLocation = CLLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //햄버거 메뉴 animate
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 0
        //
        
        
        //connect action
       // showTasks.addTarget(self, action: #selector(findTasks(_:)), for: UIControlEvents.touchDown)
        
        
        //navigation bar 앞으로 계속 검정
        //수행인
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black

        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        self.googleMapsView.delegate = self
        self.googleMapsView.isMyLocationEnabled = true
       
        
        self.view.insertSubview(googleMapsView, at: 0)
        self.view.insertSubview(search1, at: 1)
        self.view.insertSubview(search2, at: 1)

    
    }
    
    
    //마커 그리는 함수 createMarker
    /*func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMapsView
        
    }*/
    
    //CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while get location \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        //현재 위치 가져갈 변수에다 저장
        //혹시 모르니까 변수 따로..crash 안나면 나중에 통합
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
        } else {
            endLocation.text = "\(place.name)"
            locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
        
       /* //서버에서 데이터 미리 받아와
        let model = Model(self)
        //locationStart locationEnd
        model.postCoordinates(workplace_lat: locationEnd.coordinate.latitude, workplace_long: locationEnd.coordinate.longitude, home_lat: locationStart.coordinate.latitude, home_long: locationStart.coordinate.longitude)
        
        */
        
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
    
    
    //extended NetworkCallback
    //implement needed
    //버튼 코드로 액션 추가해줘
    func networkResult(resultData: Any, code: String) {
        if code == "2-1"{
            taskList = resultData as! [SpecificVO]
           
            //view controller 넘기기
            //push
            if let supporterTasks = storyboard?.instantiateViewController(withIdentifier: "SupporterTasks") as? SupporterTasks {
                supporterTasks.taskList = taskList
                supporterTasks.locationStart = locationStart
                supporterTasks.locationEnd = locationEnd
                navigationController?.pushViewController(supporterTasks, animated: true)
            }
        }
    }
    
/*
    func findTasks(_ sender: UIButton){
        if let supporterTasks = storyboard?.instantiateViewController(withIdentifier: "SupporterTasks") as? SupporterTasks {
            
            
            
            //다음 뷰에 데이터 넘기기
            supporterTasks.taskList = taskList
            supporterTasks.locationStart = locationStart
            supporterTasks.locationEnd = locationEnd
            print(taskList)
            
            navigationController?.pushViewController(supporterTasks, animated: true)
            
        }
    }*/

    


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
            //서버 연결
            let model = Model(self)
            //locationStart locationEnd
        model.postCoordinates(workplace_lat: locationEnd.coordinate.latitude, workplace_long: locationEnd.coordinate.longitude, home_lat: locationStart.coordinate.latitude, home_long: locationStart.coordinate.longitude, user_id:user_id)
 
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
    
    
    
    @IBAction func changeToClient(_ sender: Any) {
        leadingConstraint.constant = -280
        UIView.animate(withDuration: 0.3, animations: {self.view.layoutIfNeeded()})
        
        if let clientMain = storyboard?.instantiateViewController(withIdentifier: "ClientMain") as? ClientMain {
            
            //전환하면서 데이터 넘겨줘
            UserDefaults.standard.set("client", forKey: "user_role")

            navigationController?.pushViewController(clientMain, animated: false)
        }

    }
    
    //돌아오기 위한 함수
    @IBAction func unwindToMain(_ sender: UIStoryboardSegue){
    }

    
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
