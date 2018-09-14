//
//  ItsRequest.swift
//  SonicUserProfile
//
//  Created by user on 04/09/18.
//  Copyright © 2018 pankajBhardwaj. All rights reserved.
//

import Foundation

class ItsRequest: NSObject {
    
    func getDataFromServer(url:String,completionHandler: @escaping (Profile?) -> Void, errorHandler: @escaping (Error) -> Void) {
       
        guard let url = URL(string: url) else {
            print("Error");
            return
        }
        
        let sesseionDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let unwrappedData = data else {
                print("Error with data");
                return
            }
            do {
                if (try JSONSerialization.jsonObject(with: unwrappedData, options: .allowFragments) as? NSDictionary) != nil {
                    let decoder = JSONDecoder()
                    try completionHandler(decoder.decode(Profile.self, from: unwrappedData))
                }
            } catch {
                errorHandler(error)
                print("Error : \(error.localizedDescription)")
            }
        }
        sesseionDataTask.resume()
    }
    
}
