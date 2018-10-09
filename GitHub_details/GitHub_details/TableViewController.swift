//
//  TableViewController.swift
//  GitHub_details
//
//  Created by Alessandro Marconi on 05/10/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import UIKit
import Foundation
import CoreData

var people: [NSManagedObject] = []

class TableViewController: UITableViewController {
    struct GlobalVariables
    {
        static var names = [String]()
        static var repos = [Int16]()
        static var images = [Data]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The GitHub Users"
        tableView.register(UINib(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: "Cell")
        GetUsers() // Start the requests
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
        
        Timer.scheduledTimer(withTimeInterval: 20, repeats: false) { (t) in
            print(GlobalVariables.names)
            print(GlobalVariables.repos)
            print(GlobalVariables.images)
            print("20 seconds passed")
            if GlobalVariables.names.count != 0 {
                var index = 0
                while index < GlobalVariables.names.count {
                    self.save(index: index)
                    index = index + 1
                }
            
            }
            self.tableView.reloadData()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()

    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        cell.loginLabel?.text = person.value(forKeyPath: "login") as? String
        cell.reposLabel?.text = "\(String(describing: person.value(forKeyPath: "reposValue") as! Int16))"
        let image: Data = (person.value(forKeyPath: "avatar")! as? Data)!
        let decodedimage = UIImage(data: image)
        cell.userImage.image = decodedimage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = people[indexPath.row]
        let name = person.value(forKeyPath: "login") as? String
        print("selected: \(String(describing: name))")
        UserDefaults.standard.set(name!, forKey: "login")
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "DetailTable") as! DetailTable
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - Save
    func save(index: Int)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
            person.setValue(GlobalVariables.names[index], forKeyPath: "login")
            person.setValue(GlobalVariables.repos[index], forKeyPath: "reposValue")
            person.setValue(GlobalVariables.images[index], forKeyPath: "avatar")
        do
        {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")}
    }
    
    func deleteAllData(_ entity:String)
    {
        DispatchQueue.main.sync {
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let context = delegate.persistentContainer.viewContext
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                print ("There was an error")
            }
            viewDidAppear(true)
        }
    }
    
    // MARK: - GetRequests
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
                
                DispatchQueue.main.async
                    {
                        let alert = UIAlertController(title: "No internet",
                                                      message: "Check the internet connection",
                                                      preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Load from Core Data",
                                                         style: .cancel)
                        alert.addAction(cancelAction)
                        self.present(alert, animated: true)
                }
            } else {
                self.deleteAllData("Users")
                self.deleteAllData("Repos")
                
                //let httpResponse = response as? HTTPURLResponse
                //print(httpResponse as Any)
                do {
                    let listOfLogins = try JSONDecoder().decode([User].self ,from: data!)
                    for user in listOfLogins
                    {
                        self.GetRepos(login: user.login!)
                        
                        GlobalVariables.names.append(user.login!)
                        let url = URL(string: user.avatar_url!)
                        let imageData = try? Data(contentsOf: url!)
                        //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        GlobalVariables.images.append(imageData!)
                    }
                }
                catch {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
    
    func GetRepos(login: String)
    {
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
                    let numOfRepos = try JSONDecoder().decode(ReposValue.self ,from: data!)
                    if numOfRepos.login == login {
                        GlobalVariables.repos.append(Int16(numOfRepos.repos))
                    }
                }
                catch
                {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
}

