//
//  ViewModel.swift
//  FirebaseIntroduction
//
//  Created by Nattapong Unaregul on 8/11/17.
//  Copyright © 2017 Nattapong Unaregul. All rights reserved.
//
import UIKit
import FirebaseDatabase

protocol ViewModelDelegate : class {
    func didAppendData(indexPath : IndexPath)
    func didFinishLoadDataOnInitilization()
    func didRemoveData(indexPath : IndexPath)
    func didFinishUpdate(indexPath : IndexPath , product : Product )
}
class ViewModel: NSObject {
    var fbAPI : FBApi!
    var products : [Product] = [Product]()
    weak var delegate : ViewModelDelegate?
    fileprivate var initialDataHasBeenLoaded : Bool = false
    override init() {
        super.init()
    }
    func initilization()  {
        fbAPI = FBApi()
        fbAPI.storageRef.observeSingleEvent(of: .value, with: {[weak self] (snapshot) in
            guard let the = self else {
                return
            }
            for item in snapshot.children {
                let (data,value)  =   FBSnapShotToDictForClassMapping(any: item)
                let product = Product(id: data.key, dict: value)
                the.products.append(product)
            }
            the.initialDataHasBeenLoaded = true
            the.delegate?.didFinishLoadDataOnInitilization()
        })
    
        fbAPI.storageRef.observe(.childChanged, with: {[weak self] (snapshot) in
            guard let the = self else {
                return
            }
            if the.initialDataHasBeenLoaded {
                
                guard let index = the.products.index(where: { (p) -> Bool in
                    p.id == snapshot.key
                }) else {
                    return
                }
                let value = snapshot.value as! Dictionary<String, AnyObject> // 2
                let product = Product(id: snapshot.key, dict: value)
                the.products[index] = product
                the.delegate?.didFinishUpdate(indexPath: IndexPath(item: index, section: 0), product: product)
            }
            }, withCancel: nil)

        self.observingOnStorageAdd()
    }
    func getTitleIndexPath(indexPath : IndexPath) -> String {
        return products[indexPath.item].name
    }
    func removeProduct(indexPath : IndexPath)  {
        fbAPI.storageRef.child(products[indexPath.item].id).removeValue {[weak self] (error, refer) in
            if let _ = error , self == nil {
                return
            }
            self?.products.remove(at: indexPath.item)
            self?.delegate?.didRemoveData(indexPath: indexPath)
        }
    }
    func addProduct(name : String?)  {
        guard let name = name , name != "" else {
            return
        }
        fbAPI.add(product: Product(name: name))
    }
    func observingOnStorageAdd()  {
        fbAPI.storageRef.observe(.childAdded, with: {[weak self] (snapshot) in
            guard let the = self else {
                return
            }
            if the.initialDataHasBeenLoaded {
                let value = snapshot.value as! Dictionary<String, AnyObject> // 2
                let product = Product(id: snapshot.key, dict: value)
                the.products.append(product)
                the.delegate?.didAppendData(indexPath: IndexPath(item: the.products.count - 1 , section: 0))
            }
        })
    }
    deinit {
        print("deinit In ViewModel")
    }
}
