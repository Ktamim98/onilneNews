//
//  ViewController.swift
//  project7
//
//  Created by Tamim Khan on 15/2/23.
//
import UIKit

class ViewController: UITableViewController {
    
    
  var petitions = [Petition]()
    
   var filteredPetitions = [Petition]()
    var originalPetitions = [Petition]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightItem = UIBarButtonItem(title: "©", style: UIBarButtonItem.Style.plain, target: self, action: #selector(showSource))
        rightItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 25.0)!], for: UIControl.State.normal)
        rightItem.setTitlePositionAdjustment(UIOffset(horizontal: 0.0, vertical: 5.0), for: UIBarMetrics.default)
        
        navigationController?.navigationBar.topItem?.rightBarButtonItems = [rightItem]
        
        
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterResults))
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetList))
        
        navigationItem.leftBarButtonItems = [filterButton, resetButton]
        
        performSelector(inBackground: #selector(fetchJSON), with: nil)
       
    }
        
        
        
    @objc func fetchJSON(){
        let urlString: String
        if navigationController?.tabBarItem.tag == 0{
            
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                parse(json: data)
                originalPetitions = petitions
                return
            }
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    func parse(json: Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json){
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }else{
            
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
        
    }
          @objc func showError(){
                let ac = UIAlertController(title: "Loading Error", message: "There is a problem while loading; please check your internet and try later.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
            }
            
            
    @objc func showSource(){
        let ScoreAlert = UIAlertController(title: "CREDITS!", message: "The data comes from, We The People API of the Whitehouse.", preferredStyle: .alert)
        ScoreAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ScoreAlert, animated: true)
    }
    
        
        
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    
  @objc func showPetintion(_ answer: String) {
        
      filteredPetitions = petitions.filter { $0.title.contains(answer) || $0.body.contains(answer)
        }
      petitions = filteredPetitions
      tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    
    @objc func filterResults() {
        let ac = UIAlertController(title: "Filter Results", message: "Please type your search in below.", preferredStyle: .alert)
        ac.addTextField()
        
        let submitFilter = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text
            else { return }
            self?.performSelector(inBackground: #selector(self?.showPetintion), with: answer)
           
          
            
        }
        ac.addAction(submitFilter)
        present(ac, animated: true)
        
    }
    @objc func resetList() {
        DispatchQueue.main.async {
            self.petitions = self.originalPetitions
            self.tableView.reloadData()
        }
    }

            
        }
