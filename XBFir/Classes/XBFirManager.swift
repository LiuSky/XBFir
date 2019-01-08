//
//  XBFirManager.swift
//  Pods-XBFir_Example
//
//  Created by xiaobin liu on 2019/1/8.
//

import UIKit
import Foundation


/// MARK - Fir管理类
public class XBFirManager {
    
    /// firAppId
    private let firAppId: String
    
    /// appToken
    private let apptoken: String
    
    /// 请求Api
    private var requestApi: String {
        return "http://api.fir.im/apps/latest/\(firAppId)?api_token=\(apptoken)"
    }
    
    /// 初始化
    public init(firAppId: String, apptoken: String) {
        self.firAppId = firAppId
        self.apptoken = apptoken
    }
    
    /// MARK - fir更新通知
    public func firUpdate() {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        guard let requestUrl = URL(string: requestApi) else {
            return
        }
        let request = URLRequest(url: requestUrl)
        session.dataTask(with: request) { (data, response, error) in
            
            if let temData = data,
                let result = try? JSONSerialization.jsonObject(with: temData, options: .mutableContainers) as! [String: Any],
                let versionShort = result["versionShort"] as? String,
                let bundleVersion = result["version"] as? String,
                let updateUrl = result["update_url"] as? String
            {
                
                /// 修改资料
                let changelog = result["changelog"] as? String ?? ""
                /// 本地版本号
                let localVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0"
                /// 本地编译版本号
                let localBundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
                /// 版本号比较
                if (Int(localBundleVersion)! - Int(bundleVersion)! < 0 || localVersion.compare(versionShort) == ComparisonResult.orderedAscending) {
                    
                    let messageString = "新版本" + "\(versionShort)(\(bundleVersion))," + "是否更新?"
                    let alertController = UIAlertController(title: messageString, message: changelog, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
                    alertController.addAction(UIAlertAction(title: "更新", style: .default) { _ in
                        let url = URL(string: updateUrl)!
                        UIApplication.shared.openURL(url)
                    })
                    
                    if  let message = alertController.view.subviews[0]
                        .subviews[0]
                        .subviews[0]
                        .subviews[0]
                        .subviews[0]
                        .subviews[1] as? UILabel {
                        message.textAlignment = .left
                    }
                    guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
                        return
                    }
                    vc.present(alertController, animated: true, completion: nil)
                }
            }
            }.resume()
    }
}
