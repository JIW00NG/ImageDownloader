//
//  DownloadImageViewModel.swift
//  ImageDownloader
//
//  Created by JiwKang on 2023/03/01.
//

import UIKit

enum DownloadError: Error {
    case downloadFail
}

struct DownloadImageViewModel {
    
    // MARK: - Properties
    
    private let urlStrings: [String] = ["https://images.unsplash.com/photo-1677041752552-a492645630c8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY3NzY3NjEyOQ&ixlib=rb-4.0.3&q=80&w=1080", "https://images.unsplash.com/photo-1677216794333-c6efad6f23f3?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY3NzY3NzkyNg&ixlib=rb-4.0.3&q=80&w=1080", "https://images.unsplash.com/photo-1675369512729-655c6e7ec6a6?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY3NzY3NzkzNw&ixlib=rb-4.0.3&q=80&w=1080", "https://images.unsplash.com/photo-1676807882724-1027059e6289?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY3NzY3NzkzMg&ixlib=rb-4.0.3&q=80&w=1080", "https://images.unsplash.com/photo-1675767528183-628d7e46ae59?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY3NzY3Nzk4Ng&ixlib=rb-4.0.3&q=80&w=1080"]
    
    var urlCount: Int {
        return urlStrings.count
    }
    
    // MARK: - Functions
    
    func downloadImageFromURL(i: Int) async throws -> UIImage? {
        if i >= urlCount || i < 0 { return nil }
        
        guard let url = URL(string: urlStrings[i]) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else {
            throw DownloadError.downloadFail
        }
        
        return image
    }
}
