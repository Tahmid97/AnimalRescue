//
//  FavoritesWidget.swift
//  FavoritesWidget
//
//  Created by Sami Tamim on 12/6/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    @AppStorage("animal", store: UserDefaults(suiteName: "group.com.TahmidMuttaki.AnimalRescue.AnimalWidget"))
    var widgetData: Data = Data()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), pictureUrl: "...", animalName: "...")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let animal = try? JSONDecoder().decode(AnimalStruct.self, from: widgetData) else {
            print("error decoding animal")
            return }
        let entry = SimpleEntry(date: Date(), pictureUrl: animal.photoUrl, animalName: animal.name)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        guard let animal = try? JSONDecoder().decode(AnimalStruct.self, from: widgetData) else {
            print("error decoding animal")
            return }
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 3 {
            let entryDate = Calendar.current.date(byAdding: .second, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, pictureUrl: animal.photoUrl, animalName: animal.name)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let pictureUrl: String
    let animalName: String
}

struct FavoritesWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            Color
                .gray
                .opacity(0.9)
                .edgesIgnoringSafeArea(.all)
            
            getImageFromUrl(url: entry.pictureUrl, defaultFilename: "ImageUnavailable")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack{
                Text(entry.animalName)
                    .padding(.top, 10)
                Spacer()
            }
            
        }
    }
}

@main
struct FavoritesWidget: Widget {
    let kind: String = "FavoritesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FavoritesWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Favorites Widget")
        .description("This widget will show images of favorite pets.")
    }
}

struct FavoritesWidget_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesWidgetEntryView(entry: SimpleEntry(date: Date(), pictureUrl: "...", animalName: "..."))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
