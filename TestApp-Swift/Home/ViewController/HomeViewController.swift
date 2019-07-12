//
//  HomeViewController.swift
//  TestApp-Swift
//
//  Created by Dina Mansour on 10/5/18.
//  Copyright © 2018 TestApplication. All rights reserved.
//

import Foundation
import UIKit
import Typist
import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class HomeViewController: BaseViewController,  UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    var model: BaseModel!
    var titles: NSArray!
    var images: NSArray!
    var imageModel: ImageModel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
         self.view.backgroundColor = UIColor(patternImage: UIImage(named:"bg.png")!)
        
        if isNetworkConnected(){
            showProgressDialog()
            callNetwork()
        }else{
            showNoNetworkConnectedMessage()
        }
        
        
    }
    
    func callNetwork(){
        
        let viewModel = HomeViewModel()
        
        
        
        viewModel.home()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] model in
                
                self.model = model
                if (model != nil){
                    self.titles =   model.valuesRanges[0].values[0] as NSArray
                    self.images =  model.valuesRanges[1].values[0] as NSArray
                    self.imageModel = ImageModel.init(images: model.valuesRanges[1].values[0])
                    let db = HomeDatabaseHelper.init()
                    db.saveImages(images:self.imageModel!)
                   
                }
                
                self.tableView!.reloadData()
     
           
                
            })
            .disposed(by: disposeBag)
        
        
        viewModel.activityIndicator
            .distinctUntilChanged()
            .drive(onNext: { [unowned self] active in
                self.hideProgressDialog()
                
            })
            .addDisposableTo(disposeBag)
        
        
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (titles?.count != nil){
            return titles.count
        }else{
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        
        var cell: HomeTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "home") as? HomeTableViewCell
        if cell == nil {
            tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "home")
            cell = tableView.dequeueReusableCell(withIdentifier: "home") as? HomeTableViewCell
        }
        
        
        cell.tag = indexPath.row
   
        
        cell.label.text = titles[indexPath.row] as! String
        if (indexPath.row<imageModel.images.count ){
            if (imageModel?.images[indexPath.row] != nil){
                
                cell.imagee.sd_setImage(with: URL(string: imageModel.images[indexPath.row] ) , placeholderImage:UIImage(named:"logo.png"))
            }
            
            
        }
        
        
        return cell;
    }


}
