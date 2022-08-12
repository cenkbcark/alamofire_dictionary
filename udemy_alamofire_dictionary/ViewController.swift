//
//  ViewController.swift
//  udemy_alamofire_dictionary
//
//  Created by Cenk Bahadır Çark on 11.08.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var kelimeListesi = [Kelimeler]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        getAllWords()
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! KelimeDetayViewController
        gidilecekVC.kelime = kelimeListesi[indeks!]
        
    }
    
    func getAllWords() {
        Alamofire.request("http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php",method: .get).responseJSON {
            response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(SozlukResponse.self, from: data)
                    
                    if let gelenKelimeListesi = cevap.kelimeler{
                        self.kelimeListesi = gelenKelimeListesi
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        
        
    }
    
    func searchWords(searchWord: String) {
        
        let parametreler : Parameters = ["ingilizce":searchWord]
        
        Alamofire.request("http://kasimadalan.pe.hu/sozluk/kelime_ara.php",method: .post,parameters: parametreler).responseJSON {
            response in
            if let data = response.data{
                do{
                    let cevap = try JSONDecoder().decode(SozlukResponse.self, from: data)
                    
                    if let gelenKelimeListesi = cevap.kelimeler{
                        self.kelimeListesi = gelenKelimeListesi
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        
        
    }


}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kelimeListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kelime = kelimeListesi[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! KelimelerTableViewCell
        
        cell.ingilizceLabel.text = kelime.ingilizce
        cell.turkceLabel.text = kelime.turkce
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toKelimeDetay", sender: indexPath.row)
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        searchWords(searchWord: searchText)
    }
}
