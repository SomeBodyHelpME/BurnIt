//
//  AcceptedTaskMap.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 7. 2..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces


/*수행중인 의뢰, 지도에 찍어주고
 전화, 메세지, 취소
 */
class AcceptedTaskMap : UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate{
    
    //outlets
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var cancelTask: UIButton!
    @IBOutlet weak var completeTask: UIBarButtonItem!
    
    @IBOutlet weak var clientName: UILabel!
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var taskType: UILabel!
    
    @IBOutlet weak var taskFee: UILabel!
    
    
    
    
    
    
    
    //actions
    @IBAction func completeTask(_ sender: Any) {
    }
    
    //세그에다 이름 붙여서 그때 data 넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "rate"{
            
            let detailVC = segue.destination as! StarRatePopUp
            detailVC.task = task
            
        }
    }
    
    
    @IBAction func cancelTask(_ sender: Any) {
        let alert = UIAlertController(title: "수행을 취소하시겠습니까?", message: "", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            (_)in
            self.performSegue(withIdentifier: "unwindToMain", sender: self)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        
        
        alert.addAction(cancelAction)
        alert.addAction(OKAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //variables
    var task : SpecificVO?

    
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
    
    
    
    var locationManager = CLLocationManager()

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.googleMapsView.delegate = self
        self.navigationItem.hidesBackButton = true
       
        
        //지워주고 시작
        googleMapsView.clear()
    
        let camera = GMSCameraPosition.camera(withLatitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude, zoom: 15.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
        //목적지 마커
        //변수로.. 윈도우 확인하려고?
        createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "mini_pin"), latitude: current_location.coordinate.latitude, longitude: current_location.coordinate.longitude)
        
        createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "mini_pin"), latitude: destination.coordinate.latitude, longitude: destination.coordinate.longitude)
        
        //내위치에서 목적지까지 direction
        drawLine(startLocation: current_location, endLocation: destination)
        
        
        taskType.text = task?.task_type!
        taskFee.text = "\(gino(task?.cost))원"
        
        
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



