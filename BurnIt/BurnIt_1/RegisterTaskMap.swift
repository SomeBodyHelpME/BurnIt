//
//  RegisterTaskMap.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 4..
//  Copyright © 2017년 김혜민. All rights reserved.
//
import UIKit
import GoogleMaps
import GooglePlaces

/*
 의뢰 출발지,목적지 화면전환할때 받아서 루트 그려주고
 상세정보 입력 창
 */
class RegisterTaskMap : UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate{
    
    //outlets
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var inputDetail: UIBarButtonItem!
    @IBOutlet weak var back: UIBarButtonItem!
    @IBOutlet weak var dest: UILabel!
    @IBOutlet weak var work: UILabel!
    
    
    
    //actions
    @IBAction func inputDetail(_ sender: Any) {
        
    }
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerDetail"{
            
            let navController = segue.destination as! UINavigationController
            let detailVC = navController.topViewController as! RegisterTaskDetails
            detailVC.locationStart = locationStart
            detailVC.locationEnd = locationEnd
            detailVC.startPlace = startPlace
            detailVC.endPlace = endPlace
            
        }
    }

    
    
    var locationManager = CLLocationManager()
    
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    //어딘지 찍어주려고 Place
    var startPlace : String?
    var endPlace : String?

    /*
     //나중에 서버에서 위도, 경도 받아서 location 저장
     //의뢰 출발지
     var current_location = CLLocation()
     //의뢰 도착지
     var destination = CLLocation()
     */
    
    //서울로 테스트
    /*var current_location = CLLocation.init(latitude: 37.556471, longitude: 126.970889)
    var destination = CLLocation.init(latitude: 37.556471, longitude: 126.982734)
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.googleMapsView.delegate = self
        
        self.navigationItem.hidesBackButton = true
        
        //navigation bar 색깔지정
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        
        dest.text = startPlace
        work.text = endPlace
        
            
        //navigation tab으로 처리함
        //버튼이 위로 오도록
        self.view.insertSubview(googleMapsView, at: 0)
        
        //지워주고 시작
        googleMapsView.clear()
        
        let camera = GMSCameraPosition.camera(withLatitude: locationEnd.coordinate.latitude, longitude: locationEnd.coordinate.longitude, zoom: 15.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
        
        //목적지 마커
        createMarker(titleMarker: startPlace!, iconMarker: #imageLiteral(resourceName: "mini_pin"), latitude: locationStart.coordinate.latitude, longitude: locationStart.coordinate.longitude)
        
        createMarker(titleMarker: endPlace!, iconMarker: #imageLiteral(resourceName: "doing_orange_pin"), latitude: locationEnd.coordinate.latitude, longitude: locationEnd.coordinate.longitude)
        
        //내위치에서 목적지까지 direction
        drawLine(startLocation: locationStart, endLocation: locationEnd)
        
    }
    
    //마커 그리는 함수 createMarker
    //마커 리턴하는 함수?
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = googleMapsView
        
    }
    
    
    func drawLine(startLocation : CLLocation, endLocation : CLLocation){
        let path = GMSMutablePath()
        path.addLatitude(startLocation.coordinate.latitude, longitude:startLocation.coordinate.longitude)
        path.addLatitude(endLocation.coordinate.latitude, longitude:endLocation.coordinate.longitude)
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = UIColor.orange
        polyline.geodesic = true
        polyline.map = googleMapsView
    }

    
}
