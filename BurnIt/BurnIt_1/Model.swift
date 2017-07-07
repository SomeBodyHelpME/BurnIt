//
//  Model.swift
//  BurnIt
//
//  Created by 이상은 on 2017. 6. 30..
//  Copyright © 2017년 이상은. All rights reserved.
//


import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SwiftyJSON

//멀티파트 예외처리 파싱은 SwiftyJSON 이용해서하기

class Model : NetworkModel {
    
    //1-1
   /* func getWholeInformation(role:String){
        
        let URL : String = "\(baseURL)/task?"
        
        let parameter = ["role": role]
        
        Alamofire.request(URL, method: .get, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<ResultVO>) in
            
            switch response.result{
                
            case .success:
                print("getWholeInformation Success")
                guard let specificList = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                //게시글 리스트 가져오기 성공
                if specificList.message == "Success selecting the task list" {
                    print("getWholeInformation Server clear")
                    if let results = specificList.result {
                        self.view.networkResult(resultData: results, code: "1-1")
                    }
                }
                    
                    
                    
                    
                    //게시글 리스트 가져오기 실패(예외)
                else if specificList.message == "this user has already helped other client" {
                    
                    self.view.networkResult(resultData: "[에러원인", code: "this user has already helped other client")
                }
                else if specificList.message == "wrong input" {
                    
                    self.view.networkResult(resultData: "[에러원인", code: "wrong input")
                }
                else if specificList.message == "internal server error : [에러원인]" {
                    
                    self.view.networkResult(resultData: "[에러원인", code: "internal server error : [에러원인]")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
        
    }//getWholeInformation
    
    

    //1-2
    func getHamburgerDetail(role:String){
        
        let URL : String = "\(baseURL)/navi?role=\(role)"


        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<HamburgerVO>) in
            print("sjdsdjad")
            print(response.result)
            switch response.result{
            
            case .success:
            
                print("getHamburgerDetail Success")
                guard let HamburgerDetail = response.result.value else{
                    self.view.networkFailed()
                    return
                }
            
                
                //게시물 상세보기 가져오기 성공
                
                if HamburgerDetail.message == "Success in getting navi information" {
                    print("getHamburgerDetail Server clear")
                    if let post = HamburgerDetail.result {
             
                        self.view.networkResult(resultData: post, code: "1-2")
                    }
                    
                }
                    
              
                    //게시물 상세보기 갸져오기 실패(예외)
                else if HamburgerDetail.message == "internal server error"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-2-fail2")
                    print("hi8")
                }

                
            case .failure(let err):
                print("사랑은 가슴이 시킨다")
                print(err)
                self.view.networkFailed()
            }
            
        }
        
    }//getHamburgerDetail

    //1-3
    func getMoney(){
        
        let URL : String = "\(baseURL)/navi/money"

        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<MoneyVO>) in
            
            switch response.result{
                
            case .success:

                guard let MoneyDetail = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                //게시물 상세보기 가져오기 성공
                
                if MoneyDetail.message == "Success in getting money of user" {

                   
                    if let money = MoneyDetail.result {
                        self.view.networkResult(resultData: money, code: "1-3")
                    }
                    
                }
                    
                    //게시물 상세보기 갸져오기 실패(예외)
                else if MoneyDetail.message == "internal server error : [에러원인]"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-3-selecting post error")
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
                
            }
            
        }
        
    }//getMoney
    

    //1-4
    func getHistoryDetail(role:String){
        
        let URL : String = "\(baseURL)/navi/mypage/log?role=\(role)"
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<LogVO>) in
         
            
            switch response.result{
                
            case .success:
                print("getHistoryDetail Success")
                guard let LogDetail = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                //게시물 상세보기 가져오기 성공
                
                if LogDetail.message == "Success in getting work logs"{
                    print("getHistoryDetail Server clear")
                    if let log = LogDetail.result {
                        self.view.networkResult(resultData: log, code: "1-4")
                    }
                    
                }
                
                    //게시물 상세보기 갸져오기 실패(예외)
                else if LogDetail.message == "wrong input"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-5-selecting post error")
                }
                    
                    //게시물 상세보기 갸져오기 실패(예외)
                else if LogDetail.message == "internal server error : [에러원인]"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-5-selecting post error")
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
                
            }
            
        }
        
    }//getHistoryDetail
    
    
    //1-5
    func getSetMypage(){
        
        let URL : String = "\(baseURL)/navi/mypage/set"
   
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<SetMypageVO>) in
            
            switch response.result{
                
            case .success:

                guard let SetMyPage = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                //게시물 상세보기 가져오기 성공
                
                if SetMyPage.message == "Success in getting user information"{

                    if let mypage = SetMyPage.result {
                        self.view.networkResult(resultData: mypage, code: "1-5")
                    }
                    
                }
                    
            
                    //게시물 상세보기 갸져오기 실패(예외)
                else if SetMyPage.message == "internal server error"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-5-selecting post error")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
                
            }
            
        }
        
    }//getSetMypage

 
    //1-6
    func getImage(){
        
        let URL : String = "\(baseURL)/navi/mypage"

        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<ImageVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let Image = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                //게시물 상세보기 가져오기 성공
                
                if Image.message == "Success in getting user information"{

                    if let myimage = Image.result {
                        self.view.networkResult(resultData: myimage, code: "1-6")
                    }
                    
                }
                    
                    //게시물 상세보기 갸져오기 실패(예외)
                else if Image.message == "wrong input"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-6-selecting post error")
                }
                    
                    //게시물 상세보기 갸져오기 실패(예외)
                else if Image.message == "internal server error : [에러원인]"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-6-selecting post error")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
                
            }
            
        }
        
    }//getImage
    
    //1-7
    func getBookmark(){
        
        let URL : String = "\(baseURL)/navi/mypage/bookmark"
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<BookmarkVO>) in
            
            switch response.result{
                
            case .success:

                guard let Bookmark = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                //게시물 상세보기 가져오기 성공
                
                if Bookmark.message == "Success in selecting bookmark"{
                    print(Bookmark)
                    if let mybookmark = Bookmark.result {

                        
                        self.view.networkResult(resultData: mybookmark, code: "1-7")
                    }
                    
                }
                    
                 
                    //게시물 상세보기 갸져오기 실패(예외)
                else if Bookmark.message == "internal server error : [에러원인]"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-7-selecting post error")
                }
                
            case .failure(let err):
                print(err)
                print("bookmark7")
                self.view.networkFailed()
                
                
            }
            
        }
        
    }//getBookmark
    
    //1-8
    func getMyComment(role:String){
        
        let URL : String = "\(baseURL)/navi/mypage/comments?role=\(role)"
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<MyCommentVO>) in
            print("ssipal1")
            switch response.result{
                
            case .success:
                print("ssipal2")
                guard let Comment = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                //게시물 상세보기 가져오기 성공
                
                if Comment.message == "Success in getting comments"{
                    print("여기")
                    if let mycomment = Comment.result {
                        self.view.networkResult(resultData: mycomment, code: "1-8")
                    }
                    
                }
                    
                    //게시물 상세보기 갸져오기 실패(예외)
                else if Comment.message == "this user has already helped other client"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-7-selecting post error")
                }
                    
                    //게시물 상세보기 갸져오기 실패(예외)
                else if Comment.message == "wrong input"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-7-selecting post error")
                }
                    
                    //게시물 상세보기 갸져오기 실패(예외)
                else if Comment.message == "internal server error : [에러원인]"{
                    self.view.networkResult(resultData: "[에러원인", code: "1-7-selecting post error")
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
                
            }
            
        }
        
    }//getBookmark
 
 */
    
    

    //2-3
    func getJoinCheck(user_id:String){
        
        let URL : String = "\(baseURL)/auth/join/check?user_id=\(user_id)"
        print(URL)
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response : DataResponse<AnswerVO>) in
            
            switch response.result{
                
            case .success:
                guard let IDrepeat = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if IDrepeat.message == "id already exists"{
                    self.view.networkResult(resultData: "", code: "2-3-1")

                }
                    
                else if IDrepeat.message == "there is no id"{
                    self.view.networkResult(resultData: "[에러원인", code: "2-3-2")
                }
                    
                    
                else if IDrepeat.message == "internal server error"{
                    self.view.networkResult(resultData: "[에러원인", code: "2-3-3")
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
                
            }
            
        }
        
    }//getJoinCheck
    

    

    
 
    
    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////
    //P
    //O
    //S
    //T
    //var succeed = false

    //두 군데 coordinate 보내기
    func postCoordinates(workplace_lat:Double, workplace_long:Double, home_lat:Double, home_long:Double, user_id:String){
        
        let URL : String = "\(baseURL)/task/helper?home_lat=\(home_lat)&home_long=\(home_long)&workplace_lat=\(workplace_lat)&workplace_long=\(workplace_long)&user_id=\(user_id)"
        
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response:DataResponse<ResultVO>) in
            print("포스트")
            print(response.result)
            
            switch response.result{
                
            case .success:
    print("실망4")
                guard let Detail = response.result.value else{
                    
                    self.view.networkFailed()
                    return
                }
    
    print(user_id)
    //아직 못받아온거 vs 받아왔는데 없는거
    
                if Detail.message == "Success in selecting the task list" {
                    
                    print("실망5")
                    
                    if let myDetail = Detail.result {
                        
                        //구별 위한 변수
                        //self.succeed = true
                        print("실망5")
                        self.view.networkResult(resultData: myDetail, code: "2-1")
                    }
                    
                }
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    
 
    
    //2-2
    func postClientCoordinates(workplace_lat: Double, workplace_long: Double, home_lat: Double, home_long: Double, task_type: String, cost: Int, home_name: String, workplace_name: String, deadline: String, details: String, user_id: String){
        
        var URL : String = "\(baseURL)/task/client?"
        
        let body = "task_type=\(task_type)&cost=\(cost)&details=\(details)&deadline=\(deadline)&workplace_lat=\(workplace_lat)&workplace_long=\(workplace_long)&home_lat=\(home_lat)&home_long=\(home_long)&workplace_name=\(workplace_name)&home_name=\(home_name)&user_id=\(user_id)"
        print(type(of : task_type))
        print(type(of : cost))
        print(type(of : details))
        print(type(of : deadline))

        print(type(of : workplace_name))

        print(type(of : user_id))

        
        URL = URL + body
        
        
                Alamofire.request(URL, method: .put, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response:DataResponse<AnswerVO>) in
            
            print(response.result)
            
            switch response.result{
                
            case .success:
                
                self.view.networkResult(resultData: "", code: "2-2")
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }//postClientCoordinates

    
    func postJoin(user_name: String, user_id: String, user_pw: String, phone: String){
        
        let URL : String = "\(baseURL)/auth/join"
        
        let body : [String : Any] = [
            
            "user_name": user_name,
            "user_id": user_id,
            "user_pw": user_pw,
            "phone": phone
            
        ]
        
        Alamofire.request(URL, method: .post, parameters:body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response:DataResponse<AnswerVO>) in
            
            print("여기")
            switch response.result{
                
            case .success:
                //let result = response.result.value
                guard response.result.value != nil else{
                    
                    self.view.networkFailed()
                    return
                }
                
                print("저기")
                self.view.networkResult(resultData: "", code: "2-3")
                
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }//postJoin
    
    
    
    func postStar(user_id: String, user_star: Double, user_comment: String, role: String) {
        
        var URL : String = "\(baseURL)/task/star?"
        
        
        
        let body = "user_id=\(user_id)&user_star=\(user_star)&user_comment=\(user_comment)&role=\(role)"
        
        URL = URL + body
        
        Alamofire.request(URL, method: .get, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response:DataResponse<AnswerVO>) in
            
            //            print(response.result.value?.message)
            print("여요기hihh")
            
            switch response.result{
                
            case .success:
                guard let IDrepeat = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                //게시물 상세보기 가져오기 성공
                
                if IDrepeat.message == "Success --1"{
                    print("저기")
                    
                    
                    self.view.networkResult(resultData: "", code: "3-1")
                    
                    
                }
                else if IDrepeat.message == "Success --2"{
                    print("저기")
                    
                    
                    self.view.networkResult(resultData: "", code: "3-2")
                    
                    
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
                
                
            }
            
        }
    }//postStar

    
    
  /*
    
    func writeBoard(user_name:String, user_id:String, user_pw:String, phone:String, gender:String){
     
        let URL : String = "\(baseURL)/lists"
     
        let body : [String:String] = [
     
            "user_name":user_name,
            "user_id":user_id,
            "user_pw":user_pw,
            "phone":phone,
            "gender":gender
            
        ]
        
        Alamofire.request(URL, method: .post, parameters:body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            (response:DataResponse<JoinMessageVO>) in
            
            
            switch response.result{
                
            case .success:
                
                guard let Message = response.result.value else{
                    
                    self.view.networkFailed()
                    return
                }
                
                if Message.message == "ok"{
                    self.view.networkResult(resultData: "", code: "1-3")
                }
                    
                else if Message.message == "selecting post error : [에러원인]"{
                    self.view.networkResult(resultData: "", code: "1-3-selecting post error")
                }
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
    
    //멀티파트 이용
    //문법설명 따로
    func writeBoardWithImage(title:String, content:String, writer:String,imageData:Data?){
        
        let URL = "\(baseURL)/lists"
        
        let title = title.data(using: .utf8)
        let content = content.data(using: .utf8)
        let writer = writer.data(using: .utf8)
        
        
        if imageData == nil{
            
        }else{
            
            Alamofire.upload(multipartFormData : { multipartFormData in
                
                //멀티파트를 이용해 데이터를 담습니다
                multipartFormData.append(imageData!, withName: "image", fileName: "image.jpg", mimeType: "image/png")
                multipartFormData.append(title!, withName: "title")
                multipartFormData.append(content!, withName: "content")
                multipartFormData.append(writer!, withName: "writer")
            },
                             
                             to: URL,
                             encodingCompletion: { encodingResult in
                                
                                switch encodingResult{
                                case .success(let upload, _, _):
                                    upload.responseData { res in
                                        switch res.result {
                                        case .success:
                                            
                                            print(JSON(res.result.value))
                                            if let value = res.result.value {
                                                let data = JSON(value)
                                                let msg = data["message"].stringValue
                                                
                                                if msg == "ok" {
                                                    
                                                    
                                                    DispatchQueue.main.async(execute: {
                                                        print("dispatc Queue")
                                                        self.view.networkResult(resultData: "", code: "1-4")
                                                    })
                                                    print(msg)
                                                }//if msg == "ok
                                                
                                                
                                        }//if let value
                                        case .failure(let err):
                                            print("upload Error : \(err)")
                                            DispatchQueue.main.async(execute: {
                                                self.view.networkFailed()
                                            })
                                        }
                                    }
                                case .failure(let err):
                                    print("network Error : \(err)")
                                    self.view.networkFailed()
                                }//switch
            }
                
            )//Alamofire.upload
            
        }
    }
    
    
    func writeComment(id:Int,writer:String,content:String){
        
        let URL = "\(baseURL)/lists/\(id)"
        
        let body : [String:String] = [
            
            "writer" : writer,
            "content" : content
            
        ]
        
        Alamofire.request(URL, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil).responseObject{
            
            
            (response : DataResponse<MessageVO>) in
            
            switch response.result{
                
            case .success:
                
                guard let Message = response.result.value else{
                    self.view.networkFailed()
                    return
                }
                
                if Message.message == "ok"{
                    self.view.networkResult(resultData: "댓글작성완료", code: "1-5")
                }else{
                    self.view.networkFailed()
                }
                
            case .failure(let err):
                self.view.networkFailed()
            }//switch
        }//Alamofire
        
    }
    
*/
    
    ///////////////////////////////////////////
    ////////////////////////////////////////////
     
     
     func putTaskMatch(task_idx: Int, user_id: String){
     
     var URL : String = "\(baseURL)/task/matching?"
     
     let body = "task_idx=\(task_idx)&user_id=\(user_id)"
     URL = URL + body
     print(URL)
     Alamofire.request(URL, method: .put, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject{
     
     (response:DataResponse<AnswerVO>) in
     
     
     switch response.result{
     
     case .success:
     //let result = response.result.value
     print("ssisisipal")
     
     self.view.networkResult(resultData: "", code: "")
     
     
     
     case .failure(let err):
     print("isisisisisipfkaka")
     print(err)
     self.view.networkFailed()
     }
     
     }
     }//putTaskMatch
     
     
     
     func putTaskMatchCheck(user_id: String){
     
     var URL : String = "\(baseURL)/navi/mypage/set?"
     
     let body = "user_id=\(user_id)"
     URL = URL + body
     
     Alamofire.request(URL, method: .put, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject{
     
     (response:DataResponse<AnswerVO>) in
     
     
     switch response.result{
     
     case .success:
     //let result = response.result.value
     
     
     self.view.networkResult(resultData: "", code: "")
     
     
     
     case .failure(let err):
     print(err)
     self.view.networkFailed()
     }
     
     }
     }//putTaskMatchCheck
     
     
     
     func putTaskCancel(user_id: String, role: String){
     
     var URL : String = "\(baseURL)/task/matching/cancel?"
     
     let body = "user_id=\(user_id)&role=\(role)"
     
     URL = URL + body
     print(URL)
     Alamofire.request(URL, method: .delete, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject{
     
     (response:DataResponse<AnswerVO>) in
     
     print("qehqoieq")
     switch response.result{
     
     case .success:
     //let result = response.result.value
     
     print("dajdiada")
     self.view.networkResult(resultData: "", code: "")
     
     
     
     case .failure(let err):
     print(err)
     self.view.networkFailed()
     }
     
     }
     }//putTaskCancel
     
     
     
     
     
     /*
     
     
    func putPerform(user_name: String, phone: Int, about: String, image_path: String){
     
        var URL : String = "\(baseURL)/navi/mypage/set?"
    
        let body = "user_name=\(user_name)&phone=\(phone)&about=\(about)&image_path=\(image_path)"
        URL = URL + body

        Alamofire.request(URL, method: .put, parameters:nil, encoding: JSONEncoding.default, headers: nil).responseObject{
     
            (response:DataResponse<SelfPerformVO>) in
     
     
            switch response.result{
                
            case .success:
                //let result = response.result.value
                guard response.result.value != nil else{
                    
                    self.view.networkFailed()
                    return
                }
                
                
                self.view.networkResult(resultData: "", code: "3-1")
                
                
                
            case .failure(let err):
                print(err)
                self.view.networkFailed()
            }
            
        }
    }
*/
    
}
