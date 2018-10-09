//
//  DetailTable.swift
//  GitHub_details
//
//  Created by Alessandro Marconi on 09/10/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import UIKit
import CoreData

var repositories: [NSManagedObject] = []
class DetailTable: UITableViewController {

    struct DetailVariables
    {
        static var fullname = [String]()
        static var dateOfCreation = [Date]()
        static var update = [Date]()
    }
    
    var user: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "Cell2")
        user = UserDefaults.standard.object(forKey: "login") as! String

        GetRepos(login: user) // Start the requests
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Repos")
        
        do {
            repositories = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        tableView.reloadData()
        
        Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { (t) in
            print(DetailVariables.fullname)
            print(DetailVariables.dateOfCreation)
            print(DetailVariables.update)
            print("7 seconds passed")
            if DetailVariables.fullname.count != 0 {
                var index = 0
                while index < DetailVariables.fullname.count {
                    self.save(index: index)
                    index = index + 1
                }
                self.tableView.reloadData()
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return repositories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repository = repositories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! DetailCell
        cell.label1?.text = "Repository Name:  \(repository.value(forKeyPath: "fullName") as! String)"
        let string2 = "Created: \(repository.value(forKeyPath: "dateOfCreation") as! Date)".prefix(28)
        cell.label2?.text = "\(string2) 🐱"
        let string3 = "Last change: \(repository.value(forKeyPath: "lastUpdate") as! Date)".prefix(32)
        cell.label3?.text = "\(string3) \u{2665}"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = repositories[indexPath.row]
        let ref =  repo.value(forKeyPath: "fullName") as! String
        
        print("http://github.com/\(ref)")
        guard let url = URL(string: "http://github.com/\(ref)") else { return }
        UIApplication.shared.open(url)
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil) } else {
            UIApplication.shared.openURL(url)
        }
    }
        
        // MARK: - Save
        func save(index: Int)
        {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Repos", in: managedContext)!
            let repository = NSManagedObject(entity: entity, insertInto: managedContext)
            
            repository.setValue(DetailVariables.fullname[index], forKeyPath: "fullName")
            repository.setValue(DetailVariables.dateOfCreation[index], forKeyPath: "dateOfCreation")
            repository.setValue(DetailVariables.update[index], forKeyPath: "lastUpdate")
            do
            {
                try managedContext.save()
                repositories.append(repository)
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
        
        func GetRepos(login: String)
        {
            let request = NSMutableURLRequest(url: NSURL(string: "https://api.github.com/users/\(login)/repos")! as URL,
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
                        let reposList = try JSONDecoder().decode([Repo].self ,from: data!)
                        for repo in reposList
                        {
                            //self.deleteAllData("Repos")
                            DetailVariables.fullname.append(repo.full_name!)
                            
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZZ"
                            
                            let date1 = dateFormatter.date(from: repo.created_at!)
                            DetailVariables.dateOfCreation.append(date1!)
                            
                            let date2 = dateFormatter.date(from: repo.created_at!)
                            DetailVariables.update.append(date2!)
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


