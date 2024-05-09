//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController {
    
    private var editMode = false
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistMoveDeleteModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        setUpNavigationItem()
    }
    
    func setUpNavigationItem() {
        
        let title = editMode ? "Done" : "Edit"

        let barButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(changeModeButtonDidTap))
        
        navigationItem.rightBarButtonItem = barButton
        
        if barButton.title == "Done" {
            contentView.tableView.isEditing = true
        } else {
            contentView.tableView.isEditing = false
        }
         
    }
    
    @objc func changeModeButtonDidTap() {
        editMode = !editMode
        setUpNavigationItem()
        
    }
    
}

extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteModelDelegate {
    
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
    
    
}

extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteViewDelegate {
    
}

extension PlaylistMoveDeleteViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell")
        else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = model.items[indexPath.row].songTitle
        
        return cell
    }
    
    
}

extension PlaylistMoveDeleteViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
   
       if editingStyle == .delete {
            model.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
     }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        model.items.remove(at: sourceIndexPath.row)
        model.items.insert(contentsOf: model.items, at: destinationIndexPath.row)
        
    }
    
}
