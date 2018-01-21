//
//  SignUpViewController.swift
//  FiNote
//
//  Created by 岩見建汰 on 2018/01/21.
//  Copyright © 2018年 Kenta. All rights reserved.
//

import Eureka
import PopupDialog
import NVActivityIndicatorView
import Alamofire
import SwiftyJSON
import KeychainAccess

class SignUpViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.CreateForm()
        self.tableView.isScrollEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Sign Up"
    }
    
    func CreateForm() {
        LabelRow.defaultCellUpdate = { cell, row in
            cell.contentView.backgroundColor = .red
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            cell.textLabel?.textAlignment = .right
        }
        
        let birthyears = GetBirthYears()

        
        form +++ Section("ユーザ情報")
            <<< TextRow(){
                $0.title = "UserName"
                $0.value = ""
                $0.add(rule: RuleRequired(msg: "必須項目です"))
                $0.validationOptions = .validatesOnChange
                $0.tag = "username"
            }
            .onRowValidationChanged {cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, err) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow() {
                            $0.title = err
                            $0.cell.height = { 30 }
                        }
                        row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                    }
                }
            }
        
            <<< PasswordRow(){
                $0.title = "Password"
                $0.value = ""
                $0.add(rule: RuleRequired(msg: "必須項目です"))
                $0.validationOptions = .validatesOnChange
                $0.tag = "password"
            }
            .onRowValidationChanged {cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, err) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow() {
                            $0.title = err
                            $0.cell.height = { 30 }
                        }
                        row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                    }
                }
            }
        
        
            <<< TextRow(){
                $0.title = "Email"
                $0.value = ""
                $0.add(rule: RuleRequired(msg: "必須項目です"))
                $0.add(rule: RuleRegExp(regExpr: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}", allowsEmpty: false, msg: "メールアドレスの形式を再確認してください"))
                $0.validationOptions = .validatesOnChange
                $0.tag = "email"
            }
            .onRowValidationChanged {cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, err) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow() {
                            $0.title = err
                            $0.cell.height = { 30 }
                        }
                        row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                    }
                }
            }
            
            
            <<< PickerInputRow<Int>(""){
                $0.title = "BirthYear"
                $0.value = birthyears[0]
                $0.options = birthyears
                $0.add(rule: RuleRequired(msg: "必須項目です"))
                $0.validationOptions = .validatesOnChange
                $0.tag = "birthyear"
            }
            .onRowValidationChanged {cell, row in
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, err) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow() {
                            $0.title = err
                            $0.cell.height = { 30 }
                        }
                        row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                    }
                }
            }
        
        
        form +++ Section(header: "", footer: "他サービスで使用しているユーザ名、パスワードは使用しないでください")
            <<< ButtonRow(){
                $0.title = "Sign Up"
                $0.baseCell.backgroundColor = UIColor.hex(Color.main.rawValue, alpha: 1.0)
                $0.baseCell.tintColor = UIColor.white
                $0.tag = "signup"
            }
            .onCellSelection {  cell, row in
                let popup = PopupDialog(title: "Sign Up Error", message: "必須項目を入力してください")
                let button = DefaultButton(title: "OK", dismissOnTap: true) {}
                popup.addButtons([button])

                if IsCheckFormValue(form: self.form) {
                    self.CallSignUpAPI()
                }else {
                    self.present(popup, animated: true, completion: nil)
                }
            }
    }
    
    func CallSignUpAPI() {
        let activityData = ActivityData(message: "Sign Up Now", type: .lineScaleParty)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        DispatchQueue(label: "sign-up").async {
            let urlString = API.base.rawValue+API.v1.rawValue+API.user.rawValue+API.signup.rawValue
            Alamofire.request(urlString, method: .post, parameters: self.form.values(), encoding: JSONEncoding(options: [])).responseJSON { (response) in
                let obj = JSON(response.result.value)
                print("***** API results *****")
                print(obj)
                print("***** API results *****")
                
                let keychain = Keychain()
                try! keychain.set(self.form.values()["username"] as! String, key: "username")
                try! keychain.set(self.form.values()["password"] as! String, key: "password")
                try! keychain.set(obj["id"].stringValue, key: "id")
                
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let signVC = storyboard.instantiateViewController(withIdentifier: "Main")
                self.present(signVC, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}