//
//  SiswaTableViewController.swift
//  Quizkelas
//
//  Created by SMK IDN MI on 11/16/17.
//  Copyright © 2017 Djoendhie. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SiswaTableViewController: UITableViewController {
    
    var judSelected:String?
    var katSelected:String?
    var iSISelected:String?
    
    var nampungId : String? = nil
     var arraysiswa = [[String:String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("id + " + nampungId!)
        
        let params = ["id_kelas" : nampungId]
        let url = "http://localhost/kelas/index.php/api/getsiswa"
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler:
            { (response) in
                
                //        Alamofire.request(url, method: .post, Parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                // check response
                if response.result.isSuccess {
                    //kalau response suces kita ambil json
                    let json = JSON(response.result.value as Any)
                    print(json)
                    //get jsonaray dari json arrayq
                    self.arraysiswa = json["data"].arrayObject as! [[String : String]]
                    //check d log
                    //check jumlah array
                    if (self.arraysiswa.count > 0){
                        
                        //refresh tableview
                        self.tableView.reloadData()
                    }
                }
                else{
                    
                    print("error server")
                    
                }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arraysiswa.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSiswa", for: indexPath) as! SiswaTableViewCell
        
        var serverid = arraysiswa[indexPath.row]
        
        var id = serverid["id_kelas"]
        let nama = serverid["Siswa"]
        let kelas = serverid["kelas"]
        let email = serverid["Email"]
        //print judul
        
        cell.labelNama.text = nama
        cell.labelEmail.text = email
        cell.labelKelas.text = kelas
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("Row \(indexPath.row)selected")
        
        let task = arraysiswa[indexPath.row]
        judSelected = task["id_siswa"] as! String
        katSelected = task["id_kelas"] as! String
        iSISelected = task["Siswa"] as! String
        
        
        performSegue(withIdentifier: "passIsi", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "passIsi" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                let value = arraysiswa[indexPath.row]
                
                controller.passnama = value["Siswa"] as! String
                controller.passEmail = value["Email"] as! String
                controller.passKelas = value["kelas"] as! String
                controller.passTelp = value["Telp"] as! String
                controller.passKelamin = value["Kelamin"] as! String
                controller.passAlamat = value["Alamat"] as! String
               
                
            }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
