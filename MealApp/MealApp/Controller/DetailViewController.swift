//
//  DetailViewController.swift
//  MealApp
//
//  Created by Dimas Syuhada on 27/05/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    //MARK: Components & Variables
    @IBOutlet weak var imageMeals: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtCategory: UILabel!
    @IBOutlet weak var txtArea: UILabel!
    @IBOutlet weak var txtInstruction: UILabel!
    
    let baseUrl: String = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    var detailList = [MealDetails]()
    var strId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchData()
    }
    
}

//MARK: Functions
extension DetailViewController {
    
    func setupView(){
        let data = self.detailList[0]
        self.txtTitle.text = data.strMeal
        self.txtArea.text = data.strArea
        self.txtCategory.text = data.strCategory
        self.txtInstruction.text = data.strInstructions
        self.imageMeals.downloadedFrom(link: data.strMealThumb)
    }
    
    func fetchData(){
        getJSON{
            self.setupView()
        };
    }
    
    func getJSON(completed: @escaping() -> ()){
        let url = URL (string: "\(baseUrl)\(strId)")
        URLSession.shared.dataTask(with: url!) { (data,response,error) in
            if error == nil {
                do{
                    let dataMeals = try JSONDecoder().decode(Detail.self, from: data!)
                    self.detailList = dataMeals.meals
                    DispatchQueue.main.async {
                        completed()
                    }
                } catch {
                    print("error: ", error)
                }
            }
        }.resume()
    }
    
}
