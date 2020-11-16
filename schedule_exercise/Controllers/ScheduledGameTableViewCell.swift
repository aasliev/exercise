//
//  ScheduledGameTableViewCell.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/14/20.
//

import UIKit

class ScheduledGameTableViewCell: UITableViewCell {

    @IBOutlet weak var leftTeamName: UILabel!
    @IBOutlet weak var rightTeamName: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var gameState: UILabel!
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var BYEWeekLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        leftTeamName.font = LabelFonts.kTeamNameFont
        rightTeamName.font = LabelFonts.kTeamNameFont
        homeScore.font = LabelFonts.kScoreFont
        awayScore.font = LabelFonts.kScoreFont
        time.font = LabelFonts.k3RDLevelFont
        gameState.font = LabelFonts.k3RDLevelFont
        week.font = LabelFonts.k3RDLevelFont
        week.textColor = UIColor(rgb: 0x999999)
        BYEWeekLabel.textColor = UIColor(rgb: 0x999999)
        //BYEWeekLabel.font = LabelFonts.kBYEFont
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}