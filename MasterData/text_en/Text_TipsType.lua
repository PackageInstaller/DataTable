__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "Changing resolution requires a client restart to take effect. Proceed?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "Cancel"},
  TipsType_100001_RightBtnDesc = {Text = "Confirm"},
  TipsType_100001_Title = {
    Text = "Resolution Switch Confirm"
  },
  TipsType_100002_Desc = {
    Text = "Waiting for {s1} to accept your invite..."
  },
  TipsType_100002_RightBtnDesc = {Text = "Cancel"},
  TipsType_100002_Title = {
    Text = "Another Round"
  },
  TipsType_100003_Desc = {
    Text = "{s1} invites you to play another round."
  },
  TipsType_100003_LeftBtnDesc = {Text = "Refuse"},
  TipsType_100003_RightBtnDesc = {Text = "Accept"},
  TipsType_100003_Title = {
    Text = "Another Round"
  },
  TipsType_100004_Desc = {
    Text = "Already set as current dorm background."
  },
  TipsType_100005_Desc = {
    Text = "Traphase Is Not Yet Available"
  },
  TipsType_100006_Desc = {
    Text = "The other player hasn't unlocked Traphase mode."
  },
  TipsType_100007_Desc = {
    Text = "You must follow each other to start a Friendly Match."
  },
  TipsType_100008_Desc = {
    Text = "The other party is offline."
  },
  TipsType_100009_Desc = {
    Text = "The other player is currently on an investigation."
  },
  TipsType_100010_Desc = {
    Text = "Friendly Match request timed out."
  },
  TipsType_100011_Desc = {
    Text = "You have canceled the Friendly Match."
  },
  TipsType_100012_Desc = {
    Text = "Friendly Match invitation declined."
  },
  TipsType_100012_LeftBtnDesc = {Text = "Confirm"},
  TipsType_100012_Title = {
    Text = "Investigation in Progress"
  },
  TipsType_100013_Desc = {
    Text = "The other party is offline."
  },
  TipsType_100014_Desc = {
    Text = "The other player has entered another game mode."
  },
  TipsType_100015_Desc = {
    Text = "Invitation sent too frequently. Try again in {s1}s."
  },
  TipsType_100016_Desc = {
    Text = "The other player has canceled the Friendly Match."
  },
  TipsType_100016_LeftBtnDesc = {Text = "Confirm"},
  TipsType_100016_Title = {
    Text = "Investigation in Progress"
  },
  TipsType_100017_Desc = {
    Text = "This player is currently in a Friendly Match."
  },
  TipsType_100017_LeftBtnDesc = {Text = "Confirm"},
  TipsType_100017_Title = {
    Text = "Investigation in Progress"
  },
  TipsType_100018_Desc = {
    Text = [[
This team includes time-limited cards. You need to unlock this Season's Premium Topics to continue. Looking forward to fighting side by side with you again!
Go unlock the Premium Topics now?]]
  },
  TipsType_100018_LeftBtnDesc = {Text = "Cancel"},
  TipsType_100018_RightBtnDesc = {Text = "Confirm"},
  TipsType_100018_Title = {
    Text = "Premium Topics has expired"
  },
  TipsType_10001_Desc = {Text = "Success"},
  TipsType_100020_Desc = {
    Text = "Would you like to continue the ongoing investigation?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "Cancel"},
  TipsType_100020_RightBtnDesc = {Text = "Continue"},
  TipsType_100020_Title = {Text = "Notice"},
  TipsType_10002_Desc = {
    Text = "Config data error"
  },
  TipsType_10003_Desc = {
    Text = "Client data input error"
  },
  TipsType_10004_Desc = {
    Text = "Server Not Started"
  },
  TipsType_10005_Desc = {
    Text = "Character data error"
  },
  TipsType_10006_Desc = {
    Text = "No Awakener data found"
  },
  TipsType_10007_Desc = {
    Text = "Awakener has reached the maximum level."
  },
  TipsType_10008_Desc = {
    Text = "Not Enough Topic Points"
  },
  TipsType_10009_Desc = {
    Text = "The Awakener has not reached the maximum level and cannot be Enlightened."
  },
  TipsType_100100_Desc = {
    Text = "A new version is available. If the update does not start automatically, please try restarting Steam to check for updates."
  },
  TipsType_100100_RightBtnDesc = {Text = "Confirm"},
  TipsType_100100_Title = {
    Text = "Update Hint"
  },
  TipsType_10010_Desc = {
    Text = "Enlighten Complete"
  },
  TipsType_10011_Desc = {
    Text = "No character has been created yet."
  },
  TipsType_10012_Desc = {
    Text = "Current Characters"
  },
  TipsType_10013_Desc = {
    Text = "Duplicate Character Name"
  },
  TipsType_10014_Desc = {
    Text = "Domain Area Error"
  },
  TipsType_10015_Desc = {
    Text = "Unable to locate the Domain area."
  },
  TipsType_10016_Desc = {
    Text = "Current HP is too low."
  },
  TipsType_10017_Desc = {
    Text = "Unlocks at {s1} to {s2}"
  },
  TipsType_10018_Desc = {
    Text = "After reaching the second floor of this Domain 1 time, you can perform a Quick Investigation."
  },
  TipsType_10019_Desc = {
    Text = "Event Completed"
  },
  TipsType_10020_Desc = {
    Text = "Incorrect type entry in the event configuration table."
  },
  TipsType_10021_Desc = {
    Text = "Event Does Not Exist"
  },
  TipsType_10022_Desc = {
    Text = "Not enough Black Sigils to purchase."
  },
  TipsType_10023_Desc = {
    Text = "This card cannot be enhanced."
  },
  TipsType_10024_Desc = {
    Text = "This card has reached the max enhance limit."
  },
  TipsType_10025_Desc = {
    Text = "The merchant does not sell this item."
  },
  TipsType_10026_Desc = {
    Text = "No Such Reward"
  },
  TipsType_10027_Desc = {
    Text = "Reward Claimed"
  },
  TipsType_10028_Desc = {
    Text = "Event data error"
  },
  TipsType_10029_Desc = {
    Text = "Already purchased"
  },
  TipsType_10030_Desc = {
    Text = "Current energy is insufficient to activate the Gate. Activating the Gate requires {s1} energy."
  },
  TipsType_10031_Desc = {
    Text = "No Story Dialogue Event Found"
  },
  TipsType_10032_Desc = {
    Text = "Not enough Command Cards selected for the event."
  },
  TipsType_10033_Desc = {
    Text = "Too many Command Cards selected for the event."
  },
  TipsType_10034_Desc = {
    Text = "Event selection Command Cards does not exist."
  },
  TipsType_10035_Desc = {
    Text = "No data in the random event pool."
  },
  TipsType_10036_Desc = {
    Text = "The merchant does not sell this item."
  },
  TipsType_10037_Desc = {
    Text = "Insufficient Relics selected for the event"
  },
  TipsType_10038_Desc = {
    Text = "Too many Relics selected for the event."
  },
  TipsType_10039_Desc = {
    Text = "Selected Relic for the event does not exist"
  },
  TipsType_10040_Desc = {
    Text = "Event Node Not Found"
  },
  TipsType_10041_Desc = {
    Text = "Merchant Refresh count has been exhausted."
  },
  TipsType_10042_Desc = {
    Text = "Battle drop Command Card Refresh count has been exhausted."
  },
  TipsType_10043_Desc = {
    Text = "Battle drop Relic Refresh attempts have been exhausted."
  },
  TipsType_10044_Desc = {
    Text = "Junction function is locked"
  },
  TipsType_10045_Desc = {
    Text = "Event region mismatch! Current region: {s1}, event configured region: {s2}."
  },
  TipsType_10046_Desc = {
    Text = "Attempts to remove cards in the event shop have been exhausted"
  },
  TipsType_10047_Desc = {
    Text = "Topic Unit Data Not Found"
  },
  TipsType_10048_Desc = {
    Text = "Unit has been submitted. No need to resubmit."
  },
  TipsType_10049_Desc = {
    Text = "Not all tasks under the unit have been completed yet. Unable to submit."
  },
  TipsType_10050_Desc = {
    Text = "Course Module Not Found"
  },
  TipsType_10051_Desc = {
    Text = "Stage Has No Challenge Data"
  },
  TipsType_10052_Desc = {
    Text = "No courses available for this Domain."
  },
  TipsType_10053_Desc = {
    Text = "Insufficient credits, unable to claim rewards."
  },
  TipsType_10054_Desc = {
    Text = "The credit reward conditions have not been met yet."
  },
  TipsType_10055_Desc = {
    Text = "No tasks found in the subject section."
  },
  TipsType_10056_Desc = {
    Text = "Subtask Completed"
  },
  TipsType_10057_Desc = {
    Text = "Sub-tasks within the project subtasks are not completed."
  },
  TipsType_10058_Desc = {
    Text = "NPC Has Been Triggered"
  },
  TipsType_10059_Desc = {
    Text = "NPC data error"
  },
  TipsType_10060_Desc = {
    Text = "NPC does not exist"
  },
  TipsType_10061_Desc = {
    Text = "Not Discovered in Domain"
  },
  TipsType_10062_Desc = {
    Text = "No Resonance Data Discovered"
  },
  TipsType_10063_Desc = {
    Text = "Resonance has reached the maximum level."
  },
  TipsType_10064_Desc = {
    Text = "No Resonance Level-related data found."
  },
  TipsType_10065_Desc = {
    Text = "No Resets Remaining"
  },
  TipsType_10066_Desc = {
    Text = "Resonance activation conditions not met."
  },
  TipsType_10067_Desc = {
    Text = "Insufficient Resonance Particles"
  },
  TipsType_10068_Desc = {
    Text = "Enlighten is complete, cannot Enlighten again."
  },
  TipsType_10069_Desc = {
    Text = "Insufficient materials required for Enlighten."
  },
  TipsType_10070_Desc = {
    Text = "Insufficient materials to upgrade the Awakener."
  },
  TipsType_10071_Desc = {
    Text = "Insufficient Rose Scrip to upgrade the Awakener."
  },
  TipsType_10072_Desc = {
    Text = "Insufficient Rose Scrip to upgrade the Awakener."
  },
  TipsType_10073_Desc = {
    Text = "No Awakener Skills"
  },
  TipsType_10074_Desc = {
    Text = "Awakener Skill Locked"
  },
  TipsType_10075_Desc = {
    Text = "Not enough \"Silver\" required for Awakening."
  },
  TipsType_10076_Desc = {
    Text = "Insufficient items"
  },
  TipsType_10077_Desc = {
    Text = "You have reached the daily purchase limit"
  },
  TipsType_10078_Desc = {
    Text = "Item cannot be used"
  },
  TipsType_10079_Desc = {
    Text = "Incorrect item usage quantity"
  },
  TipsType_10080_Desc = {
    Text = "Skill has reached the maximum level"
  },
  TipsType_10081_Desc = {
    Text = "Not Enough Materials to Upgrade"
  },
  TipsType_10082_Desc = {
    Text = "Not Enough Currency to Upgrade"
  },
  TipsType_10083_Desc = {
    Text = "Awakener link rate has reached the maximum Level."
  },
  TipsType_10084_Desc = {
    Text = "This Awakener has insufficient Origin Spirit."
  },
  TipsType_10085_Desc = {
    Text = "The upgrade path does not have a configured character ID"
  },
  TipsType_10086_Desc = {
    Text = "Cannot find the specified exclusive card information"
  },
  TipsType_10087_Desc = {
    Text = "Designated exclusive card not unlocked"
  },
  TipsType_10088_Desc = {
    Text = "Cannot find the UUID for this exclusive card"
  },
  TipsType_10089_Desc = {
    Text = "Chapter rewards not reaching the required points"
  },
  TipsType_10090_Desc = {
    Text = "Chapter rewards have been claimed"
  },
  TipsType_10091_Desc = {
    Text = "The selected storyline has not been unlocked yet"
  },
  TipsType_10092_Desc = {
    Text = "The selected instance has not been unlocked yet"
  },
  TipsType_10093_Desc = {
    Text = "Instance area has not been unlocked yet"
  },
  TipsType_10094_Desc = {
    Text = "Storyline sweep not yet unlocked"
  },
  TipsType_10095_Desc = {
    Text = "No storyline found for the instance challenge"
  },
  TipsType_10096_Desc = {
    Text = "No storyline quests found for instance challenges"
  },
  TipsType_10097_Desc = {
    Text = "Challenge completed. Rewards cannot be claimed again."
  },
  TipsType_10098_Desc = {
    Text = "Challenge not completed. Rewards unavailable."
  },
  TipsType_10099_Desc = {
    Text = "The building does not exist"
  },
  TipsType_10100_Desc = {
    Text = "Building has reached the maximum level"
  },
  TipsType_10101_Desc = {
    Text = "Insufficient conditions to upgrade/construct buildings"
  },
  TipsType_10102_Desc = {
    Text = "Building already exists and cannot be constructed again"
  },
  TipsType_10103_Desc = {
    Text = "Not enough items for upgrade/construction"
  },
  TipsType_10104_Desc = {
    Text = "Location already occupied by an Awakener, unable to enter"
  },
  TipsType_10105_Desc = {
    Text = "Insufficient materials to craft the required item"
  },
  TipsType_10106_Desc = {
    Text = "Insufficient currency to craft the item"
  },
  TipsType_10107_Desc = {
    Text = "Synthesis item not unlocked"
  },
  TipsType_10108_Desc = {
    Text = "Failed to connect to the server. Please check your network and try again."
  },
  TipsType_10109_Desc = {
    Text = "The camp has already selected a function and cannot make another selection"
  },
  TipsType_10110_Desc = {
    Text = "The camp function has no remaining uses"
  },
  TipsType_10111_Desc = {
    Text = "Upgrade exclusive card to switch"
  },
  TipsType_10112_Desc = {
    Text = "Change exclusive card to switch"
  },
  TipsType_10113_Desc = {
    Text = "Failed to switch the exclusive card"
  },
  TipsType_10114_Desc = {
    Text = "Obtained Awakener {s1}"
  },
  TipsType_10115_Desc = {
    Text = "Obtained {s1} again, converted to {s2}{s3}."
  },
  TipsType_10116_Desc = {
    Text = "{s1} keepsakes exceeded the limit and have been converted to {s2}{s3}."
  },
  TipsType_10117_Desc = {
    Text = "Log Uploaded Successfully"
  },
  TipsType_10118_Desc = {
    Text = "Instruction mismatch, currently in The Vigil for instruction {s1}, but received {s2}."
  },
  TipsType_10119_Desc = {
    Text = "Lost Card:{s1}; uid:{s2}"
  },
  TipsType_10120_Desc = {
    Text = "Cannot Unleash"
  },
  TipsType_10121_Desc = {
    Text = "No Such Skill"
  },
  TipsType_10122_Desc = {
    Text = "Skill on Cooldown"
  },
  TipsType_10123_Desc = {
    Text = "Skill Uses Depleted"
  },
  TipsType_10124_Desc = {
    Text = "Check if the building upgrade order for building Tid {s1} is circular."
  },
  TipsType_10125_Desc = {
    Text = "Check if building Tid {s1} has no associated configuration."
  },
  TipsType_10126_Desc = {
    Text = "Building Tid {s1} actual Level should be {s2}, configured as {s3}."
  },
  TipsType_10127_Desc = {
    Text = "Building Type Configuration Not Found"
  },
  TipsType_10128_Desc = {
    Text = "Building configuration not found, or no building type specified."
  },
  TipsType_10129_Desc = {
    Text = "This Story quest task has not been unlocked yet."
  },
  TipsType_10130_Desc = {
    Text = "Removed Successfully"
  },
  TipsType_10131_Desc = {
    Text = "Successfully gained \"Menophin\" × {s1}."
  },
  TipsType_10132_Desc = {
    Text = "Fix Complete"
  },
  TipsType_10133_Desc = {
    Text = "GM add item by item name [\"..arg1..\"] no matching item found."
  },
  TipsType_10134_Desc = {
    Text = "Event [\"..arg1..\"] does not exist."
  },
  TipsType_10135_Desc = {
    Text = "Current: Press {s1}"
  },
  TipsType_10136_Desc = {
    Text = "Skill Upgraded"
  },
  TipsType_10137_Desc = {
    Text = "Generated Successfully"
  },
  TipsType_10138_Desc = {
    Text = "Server time updated successfully."
  },
  TipsType_10139_Desc = {
    Text = "Failed to Modify Server Time"
  },
  TipsType_10140_Desc = {
    Text = [[
Total Buildings: 17
This temporary version only has some buildings available.]]
  },
  TipsType_10141_Desc = {
    Text = "Building unlock conditions not met."
  },
  TipsType_10142_Desc = {
    Text = "Building: The interface for {s1} configuration does not exist {s2}."
  },
  TipsType_10143_Desc = {
    Text = "This crafting recipe is currently locked."
  },
  TipsType_10144_Desc = {
    Text = "Insufficient Materials"
  },
  TipsType_10145_Desc = {
    Text = "Crafting Successful"
  },
  TipsType_10146_Desc = {Text = "Upgraded"},
  TipsType_10147_Desc = {
    Text = "The monster slot is empty, cannot enter battle."
  },
  TipsType_10148_Desc = {
    Text = "Menophin\" Recovery"
  },
  TipsType_10149_Desc = {
    Text = "The character ID entered is duplicated and cannot enter combat."
  },
  TipsType_10150_Desc = {
    Text = "The ID {s1} you entered does not exist and cannot enter battle."
  },
  TipsType_10151_Desc = {
    Text = "Monster has no corresponding action."
  },
  TipsType_10152_Desc = {
    Text = "Not yet available"
  },
  TipsType_10153_Desc = {
    Text = "No cards in the current deck."
  },
  TipsType_10154_Desc = {
    Text = "Other Cards are in effect, cannot play cards."
  },
  TipsType_10155_Desc = {
    Text = "Not in hand, cannot play."
  },
  TipsType_10156_Desc = {
    Text = "This card cannot be played."
  },
  TipsType_10157_Desc = {
    Text = "This card has no skills configured."
  },
  TipsType_10158_Desc = {
    Text = "This card cannot be played."
  },
  TipsType_10159_Desc = {
    Text = "Insufficient Arithmetica"
  },
  TipsType_10160_Desc = {
    Text = "No corresponding Awakener on the field."
  },
  TipsType_10161_Desc = {
    Text = "Insufficient remaining attempts"
  },
  TipsType_10162_Desc = {
    Text = "Use an Exploration Skill"
  },
  TipsType_10163_Desc = {
    Text = "Selected %d Command Cards"
  },
  TipsType_10164_Desc = {
    Text = "Quantity Limit Reached"
  },
  TipsType_10165_Desc = {
    Text = "Not Selected Yet"
  },
  TipsType_10166_Desc = {
    Text = "This card cannot be played by spending Arithmetica."
  },
  TipsType_10167_Desc = {
    Text = "Total Consumption Exceeds"
  },
  TipsType_10168_Desc = {
    Text = "{s1} <plural value=\"{s1}\" singular=\"Card\" plural=\"Cards\"> Selected"
  },
  TipsType_10169_Desc = {
    Text = "Tentacle Count has reached the maximum."
  },
  TipsType_10170_Desc = {
    Text = "Removed Successfully"
  },
  TipsType_10171_Desc = {Text = "Enhanced"},
  TipsType_10172_Desc = {
    Text = "Transformation Successful"
  },
  TipsType_10173_Desc = {Text = "Copied"},
  TipsType_10174_Desc = {
    Text = "Command Card Obtained"
  },
  TipsType_10175_Desc = {
    Text = "Removal count has been exhausted."
  },
  TipsType_10176_Desc = {
    Text = "Enhance count has been exhausted."
  },
  TipsType_10177_Desc = {
    Text = "Transformation count has been exhausted."
  },
  TipsType_10178_Desc = {
    Text = "Copy count has been exhausted."
  },
  TipsType_10179_Desc = {
    Text = "Command Card Selection Limit Reached"
  },
  TipsType_10180_Desc = {
    Text = "No Command Card Selected"
  },
  TipsType_10181_Desc = {
    Text = "The shop is not yet open. Stay tuned."
  },
  TipsType_10182_Desc = {Text = "Stay tuned"},
  TipsType_10183_Desc = {
    Text = "The target area is too far away to locate."
  },
  TipsType_10184_Desc = {
    Text = "Missed the target's area, unable to complete."
  },
  TipsType_10185_Desc = {
    Text = "This topic is not yet unlocked."
  },
  TipsType_10186_Desc = {
    Text = "Explore Domains to unlock more investigations."
  },
  TipsType_10187_Desc = {
    Text = "Complete prerequisite tasks to unlock more investigations."
  },
  TipsType_10188_Desc = {
    Text = "Submission successful, research points +{s1}."
  },
  TipsType_10189_Desc = {
    Text = "No Tasks Available to Submit"
  },
  TipsType_10190_Desc = {
    Text = "Not yet available. Please check the dungeon opening schedule."
  },
  TipsType_10191_Desc = {
    Text = "Stage Unlock Conditions Not Yet Met"
  },
  TipsType_10192_Desc = {
    Text = "{s1} cannot be empty"
  },
  TipsType_10193_Desc = {
    Text = "{s1} and {s2} cannot be empty."
  },
  TipsType_10194_Desc = {
    Text = "Refresh count has been exhausted, unable to refresh."
  },
  TipsType_10195_Desc = {
    Text = "Acquisition method not yet unlocked."
  },
  TipsType_10196_Desc = {
    Text = "Not within the available time period."
  },
  TipsType_10197_Desc = {
    Text = "Select a Relic to Transform"
  },
  TipsType_10198_Desc = {
    Text = "Removed Successfully"
  },
  TipsType_10199_Desc = {
    Text = "Removal count has been exhausted."
  },
  TipsType_10200_Desc = {
    Text = "Transformation count has been exhausted."
  },
  TipsType_10201_Desc = {
    Text = "Select a Relic to Remove"
  },
  TipsType_10202_Desc = {
    Text = "Quantity Has Reached the Limit"
  },
  TipsType_10203_Desc = {
    Text = "Please select at least {s1} Relics."
  },
  TipsType_10204_Desc = {
    Text = "No Switches Remaining"
  },
  TipsType_10205_Desc = {
    Text = "All exclusive cards have been upgraded to the maximum level."
  },
  TipsType_10206_Desc = {
    Text = "The current repulsion level is 0 and cannot be reduced further."
  },
  TipsType_10207_Desc = {
    Text = "Not yet available"
  },
  TipsType_10208_Desc = {
    Text = "Insufficient Soul-Binding Anchors to Enhance."
  },
  TipsType_10209_Desc = {
    Text = "Requires {s1} to reach level {s2} to perform Enlighten."
  },
  TipsType_10210_Desc = {
    Text = "\"{s1}\" Is Insufficient"
  },
  TipsType_10211_Desc = {
    Text = "Do not currently possess \"{s1}\""
  },
  TipsType_10212_Desc = {
    Text = "Level Maxed"
  },
  TipsType_10213_Desc = {
    Text = "Please Select a Material First"
  },
  TipsType_10214_Desc = {
    Text = "\"{s1}\" is insufficient"
  },
  TipsType_10215_Desc = {Text = "Upgraded"},
  TipsType_10216_Desc = {
    Text = "Gnosis Elixir Has Been Added"
  },
  TipsType_10217_Desc = {
    Text = "Enlighten Limit Reached"
  },
  TipsType_10218_Desc = {
    Text = "Upgrade Failed"
  },
  TipsType_10219_Desc = {
    Text = "Insufficient Items for Upgrade"
  },
  TipsType_10221_Desc = {
    Text = "Skill Upgraded"
  },
  TipsType_10222_Desc = {
    Text = "Not enough Black Sigils to purchase."
  },
  TipsType_10223_Desc = {Text = "Sold Out"},
  TipsType_10224_Desc = {
    Text = "Not enough Black Sigils to remove the Command Card."
  },
  TipsType_10225_Desc = {
    Text = "Remove {s1} <plural value=\"{s1}\" singular=\"Command Card\" plural=\"Command Cards\">"
  },
  TipsType_10226_Desc = {
    Text = "This direction is not yet available and cannot be Enhanced."
  },
  TipsType_10227_Desc = {
    Text = "This direction has been Enhanced to the maximum Level."
  },
  TipsType_10228_Desc = {
    Text = "Please select the direction you'd like to Enhance your exclusive card first."
  },
  TipsType_10229_Desc = {
    Text = "Insufficient Soul-Binding Anchors to Enhance."
  },
  TipsType_10230_Desc = {
    Text = "You don't own the Awakener for this Realm yet and cannot select it."
  },
  TipsType_10231_Desc = {
    Text = "Create a Team"
  },
  TipsType_10232_Desc = {
    Text = "Team name cannot exceed {s1} characters."
  },
  TipsType_10233_Desc = {
    Text = "Team name cannot be empty"
  },
  TipsType_10234_Desc = {
    Text = "Redemption Successful"
  },
  TipsType_10235_Desc = {
    Text = "No More \"Silver\" Left"
  },
  TipsType_10236_Desc = {
    Text = "Can't Be Reduced Any Further"
  },
  TipsType_10237_Desc = {
    Text = "{s1} is not yet available. Stay tuned."
  },
  TipsType_10238_Desc = {
    Text = "Summon is not yet available. Stay tuned."
  },
  TipsType_10239_Desc = {
    Text = "Campus mini-map feature is not yet available."
  },
  TipsType_10240_Desc = {
    Text = "Unlocks at Topic Level {s1}"
  },
  TipsType_10241_Desc = {
    Text = "No Cards Match the Criteria"
  },
  TipsType_10242_Desc = {
    Text = "All Realm cards have been upgraded."
  },
  TipsType_10243_Desc = {
    Text = "No Command Cards available to upgrade."
  },
  TipsType_10244_Desc = {
    Text = "Discovered a new teleport point! You can now travel to {s1}."
  },
  TipsType_10245_Desc = {
    Text = "Already owned. Cannot obtain again."
  },
  TipsType_10246_Desc = {
    Text = "Recovery Successful"
  },
  TipsType_10247_Desc = {
    Text = "Removed Successfully"
  },
  TipsType_10248_Desc = {
    Text = "Open the Backpack Interface"
  },
  TipsType_10249_Desc = {
    Text = "An abnormal disconnection was detected from your last session. Your \"Menophin\" and any earned supplies have been returned. Check your inventory to view them."
  },
  TipsType_10250_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10251_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10252_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10253_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10254_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10255_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10256_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10257_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10258_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10259_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10260_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10261_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10262_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10263_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10264_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10265_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10266_Desc = {
    Text = "The AVG version only provides select buildings; the total number of buildings here is 17."
  },
  TipsType_10267_Desc = {
    Text = "Conditions Not Met"
  },
  TipsType_10268_Desc = {
    Text = "Unlock Quick Investigation at Keeper Level 2"
  },
  TipsType_10269_Desc = {
    Text = "Connection Lost"
  },
  TipsType_10270_Desc = {
    Text = "Server connection interrupted. You will be returned to the login page shortly."
  },
  TipsType_10271_Desc = {Text = "Confirm"},
  TipsType_10272_Desc = {
    Text = "The server is not yet available. Please try again later."
  },
  TipsType_10273_Desc = {Text = "Success"},
  TipsType_10274_Desc = {
    Text = "Domain not found"
  },
  TipsType_10275_Desc = {
    Text = "Domain Event Completed"
  },
  TipsType_10276_Desc = {
    Text = "Incorrect Domain Event Configuration Type"
  },
  TipsType_10277_Desc = {
    Text = "Domain Event Does Not Exist"
  },
  TipsType_10278_Desc = {
    Text = "Not enough Black Sigils to purchase."
  },
  TipsType_10279_Desc = {
    Text = "This card cannot be enhanced."
  },
  TipsType_10280_Desc = {
    Text = "This card has reached the max enhance limit."
  },
  TipsType_10281_Desc = {
    Text = "Merchant does not sell this item."
  },
  TipsType_10282_Desc = {
    Text = "No Such Reward"
  },
  TipsType_10283_Desc = {
    Text = "Reward Claimed"
  },
  TipsType_10284_Desc = {
    Text = "Config data error"
  },
  TipsType_10285_Desc = {
    Text = "Event data error"
  },
  TipsType_10286_Desc = {
    Text = "Already purchased"
  },
  TipsType_10287_Desc = {
    Text = "Topic Unit Data Not Found"
  },
  TipsType_10288_Desc = {
    Text = "Unit has been submitted. No need to resubmit."
  },
  TipsType_10289_Desc = {
    Text = "Not all tasks under the unit have been completed yet. Unable to submit."
  },
  TipsType_10290_Desc = {
    Text = "No Module For Topic"
  },
  TipsType_10291_Desc = {
    Text = "Stage Null Topic Data"
  },
  TipsType_10292_Desc = {
    Text = "Client data input error"
  },
  TipsType_10293_Desc = {
    Text = "Service not started"
  },
  TipsType_10294_Desc = {
    Text = "Character data error"
  },
  TipsType_10295_Desc = {
    Text = "No character found. Please create one."
  },
  TipsType_10296_Desc = {
    Text = "Character already exists; no need to create again."
  },
  TipsType_10297_Desc = {
    Text = "Duplicate Character Name"
  },
  TipsType_10298_Desc = {
    Text = "Domain Error"
  },
  TipsType_10299_Desc = {
    Text = "This storyline has not been unlocked yet."
  },
  TipsType_10300_Desc = {
    Text = "View Terrain Effects and enemy information."
  },
  TipsType_10301_Desc = {
    Text = "{s1} reaches {s2} to unlock {s3}."
  },
  TipsType_10302_Desc = {
    Text = "{s1} reaches {s2} to unlock {s3}."
  },
  TipsType_10303_Desc = {
    Text = "Building unlock conditions not met."
  },
  TipsType_10304_Desc = {
    Text = "Building upgrade requirements not met."
  },
  TipsType_10305_Desc = {
    Text = "Insufficient materials to upgrade the building."
  },
  TipsType_10306_Desc = {
    Text = "There are available mission rewards."
  },
  TipsType_10307_Desc = {
    Text = "(HP will be reduced by <Negative:10%>)"
  },
  TipsType_10308_Desc = {
    Text = "At the end of each turn, gain <BuffTipBlock:Shield> equal to the current number of Fortify stacks. Each time you take DMG, Fortify decreases by <BuffTip:1> stack."
  },
  TipsType_10309_Desc = {
    Text = "Multiple Ward"
  },
  TipsType_10310_Desc = {
    Text = "Health below Alert value, investigation risk increased."
  },
  TipsType_10311_Desc = {
    Text = "Health is below the Alert threshold. The risk of investigation is extremely high. Do you wish to proceed by force?"
  },
  TipsType_10312_Desc = {
    Text = "Current Stamina is too low to enter the Domain."
  },
  TipsType_10313_Desc = {
    Text = "Please select an exclusive card of the same level to switch."
  },
  TipsType_10314_Desc = {
    Text = "Unlock this direction after the Awakener reaches Enlighten Level 2."
  },
  TipsType_10315_Desc = {
    Text = "Unlock this direction after the Awakener reaches Enlighten Level 3."
  },
  TipsType_10316_Desc = {Text = "Current"},
  TipsType_10317_Desc = {
    Text = "All Awakeners have Locked skills and cannot charge."
  },
  TipsType_10318_Desc = {
    Text = "All Awakener Skills are fully charged."
  },
  TipsType_10319_Desc = {Text = "Used"},
  TipsType_10320_Desc = {
    Text = "Insufficient Black Sigil"
  },
  TipsType_10321_Desc = {
    Text = "Insufficient Black Sigil"
  },
  TipsType_10322_Desc = {
    Text = "Insufficient Black Sigil"
  },
  TipsType_10323_Desc = {
    Text = "Cannot obtain a Relic you already have."
  },
  TipsType_10324_Desc = {
    Text = "Not Enough Refreshes"
  },
  TipsType_10325_Desc = {
    Text = "Deals {s1} DMG to allies."
  },
  TipsType_10326_Desc = {Text = "ATK"},
  TipsType_10327_Desc = {
    Text = "A minimap preview of the Stage will be displayed here, allowing players to plan their strategy in advance."
  },
  TipsType_10328_Desc = {
    Text = "You spent 10 minutes completing a stage in the daily dungeon, where you gained a unique gameplay experience and reinforced your genre understanding through the stage design."
  },
  TipsType_10329_Desc = {
    Text = "Current HP cap is below 50% of Max HP, please stay safe."
  },
  TipsType_10330_Desc = {
    Text = "The energy that sustains the Awakener's existence. Taking DMG reduces HP, and when HP reaches zero, the investigation fails."
  },
  TipsType_10331_Desc = {
    Text = "A measure of the Awakener's attack intensity. The higher the Strength, the more DMG dealt to enemies when using Command Cards."
  },
  TipsType_10332_Desc = {
    Text = "A reflection of the Awakener's defensive capability. The higher the Alert, the more Shield gained when using Command Cards."
  },
  TipsType_10333_Desc = {
    Text = "Click anywhere to continue"
  },
  TipsType_10334_Desc = {
    Text = "No mission investigation items completed yet."
  },
  TipsType_10335_Desc = {Text = "Evaluation"},
  TipsType_10336_Desc = {
    Text = "Grant 1 Exclusive Card the Spirit of Revelation."
  },
  TipsType_10337_Desc = {
    Text = "Choose the enhancement direction for the exclusive card."
  },
  TipsType_10338_Desc = {
    Text = "The main city minimap is not yet available. Stay tuned."
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2} Value"
  },
  TipsType_10340_Desc = {
    Text = "{s1} Basic Deck Level Up"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:Affinity:>"
  },
  TipsType_10342_Desc = {
    Text = "A manifestation of the emotional bond with the Awakener. As affinity deepens, you can get to know the Awakener more intimately."
  },
  TipsType_10343_Desc = {
    Text = "<Positive:Current Level:>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Basic Deck:>"
  },
  TipsType_10345_Desc = {
    Text = "The initial deck the Realm has when entering a dungeon."
  },
  TipsType_10346_Desc = {
    Text = "<Positive:Highest Level In Deck:>{s1} Level"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:Deck Level:>"
  },
  TipsType_10348_Desc = {
    Text = "When the specified number of Awakeners in this Realm reach the designated affinity Level, the base deck can be Upgraded."
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Upgrade Content:>"
  },
  TipsType_10350_Desc = {
    Text = "Each upgrade will enhance the base value of one Command Card."
  },
  TipsType_10351_Desc = {
    Text = "{s1} Affection Increased"
  },
  TipsType_10352_Desc = {
    Text = "In the Silence of the Domain"
  },
  TipsType_10353_Desc = {
    Text = "Domains Repel Intruders"
  },
  TipsType_10354_Desc = {
    Text = "Domain Repulsion Increased"
  },
  TipsType_10355_Desc = {
    Text = "Repulsion reaches {s1}, the Domain is watching you."
  },
  TipsType_10356_Desc = {
    Text = "Enlighten 1"
  },
  TipsType_10357_Desc = {
    Text = "Comprehend This Skill"
  },
  TipsType_10358_Desc = {
    Text = "The maximum number of Tentacles that can exist simultaneously."
  },
  TipsType_10359_Desc = {
    Text = "A measure of Tentacle attack strength. The stronger the Tentacle's Strength, the more DMG it deals to enemies when triggered."
  },
  TipsType_10360_Desc = {
    Text = "No Command Card Selected"
  },
  TipsType_10361_Desc = {
    Text = "Transformation Successful"
  },
  TipsType_10362_Desc = {
    Text = "No Command Card Selected"
  },
  TipsType_10363_Desc = {
    Text = "Copied Successfully"
  },
  TipsType_10364_Desc = {
    Text = "{s1} <plural value=\"{s1}\" singular=\"Command Card\" plural=\"Command Cards\"> Selected"
  },
  TipsType_10365_Desc = {
    Text = "No Command Card Selected"
  },
  TipsType_10366_Desc = {
    Text = "No Command Card Selected"
  },
  TipsType_10367_Desc = {Text = "Upgraded"},
  TipsType_10368_Desc = {
    Text = "The Relic inventory interface is under development. Please stay tuned."
  },
  TipsType_10369_Desc = {
    Text = "Select a Relic to Transform"
  },
  TipsType_10370_Desc = {
    Text = "Game updated. Please re-download and install."
  },
  TipsType_10371_Desc = {
    Text = "Advanced Effect"
  },
  TipsType_10372_Desc = {
    Text = "Domain Info"
  },
  TipsType_10373_Desc = {
    Text = "For every 1 DMG card played, a Tentacle deals {s1} DMG to a random enemy."
  },
  TipsType_10374_Desc = {
    Text = "No Pending Topics at This Time"
  },
  TipsType_10375_Desc = {
    Text = "No Archived Topics Yet"
  },
  TipsType_10376_Desc = {
    Text = "Unfinished Tasks from This Survey"
  },
  TipsType_10377_Desc = {
    Text = "Cannot Undo"
  },
  TipsType_10378_Desc = {
    Text = "(The following topics have been automatically archived.)"
  },
  TipsType_10379_Desc = {
    Text = "Target Topic Completed"
  },
  TipsType_10380_Desc = {
    Text = "Item not owned"
  },
  TipsType_10381_Desc = {
    Text = "Invalid index value"
  },
  TipsType_10382_Desc = {Text = "Locked"},
  TipsType_10383_Desc = {
    Text = "No exclusive card upgrade attempts remaining"
  },
  TipsType_10384_Desc = {
    Text = "1 Relic Retain slot unlocked."
  },
  TipsType_10385_Desc = {
    Text = "Connection Rate Boost"
  },
  TipsType_10386_Desc = {
    Text = "No slot information available"
  },
  TipsType_10387_Desc = {
    Text = "Insufficient Currency"
  },
  TipsType_10388_Desc = {
    Text = "Max level reached"
  },
  TipsType_10389_Desc = {
    Text = "Under development, please stay tuned."
  },
  TipsType_10390_Desc = {
    Text = "No more manual upgrade slots available"
  },
  TipsType_10391_Desc = {
    Text = "Can be used after being unsealed at a shop or camp."
  },
  TipsType_10392_Desc = {
    Text = "This Battle Costs {s1} Stamina"
  },
  TipsType_10393_Desc = {
    Text = "Awakener energy is full and cannot be increased further."
  },
  TipsType_10394_Desc = {
    Text = "All Awakeners' energy has been fully upgraded."
  },
  TipsType_10395_Desc = {
    Text = "Requires \"Her Eyes\" to Unlock"
  },
  TipsType_10396_Desc = {
    Text = "Orison successfully engraved"
  },
  TipsType_10397_Desc = {
    Text = "{s1} <plural value=\"{s1}\" singular=\"Awakener\" plural=\"Awakeners\"> deployed, the team will carry {s2} Realm's traits."
  },
  TipsType_10398_Desc = {
    Text = "The party becomes Neutral, carrying no Realm traits."
  },
  TipsType_10399_Desc = {
    Text = "The small loop system verification unlocks in Chapter 4 Stages."
  },
  TipsType_10400_Desc = {
    Text = "You can inherit a maximum of {s1} Relics. Please reduce the number of selected Relics first."
  },
  TipsType_10401_Desc = {
    Text = "Unchecked Relics cannot be inherited."
  },
  TipsType_10405_Desc = {Text = "Gain {s1}"},
  TipsType_10406_Desc = {
    Text = "The Awakeners on the field have reached the maximum limit."
  },
  TipsType_10407_Desc = {
    Text = "This Gold Tower cannot be challenged."
  },
  TipsType_10408_Desc = {
    Text = "This Gold Tower is locked. Please complete the designated investigation dungeon."
  },
  TipsType_10409_Desc = {
    Text = "Please select an Awakener to deploy."
  },
  TipsType_10410_Desc = {
    Text = "Awakeners are busy completing assignments. Come back later to claim your rewards."
  },
  TipsType_10411_Desc = {
    Text = "Received {s1} Rose Scrips"
  },
  TipsType_10412_Desc = {
    Text = "Time rewards need to accumulate over time."
  },
  TipsType_10413_Desc = {
    Text = "Insufficient \"Silver\""
  },
  TipsType_10414_Desc = {
    Text = "No challenge attempts remaining"
  },
  TipsType_10415_Desc = {
    Text = "Challenge on cooldown"
  },
  TipsType_10416_Desc = {
    Text = "No opponents to challenge"
  },
  TipsType_10417_Desc = {
    Text = "Select an Awakener to deploy"
  },
  TipsType_10418_Desc = {
    Text = "Insufficient Gnosis Elixir, unable to continue leveling up."
  },
  TipsType_10419_Desc = {
    Text = "Current Level has reached the maximum."
  },
  TipsType_10420_Desc = {
    Text = "Awakener Is Locked"
  },
  TipsType_10421_Desc = {
    Text = "Successfully removed from collections."
  },
  TipsType_10422_Desc = {
    Text = "Insufficient purchase attempts for storyline challenges"
  },
  TipsType_10423_Desc = {
    Text = "Not enough storyline stars to sweep"
  },
  TipsType_10424_Desc = {
    Text = "Incorrect Realm configuration for the investigation dungeon party."
  },
  TipsType_10425_Desc = {
    Text = "Insufficient \"Silver\""
  },
  TipsType_10426_Desc = {
    Text = "Daily Voucher Purchase Limit Reached"
  },
  TipsType_10427_Desc = {
    Text = "Unlocked after 3-starring the Secret Realm."
  },
  TipsType_10428_Desc = {
    Text = "Successfully obtained {s1} <plural value=\"{s1}\" singular=\"voucher\" plural=\"vouchers\">."
  },
  TipsType_10429_Desc = {
    Text = "Successfully obtained {s1} challenge attempts."
  },
  TipsType_10430_Desc = {
    Text = "Clear Investigation 4-6 to Unlock"
  },
  TipsType_10431_Desc = {
    Text = "Insufficient Vouchers"
  },
  TipsType_10432_Desc = {
    Text = "Insufficient voucher purchase attempts"
  },
  TipsType_10433_Desc = {
    Text = "Enlighten level has reached the maximum."
  },
  TipsType_10434_Desc = {
    Text = "\"{s1}\" is insufficient"
  },
  TipsType_10435_Desc = {
    Text = "No such item for sale"
  },
  TipsType_10436_Desc = {
    Text = "No store of this type"
  },
  TipsType_10437_Desc = {
    Text = "The item for sale is out of stock"
  },
  TipsType_10438_Desc = {
    Text = "No store data available"
  },
  TipsType_10439_Desc = {
    Text = "No refresh attempts available"
  },
  TipsType_10440_Desc = {
    Text = "Today's \"Menophin\" purchase limit has been reached."
  },
  TipsType_10441_Desc = {
    Text = "Insufficient Awakener Shards"
  },
  TipsType_10442_Desc = {
    Text = "Enlightenment Activated"
  },
  TipsType_10443_Desc = {
    Text = "Prerequisite Enlightenment Not Activated"
  },
  TipsType_10444_Desc = {
    Text = "Successfully purchased \"Menophin\" × {s1}."
  },
  TipsType_10445_Desc = {
    Text = "\"Menophin\" Limit Reached"
  },
  TipsType_10446_Desc = {
    Text = "Clear Investigation 1-12 to Unlock"
  },
  TipsType_10447_Desc = {
    Text = "Clear Prologue to Unlock"
  },
  TipsType_10448_Desc = {
    Text = "Clear Prologue to Unlock"
  },
  TipsType_10449_Desc = {
    Text = "Clear Investigation 2-4 to Unlock"
  },
  TipsType_10450_Desc = {
    Text = "This Skill Has Reached the Maximum Level"
  },
  TipsType_10451_Desc = {
    Text = "Insufficient Edification Tier"
  },
  TipsType_10452_Desc = {
    Text = "Insufficient materials"
  },
  TipsType_10453_Desc = {
    Text = "Clear Investigation 3-15 to Unlock"
  },
  TipsType_10454_Desc = {
    Text = "Clear Investigation 3-7 to Unlock"
  },
  TipsType_10455_Desc = {
    Text = "Skill upgrade conditions not met"
  },
  TipsType_10456_Desc = {
    Text = "The test version only allows 1 recharge operation per recharge item."
  },
  TipsType_10457_Desc = {
    Text = "This Awakener's Genesis Arrival is on cooldown; unleash it next turn."
  },
  TipsType_10458_Desc = {
    Text = "No such configuration exists in the recharge settings"
  },
  TipsType_10459_Desc = {
    Text = "You have already received the free top-up and cannot recharge again"
  },
  TipsType_10460_Desc = {
    Text = "Resonance already active. No need to activate again."
  },
  TipsType_10461_Desc = {
    Text = "Price for {s1} has changed. Please confirm."
  },
  TipsType_10462_Desc = {
    Text = "Insufficient Rose Scrips"
  },
  TipsType_10463_Desc = {
    Text = "Insufficient \"Training Badge\""
  },
  TipsType_10464_Desc = {
    Text = "Clear Investigation 3-4 to Unlock"
  },
  TipsType_10465_Desc = {
    Text = "Clear Investigation 2-16 to Unlock"
  },
  TipsType_10466_Desc = {
    Text = "Clear Investigation 3-16 to Unlock"
  },
  TipsType_10467_Desc = {
    Text = "Clear Investigation 4-12 to Unlock"
  },
  TipsType_10468_Desc = {
    Text = "Clear Investigation 5-12 to Unlock"
  },
  TipsType_10469_Desc = {
    Text = "Clear Investigation 6-12 to Unlock"
  },
  TipsType_10470_Desc = {
    Text = "Clear Investigation 1-7 to Unlock"
  },
  TipsType_10471_Desc = {
    Text = "Equipped Successfully"
  },
  TipsType_10472_Desc = {
    Text = "Unequipped Successfully"
  },
  TipsType_10473_Desc = {
    Text = "Max Level Reached"
  },
  TipsType_10474_Desc = {
    Text = "Insufficient Rose Scrips"
  },
  TipsType_10475_Desc = {
    Text = "Please Select Materials"
  },
  TipsType_10476_Desc = {
    Text = "Currently locked and protected. Please unlock it first."
  },
  TipsType_10477_Desc = {
    Text = "Stage Not Available"
  },
  TipsType_10478_Desc = {
    Text = "Unavailable Outside of Combat"
  },
  TipsType_10479_Desc = {
    Text = "Discard Pile Is Empty"
  },
  TipsType_10480_Desc = {
    Text = "RPG combat adjustment in progress, currently settling victory directly"
  },
  TipsType_10482_Desc = {
    Text = "Wheel of Destiny Is Locked"
  },
  TipsType_10483_Desc = {
    Text = "Wheel of Destiny Not Found"
  },
  TipsType_10484_Desc = {
    Text = "Wheel of Destiny has reached its maximum level."
  },
  TipsType_10485_Desc = {
    Text = "Wheel of Destiny Has Been Equipped"
  },
  TipsType_10486_Desc = {
    Text = "Wheel of Destiny Mismatch"
  },
  TipsType_10487_Desc = {
    Text = "Wheel of Destiny Unlocked"
  },
  TipsType_10488_Desc = {
    Text = "Covenants currently in a \"Lineup,\" \"Support,\" or \"Covenant Plan\" cannot be dismantled."
  },
  TipsType_10489_Desc = {
    Text = "Wheels of Destiny currently in a \"Lineup\" or \"Support\" cannot be dismantled."
  },
  TipsType_10490_Desc = {
    Text = "Insufficient Aliemus to unleash Exalt."
  },
  TipsType_10491_Desc = {
    Text = "Please claim the previous gift pack first."
  },
  TipsType_10492_Desc = {
    Text = "The current Covenant is locked. Unlock it to use as material."
  },
  TipsType_10493_Desc = {
    Text = "The current Wheel of Destiny is locked. Unlock it to use as material."
  },
  TipsType_10494_Desc = {
    Text = "Clear Investigation 1-7 to Unlock"
  },
  TipsType_10495_Desc = {
    Text = "Clear Investigation 1-13 to Unlock"
  },
  TipsType_10496_Desc = {
    Text = "Current Covenant level has reached the maximum."
  },
  TipsType_10497_Desc = {Text = "Shop Reset"},
  TipsType_10498_Desc = {Text = "Replaced"},
  TipsType_10499_Desc = {
    Text = "Set as Favorite"
  },
  TipsType_10500_Desc = {Text = "Ascended"},
  TipsType_10501_Desc = {
    Text = "Current Challenge Is Locked"
  },
  TipsType_10502_Desc = {
    Text = "The current Awakener has already challenged another Stage in {s1} and cannot be deployed again."
  },
  TipsType_10503_Desc = {
    Text = "The number of Awakeners in battle is less than 4, unable to challenge."
  },
  TipsType_10504_Desc = {
    Text = "Clear Investigation 3-7 to Unlock"
  },
  TipsType_10505_Desc = {
    Text = "Reach 3 Stars on Floor 1 to Unlock"
  },
  TipsType_10506_Desc = {
    Text = "Reach 3 Stars on Floor 2 to Unlock"
  },
  TipsType_10507_Desc = {
    Text = "Reach 3 Stars on Floor 3 to Unlock"
  },
  TipsType_10508_Desc = {
    Text = "Reach 3 Stars on Floor 4 to Unlock"
  },
  TipsType_10509_Desc = {
    Text = "Reach 3 Stars on Floor 5 to Unlock"
  },
  TipsType_10510_Desc = {
    Text = "Reach 3 Stars on Floor 6 to Unlock"
  },
  TipsType_10511_Desc = {
    Text = "Reach 3 Stars on Floor 7 to Unlock"
  },
  TipsType_10512_Desc = {
    Text = "Reach 3 Stars on Floor 8 to Unlock"
  },
  TipsType_10513_Desc = {
    Text = "Please select the Covenant you wish to enhance."
  },
  TipsType_10514_Desc = {Text = "Claimed"},
  TipsType_10515_Desc = {
    Text = "Clear Investigation 2-14 to Unlock"
  },
  TipsType_10516_Desc = {
    Text = "Clear Investigation 4-7 to Unlock"
  },
  TipsType_10517_Desc = {
    Text = "Clear Investigation 4-7 to Unlock"
  },
  TipsType_10518_Desc = {
    Text = "Lineup Saved"
  },
  TipsType_10519_Desc = {
    Text = "Touch the Glowing Area to Move"
  },
  TipsType_10520_Desc = {
    Text = "Team names can only contain Chinese characters, English letters, and numbers."
  },
  TipsType_10521_Desc = {
    Text = "Team name length cannot exceed 8 characters"
  },
  TipsType_10522_Desc = {
    Text = "The number of Awakeners in the team is less than {s1}, unable to conduct the investigation."
  },
  TipsType_10523_Desc = {
    Text = "The Awakener has already participated in combat in other Domains of this Lightless Realm floor."
  },
  TipsType_10524_Desc = {
    Text = "Your team already has two Awakeners from the same Realm, so no other Realm's Awakener can be selected."
  },
  TipsType_10525_Desc = {
    Text = "Please Select an Awakener"
  },
  TipsType_10526_Desc = {
    Text = "Maximum Awakeners Selected"
  },
  TipsType_10527_Desc = {
    Text = "Cultivation Note: In Phantasmal Dive, the Awakener's Level and skill levels are both set to Level 1."
  },
  TipsType_10528_Desc = {
    Text = "Team Name Cannot Be Empty"
  },
  TipsType_10529_Desc = {
    Text = "There is an Awakener in the party who is exhausted and unable to fight anymore."
  },
  TipsType_10530_Desc = {
    Text = "All attachments in the mailbox have been claimed."
  },
  TipsType_10531_Desc = {
    Text = "Unlocks after completing Main Story Prologue"
  },
  TipsType_10532_Desc = {
    Text = "Inventory is full. Some items could not be collected. Please clear your inventory and try again."
  },
  TipsType_10533_Desc = {
    Text = "Inventory is full. Your rewards will be sent to your mailbox."
  },
  TipsType_10534_Desc = {
    Text = "Inventory is full. Some items could not be collected. Please clear your inventory and try again."
  },
  TipsType_10535_Desc = {
    Text = "No mail attachments"
  },
  TipsType_10536_Desc = {
    Text = "Please Redeem the Relic First"
  },
  TipsType_10537_Desc = {
    Text = "Clear Investigation 2-4 to Unlock"
  },
  TipsType_10538_Desc = {
    Text = "Clear Investigation 1-12 to Unlock"
  },
  TipsType_10539_Desc = {
    Text = "Clear Investigation 1-12 to Unlock"
  },
  TipsType_10540_Desc = {
    Text = "Clear Investigation 1-12 to Unlock"
  },
  TipsType_10541_Desc = {
    Text = "Reach 3 Stars on Floor 9 to Unlock"
  },
  TipsType_10542_Desc = {
    Text = "Reach 3 Stars on Floor 10 to Unlock"
  },
  TipsType_10543_Desc = {
    Text = "Reach 3 Stars on Floor 11 to Unlock"
  },
  TipsType_10544_Desc = {
    Text = "Reach 3 Stars on Floor 12 to Unlock"
  },
  TipsType_10545_Desc = {
    Text = "Reach 3 Stars on Floor 13 to Unlock"
  },
  TipsType_10546_Desc = {
    Text = "Reach 3 Stars on Floor 14 to Unlock"
  },
  TipsType_10547_Desc = {
    Text = "This Feature Is About to Be Removed"
  },
  TipsType_10548_Desc = {
    Text = "Clear Investigation 1-7 to Unlock"
  },
  TipsType_10549_Desc = {
    Text = "No More Relics Can Be Obtained"
  },
  TipsType_10550_Desc = {
    Text = "{s1} has completed the Link, and can now command her in battle."
  },
  TipsType_10551_Desc = {
    Text = "{s1}'s Level and Skill Level exceed what the Gnosis Amplifier can provide and cannot be used."
  },
  TipsType_10552_Desc = {
    Text = "The Awakener Level and Skill Level have exceeded the Level provided by the Gnosis Amplifier and cannot be used."
  },
  TipsType_10553_Desc = {Text = "Stay tuned"},
  TipsType_10554_Desc = {
    Text = "Unlocked after clearing the previous Stage."
  },
  TipsType_10555_Desc = {
    Text = "No Turning Back on the Fragile Path"
  },
  TipsType_10556_Desc = {
    Text = "Not yet available. Stay tuned."
  },
  TipsType_10557_Desc = {
    Text = "You already own this Relic and cannot obtain it again."
  },
  TipsType_10558_Desc = {
    Text = [[
About to retrieve the content from the system clipboard and perform <Positive:[Paste]>
Are you sure?]]
  },
  TipsType_10558_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10558_RightBtnDesc = {Text = "Confirm"},
  TipsType_10558_Title = {
    Text = "Enable Paste"
  },
  TipsType_10559_Desc = {
    Text = "Insufficient Materials"
  },
  TipsType_10560_Desc = {
    Text = "Already in the Initial State"
  },
  TipsType_10561_Desc = {
    Text = "Insufficient Rose Scrips"
  },
  TipsType_10562_Desc = {Text = "Unascended"},
  TipsType_10563_Desc = {
    Text = "Resonance Reset Successful"
  },
  TipsType_10564_Desc = {
    Text = "Reach Keeper Level {s1}"
  },
  TipsType_10565_Desc = {
    Text = "Sealed Aliemus Cannot Be Unleashed"
  },
  TipsType_1056601_Desc = {
    Text = "Silver Communication error, please check your network and try again ({s1})."
  },
  TipsType_10566_Desc = {
    Text = "Silver Communication error, please try again later({s1})."
  },
  TipsType_10567_Desc = {
    Text = "Failed to retrieve server information! {s1}."
  },
  TipsType_10568_Desc = {
    Text = "Please Select a Server First"
  },
  TipsType_10569_Desc = {
    Text = "Not yet unlocked"
  },
  TipsType_10570_Desc = {
    Text = "Please enter your account"
  },
  TipsType_10571_Desc = {
    Text = "Insufficient Resonance Activation Materials"
  },
  TipsType_10572_Desc = {
    Text = "Prerequisite Resonance Not Upgraded"
  },
  TipsType_10573_Desc = {
    Text = "Level Maxed"
  },
  TipsType_10574_Desc = {Text = "Upgraded"},
  TipsType_10575_Desc = {
    Text = "This Awakener Cannot Be Swapped Out"
  },
  TipsType_10576_Desc = {
    Text = "This Slot Is Unavailable for Deployment"
  },
  TipsType_10577_Desc = {
    Text = "Not Enough Awakeners, Cannot Challenge"
  },
  TipsType_10578_Desc = {
    Text = "Next Stage Locked"
  },
  TipsType_10579_Desc = {
    Text = "It's Already the Last Stage"
  },
  TipsType_10580_Desc = {
    Text = "EXP Cap Reached, Unable to Add"
  },
  TipsType_10581_Desc = {
    Text = "Wheel of Destiny Slots Are Full, Unable to Add"
  },
  TipsType_10582_Desc = {
    Text = "No materials available for quick placement."
  },
  TipsType_10583_Desc = {
    Text = "Please place materials into the Wheel of Destiny slot."
  },
  TipsType_10584_Desc = {
    Text = "No Wheel of Destiny Available to Equip"
  },
  TipsType_10585_Desc = {
    Text = "Clear Investigation 2-8 to Unlock"
  },
  TipsType_10586_Desc = {
    Text = "Clear Investigation 2-14 to Unlock"
  },
  TipsType_10587_Desc = {
    Text = "Clear Investigation 3-16 to Unlock"
  },
  TipsType_10588_Desc = {
    Text = "Clear Investigation 4-12 to Unlock"
  },
  TipsType_10589_Desc = {
    Text = "Clear Investigation 5-12 to Unlock"
  },
  TipsType_10590_Desc = {
    Text = "Clear Investigation 6-12 to Unlock"
  },
  TipsType_10591_Desc = {
    Text = "Clear Investigation 2-12 to Unlock"
  },
  TipsType_10592_Desc = {
    Text = "This account has been banned from logging in. If you have any questions, please contact customer support."
  },
  TipsType_10593_Desc = {
    Text = "Your login session has expired. Please log in again."
  },
  TipsType_10594_Desc = {
    Text = "Insufficient \"Menophin\""
  },
  TipsType_10595_Desc = {
    Text = "Activate \"{s1}\"?"
  },
  TipsType_10595_Title = {
    Text = "Activate Talent"
  },
  TipsType_10596_Desc = {
    Text = "This Awakener Has Not Been Obtained Yet"
  },
  TipsType_10597_Desc = {
    Text = "No Wheel of Destiny Available to Enhance"
  },
  TipsType_10598_Desc = {
    Text = "This account has been banned from logging in until {s1} due to violations of relevant regulations. If you have any questions, please contact customer support."
  },
  TipsType_10599_Desc = {
    Text = "Clear Investigation 2-15 to Unlock"
  },
  TipsType_10600_Desc = {
    Text = "Max Level Reached, Cannot Add More"
  },
  TipsType_10601_Desc = {
    Text = "Unlocks Keeper's Journey Record after clearing Investigation 1-7."
  },
  TipsType_10602_Desc = {
    Text = "Unlock Realm Mastery quests after clearing Investigation 1-7."
  },
  TipsType_10603_Desc = {
    Text = "No Material Selected"
  },
  TipsType_10604_Desc = {
    Text = "Automatically exiting the instance due to inactivity."
  },
  TipsType_10605_Desc = {
    Text = "The questionnaire has been completed. Thank you for your support."
  },
  TipsType_10606_Desc = {
    Text = "Not Enough Materials to Activate"
  },
  TipsType_10607_Desc = {
    Text = "The reward limit for this week has been reached. You will not receive any rewards after completing the challenge. Proceed anyway?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10607_RightBtnDesc = {Text = "Confirm"},
  TipsType_10607_Title = {
    Text = "Challenge Hint"
  },
  TipsType_10608_Desc = {
    Text = "Campus maintenance in progress. Please wait for completion."
  },
  TipsType_10609_Desc = {
    Text = "Successfully invited {s1} to your dorm."
  },
  TipsType_10610_Desc = {
    Text = "{s1} is already in your dorm."
  },
  TipsType_10611_Desc = {
    Text = "You're not on a Wi-Fi network. Do you want to use mobile data to continue downloading?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10611_RightBtnDesc = {Text = "Confirm"},
  TipsType_10611_Title = {
    Text = "Download Confirm"
  },
  TipsType_10612_Desc = {
    Text = "All cards are already engraved."
  },
  TipsType_10613_Desc = {
    Text = "Network Error, Please Wait"
  },
  TipsType_10614_Desc = {
    Text = "Current Challenge Is Locked"
  },
  TipsType_10615_Desc = {
    Text = "On cooldown, can't be unleashed until next turn."
  },
  TipsType_10616_Desc = {
    Text = "In selection, can only be unleashed after the selection is complete."
  },
  TipsType_10617_Desc = {
    Text = "Release conditions not met."
  },
  TipsType_10618_Desc = {
    Text = "The current team's average level {s1} is lower than the recommended level {s2}. The investigation may encounter significant challenges. Proceed anyway?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Enhance Awakeners"
  },
  TipsType_10618_RightBtnDesc = {Text = "Confirm"},
  TipsType_10618_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_10619_Desc = {
    Text = "Reach Keeper Level {s1}"
  },
  TipsType_10620_Desc = {
    Text = "Poor network conditions. Please check your Steam connection or restart Steam and try again."
  },
  TipsType_10621_Desc = {
    Text = "Are you sure you want to use <WeaponEffect_Num:{s1}> as your name?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10621_RightBtnDesc = {Text = "Confirm"},
  TipsType_10621_Title = {
    Text = "Confirm Your Name"
  },
  TipsType_10622_Desc = {
    Text = "Engraving is on cooldown. Your name can be re-engraved in {s1} hours and {s2} minutes."
  },
  TipsType_10623_Desc = {
    Text = "Engraving Successful"
  },
  TipsType_10624_Desc = {
    Text = "Names can only contain Chinese characters, English letters, and numbers."
  },
  TipsType_10625_Desc = {
    Text = "This card Is About to Be Discarded"
  },
  TipsType_10626_Desc = {
    Text = [[
Please enable the following option in Steam: 
[Steam Settings - In-Game - Enable the Steam Overlay while in-game]
and restart the game for the changes to take effect.]]
  },
  TipsType_10626_RightBtnDesc = {Text = "Confirm"},
  TipsType_10626_Title = {
    Text = "Investigation in Progress"
  },
  TipsType_10628_Desc = {
    Text = "The new name cannot be the same as the current one."
  },
  TipsType_10629_Desc = {
    Text = "Please Enter {s1}~{s2} Characters"
  },
  TipsType_10630_Desc = {
    Text = "{s1} Reenact available after achieving 3 stars."
  },
  TipsType_10631_Desc = {
    Text = "Your account has been forcibly logged out due to a violation of the relevant terms and conditions."
  },
  TipsType_10631_RightBtnDesc = {Text = "Confirm"},
  TipsType_10631_Title = {Text = "Note"},
  TipsType_10632_Desc = {
    Text = "After completing the challenge, you can Reenact today."
  },
  TipsType_10633_Desc = {
    Text = "The following items will be consumed and <Blue:this action cannot be reversed>. Confirm dismantling?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10633_RightBtnDesc = {Text = "Confirm"},
  TipsType_10633_Title = {
    Text = "Confirm Dismantle"
  },
  TipsType_10634_Desc = {
    Text = "The current monthly card has more than {s1} days remaining and cannot accumulate."
  },
  TipsType_10635_Desc = {
    Text = "Insufficient \"Silver Prime.\" Would you like to go to Prime Extraction?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10635_RightBtnDesc = {Text = "Confirm"},
  TipsType_10635_Title = {
    Text = "Insufficient Silver Prime"
  },
  TipsType_10636_Desc = {
    Text = "No Idle Wheel of Destiny Available"
  },
  TipsType_10637_Desc = {
    Text = "No Idle Covenants Available"
  },
  TipsType_10638_Desc = {
    Text = "No available Covenant slot. Please unequip a Covenant and try again."
  },
  TipsType_10640_Desc = {
    Text = "Are you sure you want to remove all Covenants from this Awakener?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10640_RightBtnDesc = {Text = "Confirm"},
  TipsType_10640_Title = {
    Text = "Investigation in Progress"
  },
  TipsType_10641_Desc = {
    Text = "A client restart is required to apply the new language settings. Confirm?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10641_RightBtnDesc = {Text = "Confirm"},
  TipsType_10641_Title = {
    Text = "Language Switch Confirm"
  },
  TipsType_10642_Desc = {
    Text = "Insufficient player level"
  },
  TipsType_10643_Desc = {
    Text = "Entering an area filled with Dissolution, reduce HP by {s1}."
  },
  TipsType_10644_Desc = {
    Text = "This Posse Has Been Selected"
  },
  TipsType_10645_Desc = {
    Text = "This Posse Not Obtained Yet"
  },
  TipsType_10646_Desc = {
    Text = "\"{s1}\" is insufficient"
  },
  TipsType_10647_Desc = {
    Text = "The Investigation Event has not started yet, {s1}."
  },
  TipsType_10648_Desc = {
    Text = "Rotation Gap Has Been Updated"
  },
  TipsType_10649_Desc = {
    Text = "Assignment limit reached."
  },
  TipsType_10650_Desc = {
    Text = "No SSR characters have been unlocked yet."
  },
  TipsType_10651_Desc = {
    Text = "Can only be used after collecting a certain amount."
  },
  TipsType_10652_Desc = {
    Text = "All avatars and Traphase Emotes have been obtained."
  },
  TipsType_10701_Desc = {
    Text = "A Wheel of Destiny is currently equipped. Please unequip it and try again."
  },
  TipsType_10702_Desc = {
    Text = "When the total extra Ascension of equipped SSR Wheels of Destiny reaches 12, you may equip two SSR Wheels of Destiny simultaneously."
  },
  TipsType_10703_Desc = {
    Text = "The Awakener has already equipped the same Wheel of Destiny and cannot equip it again."
  },
  TipsType_10704_Desc = {
    Text = "Covenant Level Has Reached Its Maximum"
  },
  TipsType_10705_Desc = {
    Text = "Material Consumption Has Reached Its Maximum"
  },
  TipsType_10706_Desc = {
    Text = "You can lock up to two Substats"
  },
  TipsType_10707_Desc = {
    Text = "Insufficient Materials"
  },
  TipsType_10708_Desc = {
    Text = "Unlocks upon Edification Tier {s1}"
  },
  TipsType_10709_Desc = {
    Text = "\"{s1}\" is insufficient"
  },
  TipsType_10710_Desc = {Text = "Sold Out"},
  TipsType_10711_Desc = {
    Text = "This Item Is Locked"
  },
  TipsType_10712_Desc = {
    Text = "Material Storage Is Full"
  },
  TipsType_10713_Desc = {
    Text = "Wheel of Destiny Ascension has reached its maximum."
  },
  TipsType_10714_Desc = {
    Text = "Event conditions not met, cannot select."
  },
  TipsType_10715_Desc = {
    Text = "Please install the corresponding app before sharing."
  },
  TipsType_10716_Desc = {
    Text = "Cannot select any more Wheels of Destiny."
  },
  TipsType_10717_Desc = {
    Text = "Cannot Select Any More Posses"
  },
  TipsType_10718_Desc = {
    Text = "Activation Successful"
  },
  TipsType_10719_Desc = {
    Text = "Insufficient Thousand Faces Seal. You can auto-convert materials in \"Exchange Settings\""
  },
  TipsType_10720_Desc = {
    Text = "Switched to 1× Speed"
  },
  TipsType_10721_Desc = {
    Text = "Switched to 2× Speed"
  },
  TipsType_10722_Desc = {
    Text = "The campus entrance is congested, please try again later."
  },
  TipsType_10723_Desc = {
    Text = "Saved Successfully"
  },
  TipsType_10724_Desc = {
    Text = "Save failed. Album permissions are not enabled or storage is insufficient."
  },
  TipsType_10725_Desc = {
    Text = "Insufficient Crafting Materials"
  },
  TipsType_10726_Desc = {
    Text = "Please Select a Card"
  },
  TipsType_10727_Desc = {
    Text = "This Awakener Has Been Disabled"
  },
  TipsType_10728_Desc = {
    Text = "Genesis Awakeners cannot be deployed. Please choose again."
  },
  TipsType_10736_Desc = {
    Text = "\"Menophin\" is sufficient, no need to replenish."
  },
  TipsType_10737_Desc = {
    Text = "A new game version has been detected. Please restart the game to update and ensure a smooth experience."
  },
  TipsType_10738_Desc = {
    Text = "You have read all current tutorials."
  },
  TipsType_10739_Desc = {
    Text = "{s1} has already participated in {s2} and cannot enter again."
  },
  TipsType_10740_Desc = {
    Text = "Your team's average level {s1} is lower than the recommended level {s2}. The investigation may encounter significant challenges. Proceed anyway?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10740_RightBtnDesc = {Text = "Confirm"},
  TipsType_10740_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_10741_Desc = {
    Text = "Your team's average level {s1} and your Keeper level {s2} are both too low for this stage. The investigation may encounter significant challenges. Proceed anyway?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10741_RightBtnDesc = {Text = "Confirm"},
  TipsType_10741_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_10742_Desc = {
    Text = [[
Duplicate Wheel of Destiny effects cannot stack. Currently, <Blue:{s1}> has an inactive Wheel of Destiny. You are advised to adjust your WoD lineup.
Proceed anyway?]]
  },
  TipsType_10742_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10742_RightBtnDesc = {Text = "Confirm"},
  TipsType_10742_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_10743_Desc = {
    Text = "No remaining assists in the Regional D-Effect Zone"
  },
  TipsType_10744_Desc = {
    Text = "Following Limit Reached"
  },
  TipsType_10745_Desc = {
    Text = "Invalid date of birth, unable to set."
  },
  TipsType_10746_Desc = {Text = "Copied"},
  TipsType_10747_Desc = {
    Text = "Liked Successfully"
  },
  TipsType_10748_Desc = {
    Text = "{s1} is already a Support Awakener."
  },
  TipsType_10749_Desc = {
    Text = "Support Awakener Cannot Be Empty"
  },
  TipsType_10750_Desc = {
    Text = "You've already liked this Keeper today."
  },
  TipsType_10751_Desc = {
    Text = "Can Display Up to 4 Awakeners"
  },
  TipsType_10752_Desc = {
    Text = "The Realm does not meet the requirements and cannot be deployed."
  },
  TipsType_10753_Desc = {
    Text = "{s1} is already in the lineup and cannot be selected again."
  },
  TipsType_10754_Desc = {
    Text = "{s1} Has Been Reset"
  },
  TipsType_10755_Desc = {
    Text = "Unlocked Successfully"
  },
  TipsType_10756_Desc = {
    Text = "No Ascension Materials Available"
  },
  TipsType_10757_Desc = {
    Text = "{s1} has already participated in today's event challenge and cannot compete again."
  },
  TipsType_10758_Desc = {
    Text = "Party Realm Requirements Not Met"
  },
  TipsType_10761_Desc = {
    Text = "An Awakener in Genesis form cannot be deployed simultaneously with its normal form."
  },
  TipsType_10762_Desc = {
    Text = "An Awakener's Genesis form and its normal form cannot be displayed at the same time."
  },
  TipsType_10799_Desc = {
    Text = [[
Currently, the full set effect of <Blue:{s1}>'s Covenant is not active due to the <Blue:Team Unique> constraint. You are advised to adjust your Covenant lineup.
Proceed anyway?]]
  },
  TipsType_10799_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10799_RightBtnDesc = {Text = "Confirm"},
  TipsType_10799_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_10801_Desc = {
    Text = "Covenant Plan Limit Reached"
  },
  TipsType_10802_Desc = {
    Text = "{s1} is already in use in another Covenant Plan and cannot be saved."
  },
  TipsType_10803_Desc = {
    Text = "Covenant Plan Name Cannot Be Empty"
  },
  TipsType_10804_Desc = {
    Text = "Contains invalid characters, please re-enter."
  },
  TipsType_10805_Desc = {Text = "Saved"},
  TipsType_10806_Desc = {
    Text = "Current Covenant is already active in {s1}."
  },
  TipsType_10807_Desc = {Text = "Equipped"},
  TipsType_10808_Desc = {Text = "Unequipped"},
  TipsType_10809_Desc = {
    Text = "The Current Team Is Already Deployed"
  },
  TipsType_10810_Desc = {
    Text = "Covenant Plan Cannot Be Empty"
  },
  TipsType_10811_Desc = {
    Text = "This Plan Is Currently Equipped"
  },
  TipsType_10812_Desc = {Text = "Equipped"},
  TipsType_10813_Desc = {
    Text = "Are you sure you want to delete the plan [{s1}]?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10813_RightBtnDesc = {Text = "Confirm"},
  TipsType_10814_Desc = {
    Text = "Awakeners deployed in this investigation do not meet team requirements."
  },
  TipsType_10815_Desc = {
    Text = "The current Awakener is specially designed for the Story and cannot view details."
  },
  TipsType_10816_Desc = {
    Text = "Insufficient \"Proxy Certificate\""
  },
  TipsType_10817_Desc = {
    Text = "No settlement record found. Please \"Challenge\" first and try again after the daily reset at 9:00 AM."
  },
  TipsType_10818_Desc = {
    Text = "Proxy completed for today. Cannot replay."
  },
  TipsType_10821_Desc = {
    Text = "No supplies available right now, please check back later."
  },
  TipsType_10822_Desc = {
    Text = "The event has ended."
  },
  TipsType_10823_Desc = {
    Text = "Special seeds can only be restocked at the shop after they are sold out."
  },
  TipsType_10824_Desc = {
    Text = "You've used up all your restocks—there's no more inventory left."
  },
  TipsType_10825_Desc = {
    Text = "\"{s1}\" is insufficient"
  },
  TipsType_10826_Desc = {
    Text = "Special seeds are sold out. You can choose to plant them to reset."
  },
  TipsType_10827_Desc = {
    Text = "Special Seed Has Been Reset"
  },
  TipsType_10828_Desc = {
    Text = "All items have been exchanged. Please select Reset."
  },
  TipsType_10829_Desc = {
    Text = "Reset Successful"
  },
  TipsType_10830_Desc = {
    Text = "The team contains Awakeners who cannot be deployed. Unable to start investigation."
  },
  TipsType_10831_Desc = {
    Text = "The team contains the same Wheel of Destiny, and cannot enter the Regional D-Effect Zone."
  },
  TipsType_10832_Desc = {
    Text = "No Posse equipped. Unable to start investigation."
  },
  TipsType_10833_Desc = {
    Text = "The team contains unequippable Wheels of Destiny. Unable to start investigation."
  },
  TipsType_10834_Desc = {
    Text = "Cannot equip Wheel of Destiny on Support Awakener."
  },
  TipsType_10835_Desc = {
    Text = "Cannot equip Covenant on Support Awakener."
  },
  TipsType_10836_Desc = {
    Text = "Cannot equip Wheel of Destiny for story-preset Awakener."
  },
  TipsType_10837_Desc = {
    Text = "Cannot equip Covenant for story-preset Awakener."
  },
  TipsType_10838_Desc = {
    Text = "The number of emotes equipped has maxed."
  },
  TipsType_10839_Desc = {
    Text = "Emote in use. Click on an emote to remove it."
  },
  TipsType_10840_Desc = {
    Text = "You're sending too many emotes. Slow down :)"
  },
  TipsType_10841_Desc = {
    Text = "Emote plan cannot be empty."
  },
  TipsType_10842_Desc = {
    Text = "Emote plan updated."
  },
  TipsType_10843_Desc = {
    Text = "This Entry Is Still Locked"
  },
  TipsType_10844_Desc = {
    Text = "Not yet unlocked"
  },
  TipsType_10850_Desc = {
    Text = "The team contains unequippable Posse. Unable to start investigation."
  },
  TipsType_10901_Desc = {Text = "Paralysis"},
  TipsType_10902_Desc = {Text = "Fainted"},
  TipsType_10903_Desc = {
    Text = "Not Yet Owned: {s1}"
  },
  TipsType_10904_Desc = {
    Text = "Clear this chapter's \"Normal\" mode to unlock \"Story\" mode and watch the Story."
  },
  TipsType_10905_Desc = {
    Text = "Unlocks after completing \"Investigation Operation\" 1-15: Normal, and unlocks the \"Remembrance\" storyline."
  },
  TipsType_10906_Desc = {
    Text = "Insufficient Reality Verge"
  },
  TipsType_10907_Desc = {Text = "Unlocked"},
  TipsType_10908_Desc = {
    Text = "{s1} is fully Enlightened. Further gains will be converted to <TipsHighlightText:Soul Rewind Shard ×2> and <TipsHighlightText:Radix Sediment× 250>. Confirm Awakening?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10908_RightBtnDesc = {Text = "Confirm"},
  TipsType_10908_Title = {
    Text = "Confirmation"
  },
  TipsType_10909_Desc = {
    Text = "{s1} has been awakened. Further gains will be converted to <TipsHighlightText:Shard: {s2}*1> and <TipsHighlightText:Radix Sediment*50>. Confirm awakening?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10909_RightBtnDesc = {Text = "Confirm"},
  TipsType_10909_Title = {
    Text = "Confirmation"
  },
  TipsType_10910_Desc = {
    Text = "Confirm awakening <TipsHighlightText:{s1}>?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10910_RightBtnDesc = {Text = "Confirm"},
  TipsType_10910_Title = {
    Text = "Confirmation"
  },
  TipsType_10911_Desc = {
    Text = "Insufficient Space"
  },
  TipsType_10912_Desc = {
    Text = "No Command Cards available in Ultra Space. Unable to use."
  },
  TipsType_10913_Desc = {
    Text = "Cannot Be Used Again This Turn"
  },
  TipsType_10914_Desc = {
    Text = "Confirm selection of <TipsHighlightText:{s1}>?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10914_RightBtnDesc = {Text = "Confirm"},
  TipsType_10914_Title = {
    Text = "Select Confirm"
  },
  TipsType_10915_Desc = {
    Text = "Lineups must be unlocked in order. Cannot skip locked Lineups."
  },
  TipsType_10916_Desc = {
    Text = "Consume <Blue: {s1} × {s2}> to unlock?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10916_RightBtnDesc = {Text = "Confirm"},
  TipsType_10916_Title = {
    Text = "Unlock Confirmation"
  },
  TipsType_10917_Desc = {
    Text = "{s1} Unlocked"
  },
  TipsType_10918_Desc = {
    Text = "{s1} unlocked. All Lineups have been unlocked."
  },
  TipsType_10919_Desc = {
    Text = "Unlocked after completing [{s1}: {s2}]. Go to [{s1}] now?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10919_RightBtnDesc = {Text = "Confirm"},
  TipsType_10919_Title = {
    Text = "Not Unlocked"
  },
  TipsType_10920_Desc = {
    Text = "Accumulate \"Magic Acorn\" × {s1} in the limited-time event \"Phase Reversal\" to unlock. Do you want to go to \"Phase Reversal\"?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "Cancel"},
  TipsType_10920_RightBtnDesc = {Text = "Confirm"},
  TipsType_10920_Title = {
    Text = "Not Unlocked"
  },
  TipsType_10921_Desc = {
    Text = "Cannot equip two Wheels of Destiny with the same attribute simultaneously."
  },
  TipsType_20001_Desc = {
    Text = "With Checkbox Double Confirmation"
  },
  TipsType_20001_LeftBtnDesc = {Text = "Confirm"},
  TipsType_20001_Title = {Text = "Title"},
  TipsType_20002_Desc = {
    Text = "Without Checkbox Double Confirmation"
  },
  TipsType_20002_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20002_RightBtnDesc = {Text = "Confirm"},
  TipsType_20002_Title = {Text = "Title"},
  TipsType_20003_Desc = {
    Text = "Your account has been logged in on another device."
  },
  TipsType_20003_RightBtnDesc = {Text = "Confirm"},
  TipsType_20003_Title = {
    Text = "Disconnection Hint"
  },
  TipsType_20004_Desc = {
    Text = "Disconnected from the server. Please log in again."
  },
  TipsType_20004_RightBtnDesc = {Text = "Confirm"},
  TipsType_20004_Title = {
    Text = "Disconnection Hint"
  },
  TipsType_20005_Desc = {
    Text = "Sync Failed. Try Again?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20005_RightBtnDesc = {Text = "Confirm"},
  TipsType_20005_Title = {
    Text = "Sync Failed"
  },
  TipsType_20006_Desc = {
    Text = "Desynchronized. Returning to login screen."
  },
  TipsType_20006_RightBtnDesc = {Text = "Confirm"},
  TipsType_20006_Title = {
    Text = "Sync Failed"
  },
  TipsType_20007_Desc = {
    Text = "Desynchronized. Returning to login screen."
  },
  TipsType_20007_RightBtnDesc = {Text = "Confirm"},
  TipsType_20007_Title = {
    Text = "Sync Failed"
  },
  TipsType_20008_Desc = {
    Text = "This investigation costs <Positive:{s1}> Stamina. Are you sure you want to end it?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20008_RightBtnDesc = {Text = "Confirm"},
  TipsType_20008_Title = {
    Text = "End Exploration"
  },
  TipsType_20009_Desc = {
    Text = "Refreshing will update Orisons and Relics. Awakener Rouses and Command Card sale counts will not be reset. Confirm?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20009_RightBtnDesc = {Text = "Confirm"},
  TipsType_20009_Title = {
    Text = "Confirm Refresh"
  },
  TipsType_20010_Desc = {
    Text = "The number of Awakeners in this Realm is insufficient. Do you want to continue creating the team?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20010_RightBtnDesc = {Text = "Confirm"},
  TipsType_20011_Desc = {
    Text = "No Awakener selected, lineup will not be retained."
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Confirm Exit"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Continue Lineup"
  },
  TipsType_20012_Desc = {
    Text = "No Awakener Selected"
  },
  TipsType_20012_RightBtnDesc = {Text = "Confirm"},
  TipsType_20013_Desc = {
    Text = "Lineup incomplete. Start anyway?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Return"},
  TipsType_20013_RightBtnDesc = {Text = "Set Forth"},
  TipsType_20014_Desc = {
    Text = "The team limit has been reached."
  },
  TipsType_20014_RightBtnDesc = {Text = "Confirm"},
  TipsType_20015_Desc = {
    Text = "Delete this Team?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20015_RightBtnDesc = {Text = "Confirm"},
  TipsType_20016_Desc = {
    Text = "{s1} Unlocked after Clear"
  },
  TipsType_20016_RightBtnDesc = {Text = "Confirm"},
  TipsType_20017_Desc = {
    Text = "Here you can view map information and defeated monster information. This feature is not yet available in the current version."
  },
  TipsType_20017_RightBtnDesc = {Text = "Confirm"},
  TipsType_20018_Desc = {
    Text = "Stage Unlock Conditions Not Yet Met"
  },
  TipsType_20018_RightBtnDesc = {Text = "Confirm"},
  TipsType_20018_Title = {
    Text = "Quick Survey"
  },
  TipsType_20019_Desc = {
    Text = "\"Silver\" is insufficient. Would you like to go to the shop to buy more?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20019_RightBtnDesc = {Text = "Proceed"},
  TipsType_20020_Desc = {
    Text = "Unlock this advanced difficulty after clearing Advanced {s1}."
  },
  TipsType_20020_RightBtnDesc = {Text = "Confirm"},
  TipsType_20021_Desc = {
    Text = "{s1} Advanced Training unlocked after clearing Normal Mode."
  },
  TipsType_20021_RightBtnDesc = {Text = "Confirm"},
  TipsType_20022_Desc = {
    Text = "\"Silver\" insufficient. Would you like to proceed to purchase"
  },
  TipsType_20022_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20022_RightBtnDesc = {Text = "Confirm"},
  TipsType_20022_Title = {
    Text = "Insufficient Silvers"
  },
  TipsType_20023_Desc = {
    Text = "This upgrade will waste {s1} EXP (no refund), and characters cannot gain EXP after reaching the level cap. Do you wish to continue?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20023_RightBtnDesc = {Text = "Confirm"},
  TipsType_20024_Desc = {
    Text = "The party is not full and cannot enter the instance."
  },
  TipsType_20024_RightBtnDesc = {Text = "Confirm"},
  TipsType_20026_Desc = {
    Text = "Confirm Aliemus Regen?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20026_RightBtnDesc = {Text = "Confirm"},
  TipsType_20027_Desc = {
    Text = "Confirm HP restoration?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20027_RightBtnDesc = {Text = "Confirm"},
  TipsType_20028_Desc = {
    Text = "Closing this window will forfeit [{s1}]. Proceed anyway?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20028_RightBtnDesc = {Text = "Confirm"},
  TipsType_20029_Desc = {
    Text = "Closing this screen will skip the current event (the Relic will not be removed). Confirm?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20029_RightBtnDesc = {Text = "Confirm"},
  TipsType_20030_Desc = {
    Text = "Selected Relics will not be carried over. Abandon inheritance?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20030_RightBtnDesc = {Text = "Confirm"},
  TipsType_20031_Desc = {
    Text = "Exit the Battle?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20031_RightBtnDesc = {Text = "Confirm"},
  TipsType_20032_Desc = {
    Text = "The current level is not yet unlocked. Would you like to unlock it by completing the Keeper Level?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20032_RightBtnDesc = {Text = "Confirm"},
  TipsType_20032_Title = {
    Text = "Not Unlocked"
  },
  TipsType_20033_Desc = {
    Text = "Challenge attempts are insufficient. Spend 500 Silver to reset?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20033_RightBtnDesc = {Text = "Confirm"},
  TipsType_20034_Desc = {
    Text = "The current challenge is on cooldown. Do you want to spend \"Silver\" × 50 to reset it?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20034_RightBtnDesc = {Text = "Confirm"},
  TipsType_20035_Desc = {
    Text = "The recommended Level is {s1}, and the current team's average Level is {s2}. The investigation will face obstacles. Do you wish to continue?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20035_RightBtnDesc = {Text = "Confirm"},
  TipsType_20035_Title = {
    Text = "Low Strength"
  },
  TipsType_20036_Desc = {
    Text = "The current sweep count is set to {s1}, but challenging the dungeon will only consume {s2} stamina to obtain 1 reward. Do you wish to proceed?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20036_RightBtnDesc = {Text = "Confirm"},
  TipsType_20036_Title = {
    Text = "Challenge Confirm"
  },
  TipsType_20037_Desc = {
    Text = "The enhancement materials include advance materials. Are you sure you want to enhance?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20037_RightBtnDesc = {Text = "Confirm"},
  TipsType_20037_Title = {
    Text = "Enhance Confirm"
  },
  TipsType_20038_Desc = {
    Text = "This equipment is currently locked. Would you like to unlock it?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20038_RightBtnDesc = {Text = "Confirm"},
  TipsType_20039_Desc = {
    Text = "The Investigation will fail, forfeiting any subsequent rewards. Proceed anyway?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20039_RightBtnDesc = {Text = "Confirm"},
  TipsType_20039_Title = {Text = "Quit"},
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:Quitting now will cost you {s1} Menophin.> The Investigation will fail, forfeiting any subsequent rewards. Proceed anyway?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20040_RightBtnDesc = {Text = "Confirm"},
  TipsType_20040_Title = {Text = "Quit"},
  TipsType_20041_BottomDesc = {
    Text = "Current Time Compression Permits Owned: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "Consume {s1} Time Compression Permits to speed up?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20041_RightBtnDesc = {Text = "Confirm"},
  TipsType_20041_Title = {
    Text = "Speedup Confirm"
  },
  TipsType_20042_Desc = {
    Text = "RPG combat adjustment in progress, currently settling as a direct victory."
  },
  TipsType_20042_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20042_RightBtnDesc = {Text = "Confirm"},
  TipsType_20043_Desc = {
    Text = "Spend {s1} Silver to refresh the current quest?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20043_RightBtnDesc = {Text = "Confirm"},
  TipsType_20043_Title = {
    Text = "Quest Refresh"
  },
  TipsType_20044_BottomDesc = {
    Text = "Cost: {s1} Research Permits"
  },
  TipsType_20044_Desc = {
    Text = [[
Conduct research on {s1}?
Research Effect: {s2}]]
  },
  TipsType_20044_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20044_RightBtnDesc = {Text = "Confirm"},
  TipsType_20044_Title = {
    Text = "Confirm Research"
  },
  TipsType_20045_BottomDesc = {
    Text = "Canceling research will not retain progress already made."
  },
  TipsType_20045_Desc = {
    Text = "Cancel research on {s1}? (Full research permits will be refunded.)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20045_RightBtnDesc = {Text = "Confirm"},
  TipsType_20045_Title = {
    Text = "Research Cancel"
  },
  TipsType_20046_Desc = {
    Text = "Consume {s1} \"Silver\" to speed up?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20046_RightBtnDesc = {Text = "Confirm"},
  TipsType_20046_Title = {
    Text = "Speedup Confirm"
  },
  TipsType_20047_Desc = {
    Text = "Lack of {s1} <Blue:\"{s2}\">, consume <Blue:\"Silver\"×{s3} > to purchase?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20047_RightBtnDesc = {Text = "Confirm"},
  TipsType_20047_Title = {
    Text = "Confirmation"
  },
  TipsType_20048_Desc = {
    Text = "Lack of {s1} <Blue:\"{s2}\">, consume <Blue:\"Silver\"×{s3} > to purchase?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20048_RightBtnDesc = {Text = "Confirm"},
  TipsType_20048_Title = {
    Text = "Purchase Confirmation"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:\"{s1}\"> is already equipped by <Blue:\"{s2}\">. Do you confirm the replacement?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20049_RightBtnDesc = {Text = "Confirm"},
  TipsType_20049_Title = {
    Text = "Change Hint"
  },
  TipsType_20050_Desc = {
    Text = "The Wheel of Destiny you're using has been Ascended. Continue?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20050_RightBtnDesc = {Text = "Confirm"},
  TipsType_20050_Title = {Text = "Notice"},
  TipsType_20051_Desc = {
    Text = "Ascension rank will exceed the upper limit. Excess Ascensions will be refunded accordingly. Continue?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20051_RightBtnDesc = {Text = "Confirm"},
  TipsType_20051_Title = {Text = "Notice"},
  TipsType_20052_Desc = {
    Text = "Recommended Level is {s1}, current team's average Level is {s2}. The investigation will face significant obstacles. Proceed anyway?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20052_RightBtnDesc = {Text = "Confirm"},
  TipsType_20052_Title = {
    Text = "Low Strength"
  },
  TipsType_20053_Desc = {
    Text = "Recommended Level is {s1}, current team's average Level is {s2}. The investigation will face extreme obstacles. Proceed anyway?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20053_RightBtnDesc = {Text = "Confirm"},
  TipsType_20053_Title = {
    Text = "Low Strength"
  },
  TipsType_20054_Desc = {
    Text = "All challenge rewards have been claimed. Continuing the challenge will not grant any additional rewards. Proceed anyway?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20054_RightBtnDesc = {Text = "Confirm"},
  TipsType_20054_Title = {
    Text = "Challenge Confirm"
  },
  TipsType_20055_Desc = {
    Text = "Resetting will clear all Stars earned for this stage and wipe the Awakener battle records. Confirm reset?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20055_RightBtnDesc = {Text = "Confirm"},
  TipsType_20055_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20056_Desc = {
    Text = "Upon victory, the 4 Awakeners in the current lineup will be unable to participate in any other {s1} stages. Confirm challenge?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20056_RightBtnDesc = {Text = "Confirm"},
  TipsType_20056_Title = {
    Text = "Challenge Confirm"
  },
  TipsType_20057_Desc = {
    Text = "The team composition goes against the recommended guidelines in the Academy Handbook. Do you still want to proceed with the challenge?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20057_RightBtnDesc = {Text = "Confirm"},
  TipsType_20057_Title = {
    Text = "Lineup Confirm"
  },
  TipsType_20058_Desc = {
    Text = "The current stage has been successfully cleared. To challenge it again, you need to reset the current stage progress to 0 stars. The Awakener's battle record will also be cleared. Confirm reset?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20058_RightBtnDesc = {Text = "Confirm"},
  TipsType_20058_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20059_Desc = {
    Text = "The current team does not have 4 Awakeners, and cannot enter battle."
  },
  TipsType_20059_Title = {
    Text = "Save Lineup"
  },
  TipsType_20060_BottomDesc = {
    Text = "After confirmation, you will not be able to Reawaken."
  },
  TipsType_20060_Desc = {
    Text = "Confirm your selection of this Awakening result? (you will obtain all Awakeners and Wheels of Destiny from this Awakening)?"
  },
  TipsType_20060_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20060_RightBtnDesc = {Text = "Confirm"},
  TipsType_20060_Title = {
    Text = "Confirm Selection"
  },
  TipsType_20061_BottomDesc = {
    Text = "Current Silver: {s1}"
  },
  TipsType_20061_Desc = {
    Text = [[
Spend {s1} "Silver" to Awaken again?
Awakening again will not retain the current draw results.]]
  },
  TipsType_20061_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20061_RightBtnDesc = {Text = "Confirm"},
  TipsType_20061_Title = {Text = "Reawaken"},
  TipsType_20062_Desc = {
    Text = [[
Delete all read mail?
Mail with unclaimed attachments will not be deleted.]]
  },
  TipsType_20062_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20062_RightBtnDesc = {Text = "Confirm"},
  TipsType_20062_Title = {
    Text = "Delete Read"
  },
  TipsType_20063_Desc = {
    Text = "Confirm Deletion?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20063_RightBtnDesc = {Text = "Confirm"},
  TipsType_20063_Title = {
    Text = "Delete Current Mail"
  },
  TipsType_20064_Desc = {
    Text = [[
Mail deleted from the Keepsake Box cannot be recovered.
Delete this mail?]]
  },
  TipsType_20064_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20064_RightBtnDesc = {Text = "Confirm"},
  TipsType_20064_Title = {
    Text = "Delete Letters"
  },
  TipsType_20065_Desc = {
    Text = "Confirm consuming <Blue:{s1}> to craft <Blue:{s2}>?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20065_RightBtnDesc = {Text = "Confirm"},
  TipsType_20065_Title = {
    Text = "Confirm Synthesis"
  },
  TipsType_20066_Desc = {
    Text = "Confirm dismantle <Blue:{s1} to receive {s2}>?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20066_RightBtnDesc = {Text = "Confirm"},
  TipsType_20066_Title = {
    Text = "Confirm Dismantle"
  },
  TipsType_20067_Desc = {
    Text = "Confirm consuming <Blue:{s1}> SSR <plural value=\"{s1}\" singular=\"Covenant\" plural=\"Covenants\"> to reprint <Blue:{s2}> <Blue:{s3}>?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20067_RightBtnDesc = {Text = "Confirm"},
  TipsType_20067_Title = {
    Text = "Confirm Re-Orison"
  },
  TipsType_20068_Desc = {
    Text = [[
All Awakeners are downed.

Oh lone Keeper,
What will you choose next?]]
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "Retry Battle"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "Temporary Retreat"
  },
  TipsType_20068_Title = {
    Text = "Investigation Failed"
  },
  TipsType_20069_Desc = {
    Text = "The currently selected Awakener's Aliemus is full. Are you sure you still want to select this Awakener?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20069_RightBtnDesc = {Text = "Confirm"},
  TipsType_20069_Title = {
    Text = "Confirm Select"
  },
  TipsType_20070_Desc = {
    Text = [[
Are you sure you want to use {s1}?
Levels and skills that have already been upgraded on the Awakener will not be refunded.]]
  },
  TipsType_20070_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20070_RightBtnDesc = {Text = "Confirm"},
  TipsType_20070_Title = {
    Text = "Confirm Enhancement"
  },
  TipsType_20071_Desc = {
    Text = "Limited by the Keeper Level, the Awakener's level will be upgraded to {s1}. Missing upgrade Inventory will not be refunded. Proceed?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20071_RightBtnDesc = {Text = "Confirm"},
  TipsType_20071_Title = {
    Text = "Confirm Enhancement"
  },
  TipsType_20072_Desc = {
    Text = [[
Skip all story in this section?
Note: You can re-read the story later.]]
  },
  TipsType_20072_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20072_RightBtnDesc = {Text = "Confirm"},
  TipsType_20072_Title = {Text = "Skip Story"},
  TipsType_20073_Desc = {
    Text = [[
Confirm the dismantle of {s1} to obtain {s2}?
(The current Covenant has been enhanced, and dismantling it will not return the enhancement items.)]]
  },
  TipsType_20073_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20073_RightBtnDesc = {Text = "Confirm"},
  TipsType_20073_Title = {
    Text = "Confirm Dismantle"
  },
  TipsType_20074_Desc = {
    Text = [[
Confirm dismantling {s1} to obtain {s2}?
(The selected Wheel of Destiny is high rarity.)]]
  },
  TipsType_20074_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20074_RightBtnDesc = {Text = "Confirm"},
  TipsType_20074_Title = {
    Text = "Confirm Dismantle"
  },
  TipsType_20075_BottomDesc = {
    Text = "Consuming: {s1} research permits"
  },
  TipsType_20075_Desc = {
    Text = "Start {s1} Research?\nProduction Efficiency: {s2} Rose Scrip/Every 6hrs\n     —>{s3} Rose Scrip/Every 6hrs"
  },
  TipsType_20075_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20075_RightBtnDesc = {Text = "Confirm"},
  TipsType_20075_Title = {
    Text = "Confirm Research"
  },
  TipsType_20076_BottomDesc = {
    Text = "Consuming: {s1} research permits"
  },
  TipsType_20076_Desc = {
    Text = "Start research on {s1}?\nProduction Efficiency: {s2} Gnosis Elixir/6 hours\n     —>{s3} Gnosis Elixir/6 hours"
  },
  TipsType_20076_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20076_RightBtnDesc = {Text = "Confirm"},
  TipsType_20076_Title = {
    Text = "Confirm Research"
  },
  TipsType_20077_BottomDesc = {
    Text = "Consuming: {s1} research permits"
  },
  TipsType_20077_Desc = {
    Text = "Start research on {s1}?\nProduction Efficiency: {s2} Covenant Traces/6 hours\n     —>{s3} Covenant Traces/6 hours"
  },
  TipsType_20077_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20077_RightBtnDesc = {Text = "Confirm"},
  TipsType_20077_Title = {
    Text = "Confirm Research"
  },
  TipsType_20078_Desc = {
    Text = [[
Skip all story in this section?
Note: You can re-read the story later.]]
  },
  TipsType_20078_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20078_RightBtnDesc = {Text = "Confirm"},
  TipsType_20078_Title = {Text = "Skip Story"},
  TipsType_20079_Desc = {
    Text = [[
Silver Key senses a fatal crisis. Activate Emergency Gnosis?
(Revival will consume 1 Emergency Gnosis. You receive 1 daily at 9 AM. Remaining uses: {s1}/{s2})]]
  },
  TipsType_20079_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20079_RightBtnDesc = {Text = "Confirm"},
  TipsType_20079_Title = {
    Text = "Revive Now?"
  },
  TipsType_20080_Desc = {
    Text = [[
Silver Key senses a fatal crisis. Activate Emergency Gnosis?
(Revival will consume 1 Emergency Gnosis. You receive 1 daily at 9 AM. Remaining uses: {s1}/{s2})]]
  },
  TipsType_20080_RightBtnDesc = {Text = "Confirm"},
  TipsType_20080_Title = {
    Text = "Revive Now?"
  },
  TipsType_20081_Desc = {
    Text = "Game initialization failed. {s1}."
  },
  TipsType_20081_RightBtnDesc = {Text = "Confirm"},
  TipsType_20081_Title = {
    Text = "Login Error Hint"
  },
  TipsType_20082_Desc = {
    Text = "Would you like to consume <Blue:\"Silver\" × {s1} > to purchase <Blue: {s2} > levels?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20082_RightBtnDesc = {Text = "Confirm"},
  TipsType_20082_Title = {Text = "Level Up"},
  TipsType_20083_Desc = {
    Text = "Consumes Wheel of Destiny {s1}. Confirm enhancing?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20083_RightBtnDesc = {Text = "Confirm"},
  TipsType_20083_Title = {
    Text = "Confirm Consumption"
  },
  TipsType_20084_Desc = {
    Text = "Your team's average level is too low for this stage. The investigation may encounter significant challenges. Proceed anyway?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Enhance Awakeners"
  },
  TipsType_20084_RightBtnDesc = {Text = "Confirm"},
  TipsType_20084_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20085_Desc = {
    Text = "Confirm Exit"
  },
  TipsType_20085_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20085_RightBtnDesc = {Text = "Confirm"},
  TipsType_20085_Title = {Text = "Exit Game"},
  TipsType_20086_Desc = {
    Text = "Server Under Maintenance"
  },
  TipsType_20086_RightBtnDesc = {Text = "Confirm"},
  TipsType_20086_Title = {
    Text = "Disconnection Hint"
  },
  TipsType_20087_Desc = {
    Text = "Confirm the consumption of <TipsHighlightText:{s1} × {s2}> to unlock <TipsHighlightText:{s3}>?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20087_RightBtnDesc = {Text = "Confirm"},
  TipsType_20087_Title = {
    Text = "Confirm Activate"
  },
  TipsType_20088_Desc = {
    Text = [[
After claiming, "Menophin" will overflow, and any amount exceeding {s1} cannot be obtained.
Do you wish to continue claiming?]]
  },
  TipsType_20088_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20088_RightBtnDesc = {Text = "Confirm"},
  TipsType_20088_Title = {
    Text = "Menophin Overflow"
  },
  TipsType_20089_Desc = {
    Text = [[
Spend <Blue:{s1}> Rose Scrips to refresh inventory
Remaining refreshes: <Blue:{s2}>
The more refreshes performed, the higher the number of Rose Scrips required.]]
  },
  TipsType_20089_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20089_RightBtnDesc = {Text = "Confirm"},
  TipsType_20089_Title = {
    Text = "Refresh Stock"
  },
  TipsType_20090_Desc = {
    Text = [[
The number of Wheels of Destiny has reached the limit. You need to clear some Wheels of Destiny before you can Awaken. Would you like to go there?

<color=#ADC0CB>*You can set SR/R-tier Wheels of Destiny to auto-dismantle in "Settings."</color>]]
  },
  TipsType_20090_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20090_RightBtnDesc = {Text = "Clear Now"},
  TipsType_20090_Title = {
    Text = "Cleanup Hint"
  },
  TipsType_20091_Desc = {
    Text = "The Covenant limit has been reached. You need to clear some Covenants before investigating. Proceed?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20091_RightBtnDesc = {Text = "Clear Now"},
  TipsType_20091_Title = {
    Text = "Cleanup Hint"
  },
  TipsType_20092_Desc = {
    Text = "Are you sure you want to unequip all Wheels of Destiny from the current Awakener's equipment?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20092_RightBtnDesc = {Text = "Confirm"},
  TipsType_20092_Title = {
    Text = "Unequip Confirm"
  },
  TipsType_20093_Desc = {
    Text = "The Covenant to be consumed has been upgraded. Confirm?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20093_RightBtnDesc = {Text = "Confirm"},
  TipsType_20093_Title = {
    Text = "Upgrade Confirm"
  },
  TipsType_20094_Desc = {
    Text = "This Covenant has a Max-Value Substat that was not locked. If you continue, it will be overwritten."
  },
  TipsType_20094_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20094_RightBtnDesc = {Text = "Replace"},
  TipsType_20094_Title = {
    Text = "Replace Substats?"
  },
  TipsType_20095_Desc = {
    Text = "There is a Max-Value Substat pending. If you continue Transcription, it will be lost."
  },
  TipsType_20095_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20095_RightBtnDesc = {Text = "Transcribe"},
  TipsType_20095_Title = {
    Text = "Continue Transcribing?"
  },
  TipsType_20096_Desc = {
    Text = "Upgrading this Covenant will exceed the level cap. Any overflow will refund the transcription materials. Confirm?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20096_RightBtnDesc = {Text = "Confirm"},
  TipsType_20096_Title = {
    Text = "Upgrade Confirm"
  },
  TipsType_20097_Desc = {
    Text = "This Awakener is fully Enlightened.\nAfter selection, you will only receive \"Soul Rewind Shard\" ×1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20097_RightBtnDesc = {Text = "Continue"},
  TipsType_20097_Title = {
    Text = "Confirm Selection"
  },
  TipsType_20098_Desc = {
    Text = "This item can be purchased using <Blue:{s1}> Mithril Trading Certificates"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "Cash Payment"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "Voucher Payment"
  },
  TipsType_20098_Title = {
    Text = "Settlement Method"
  },
  TipsType_20099_Desc = {
    Text = "Exit the Game?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20099_RightBtnDesc = {Text = "Confirm"},
  TipsType_20099_Title = {
    Text = "Investigation in Progress"
  },
  TipsType_20100_Desc = {
    Text = "A new game version has been detected. Please restart the game to update resources."
  },
  TipsType_20100_RightBtnDesc = {Text = "Confirm"},
  TipsType_20100_Title = {
    Text = "Update Hint"
  },
  TipsType_20101_Desc = {
    Text = "The investigation is complete. Would you like to skip the story?"
  },
  TipsType_20101_LeftBtnDesc = {Text = "Skip Story"},
  TipsType_20101_RightBtnDesc = {Text = "Read Story"},
  TipsType_20101_Title = {
    Text = "Story Confirm"
  },
  TipsType_20102_Desc = {
    Text = "Are you sure you want to unfollow {s1}?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20102_RightBtnDesc = {Text = "Confirm"},
  TipsType_20102_Title = {Text = "Unfollow"},
  TipsType_20103_Desc = {
    Text = "Unlock for <WeaponEffect_Num:limited time for free> during the event. Do you want to unlock it?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20103_RightBtnDesc = {Text = "Confirm"},
  TipsType_20103_Title = {
    Text = "Event Goods"
  },
  TipsType_20105_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20105_LeftBtnDesc = {Text = "Return"},
  TipsType_20105_RightBtnDesc = {Text = "Proceed"},
  TipsType_20105_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20106_Desc = {
    Text = "Consume <Blue:\"Silver Prime\" ×  {s1} > to purchase?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20106_RightBtnDesc = {Text = "Purchase"},
  TipsType_20106_Title = {
    Text = "Purchase Confirmation"
  },
  TipsType_20107_Desc = {
    Text = "Are you sure you want to select <Blue:{s1}>?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20107_RightBtnDesc = {Text = "Confirm"},
  TipsType_20107_Title = {
    Text = "Select Confirm"
  },
  TipsType_20108_Desc = {
    Text = [[
This action consumes the rare item "Timeloop Copy"
Continue?]]
  },
  TipsType_20108_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20108_RightBtnDesc = {Text = "Confirm"},
  TipsType_20108_Title = {
    Text = "Confirmation"
  },
  TipsType_20109_Desc = {
    Text = "Are you sure you want to restart this battle?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20109_RightBtnDesc = {Text = "Confirm"},
  TipsType_20109_Title = {
    Text = "Retry Battle"
  },
  TipsType_20110_Desc = {
    Text = [[
Set your birthday to {s1}/{s2}?
This cannot be changed.]]
  },
  TipsType_20110_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20110_RightBtnDesc = {Text = "Confirm"},
  TipsType_20110_Title = {
    Text = "Birthday Confirm"
  },
  TipsType_20111_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20111_LeftBtnDesc = {Text = "Return"},
  TipsType_20111_RightBtnDesc = {Text = "Proceed"},
  TipsType_20111_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20112_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20112_LeftBtnDesc = {Text = "Return"},
  TipsType_20112_RightBtnDesc = {Text = "Proceed"},
  TipsType_20112_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20113_Desc = {
    Text = "Mark all unlocked tutorials as read and claim rewards? (New Keepers are recommended to review tutorials first~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20113_RightBtnDesc = {Text = "Confirm"},
  TipsType_20113_Title = {
    Text = "Read All Confirm"
  },
  TipsType_20114_Desc = {
    Text = [[
Confirm selecting <WeaponEffect_Num:{s1}> to activate Reset?
This action is irreversible. Please confirm carefully.]]
  },
  TipsType_20114_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20114_RightBtnDesc = {Text = "Confirm"},
  TipsType_20114_Title = {
    Text = "Reset Selection"
  },
  TipsType_201151_Desc = {
    Text = "The current Awakener is at Enlighten Lv.0. No need for Enlightenment Reset."
  },
  TipsType_20115_Desc = {
    Text = "The current Awakener has not undergone any development, so no Development Reset is required."
  },
  TipsType_20116_Desc = {
    Text = [[
<WeaponEffect_Num:{s1}>Reset has been activated.
Would you like to proceed with the Reset now?]]
  },
  TipsType_20116_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20116_RightBtnDesc = {Text = "Proceed"},
  TipsType_20116_Title = {
    Text = "Unlock Success"
  },
  TipsType_20117_Desc = {
    Text = [[
Resetting the Awakener's Level, Edification, Skills, Talents, and Gnostic Advance statuses. All Materials consumed will be returned.
Confirm Development Reset for <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20117_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20117_RightBtnDesc = {Text = "Confirm"},
  TipsType_20117_Title = {
    Text = "Development Reset"
  },
  TipsType_20118_Desc = {
    Text = [[
Resetting the Awakener's Enlightenment status and refunding the Enlightenment costs.
Confirm Enlightenment Reset <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20118_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20118_RightBtnDesc = {Text = "Confirm"},
  TipsType_20118_Title = {
    Text = "Enlightenment Reset"
  },
  TipsType_20119_Desc = {
    Text = [[
Resetting the Awakener's Level, Edification, Skills, Talents, Enlightenment, and Gnostic Advance statuses. This Awakener will be returned to the Dark Pool.
Confirm Genesis Return for <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20119_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20119_RightBtnDesc = {Text = "Confirm"},
  TipsType_20119_Title = {
    Text = "Genesis return"
  },
  TipsType_20120_Desc = {
    Text = "Special Awakeners cannot be reset."
  },
  TipsType_20121_Desc = {
    Text = "About to reset Ascension status and refund all costs. Confirm reset for <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20121_RightBtnDesc = {Text = "Confirm"},
  TipsType_20121_Title = {
    Text = "Stack Traceback"
  },
  TipsType_20122_Desc = {
    Text = [[
About to reset Ascension status, refund all costs, and return the Wheel of Destiny to the Genesis Pool.
Confirm Genesis Return for <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20122_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20122_RightBtnDesc = {Text = "Confirm"},
  TipsType_20122_Title = {
    Text = "Genesis return"
  },
  TipsType_20123_Desc = {
    Text = "After completing the challenge, Awakeners, Wheels of Destiny, and Posse in the team will not be able to participate in other Regional D-Effect Zones. Confirm?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20123_RightBtnDesc = {Text = "Confirm"},
  TipsType_20123_Title = {
    Text = "Challenge Confirm"
  },
  TipsType_20124_Desc = {
    Text = "After resetting, Awakeners, the Wheel of Destiny, and Keys in the Investigation team can be redeployed, but the Training Value gained from this stage will be deducted."
  },
  TipsType_20124_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20124_RightBtnDesc = {Text = "Confirm"},
  TipsType_20124_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20125_Desc = {
    Text = "Current Wheel of Destiny Ascension level is 0, no Ascension reset needed."
  },
  TipsType_20126_Desc = {
    Text = "The current Awakener is on an Assignment. Please recall them before resetting or returning."
  },
  TipsType_20127_Desc = {
    Text = "The current Wheel of Destiny is locked. Please unlock it before reset."
  },
  TipsType_20128_Desc = {
    Text = [[
{s1} cleared. Reset to retry?
(After resetting, Awakeners, the Wheel of Destiny, and Keys in the Investigation team can be redeployed, but the Training Value gained from this stage will be deducted.)]]
  },
  TipsType_20128_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20128_RightBtnDesc = {Text = "Confirm"},
  TipsType_20128_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20129_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20129_LeftBtnDesc = {Text = "Return"},
  TipsType_20129_RightBtnDesc = {Text = "Proceed"},
  TipsType_20129_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20130_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20130_LeftBtnDesc = {Text = "Return"},
  TipsType_20130_RightBtnDesc = {Text = "Proceed"},
  TipsType_20130_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20131_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20131_LeftBtnDesc = {Text = "Return"},
  TipsType_20131_RightBtnDesc = {Text = "Proceed"},
  TipsType_20131_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20132_Desc = {
    Text = [[
If sufficient <TipsHighlightText:Covenant Fragments> are available, they will be used first.
If supply is insufficient, <TipsHighlightText:"{s1}"> will be consumed instead.]]
  },
  TipsType_20132_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20132_RightBtnDesc = {Text = "Confirm"},
  TipsType_20132_Title = {
    Text = "Auto-Substitution"
  },
  TipsType_20133_Desc = {
    Text = "Perform Gnostic Advance on <TipsHighlightText:\"{s1}\">?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20133_RightBtnDesc = {Text = "Confirm"},
  TipsType_20133_Title = {
    Text = "Gnostic Advance"
  },
  TipsType_20134_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20134_LeftBtnDesc = {Text = "Return"},
  TipsType_20134_RightBtnDesc = {Text = "Proceed"},
  TipsType_20134_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20137_Desc = {
    Text = "Unlock this track with <Blue:\"{s1}\"*{s2}>?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20137_RightBtnDesc = {Text = "Confirm"},
  TipsType_20137_Title = {
    Text = "Unlock Confirmation"
  },
  TipsType_20138_Desc = {
    Text = "<Blue:Free To Unlock> for limited-time only. Unlock now?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20138_RightBtnDesc = {Text = "Confirm"},
  TipsType_20138_Title = {
    Text = "Unlock Confirmation"
  },
  TipsType_20139_Desc = {
    Text = "Unlock <Blue:\"{s2}\"> with <Blue:\"{s1}\"*{s3}>?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20139_RightBtnDesc = {Text = "Confirm"},
  TipsType_20139_Title = {
    Text = "Unlock Confirmation"
  },
  TipsType_20140_Desc = {
    Text = "You have reached the maximum limit of <Blue:{s1}> count. Claiming more will not grant additional items. Claim anyway?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20140_RightBtnDesc = {Text = "Confirm"},
  TipsType_20140_Title = {
    Text = "Claim Confirm"
  },
  TipsType_20141_Desc = {
    Text = [[
Spend 30% of your Max HP ({s1}) to
skip the battle and eliminate the enemy instantly?

Current HP: {s2}]]
  },
  TipsType_20141_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20141_RightBtnDesc = {Text = "Confirm"},
  TipsType_20141_Title = {
    Text = "Muscle Memory"
  },
  TipsType_20142_Desc = {
    Text = "Consume <color=#BB646D>{s1}</color> HP to obtain {s2} Black Sigils?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20142_RightBtnDesc = {Text = "Confirm"},
  TipsType_20142_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20145_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20145_Title = {
    Text = "Login Rewards"
  },
  TipsType_20151_Desc = {
    Text = "After resetting, the remaining quantity of \"Special Items\" will be reset to the maximum. Are you sure?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20151_RightBtnDesc = {Text = "Confirm"},
  TipsType_20151_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20152_Desc = {
    Text = "{s1} insufficient, use Rose Scrips *{s2} to make up?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20152_RightBtnDesc = {Text = "Confirm"},
  TipsType_20152_Title = {
    Text = "Activation Confirm"
  },
  TipsType_20153_Desc = {
    Text = [[
After resetting, the remaining quantities of "Special Items" and "Common Items" will be reset to the maximum.
From the {s1} time onward, "Special Items" will no longer reset.
Are you sure?]]
  },
  TipsType_20153_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20153_RightBtnDesc = {Text = "Confirm"},
  TipsType_20153_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20154_Desc = {
    Text = [[
After resetting, the remaining quantities of "Special Items" and "Common Items" will be reset to the maximum. 
From the 3rd time onward, "Special Items" will no longer be reset. 
 <Blue:You still have "Common Items" remaining>, are you sure?]]
  },
  TipsType_20154_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20154_RightBtnDesc = {Text = "Confirm"},
  TipsType_20154_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20155_Desc = {
    Text = "The Ascension materials include a locked Wheel of Destiny. Do you confirm consuming it for Ascension?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20155_RightBtnDesc = {Text = "Confirm"},
  TipsType_20155_Title = {
    Text = "Ascension Confirm"
  },
  TipsType_20156_Desc = {
    Text = [[
Are you sure you want to use <TipsHighlightText:Reality Verge*1> to unlock?
(During the Carnal Desires event, the required Reality Verges are reduced from {s1} to {s2}.)]]
  },
  TipsType_20156_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20156_RightBtnDesc = {Text = "Confirm"},
  TipsType_20156_Title = {
    Text = "Unlock Confirmation"
  },
  TipsType_20157_Desc = {
    Text = "Are you sure you want to use <TipsHighlightText:Reality Verge*{s1}> to unlock?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20157_RightBtnDesc = {Text = "Confirm"},
  TipsType_20157_Title = {
    Text = "Unlock Confirmation"
  },
  TipsType_20158_Desc = {
    Text = "The current stage has expired. No rewards will be granted upon completion. Do you want to exit?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20158_RightBtnDesc = {Text = "Confirm"},
  TipsType_20158_Title = {
    Text = "Exit Confirmation"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:\"{s1}\"> has exceeded the limit by <TipsHighlightText: {s2} >, each converted into <Blue:\"Formless One's Invitation\" × 1>"
  },
  TipsType_20159_Title = {
    Text = "Conversion Tip"
  },
  TipsType_20160_Desc = {
    Text = [[
You have unlocked <TipsHighlightText:"{s1}">
As a free unlock bonus, you'll receive the following compensation.]]
  },
  TipsType_20160_RightBtnDesc = {Text = "Confirm"},
  TipsType_20160_Title = {
    Text = "Compensation Hint"
  },
  TipsType_20161_Desc = {
    Text = "The amount of <TipsHighlightText:{s1}> you have has overflown by <TipsHighlightText:{s2} >. Each excess item have been converted into <Blue:Rose Scrips*5000>"
  },
  TipsType_20161_Title = {
    Text = "Conversion Tip"
  },
  TipsType_20162_Desc = {
    Text = [[
Resetting the Awakener's Level, Edification, Skills, Talents, and Gnostic Advance statuses. All Materials consumed will be returned.
Confirm Development Reset for <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20162_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20162_RightBtnDesc = {Text = "Confirm"},
  TipsType_20162_Title = {
    Text = "Development Reset"
  },
  TipsType_20163_Desc = {
    Text = [[
Reset Development? 
Enlightenment will be reset and costs refunded for <WeaponEffect_Num:{s1}>. Confirm reset?]]
  },
  TipsType_20163_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20163_RightBtnDesc = {Text = "Confirm"},
  TipsType_20163_Title = {
    Text = "Enlightenment Reset"
  },
  TipsType_20164_Desc = {
    Text = [[
Resetting the Awakener's Level, Edification, Skills, Talents, Enlightenment, and Gnostic Advance statuses. This Awakener will be returned to the Dark Pool.
Confirm Genesis Return for <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20164_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20164_RightBtnDesc = {Text = "Confirm"},
  TipsType_20164_Title = {
    Text = "Genesis return"
  },
  TipsType_20165_Desc = {
    Text = [[
<WeaponEffect_Num:{s1}> is a Special Awakener. Only their Level, Edification, Skills, Talents, and Gnostic Advance statuses may be reset. Their <Red:Enlightenment status> cannot be reset. Are you sure you want to use <WeaponEffect_Num:{s1}> on this Awakener?
This operation cannot be reversed.]]
  },
  TipsType_20165_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20165_RightBtnDesc = {Text = "Confirm"},
  TipsType_20165_Title = {
    Text = "Select Reset"
  },
  TipsType_20166_Desc = {
    Text = "Enlightenment Reset is not available for Special Awakeners"
  },
  TipsType_20167_Desc = {
    Text = [[
Reset Unavailable. 
Development Reset has already been used. Please wait for the next reset cycle.]]
  },
  TipsType_20168_Desc = {
    Text = "You have already performed Enlightenment Reset during this Reset Event. Please try again next time."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:Note: This selection is permanent!>"
  },
  TipsType_20169_Desc = {
    Text = [[
Confirm Rate-Up Targets? 
Targeting: <OrangeQuality:{s1}> & <OrangeQuality:{s2}>]]
  },
  TipsType_20169_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20169_RightBtnDesc = {Text = "Confirm"},
  TipsType_20169_Title = {
    Text = "Confirm Selection"
  },
  TipsType_20170_Desc = {
    Text = "Daily challenge limit reached, please come back to challenge tomorrow!"
  },
  TipsType_20171_Desc = {
    Text = "\"Phantasmal Dive\" is unlocked!"
  },
  TipsType_20173_Desc = {
    Text = "\"Traphase\" is unlocked!"
  },
  TipsType_20174_Desc = {
    Text = "\"Investigation: Hard\" is unlocked!"
  },
  TipsType_20175_Desc = {
    Text = "\"Arcane Dominion\" is unlocked!"
  },
  TipsType_20176_Desc = {
    Text = "\"Regional D-Effect Zone\" is unlocked!"
  },
  TipsType_20177_Desc = {
    Text = "\"Reproduction Frenzy\" is unlocked!"
  },
  TipsType_20178_Desc = {
    Text = "\"Second Wheel of Destiny\" is unlocked!"
  },
  TipsType_20179_Desc = {
    Text = "\"Chaos Cluster\" is unlocked!"
  },
  TipsType_20180_Desc = {
    Text = "\"Verboten Covenant\" is unlocked!"
  },
  TipsType_20181_Desc = {
    Text = "\"Covenant Upgrade\" is unlocked!"
  },
  TipsType_20182_Desc = {
    Text = "\"Covenant Transcription\" is unlocked!"
  },
  TipsType_20183_Desc = {
    Text = "Current event has ended."
  },
  TipsType_20184_Desc = {
    Text = "\"Manual\" is unlocked!"
  },
  TipsType_20185_Desc = {
    Text = "Skip story segment?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20185_RightBtnDesc = {Text = "Confirm"},
  TipsType_20185_Title = {Text = "Skip Story"},
  TipsType_20186_Desc = {
    Text = [[
Download Game Data? 
Required files are ready. Continue? 
*(Wi-Fi recommended)*]]
  },
  TipsType_20186_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20186_RightBtnDesc = {Text = "Confirm"},
  TipsType_20187_Desc = {
    Text = "Download complete."
  },
  TipsType_20187_LeftBtnDesc = {Text = "Confirm"},
  TipsType_20188_Desc = {
    Text = [[
Low Storage Space. 
You need {s1} free to avoid data loss. Continue download?]]
  },
  TipsType_20188_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20188_RightBtnDesc = {Text = "Confirm"},
  TipsType_20189_Desc = {
    Text = "Download failed. Retry?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20189_RightBtnDesc = {Text = "Confirm"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}> overflow! <TipsHighlightText: {s2}> over the limit converted into <Blue:{s3}> each."
  },
  TipsType_20190_Title = {
    Text = "Conversion Tip"
  },
  TipsType_20191_Desc = {
    Text = "\"Event\" is now available!"
  },
  TipsType_20192_Desc = {
    Text = [[
Download Prologue Data 
Required for subsequent content. 
Size: {s1} 
*(Wi-Fi recommended)*]]
  },
  TipsType_20192_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20192_RightBtnDesc = {Text = "Download"},
  TipsType_20193_Desc = {
    Text = "\"Assignment\" is now available!"
  },
  TipsType_20194_Desc = {
    Text = "\"Communicator\" is now available!"
  },
  TipsType_20195_Desc = {
    Text = "\"Curriculum\" is now available!"
  },
  TipsType_20196_Desc = {
    Text = "\"Lightless Realm\" is now available!"
  },
  TipsType_20197_Desc = {
    Text = "Max Awakenings reached. Please claim your task rewards!"
  },
  TipsType_20198_Desc = {
    Text = "Task incomplete. Complete the objective to claim rewards."
  },
  TipsType_20199_Desc = {
    Text = [[
After claiming, the "Proxy Certificate" will exceed the possession limit,
and the excess portion will not be obtained.
Do you wish to continue?]]
  },
  TipsType_20199_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20199_RightBtnDesc = {Text = "Confirm"},
  TipsType_20199_Title = {
    Text = "Claim Confirm"
  },
  TipsType_20200_Desc = {
    Text = "Confirm using <Blue:Proxy Certificate*1> to instantly complete the Daily Quest?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20200_RightBtnDesc = {Text = "Confirm"},
  TipsType_20200_Title = {
    Text = "Proxy Confirmation"
  },
  TipsType_20201_Desc = {
    Text = "The following Covenant is currently equipped. Do you want to replace it?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20201_RightBtnDesc = {Text = "Confirm"},
  TipsType_20201_Title = {
    Text = "Replace Substats?"
  },
  TipsType_20202_Desc = {
    Text = "The current plan is active in {s1}. Delete plan {s2} anyway?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20202_RightBtnDesc = {Text = "Confirm"},
  TipsType_20202_Title = {
    Text = "Delete Confirmation"
  },
  TipsType_20203_Desc = {
    Text = "Identical Wheel of Destiny Effects cannot stack in the same team. {s1} is already equipped. Equip anyway?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20203_RightBtnDesc = {Text = "Confirm"},
  TipsType_20203_Title = {
    Text = "Equipment Confirm"
  },
  TipsType_20204_Desc = {
    Text = "The current Covenant is already in use in {s1}. Dismantling it will remove it from that setup. Proceed anyway?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20204_RightBtnDesc = {Text = "Confirm"},
  TipsType_20204_Title = {
    Text = "Delete Confirmation"
  },
  TipsType_20205_Desc = {
    Text = "The current Covenant is already in use in Lineup {s1}. Dismantling it will unequip this Covenant. Proceed anyway?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20205_RightBtnDesc = {Text = "Confirm"},
  TipsType_20205_Title = {
    Text = "Delete Confirmation"
  },
  TipsType_20206_Desc = {
    Text = "The current Wheel of Destiny is in use in Lineup {s1}. Dismantling it will remove it from the Lineup. Proceed anyway?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20206_RightBtnDesc = {Text = "Confirm"},
  TipsType_20206_Title = {
    Text = "Delete Confirmation"
  },
  TipsType_20207_Desc = {
    Text = "Unsaved changes will be lost if you exit. Leave anyway?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20207_RightBtnDesc = {Text = "Confirm"},
  TipsType_20207_Title = {
    Text = "Apply Lineup"
  },
  TipsType_20208_Desc = {
    Text = "Rewards claimed! Check out other available tasks."
  },
  TipsType_20209_Desc = {
    Text = "Task expired."
  },
  TipsType_20210_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20210_LeftBtnDesc = {Text = "Exit"},
  TipsType_20210_RightBtnDesc = {Text = "Proceed"},
  TipsType_20210_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20211_Desc = {
    Text = "Unlocking in {s1}d {s2}hrs"
  },
  TipsType_20212_Desc = {
    Text = "Unlocking in {s1}hrs {s2}min"
  },
  TipsType_20213_Desc = {
    Text = [[
<WeaponEffect_Num:{s1}> has triggered Overlimit Causality. Rewinding will invalidate this effect and remove the unit from your lineup. 
Proceed with Rewind? (This cannot be undone)]]
  },
  TipsType_20213_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20213_RightBtnDesc = {Text = "Confirm"},
  TipsType_20213_Title = {
    Text = "Reset Selection"
  },
  TipsType_20214_Desc = {
    Text = [[
Ascension Rollback? 
Reset <WeaponEffect_Num:{s1}> to refund all costs. Overlimit Causality will be disabled and the unit removed from the lineup. Confirm?]]
  },
  TipsType_20214_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20214_RightBtnDesc = {Text = "Confirm"},
  TipsType_20214_Title = {
    Text = "Stack Traceback"
  },
  TipsType_20215_Desc = {
    Text = [[
Genesis Return? 
Reset <WeaponEffect_Num:{s1}> and return it to the Black Pool. All costs will be refunded, and the unit will be removed from the lineup. Confirm?]]
  },
  TipsType_20215_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20215_RightBtnDesc = {Text = "Confirm"},
  TipsType_20215_Title = {
    Text = "Genesis return"
  },
  TipsType_20216_Desc = {
    Text = "Purchase with <Blue:{s1} × {s2}>?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20216_RightBtnDesc = {Text = "Purchase"},
  TipsType_20216_Title = {
    Text = "Confirmation"
  },
  TipsType_20217_Desc = {
    Text = "{s1} will open after {s2}."
  },
  TipsType_20218_Desc = {
    Text = "The pre-selected Awakener cannot be removed. You may only replace them with the same Awakener."
  },
  TipsType_20219_Desc = {
    Text = "Same Awakener already deployed. Cannot select again."
  },
  TipsType_20220_Desc = {
    Text = [[
No Wi-Fi Detected. 
Downloading ({s1}) will consume cellular data. Continue?]]
  },
  TipsType_20220_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20220_RightBtnDesc = {Text = "Download"},
  TipsType_20221_Desc = {
    Text = "Download complete."
  },
  TipsType_20221_LeftBtnDesc = {Text = "Confirm"},
  TipsType_20222_Desc = {
    Text = [[
Storage Almost Full. 
At least {s1} is required to avoid data loss. Continue anyway?]]
  },
  TipsType_20222_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20222_RightBtnDesc = {Text = "Confirm"},
  TipsType_20223_Desc = {
    Text = "Download failed. Retry?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20223_RightBtnDesc = {Text = "Confirm"},
  TipsType_20224_Desc = {
    Text = [[
Download Prologue Data 
Required for subsequent content. 
Size: {s1} 
*(Wi-Fi recommended)*]]
  },
  TipsType_20224_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20224_RightBtnDesc = {Text = "Download"},
  TipsType_20225_Desc = {
    Text = [[
{s1} cleared! 
Accept the extra challenge for {s2} Training Points?]]
  },
  TipsType_20225_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20225_RightBtnDesc = {Text = "Confirm"},
  TipsType_20225_Title = {
    Text = "Extra Challenge"
  },
  TipsType_20226_Desc = {
    Text = "After resetting, the Awakener, Posse, and Wheel of Destiny of the extra challenge team can all re-enter the battlefield, but the Training Points obtained for clearing this stage will also be deducted (this does not affect reward status). Are you sure you want to reset?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20226_RightBtnDesc = {Text = "Confirm"},
  TipsType_20226_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20227_Desc = {
    Text = "After resetting, the Awakener, Posse, and Wheel of Destiny of the current investigation team can be deployed again. Additionally, the extra challenge team will replace the current investigation team, but the Training Points obtained from completing this stage as an extra challenge will also be deducted (this does not affect reward status). Are you sure you want to reset?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20227_RightBtnDesc = {Text = "Confirm"},
  TipsType_20227_Title = {
    Text = "Confirm Reset"
  },
  TipsType_20228_Desc = {
    Text = "Scroll down for more announcements."
  },
  TipsType_20229_Desc = {
    Text = [[
"<Blue:{s1}>" has been Max Ascended.
Purchase anyway?
Remaining quantity: {s2}]]
  },
  TipsType_20229_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20229_RightBtnDesc = {Text = "Confirm"},
  TipsType_20229_Title = {
    Text = "Confirmation"
  },
  TipsType_20230_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20230_LeftBtnDesc = {Text = "Exit"},
  TipsType_20230_RightBtnDesc = {Text = "Proceed"},
  TipsType_20230_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20231_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20231_LeftBtnDesc = {Text = "Exit"},
  TipsType_20231_RightBtnDesc = {Text = "Proceed"},
  TipsType_20231_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20232_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20232_LeftBtnDesc = {Text = "Exit"},
  TipsType_20232_RightBtnDesc = {Text = "Proceed"},
  TipsType_20232_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20233_Desc = {
    Text = "Insufficient required materials. Would you like to consume the following materials instead?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20233_RightBtnDesc = {Text = "Confirm"},
  TipsType_20233_Title = {
    Text = "Complete Confirmation"
  },
  TipsType_20234_Desc = {
    Text = "This stage allows only the equipped Posse to be used, and cannot be replaced."
  },
  TipsType_20235_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20235_LeftBtnDesc = {Text = "Return"},
  TipsType_20235_RightBtnDesc = {Text = "Proceed"},
  TipsType_20235_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20236_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20236_LeftBtnDesc = {Text = "Return"},
  TipsType_20236_RightBtnDesc = {Text = "Proceed"},
  TipsType_20236_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20237_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20237_LeftBtnDesc = {Text = "Return"},
  TipsType_20237_RightBtnDesc = {Text = "Proceed"},
  TipsType_20237_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20238_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20238_LeftBtnDesc = {Text = "Return"},
  TipsType_20238_RightBtnDesc = {Text = "Proceed"},
  TipsType_20238_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20239_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20239_LeftBtnDesc = {Text = "Return"},
  TipsType_20239_RightBtnDesc = {Text = "Proceed"},
  TipsType_20239_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20240_Desc = {
    Text = "Reparation complete. Please restart the game."
  },
  TipsType_20240_RightBtnDesc = {Text = "Confirm"},
  TipsType_20240_Title = {Text = "Note"},
  TipsType_20241_Desc = {
    Text = [[
Needs {s1} more "<Blue:{s2}>" to fully ascend.
Would you like to continue purchasing?]]
  },
  TipsType_20241_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20241_RightBtnDesc = {Text = "Confirm"},
  TipsType_20241_Title = {
    Text = "Confirmation"
  },
  TipsType_20250_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20250_LeftBtnDesc = {Text = "Return"},
  TipsType_20250_RightBtnDesc = {Text = "Proceed"},
  TipsType_20250_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20251_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20251_LeftBtnDesc = {Text = "Return"},
  TipsType_20251_RightBtnDesc = {Text = "Proceed"},
  TipsType_20251_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20252_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_20252_LeftBtnDesc = {Text = "Return"},
  TipsType_20252_RightBtnDesc = {Text = "Proceed"},
  TipsType_20252_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20259_Desc = {
    Text = "Saved exchange settings for when the \"Thousand Faces Seal\" is insufficient"
  },
  TipsType_20300_Desc = {
    Text = "Already have {s1} Traphase Roles Awakener, unable to use the same Traphase Roles Awakener in the same team."
  },
  TipsType_20301_Desc = {
    Text = "Training Tasks"
  },
  TipsType_20351_Desc = {
    Text = [[
Insufficient {s1}. 
Exchange {s2} {s3} for {s4} {s5}?]]
  },
  TipsType_20351_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20351_RightBtnDesc = {Text = "Confirm"},
  TipsType_20351_Title = {
    Text = "Insufficient {s1}"
  },
  TipsType_20352_Desc = {
    Text = [[
Bind with this Keeper? 
Note: This action is permanent.]]
  },
  TipsType_20352_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20352_RightBtnDesc = {Text = "Confirm"},
  TipsType_20352_Title = {
    Text = "Confirm Invitation"
  },
  TipsType_20353_Desc = {
    Text = "Invitation code copied!"
  },
  TipsType_20354_Desc = {
    Text = "You have already invited this user."
  },
  TipsType_20355_Desc = {
    Text = "You cannot use your own code. Please enter a code from another Keeper."
  },
  TipsType_20356_Desc = {
    Text = [[
You can replay to experience the Prologue story and tutorial again!
However, you will not really receive the same rewards again.
Proceed anyway?]]
  },
  TipsType_20356_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20356_RightBtnDesc = {Text = "Confirm"},
  TipsType_20356_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_20357_Desc = {
    Text = "Unfollow the {s1} Keepers selected?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20357_RightBtnDesc = {Text = "Confirm"},
  TipsType_20357_Title = {Text = "Unfollow"},
  TipsType_20358_Desc = {
    Text = "There is an unconfirmed unfollow. Leave and cancel unfollow?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20358_RightBtnDesc = {Text = "Confirm"},
  TipsType_20358_Title = {
    Text = "Confirmation"
  },
  TipsType_20400_Desc = {
    Text = "Insufficient <WeaponEffect_Num:{s1}>. Exchange for more?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "Cancel"},
  TipsType_20400_RightBtnDesc = {Text = "Confirm"},
  TipsType_20400_Title = {
    Text = "Insufficient Lottery Items"
  },
  TipsType_300001_Desc = {
    Text = "\"Argent Dawnlight\" offers one free Awakening chance only. Are you sure you want to use it?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "Cancel"},
  TipsType_300001_RightBtnDesc = {Text = "Confirm"},
  TipsType_300001_Title = {
    Text = "Confirmation"
  },
  TipsType_300002_Desc = {
    Text = "Do you confirm the result of this Awakening? Once confirmed, the free Awakening chance will be consumed."
  },
  TipsType_300002_LeftBtnDesc = {Text = "Cancel"},
  TipsType_300002_RightBtnDesc = {Text = "Confirm"},
  TipsType_300002_Title = {
    Text = "Confirmation"
  },
  TipsType_30001_Desc = {
    Text = "Side tip without icon"
  },
  TipsType_30003_Desc = {
    Text = "{s1} Unlocked"
  },
  TipsType_30004_Desc = {
    Text = "{s1} Advanced Mode Unlocked"
  },
  TipsType_30005_Desc = {
    Text = "{s1} (Hard) Unlocked"
  },
  TipsType_31000_Desc = {
    Text = [[
Confirm Date of Birth? 
Once confirmed, your birthday cannot be changed.]]
  },
  TipsType_31000_LeftBtnDesc = {Text = "Cancel"},
  TipsType_31000_RightBtnDesc = {Text = "Confirm"},
  TipsType_31000_Title = {Text = "Verify Age"},
  TipsType_31001_Desc = {
    Text = [[
Monthly Limit Reached. 
You have spent <Blue:${s1}> of your <Blue:${s2}> limit. Please try a lower tier or wait until next month.]]
  },
  TipsType_31002_Desc = {
    Text = "Please complete age verification first"
  },
  TipsType_31003_Desc = {
    Text = [[
Activate Emergency Gnosis? 
Revive now? (Consumes 1 Gnosis; refills daily at 9 AM). 
Remaining: {s1} 
<Blue:(First revival is free!)>]]
  },
  TipsType_31003_LeftBtnDesc = {Text = "Cancel"},
  TipsType_31003_RightBtnDesc = {Text = "Confirm"},
  TipsType_31003_Title = {
    Text = "Revive Now?"
  },
  TipsType_31004_Desc = {
    Text = [[
Activate Emergency Gnosis? 
Revive now? (Consumes 1 Gnosis; refills daily at 9 AM). 
Remaining: {s1} 
<Blue:(First revival is free!)>]]
  },
  TipsType_31004_RightBtnDesc = {Text = "Confirm"},
  TipsType_31004_Title = {
    Text = "Revive Now?"
  },
  TipsType_40001_Desc = {
    Text = "When HP reaches 0, the investigation terminates immediately."
  },
  TipsType_40001_Title = {Text = "HP"},
  TipsType_40002_Desc = {
    Text = [[
Moving and Events generate Stress, accumulating into Mental Symptoms.
Each tile moved adds 10 Stress. Every 100 Stress causes 1 Symptom.
At 500 Stress, each movement reduces HP by 10%.]]
  },
  TipsType_40002_Title = {Text = "Stress"},
  TipsType_40003_Desc = {
    Text = "Higher Assignment levels mean greater difficulty but better rewards."
  },
  TipsType_40003_Title = {
    Text = "Assignment Level"
  },
  TipsType_40004_Desc = {
    Text = [[
The first Command Card played each turn creates a temporary copy in Ultra Space.
When full, gain 1 extra Ultra Round and keep your Shield from last turn.
Realm Mastery Effect: Has a chance to add 1 "Insight" to hand at the start of turns.]]
  },
  TipsType_40004_Title = {
    Text = "Ultra Space"
  },
  TipsType_40005_Desc = {
    Text = "Keepers gain Keeper EXP through Investigations, Interludes, and challenges. Higher Keeper Levels unlock more gameplay options."
  },
  TipsType_40005_Title = {Text = "Keeper EXP"},
  TipsType_40006_Desc = {
    Text = "Command Cards spend Arithmetica. Unused points don't carry over. Arithmerica is fully restored at each turn start."
  },
  TipsType_40006_Title = {
    Text = "Arithmetica"
  },
  TipsType_40007_Desc = {
    Text = "The Silver Key detects special energy. Something valuable may be hidden here..."
  },
  TipsType_40007_Title = {
    Text = "Hidden Resource"
  },
  TipsType_40008_Desc = {
    Text = [[
Activates during lethal crises (1 use consumed).
Restores team HP and Awakeners' Aliemus to max.
Daily refresh: 1 at 9 AM.]]
  },
  TipsType_40008_Title = {
    Text = "Emergency Gnosis"
  },
  TipsType_40009_Desc = {
    Text = [[
Command Cards consume Arithmetica. Unused points expire.
Turn start: +1 cap, restore to cap. Current turn: {s1}.]]
  },
  TipsType_40009_Title = {
    Text = "Arithmetica"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "The D-Effect Restricted Zone has been reset. Any ongoing challenge will end immediately."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_AbyssChallengeResetTips_Title = {
    Text = "Investigation in Progress"
  },
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = [[
Silver Key senses a fatal crisis. Activate Emergency Gnosis?
(Revival will consume {s1} Emergency Gnosis. You receive 1 daily at 9 AM.)]]
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Revive Now?"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "Do you accept <Blue:{s1}>'s <Blue:{s2}> invitation?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "Refuse"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "Accept"},
  TipsType_AcceptConfirm_Title = {
    Text = "Password Mode"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Complete Tasks to Awaken"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Already set as current BGM"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "\"Rose Scrip\" is insufficient to fully use the currently owned \"Gnosis Elixir\". Please replenish \"Rose Scrip\" and try again."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "Awakener is not yet available. Stay tuned!"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "Confirm using <Blue:{s1}> to obtain 1 <Blue:random> Awakener?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Use Confirmation"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Battle Creation Failed"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "All current Archives have been completed."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "Clear the following stages first for best experience"
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Exit"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Proceed Anyway"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Return"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {Text = "Proceed"},
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Return"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {Text = "Proceed"},
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Return"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {Text = "Proceed"},
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Return"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {Text = "Proceed"},
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Return"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {Text = "Proceed"},
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "Clear the following stages first for best experience"
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Exit"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Proceed Anyway"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "Clear the following stages first for best experience"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Exit"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Proceed Anyway"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "Clear the following stages first for best experience"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Exit"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Proceed Anyway"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "Unfavorited"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "Consume \"Rose Gold Voucher\" × {s1} to make a purchase?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Purchase Confirmation"
  },
  TipsType_CollectAwakerTips_Desc = {Text = "Favorited"},
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "You have added too many Favorite Supports. Please adjust the list."
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Failed to load files. Please check your storage space."
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "Confirm"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Insufficient storage space. Continue downloading?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "Cancel"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "Confirm"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = [[
Purchase with <Blue:{s1}> Silver Prime?
 <color=#ACBFCA>This is a Special Curriculum Season. Premium Topics is discounted.</color>]]
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Purchase"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Purchase Confirmation"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Please enter the <color=#5EF2FF>Password</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Select up to {s1} Awakeners to filter"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = [[
Follow the <color=#5EF2FF>{s1}</color> followers on this page? 

<color=#96947F>Currently following </color>{s2}<color=#A0A0A0>/{s3}
You will not be able to follow more than this amount of Keepers. </color>]]
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_FollowBackConfirm_Title = {
    Text = "Follow Back?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = [[
Are you sure you want to enhance "Madness Omen"?
This action will consume a large amount of resources. It is best suited for veteran Keepers who want to push their Awakener's abilities to the limit.]]
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Enhance Confirm"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = [[
Are you sure you want to enhance "Gnostic Potential"?
This action will consume a large amount of resources. It is best suited for veteran Keepers who want to push their Awakener's abilities to the limit.]]
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Enhance Confirm"
  },
  TipsType_InCharging_Desc = {
    Text = "Your order is being processed. Please do not make duplicate payments. \n\n• Payment complete? Please wait for your rewards to be delivered.\nPayment incomplete? Please restart the game and try again. \n\nIf you have any issues, please contact Customer Service."
  },
  TipsType_InCharging_RightBtnDesc = {Text = "Confirm"},
  TipsType_InCharging_Title = {Text = "Note"},
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Downloading multilingual key. Please wait a moment."
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "This Awakener is fully Enlightened.\nAfter selection, you will only receive \"Soul Rewind Shard\" ×2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "Continue"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Confirm Selection"
  },
  TipsType_MainResetBG_Desc = {
    Text = "Restore the dormitory background <Blue:Image> and <Blue:Music> to default?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "Cancel"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "Confirm"},
  TipsType_MainResetBG_Title = {
    Text = "Restore Default"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Guaranteed item. Cannot change."
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Please complete the selection of all self-selected items before proceeding to purchase"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "Opponent canceled matching"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "The opponent refused the <Blue:{s1}> invitation, please reselect a mode."
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = [[
The battle round limit has been reached

O sole Keeper
What choice will you make now?]]
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "Retry Battle"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Temporary Retreat"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Investigation Failed"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Error retrieving battle replay, please try again later"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = [[
The Replay has reached the maximum limit of 25 turns.
Replay ends.]]
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "Confirm"},
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "Confirmation"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "No Investigation Records"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Loading battle replay, please do not repeat operations"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "Special lineup battle replay is not supported at the moment."
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Getting battle replay timed out"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "No operations can be performed during battle replay"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {Text = "Copied"},
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "No <color=#5EF2FF>Investigation</color> Liineup found in clipboard"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = [[
Apply the lineup in the lineup code?
The items not held will be left empty.]]
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Apply Lineup"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "This team contains a preset Awakener. The lineup code cannot be copied or imported"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "The match has reached the round limit. The first player failed to End the match and is declared the loser."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "Confirm"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {Text = "Match End"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "The match has reached the round limit. The second player successfully held out until the End and is declared the winner."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "Confirm"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {Text = "Match End"},
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "Do you surrender?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Surrender Confirmation"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "No <color=#5EF2FF>Traphase</color> Liineup found in clipboard"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "Do you need to block this Keeper?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "Refuse"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "Accept"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {Text = "Block?"},
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "This Password Mode has already started."
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "A new keeper has entered this turn of the cryptographic battle"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "Currently in queue..."
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "Do you want to exit the password battle?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Exit"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Exit Confirmation"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "The opponent refused to fight you"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "Basic Active Ion:\nDuring this Curriculum Season, Basic Active Ions Rewards (Reality Verges, Pure Cores, Silvers, EXP) are tripled. After purchasing Premium Topics, the 3× bonus rewards from prevous days are granted retroactively."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = [[
Time Reversal:
Return to any of the last 25 turns during battle. This feature remains usable even after retrying the challenge.]]
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = [[
Traphase:
During this Curriculum Season, all cards are unlocked in Traphase (including ones not obtained.)]]
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "<color=#5EF2FF>Password</color> has been copied to clipboard"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "Spend <Blue:\"Silver Prime\" × {s1} >to purchase?\n\n<size=30><color=#ACBFCA>When spending \"Silver Prime\", gifted \"Silver Prime\" will be deducted first.\n(Extracted: {s2}, Gifted: {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "Cancel"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Purchase"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Purchase Confirmation"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "Comment content cannot be empty."
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "Do you want to delete this comment?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Delete Confirmation"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "Hide all comments from this Keeper?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "No"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "Yes"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "Hidden"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Network anomaly detected. Matchmaking interrupted."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = [[
You are still in combat. Continue the previous battle? 
 The "Express of Joy" season has been updated. Continuing the challenge allows you to complete the latest season missions, but you will not be able to enter the "VIP Registry".]]
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {
    Text = "Investigation in Progress"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "Your last challenge progress was {s1} - Stage {s2} - Battle {s3}, with \"VIP Points\" × {s4} earned.\nThe season has been updated. Continuing the challenge allows you to complete the latest season missions, but you will not be able to enter the \"VIP Registry\". Do you wish to continue the challenge?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "Continue Challenge"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = [[
Resume Progress: {s1} - Phase {s2} - Battle {s3}.
VIP Points earned: {s4}.
Continue challenge?]]
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "Cancel"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "Confirm"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Continue Challenge"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "You need to finish the previous saved challenge before starting a new one"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = [[
Exit challenge?
Progress will be saved. Resuming will restart the current battle.]]
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Save and Exit"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = [[
Exit now?
The current progress will be saved, and you can choose to continue from here next time.]]
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Save and Exit"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "The season has been updated. Continuing the challenge allows you to complete the latest season missions, but you will not be able to enter the \"VIP Registry\"."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "Replay information cannot be empty"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Realm Conflict. Please readjust lineup."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Exceeded the selected quantity"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "The ranking data has not finished loading yet. Please reopen the page later."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "Confirm"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "Server Ranking Data Initializing"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "<Blue:{s1}> {s2} will be used to exchange for <Blue:{s3}> {s4}. Confirm the redemption?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Redemption Confirmation"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "Battle records are hidden"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Please enable \"Enable the Steam overlay while in-game\" in Steam \"Settings - In-Game\" and in the game's \"Properties - General\", then restart the game and try again."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "Confirm"},
  TipsType_SteamOverlayEnabledTips_Title = {Text = "Note"},
  TipsType_SteamRestartTips_Desc = {
    Text = "Steam authorization error. Please restart the Steam client and try again."
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_SteamRestartTips_Title = {
    Text = "Login Error"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "Clear the following stages first for best experience"
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Exit"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {Text = "Proceed"},
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "We recommend clearing the following stages first:"
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Return"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {Text = "Proceed"},
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "Clear the following stages first for best experience"
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Exit"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Proceed Anyway"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Continue Investigation?"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "Awakening material costs has changed, please try Reawaken"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "You're missing {s1} <Blue:\"{s2}\">. Consume <Blue:{s4} × {s3} > instead?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Redemption Confirmation"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:Note: Once selected, your choice cannot be changed for the current event!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "Confirm selecting Awakener <OrangeQuality:{s1}, {s2}, {s3}, {s4}>?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Confirm Selection"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:Note: Once selected, your choice cannot be changed for the current event!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Selection limit reached"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Please complete all types of selections before trying again"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = [[
Confirm completing the designated Awakener selection?
Once confirmed, this period's selection cannot be changed again.]]
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Confirm Selection"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "This is the latest list. Follow more Keepers for more Supports!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Auto-Transcription in progress, operation unavailable."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(Auto-Transcription stops when an unlocked stat reaches 8.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = [[
Transcribe up to {s1} times
Consume up to]]
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Auto-Transcription Confirmation"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "Covenant storage is full"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "Unbind all Covenants?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Unbind Confirmation"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "There are bound Covenants. You cannot save this as a plan yet."
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "Confirm binding the following Covenant? Any Covenant equipped by another Awakener or present in a formation/preset/support will be automatically unequipped."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_TrinketBindTips_Title = {
    Text = "Bind Confirmation"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "Confirm modifying the binding?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Modify Binding Confirmation"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = [[
Unbind all Covenant sets?

<color=#9BA3A2><size=30>+12 Covenant pieces will be consumed.</size></color>]]
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Unbind Confirmation"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = [[
Confirm change?

<color=#9BA3A2><size=30>+12 Covenant pieces will be consumed.</size></color>]]
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Modify Binding Confirmation"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = [[
Unbind this Covenant set?

<color=#9BA3A2><size=30>+12 Covenant pieces will be consumed.</size></color>]]
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Unbind Confirmation"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "Confirm unbinding this Covenant?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "Cancel"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "Confirm"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "Unbind Confirmation"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "The <color=#5EF2FF>Password</color> is currently in use, please try again later"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = [[
Waiting for
{s1}
to accept <Blue:{s2}> invitation...]]
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "Cancel"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Password Mode"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = [[
Waiting for other Keepers to enter
<Blue:{s1}>
Matching Password Battle]]
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "Cancel"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "Copy <color=#5EF2FF>Password</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Password Mode"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "Confirm using <Blue:{s1}> to obtain 1 <Blue:random> Wheel of Destiny?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "Cancel"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "Confirm"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Use Confirmation"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "The number of rewards obtained this week has been exhausted, unable to reenact."
  }
})
return Text_TipsType
