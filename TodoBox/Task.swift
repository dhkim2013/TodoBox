//
//  Task.swift
//  TodoBox
//
//  Created by almond on 2016. 12. 19..
//  Copyright © 2016년 almond. All rights reserved.
//

struct Task {
    var title: String
    var memo: String?
    var done: Bool
    
    init(title: String, memo: String? = nil, done: Bool = false) {
        self.title = title
        self.memo = memo
        self.done = done
    }
    
    init?(dictionary: [String: Any]) {
        guard let title = dictionary["title"] as? String,
            let done = dictionary["done"] as? Bool
            else { return nil }
        self.title = title
        self.memo = dictionary["memo"] as? String
        self.done = done
    }
}
