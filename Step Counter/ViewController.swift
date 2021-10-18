//
//  ViewController.swift
//  Step Counter
//
//  Created by zhaoxin on 2021/10/18.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    private let realm = try! Realm()
    private var steps:Results<Step>!
    var notificationToken: NotificationToken? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        steps = realm.objects(Step.self).filter(NSPredicate(format: "isDeleted=false")).sorted(byKeyPath: "date")
        notificationToken = steps.observe{ [unowned self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial(_):
                tableView.reloadData()
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                // Always apply updates in the following order: deletions, insertions, then modifications.
                // Handling insertions before deletions may result in unexpected behavior.
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }

    @IBAction func addItemClicked(_ sender: Any) {
        let step = Step()
        step.step = Int.random(in: 1...20)
        
        try! realm.write {
            realm.add(step, update: .all)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
}

extension ViewController:UITableViewDelegate {
    
}

extension ViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stepCell", for: indexPath)
        let step = steps[indexPath.row]
        
        cell.textLabel?.text = String(step.step)
        cell.detailTextLabel?.text = DateFormatter.localizedString(from: step.date, dateStyle: .none, timeStyle: .medium)
        
        return cell
    }
}

