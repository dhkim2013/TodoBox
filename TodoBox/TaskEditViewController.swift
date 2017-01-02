//
//  TaskEditViewController.swift
//  TodoBox
//
//  Created by almond on 2016. 12. 19..
//  Copyright © 2016년 almond. All rights reserved.
//

import UIKit

class TaskEditViewController: UIViewController {
    
    @IBOutlet var titleInput: UITextField!
    @IBOutlet var memoInput: UITextView!
    
    var didAddTask: ((Task) -> Void)?
    
    @IBAction func cancelButtonDidTap() {
        if let title = titleInput.text, title.isEmpty {
            self.dismiss(animated: true, completion: nil)
        }
        
        else {
            let alertController = UIAlertController(title: "헉!", message: "진짜 취소 할거임????", preferredStyle: .alert)
            let yes = UIAlertAction(title: "예", style: .destructive) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            let no = UIAlertAction(title: "아니오", style: .default, handler: nil)
            alertController.addAction(no)
            alertController.addAction(yes)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func doneButtonDidTap() {
        guard let title = titleInput.text,
            !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            // 왼쪽으로 10
            UIView.animate(
                withDuration: 0.1,
                animations: { self.titleInput.frame.origin.x -= 5 },
                completion: { _ in
                    // 오른쪽으로 20
                    UIView.animate(
                        withDuration: 0.1,
                        animations: { self.titleInput.frame.origin.x += 10 },
                        completion: { _ in
                            // 왼쪽으로 20
                            UIView.animate(
                                withDuration: 0.1,
                                animations: { self.titleInput.frame.origin.x -= 10 },
                                completion: { _ in
                                    // 오른쪽으로 20
                                    UIView.animate(
                                        withDuration: 0.1,
                                        animations: { self.titleInput.frame.origin.x += 10 },
                                        completion: { _ in
                                            // 왼쪽으로 10
                                            // 이때 다시 제자리 ㅇㅇ
                                            UIView.animate(
                                                withDuration: 0.1,
                                                animations: { self.titleInput.frame.origin.x -= 5 },
                                                completion: { _ in self.titleInput.becomeFirstResponder() }
                                            )
                                        }
                                    )
                                }
                            )
                        }
                    )
                }
            )
            
            return
        }
        
        let newTask = Task(title: title)
        
        self.didAddTask?(newTask)
        self.dismiss(animated: true, completion: nil)
    }
    
}
