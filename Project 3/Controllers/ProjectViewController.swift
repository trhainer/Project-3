//
//  ProjectViewController.swift
//  Project 3
//
//  Created by Tracy Hainer on 7/19/19.
//  Copyright © 2019 Tracy Hainer. All rights reserved.
//

import UIKit
import CoreData

class ProjectViewController: UITableViewController {
    
    var projects = [Project]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProjects()

    }
    
    // MARK - TableView Datasource Methods:
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return projects.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell", for: indexPath)
        
        cell.textLabel?.text = projects[indexPath.row].name
        
        return cell
        
    }
    
    // MARK - TableView Delegate Methods:
    
    // MARK - Data Manipulation Methods:
    
    func saveProjects() {
        do {
            try context.save()
        } catch {
            print("Error Saving Project \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadProjects() {
        
        let request : NSFetchRequest<Project> = Project.fetchRequest()
        
        do {
        projects = try context.fetch(request)
        } catch {
            print("Error loading Projects \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    // MARK - Add New Projects:

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Project", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newProject = Project(context: self.context)
            newProject.name = textField.text!
            
            self.projects.append(newProject)
            
            self.saveProjects()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a New Project"
        }
        
        present(alert, animated: true, completion: nil)
        
    }

}
