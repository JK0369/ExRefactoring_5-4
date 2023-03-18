//
//  ViewController.swift
//  ExRefactoring5_4
//
//  Created by 김종권 on 2023/03/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

struct Product {
    let basePrice: Double = 0
    let discountRate: Double = 1
    let discountThreshold: Double = 2
}

struct ShippingMethod {
    let discountThreshold: Double = 1
    let discountRate: Double = 2
    let discountFee: Double = 3
    let feePerCase: Double = 4
}

struct PriceData {
    let basePrice: Double
    let quantity: Double
    let discount: Double
}

func priceOrder(product: Product, quantity: Double, shippingMethod: ShippingMethod) -> Double {
    let priceData = calculatePricingData(product: product, quantity: quantity)
    let price = applyShipping(priceData: priceData, shippingMethod: shippingMethod)
    return price
}

func calculatePricingData(product: Product, quantity: Double) -> PriceData {
    let basePrice = product.basePrice * quantity
    let discount = max(quantity - product.discountThreshold, 0) * product.basePrice * product.discountRate
    let priceData = PriceData(basePrice: basePrice, quantity: quantity, discount: discount)
    return priceData
}

func applyShipping(priceData: PriceData, shippingMethod: ShippingMethod) -> Double {
    let shippingPerCase = (priceData.basePrice > shippingMethod.discountThreshold) ? shippingMethod.discountFee : shippingMethod.feePerCase
    let shippingCost = priceData.quantity * shippingPerCase
    let price = priceData.basePrice - priceData.discount + shippingCost
    return price
}
