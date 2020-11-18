//
//  ScheduledGameTableViewController.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/14/20.
//

import UIKit

let urlString : String = "http://files.yinzcam.com.s3.amazonaws.com/iOS/interviews/ScheduleExercise/schedule.json";
let cache = ImageCache()


class ScheduledGameTableViewController: UITableViewController {
    
    let currentTeam = TeamScheduleData(apiURL: urlString)
    var scheduledGames  =  [GameSections]()
    var teamInfo = TeamDetails()
    var currentYear = String()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load dataObjects
        self.scheduledGames = self.currentTeam.getGameSections()
        self.teamInfo = self.currentTeam.getTeamInfo()
        self.currentYear = self.currentTeam.getCurrentYear() ?? ""
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x234E57)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.scheduledGames.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
//        sectionHeader.backgroundColor = .red
        let backGroundImage = UIImageView(image: UIImage(named: "list_header"))
        backGroundImage.frame = sectionHeader.bounds
        sectionHeader.addSubview(backGroundImage)
        let headerTitle = UILabel(frame: sectionHeader.bounds)
        headerTitle.textAlignment = .center
        headerTitle.text = " \(self.currentYear) \(self.scheduledGames[section].section ?? "")"
        headerTitle.font = LabelFonts.kHeaderFont
        headerTitle.textColor = UIColor(rgb: 0x999999)
        sectionHeader.addSubview(headerTitle)

        return sectionHeader

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.scheduledGames[section].games?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! ScheduledGameTableViewCell
        let game = scheduledGames[indexPath.section].games?[indexPath.row]
        
//        print("Week: \(game?.week) type \(game?.type)")

        if (game?.type == "B"){
            cell.BYEWeekLabel.isHidden = false
            cell.hideLabels()
            


        }
        else {
            cell.BYEWeekLabel.isHidden = true
            cell.hideLabels()
            
            cell.homeScore.text = game?.homeScore
            cell.awayScore.text = game?.awayScore
            cell.time.text = self.convertISO8601ToDate(timestamp: (game?.date?.timestamp) ?? "")[0]
            cell.week.text = game?.week.uppercased()
            
            if (game?.isHome != "true"){
                // current team is playing away
                cell.homeTeamName.text = game?.opponent?.name
                cell.awayTeamName.text = teamInfo.name
                  
//                cell.homeTeamImage.loadImge(withTriCode: game?.opponent?.triCode ?? "")
//                cell.awayTeamImage.loadImge(withTriCode: teamInfo.triCode ?? "")
//
                
                //ImageLoader attempt
//                cell.homeTeamImage.image = ImageLoader.shared.loadImage(withTriCode: game?.opponent?.triCode ?? "" )
//                cell.awayTeamImage.image = ImageLoader.shared.loadImage(withTriCode: teamInfo.triCode ?? "" )

//                print("finished function call")
                
                //IMageLoaderClass with UIImageView extension attempt
//                cell.homeTeamImage.loadImage(withTriCode: game?.opponent?.triCode ?? "")
//                cell.awayTeamImage.loadImage(withTriCode: teamInfo.triCode ?? "")

                // get linsk for logo with trycode
                let homeTeamLink = self.getLogoLink(withTriCode: game?.opponent?.triCode)
                let awayTeamLink = self.getLogoLink(withTriCode: teamInfo.triCode)
                cell.homeTeamImage.loadImage(fromUrl: homeTeamLink)
                cell.awayTeamImage.loadImage(fromUrl: awayTeamLink)
                
                
            } else {
                cell.homeTeamName.text = teamInfo.name
                cell.awayTeamName.text = game?.opponent?.name

//                cell.homeTeamImage.loadImge(withTriCode: teamInfo.triCode ?? "")
//                cell.awayTeamImage.loadImge(withTriCode: game?.opponent?.triCode ?? "")
                    
                
                
                
                //
//                cell.homeTeamImage.image = ImageLoader.shared.loadImage(withTriCode: teamInfo.triCode ?? "" )
//                cell.awayTeamImage.image = ImageLoader.shared.loadImage(withTriCode: game?.opponent?.triCode ?? "" )
                
                //ImageLoaderClass with UIImageView extension attemp
//                cell.homeTeamImage.loadImage(withTriCode: teamInfo.triCode ?? "")
//                cell.awayTeamImage.loadImage(withTriCode: game?.opponent?.triCode ?? "")
                
                
                let homeTeamLink = self.getLogoLink(withTriCode: teamInfo.triCode)
                let awayTeamLink = self.getLogoLink(withTriCode: game?.opponent?.triCode)
                cell.homeTeamImage.loadImage(fromUrl: homeTeamLink)
                cell.awayTeamImage.loadImage(fromUrl: awayTeamLink)

            }
            
            if (game?.type == "F"){
                cell.gameState.text = game?.gameState?.uppercased()
            } else {
                cell.gameState.text = self.convertISO8601ToDate(timestamp: game?.date?.timestamp ?? "")[1]
                
                cell.homeScore.font = LabelFonts.kScoreFontScheduledGame
                cell.homeScore.textColor = UIColor(rgb: 0x999999)
                
                cell.awayScore.font = LabelFonts.kScoreFontScheduledGame
                cell.awayScore.textColor = UIColor(rgb: 0x999999)
            }

        }
        return cell
        
    }
    
    
    // function to convert ISO8601 format timestamp to date
    func convertISO8601ToDate(timestamp: String) -> [String]{
        let formatterInput = ISO8601DateFormatter()
        var time = [String]()
        if let date = formatterInput.date(from: timestamp){
            let formatterOutput = DateFormatter()
            formatterOutput.dateFormat = "E, MMM d-h:mm a"
            formatterOutput.locale = Locale.current
            formatterOutput.timeZone = TimeZone.current
            time = formatterOutput.string(from: date).components(separatedBy: "-")
        }
        return time
    }
    
    
    
    @IBAction func checkPrint(_ sender: Any) {
        print("--------------------------------------")
    }
    
    func getLogoLink(withTriCode triCode: String?)->String{
        return "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode!.lowercased())_light.png"
    }
    
}

//
//extension UIImageView {
//    
//    
//    func loadImge(withTriCode triCode: String) {
//        let urlString = "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode.lowercased())_light.png"
//        var isLoaded : Bool = false
//        //check cache if image is already downloaded
//        if let image = cache[urlString as NSString] {
//            print("cache hit ---> \(triCode)  ")
//            DispatchQueue.main.async {[weak self] in
//                self?.image =  image
//                isLoaded = true
//            }
//        }
//        if (!isLoaded){
//        guard let url = URL(string: urlString) else {return}
//           DispatchQueue.global().async { [weak self] in
//               if let imageData = try? Data(contentsOf: url) {
//                   if let image = UIImage(data: imageData) {
//                       DispatchQueue.main.async {
//                        cache.insert(image, for: urlString)
//                        print("cache miss. loading logo from url ----> \(triCode)")
//                        self?.image = image
//                       }
////                    cache[urlString as NSString] = image
//
//                   }
//               }
//           }
//        }
//       }
//}
