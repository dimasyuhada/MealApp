//
//  Meal.swift
//  MealApp
//
//  Created by Dimas Syuhada on 26/05/22.
//

import Foundation

struct MealData: Decodable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
}

struct MealDetails: Decodable {
    var idMeal: String
    var strMeal: String
    var strCategory: String
    var strArea: String
    var strInstructions: String
    var strMealThumb: String
}

struct Meal: Decodable {
    var meals: [MealData]
}

struct Detail: Decodable {
    var meals: [MealDetails]
}
