//
//  Start_current_loc.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 6. 28..
//  Copyright © 2017년 김혜민. All rights reserved.
//
//
//  create_location.swift
//  BurnIt_1
//
//  Created by 김혜민 on 2017. 6. 27..
//  Copyright © 2017년 김혜민. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces



/*검색한 자리에 마커가 뜨고
 그에 따라서 현재 위치를 기준으로 디렉션 제시
 (이때 주변의 의뢰도 다 표시해야해)
 주변의 의뢰 시작점, 목적지 다 담는 변수 필요
 상세보기 화면전환시 같은 이름으로 TaskDetails에다가 넘겨줘*/
class SupporterTasks: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, NetworkCallback {

    //outlets
    @IBOutlet weak var googleMapsView: GMSMapView!
    @IBOutlet weak var filter: UIBarButtonItem!
    @IBOutlet weak var back: UIBarButtonItem!
    
    
    //variables
    var locationManager = CLLocationManager()
    //중간task 데이터 받아오기
    var taskList : [SpecificVO] = [SpecificVO]()
    
    //수행자가 입력한 시작, 끝 location
    var locationStart = CLLocation()
    var locationEnd = CLLocation()
    
    //마커 여러개 정보
    var markerDict: [GMSMarker : SpecificVO] = [:]

    
    
    func networkResult(resultData: Any, code: String) {
       /* if code == "2-1"{
            print("붸")
            taskList = resultData as! [SpecificVO]
            print(taskList)
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //만약에 아무것도 없으면 알림창
        if taskList.isEmpty{
            simpleAlert(title: "알림", msg: "주변에 의뢰가 없습니다.")
        }
        
        
        //서버에서 데이터 받아와
        //let model = Model(self)
        //locationStart locationEnd
        /*model.postCoordinates(workplace_lat: locationEnd.coordinate.latitude, workplace_long: locationEnd.coordinate.longitude, home_lat: locationStart.coordinate.latitude, home_long: locationStart.coordinate.longitude)
        */
        self.googleMapsView.delegate = self

        
        //지워주고 시작
        //googleMapsView.clear()
        
        //카메라를 두 점의 중심으로 해야할 듯
        let camera = GMSCameraPosition.camera(withLatitude: locationStart.coordinate.latitude, longitude: locationStart.coordinate.longitude, zoom: 15.0)
        
        self.googleMapsView.animate(to: camera)
        self.locationManager.stopUpdatingLocation()
        
        
        //출발지 마커
        createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "big_cir"), latitude: locationStart.coordinate.latitude, longitude: locationStart.coordinate.longitude)
        
        //목적지 마커
        //변수로.. 윈도우 확인하려고?
        createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "final_deti"), latitude: locationEnd.coordinate.latitude, longitude: locationEnd.coordinate.longitude)
        
        //의뢰지 마커 여러개 그리기
        createTasks(taskList: taskList)

        //내위치에서 목적지까지 line
        drawLineColor(startLocation: locationStart, endLocation: locationEnd, color: UIColor(rgb : 0xFF6600))
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
    
    //받아온 task 마커 찍어주는 함수
    func createTasks(taskList : [SpecificVO]){
        for task in taskList{
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(gdno(task.workplace_lat), gdno(task.workplace_long))
            marker.icon = #imageLiteral(resourceName: "mini_pin")
            markerDict[marker] = task
            marker.map = googleMapsView
        }
        print(markerDict)
    }
    
    
    //직선 라인 그려주는 함수
    //색깔 지정 가능한 버전
    func drawLineColor(startLocation : CLLocation, endLocation : CLLocation, color : UIColor){
        let path = GMSMutablePath()
        path.addLatitude(startLocation.coordinate.latitude, longitude:startLocation.coordinate.longitude)
        path.addLatitude(endLocation.coordinate.latitude, longitude:endLocation.coordinate.longitude)
        let polyline = GMSPolyline(path: path)
        polyline.strokeWidth = 3.0
        polyline.strokeColor = color
        polyline.geodesic = true
        polyline.map = googleMapsView
    }
    
    
    
    //마커 누르면 상세창 뜨기
    //마커 누르면 그에 해당하는 회색루트 그려주고
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        var selectedTask : SpecificVO?
        //var homeLocation = CLLocationCoordinate2D()
        //var workplaceLocation = CLLocationCoordinate2D()
        
        print(markerDict.count)
        
        //task 넘기기
        for (dmarker, task) in markerDict{
            /*if task.value.home_lat == marker.position.latitude{
                if task.value.home_long == marker.position.longitude{
                    selectedTask = task.value
                    print(selectedTask)
                }
            }*/
            if dmarker == marker{
                selectedTask = task
            }
         print(selectedTask?.task_idx)
        }
        
        
        if let popUp = self.storyboard?.instantiateViewController(withIdentifier: "PopUp") as? PopUp{
            
            //마커의 task 번호 알아내기
            //task 다음 뷰한테 정보 넘기기
            popUp.task = selectedTask
            
            self.present(popUp, animated: true, completion: nil)
            }
            /*
            homeLocation = CLLocationCoordinate2DMake(gdno(selectedTask?.home_lat), gdno(selectedTask?.home_long))
            workplaceLocation = CLLocationCoordinate2DMake(gdno(selectedTask?.workplace_lat), gdno(selectedTask?.workplace_long))
            */
            /*
            //지도 한번 지우고 회색, 주황색 루트 새로 그리기
            googleMapsView.clear()
            
            //기존 루트 회색처리
            createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "start_point"), latitude: locationStart.coordinate.latitude, longitude: locationStart.coordinate.longitude)
            createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "logo_pin_grey"), latitude: locationEnd.coordinate.latitude, longitude: locationEnd.coordinate.longitude)
            drawLineColor(startLocation: locationStart, endLocation: locationEnd, color: UIColor(rgb : 0x95989A))
            
            //선택한 의뢰 루트 주황색
            createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "destination_pin"), latitude: homeLocation.latitude, longitude: homeLocation.longitude)
            createMarker(titleMarker: "", iconMarker: #imageLiteral(resourceName: "doing_pin"), latitude: workplaceLocation.latitude, longitude: workplaceLocation.longitude)
            drawLineColor(startLocation: CLLocation.init(latitude: homeLocation.latitude, longitude: homeLocation.longitude), endLocation: CLLocation.init(latitude: workplaceLocation.latitude, longitude: workplaceLocation.longitude), color: UIColor(rgb : 0xFF6600))
            */
            
            

        return false
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func filter(_ sender: UIBarButtonItem) {
        //종류 선택해서 보여주기
        
    }
}


