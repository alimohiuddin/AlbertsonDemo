//
//  ViewController.swift
//  AlbertsonDemo
//
//  Created by Ali Mohiuddin on 11/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableViewObj: UITableView!
    
    @IBOutlet weak var searchTF: UITextField!
    var resultArray : [VarsData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableViewObj.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        
    }
    
    // MARK: -  Webservice Method :
    func getDataFromService(searchStr : String?){
        
        NetworkManger.shared.ApiCall(searchParam: searchStr ?? "") { result in
            switch result{
            case .success(let resultData):
                DispatchQueue.main.async {
                    self.resultArray = resultData
                    self.tableViewObj.reloadData()
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    // MARK: -  Table view Datasource and Delegate :
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = self.resultArray[indexPath.row].lf ?? ""
        cell?.textLabel?.numberOfLines = 0
        return cell!
    }
}
extension ViewController : UITextFieldDelegate{
    // MARK: -  Text field Delegate :
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        
        let textFieldText: NSString = (textField.text ?? "") as NSString
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        if txtAfterUpdate.count > 0
        {
            self.resultArray.removeAll()
            self.tableViewObj.reloadData()
            self.getDataFromService(searchStr: txtAfterUpdate)
        }
        else
        {
            self.resultArray.removeAll()
            self.tableViewObj.reloadData()
        }
        
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder();
        return true;
    }
}

