//
//  Requests.swift
//  GitHub_details
//
//  Created by Alessandro Marconi on 07/10/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import Foundation
import CoreData
import UIKit
/*
func GetUsers(){
    let postData = NSData(data: "".data(using: String.Encoding.utf8)!)
    let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/users")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.httpBody = postData as Data

    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error as Any)
        } else {
            let httpResponse = response as? HTTPURLResponse
            print(httpResponse as Any)
            
            do {
                let listOfLogins = try JSONDecoder().decode([User].self ,from: data!)
                for user in listOfLogins
                {
                    let repoAmount = GetRepos(login: user.login)
                    print(user.login)
                    let imageUrlString = user.avatar
                    let imageUrl:URL = URL(string: imageUrlString)!
                    
                    // Start background thread so that image loading does not make app unresponsive
                    DispatchQueue.global(qos: .userInitiated).async
                    {
                        let imageData:NSData = NSData(contentsOf: imageUrl)!
                        
                    }
                    
                    print(repoAmount)

                }
            }
            catch {
                print(error)
            }
        }
    })
    dataTask.resume()
}


func GetRepos(login: String)->Int{
    let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/users/\(login)")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error as Any)
        } else
        {
            do
            {
                let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                //Dictionary inside
                let dataDictionary:NSDictionary = jsonResponse as! NSDictionary
                for (key,value) in dataDictionary{
                    if key as! String == "public_repos"{
                        //print(value)
                         GlobalVariables.sharedManager.repos = value as! Int
                    }
                }
            }
            catch
            {
                print(error)
            }
        }
    })
    dataTask.resume()
    return GlobalVariables.sharedManager.repos
}
*/
