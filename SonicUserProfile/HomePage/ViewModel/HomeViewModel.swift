//
//  HomeViewModel.swift
//  SonicUserProfile
//
//  Created by user on 04/09/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import Foundation
/*
 {"section":"EXPERIENCE","jobs":[{"role":"Barista and Bartender","job":"Bartender at O2 Academy","dates":"from 30/10/2016 till present"},{"role":"Waiter and Retail","job":"Waitress at Chacombe park","dates":"from 20/05/2014 to 29/06/2018"},{"role":"Waiter and Retail","job":"Waitress at the New Inn pub","dates":"from 29/09/2013 to 29/04/2015"}]}
 */
class HomeViewModel {
    
    let request = ItsRequest()
    var userProfile:Profile?
    func getDataFromServer(completionHandler: @escaping (Bool?) -> Void)
    {
         let surl = "https://api.myjson.com/bins/jfpas"
        request.getDataFromServer(url:surl,completionHandler: { (Profile) in
            print(Profile!)
            if let profileData = Profile
            {
                self.userProfile = profileData
                completionHandler(true)
            }else
            {
                completionHandler(false)
            }
        }) { (Error) in
            print(Error)
            completionHandler(false)
        }
    }
    
    func availableProfile() -> Profile? {
        if(userProfile != nil)
        {
            return userProfile!
        }
        return nil
    }
    
}
