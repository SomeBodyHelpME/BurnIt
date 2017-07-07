//
//  TaskDetails.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 2..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

//direction 그리는거 때문에 import
//import SwiftyJSON
//import Alamofire



/*서버에서 받아온 의뢰 출발지,목적지 화면전환할때 받아서 루트 그려주고
 아래 상세정보 보여줘
 */
class AcceptedTaskMap2 : UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate{
    
    //outlets
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var cancelTask: UIButton!
    
    
    //action
    @IBAction func cancelTask(_ sender: Any) {
        let alert = UIAlertController(title: "수행을 취소하시겠습니까?", message: "", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            (_)in
            self.performSegue(withIdentifier: "unwindToClient", sender: self)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        
        
        alert.addAction(cancelAction)
        alert.addAction(OKAction)
        
        self.present(alert, animated: true, completion: nil)

    }
    
    
    
    var locationManager = CLLocationManager()
    
    /*
     //나중에 서버에서 위도, 경도 받아서 location 저장
     //의뢰 출발지
     var current_location = CLLocation()
     //의뢰 도착지
     var destination = CLLocation()
     */
    
    //서울로 테스트
    var current_location = CLLocation.init(latitude: 37.556471, longitude: 126.970889)
    var destination = CLLocation.init(latitude: 37.556471, longitude: 126.982734)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.googleMapsView.delegate = self
        
        //navigation tab으로 처리함
        //버튼이 위로 오도록
        self.view.insertSubview(googleMapsView, at: 0)
        //self.view.insertSubview(closeDetail, at: 1)
        
        //지워주고 시작
        googleMapsView.clear()
        
        let camera = GMSCameraPosition.camera(withLatitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude, zoom: 15.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
        
        //목적지 마커
        createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "mini_pin"), latitude: current_location.coordinate.latitude, longitude: current_location.coordinate.longitude)
        
        createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "mini_pin"), latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
        
        //내위치에서 목적지까지 direction
        drawLine(startLocation: current_location, endLocation: destination)
        
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



