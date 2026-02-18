import SwiftUI

struct ContentView: View {
    
    let videos = VideoList.topTwelve
    
    var body: some View {
        NavigationView {
            List(videos) { video in
                HStack {
                    Image(video.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                        .cornerRadius(8)
                    
                    Spacer().frame(width: 16)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(video.title)
                            .font(.headline)
                            .lineLimit(2)
                        
                        Text(video.uploadDate)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Hussain's Videos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
