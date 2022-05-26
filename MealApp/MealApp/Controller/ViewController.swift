//
//  ViewController.swift
//  MealApp
//
//  Created by Dimas Syuhada on 26/05/22.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Components & Variables
    @IBOutlet weak var tableView: UITableView!
    
    let baseUrl: String = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood"
    var mealList = [MealData]()
    var strIdMeal: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        fetchData()
    }
}


// MARK: Functions
extension ViewController {
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MealTableViewCell.nib(), forCellReuseIdentifier: MealTableViewCell.identifier)
    }
    
    func fetchData() {
        getJSON{
            self.tableView.reloadData()
        };
    }
    
    func getJSON(completed: @escaping() -> ()){
        let url = URL (string: baseUrl)
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            if error == nil {
                do{
                    let dataMeals = try JSONDecoder().decode(Meal.self, from: data!)
                    self.mealList = dataMeals.meals
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetails"{
            let vc = segue.destination as! DetailViewController
            vc.strId = strIdMeal
        }else {
            
        }
    }
    
}

// MARK: TableViews
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mealList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
        cell.configure(with: mealList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        strIdMeal = mealList[(indexPath.row)].idMeal
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "goDetails", sender: self)
        }
    }
    
}
