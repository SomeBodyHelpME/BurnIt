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
import Cosmos

/*서버에서 받아온 의뢰 출발지,목적지 화면전환할때 받아서 루트 그려주고
 아래 상세정보 보여줘
 */
class TaskDetails : UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate, NetworkCallback{
   
    //outlets
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var acceptTask: UIButton!
    @IBOutlet weak var closeDetail: UIBarButtonItem!
    @IBOutlet weak var taskType: UILabel!
    @IBOutlet weak var taskFee: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    
    @IBOutlet weak var taskContents: UITextView!
    @IBOutlet weak var cosmosview: CosmosView!
    
    let user_id = UserDefaults.standard.string(forKey: "user_id")
    
    //action
    @IBAction func closeDetail(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptTask(_ sender: UIButton) {
        //여기서 의뢰인이랑 매칭되어야
        //매칭하고 이름 넘겨주기
        let model = Model(self)
        
        let taskIndex = task?.task_idx
        model.putTaskMatch(task_idx: taskIndex!, user_id: user_id!)
        
    }

    func networkResult(resultData: Any, code: String) {
        if let taskAccepted = storyboard?.instantiateViewController(withIdentifier: "TaskAccepted") as? TaskAccepted {
            navigationController?.pushViewController(taskAccepted, animated: true)
        }

    }
    
    
    
    var locationManager = CLLocationManager()
    //이전 뷰에서 받아올 애
    var task : SpecificVO?
    var type : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //별점
        cosmosview.rating = 4
        cosmosview.settings.fillMode = .half
        cosmosview.settings.starSize = 13
        cosmosview.settings.starMargin = 2.5
        
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        
        
        self.googleMapsView.delegate = self
        
        //navigation tab으로 처리함
        //버튼이 위로 오도록
        self.view.insertSubview(googleMapsView, at: 0)
        //self.view.insertSubview(closeDetail, at: 1)
        
        //서버에서 위도, 경도 받아서 location 저장
        //의뢰 출발지
        let homeLocation = CLLocation.init(latitude: gdno(task?.home_lat), longitude: gdno(task?.home_long))
        let homePlace = gsno(task?.home_name)
        
        //의뢰 도착지
        let workLocation = CLLocation.init(latitude: gdno(task?.workplace_lat), longitude: gdno(task?.workplace_long))
        let workPlace = gsno(task?.workplace_name)
        
        
        //지워주고 시작
        googleMapsView.clear()
        
        let camera = GMSCameraPosition.camera(withLatitude: workLocation.coordinate.latitude, longitude: workLocation.coordinate.longitude, zoom: 16.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
        //의뢰 출발, 목적지
        createMarker(titleMarker: homePlace, iconMarker: #imageLiteral(resourceName: "mini_pin"), latitude: homeLocation.coordinate.latitude, longitude: homeLocation.coordinate.longitude)
        
        createMarker(titleMarker: workPlace, iconMarker: #imageLiteral(resourceName: "doing_orange_pin"), latitude: workLocation.coordinate.latitude, longitude: workLocation.coordinate.longitude)
        
        //내위치에서 목적지까지 line
        drawLine(startLocation: homeLocation, endLocation: workLocation)
        
        
        
        
        //label 채우기
        switch task?.task_type {
        case "D"?:
            type = "배달"
        case "C"?:
            type = "청소"
        case "A"?:
            type = "동행"
        case "L"?:
            type = "줄서주기"
        case "P"?:
            type = "반려동물"
        case "E"?:
            type = "기타"
        default: break
        }
        //아래 상세정보 띄우기
        //빈칸 없어야 돼
        taskType.text = type
        
        let fee = "\((task?.cost)!)"
        let rating = (gdno(task?.star))
        let due = (task?.deadline!)!
        let content = (task?.details!)!
        
        taskFee.text = fee
        cosmosview.rating = rating
        dueDate.text = due
        taskContents.text = content
        
        
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



