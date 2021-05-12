//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Dewan Sunnah on 5/12/21.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    //MARK: - listDetailViewController protocols
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let newRowIndex = lists.count
        lists.append(checklist)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        navigationController?.popViewController(animated: true)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = lists.firstIndex(of: checklist)
        {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath)
            {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    var lists = [Checklist]()
    
    let cellIdentifer = "ChecklistCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register( UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        var list = Checklist(name: "Birthdays")
        lists.append(list)

        list = Checklist(name: "Groceries")
        lists.append(list)

        list = Checklist(name: "Cool Apps")
        lists.append(list)

        list = Checklist(name: "To Do")
        lists.append(list)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
        let checklist = lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checklist = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist"
        {
            let controller = segue.destination as! ChecklistViewController
            controller.checklist = sender as? Checklist
        }
        
        else if (segue.identifier == "AddChecklist")
        {
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }
    
    //MARK: - Deleting rows
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        lists.remove(at: indexPath.row)
        
        let indexPaths = [indexPath]
        
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }







}
