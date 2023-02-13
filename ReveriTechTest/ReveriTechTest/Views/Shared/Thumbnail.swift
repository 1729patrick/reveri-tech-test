//
//  ThumbnailView.swift
//  ReveriTechTest
//
//  Created by Patrick Battisti Forsthofer on 13/11/22.
//

import SwiftUI

struct ThumbnailView: View {
    //    BUG: for debug purposes, cache works fine with one URL and doesn't work with the API proposed xD
    //    var goodURL = "https://infatuation.imgix.net/media/images/guides/6-diy-burger-meal-kits/banners/1606222689.1394382.png"
    //    var badURL = "https://dummyjson.com/image/i/products/2/thumbnail.jpg"
    
    var url: String
    
    var body: some View {
        VStack {
            CachedImage(url: url) { phase in
                switch phase {
                case .empty:
                    ImagePlaceholder()
                    
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure(_):
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                        .foregroundColor(.primary)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        ThumbnailView(url: "https://infatuation.imgix.net/media/images/guides/6-diy-burger-meal-kits/banners/1606222689.1394382.png")
    }
}
