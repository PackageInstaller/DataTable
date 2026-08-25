__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Lottery = readonly({
  Lottery_116466_DrawBtnText = {
    Text = "Plea for Grace"
  },
  Lottery_116466_DrawTitle = {
    Text = "Rite of Benediction"
  },
  Lottery_116466_Name = {
    Text = "Ablution of Flesh"
  },
  Lottery_116466_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each exchange will consume 750 "Audience Oblation"/"Contrite Oblation"/"Devoted Oblation" and randomly grant five item rewards.
2. The item rewards for each ritual are divided into "special items" and "common items." During the reset, you can reset the remaining quantity of specified item rewards to their limits, with the specific rules as follows:
(1) For the first two resets: When there are no remaining "special items," the Keeper can choose to reset, which will reset the remaining quantities of both "special items" and "common items" to their limits; alternatively, the Keeper can choose to continue exchanging, but when there are also no remaining "common items," a reset must be performed to continue exchanging.
(2) Starting from the third reset: A reset can only be performed when there are no remaining "common items." The reset will reset the remaining quantity of "common items" to their limits, and "special items" will no longer be reset.]]
  },
  Lottery_116467_Name = {
    Text = "Contrition of Soul"
  },
  Lottery_116468_Name = {
    Text = "Exaction of Sins"
  },
  Lottery_125044_DrawBtnText = {Text = "Offer"},
  Lottery_125044_DrawTitle = {
    Text = "Desolate Offering"
  },
  Lottery_125044_Name = {
    Text = "Carved Offering Table"
  },
  Lottery_125044_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each "Offering" will consume 750 "Pear Syrup Candy" and randomly grant five item rewards from "Desolate Offering".
2. The item rewards from "Desolate Offering" are divided into two types: "Special Items" and "Common Items". When resetting, the remaining quantity of special item rewards can be reset to the maximum limit. The specific rules are as follows:
(1) For the first 5 resets: When there are no remaining "Special Items", the Keeper can choose to reset. After resetting, the remaining quantities of both "Special Items" and "Common Items" will be reset to the maximum limit; alternatively, the Keeper can choose to continue exchanging. When there are no remaining "Common Items", a reset must be performed to continue exchanging.
(2) Starting from the 6th reset: A reset can only be performed when there are no remaining "Common Items", which will reset the remaining quantity of "Common Items" to the maximum limit, and "Special Items" will no longer be reset.]]
  },
  Lottery_126065_DrawBtnText = {
    Text = "Suggested Translation"
  },
  Lottery_126065_DrawTitle = {
    Text = "Suggested Translation"
  },
  Lottery_126065_Name = {
    Text = "Suggested Translation"
  },
  Lottery_126065_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each "Suggested Translation" will consume 750 "Suggested Translation" and randomly grant five item rewards from "Suggested Translation."
2. The item rewards from "Suggested Translation" are divided into two types: "Special Items" and "Common Items." Resetting can restore the remaining quantity of Special Item rewards to the limit. The specific rules are as follows:
(1) First 5 Resets: When "Special Items" have no remaining quantity, Keepers may choose to reset, which will restore the remaining quantities of both "Special Items" and "Common Items" to their limits; or they may choose to continue exchanging. When "Common Items" also have no remaining quantity, a reset must be performed to continue exchanging.
(2) 6th Reset and Beyond: A reset can only be performed when "Common Items" have no remaining quantity. The reset will restore the remaining quantity of "Common Items" to the limit, and "Special Items" will no longer reset.]]
  },
  Lottery_129914_Name = {
    Text = "Suggested Translation"
  },
  Lottery_129915_DrawBtnText = {
    Text = "Suggested Translation"
  },
  Lottery_129915_DrawTitle = {
    Text = "Suggested Translation"
  },
  Lottery_129915_Name = {
    Text = "Suggested Translation"
  },
  Lottery_129915_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each exchange will consume 750 "Temporary Text"/"Temporary Text"/"Temporary Text" and randomly grant five item rewards from the temporary text.
2. The item rewards for each temporary text are divided into "Special Items" and "Common Items." During a reset, the remaining quantity of specified item rewards can be reset to their limits, with specific rules as follows:
(1) For the first 2 resets: When there are no remaining "Special Items," the Keeper can choose to reset. After resetting, the remaining quantities of "Special Items" and "Common Items" will be reset to their limits; alternatively, the Keeper can choose to continue exchanging. When there are also no remaining "Common Items," a reset must be performed to continue exchanging.
(2) Starting from the 3rd reset: A reset can only be performed when there are no remaining "Common Items." The reset will reset the remaining quantity of "Common Items" to their limits, and "Special Items" will no longer reset.]]
  },
  Lottery_129916_Name = {
    Text = "Suggested Translation"
  },
  Lottery_130578_Name = {
    Text = "Treasure Two"
  },
  Lottery_130579_DrawBtnText = {
    Text = "Turn In Conches"
  },
  Lottery_130579_DrawTitle = {
    Text = "Vortice's Hoard"
  },
  Lottery_130579_Name = {
    Text = "Treasure One"
  },
  Lottery_130579_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each exchange will consume 750 "Conch One" / "Conch Two" / "Conch Three" to randomly obtain five item rewards from "Vortice's Hoard."
2. The item rewards in each "Vortice's Hoard" are divided into two types: "Special Items" and "Common Items." During a reset, the remaining quantity of specified item rewards can be reset to the limit. The specific rules are as follows:
(1) First 2 Resets: When "Special Items" have no remaining quantity, Keepers may choose to reset, which will restore the remaining quantities of both "Special Items" and "Common Items" to their limits. Keepers may also choose to continue exchanging. Once "Common Items" also have no remaining quantity, a reset must be performed to continue exchanging.
(2) Starting from the 3rd Reset: A reset can only be performed when "Common Items" have no remaining quantity. The reset will restore the remaining quantity of "Common Items" to the limit, while "Special Items" will no longer be reset.]]
  },
  Lottery_130580_Name = {
    Text = "Treasure Three"
  },
  Lottery_44279_DrawBtnText = {
    Text = "Exchange Goods"
  },
  Lottery_44279_DrawTitle = {
    Text = "Church Charity Bazaar"
  },
  Lottery_44279_Name = {
    Text = "Mrs. Gray's Shop"
  },
  Lottery_44279_RuleContent = {
    Text = [[
<Title:Introduction>
Welcome all Keepers to the "Church Charity Sale"! Here, you can use "Charity Coupons" to exchange for goods in the shops. Limited SR Wheel of Destiny "Man in the Mirror", Luminous Core, and Pure Core and other items await your exchange!

<Title:Shops>
1. The Church Charity Sale features three shops with the following opening times:
Shop "Mrs. Gray's Little Shop": Opens initially.
Shop "John's Magical Charity": Opens on the 4th day of the event.
Shop "Smith's Bargains": Opens on the 7th day of the event.
2. Different shops offer different items, and Keepers can choose items according to their needs for exchange.
3. Each shop contains special and ordinary items. Each exchange will consume 600 "Charity Coupons", randomly granting five items from the shop.

<Title:Restocking>
1. When all special items in a shop have been exchanged, the Keeper can request the shop to restock or choose to continue exchanging. When all items in the shop have been exchanged, the Keeper must choose to restock before continuing to exchange.
2. For the first two restocks in each shop, the remaining quantities of all items will be replenished to the maximum limit. Starting from the third restock, special items will no longer be replenished, only ordinary items will be restocked. After restocking, the remaining quantities of previously unexchanged items will not be retained. Therefore, Keepers should carefully consider before choosing to restock!

]]
  },
  Lottery_44280_Name = {
    Text = "Smith's Special Sale"
  },
  Lottery_44281_Name = {
    Text = "Big John's Magical Bazaar"
  },
  Lottery_48730_DrawBtnText = {
    Text = "Exchange Seed Core"
  },
  Lottery_48730_DrawTitle = {
    Text = "Spawn of Lust"
  },
  Lottery_48730_Name = {
    Text = "Spawn of Lust"
  },
  Lottery_48730_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each time you "Exchange Seed Core," it will consume 750 "Seed of Abundance" and randomly grant five item rewards from "Spawn of Lust."
3. The item rewards from "Spawn of Lust" are divided into two types: "Special Items" and "Common Items." When reset, the remaining quantity of special item rewards can be reset to the limit, with the following specific rules:
(1) For the first 4 resets: When there are no remaining quantities of "Special Items," the Keeper can choose to reset. After the reset, the remaining quantities of both "Special Items" and "Common Items" will be reset to the limit; or they can choose to continue exchanging. When there are no remaining quantities of "Common Items," a reset must be performed to continue exchanging.
(2) For the 5th reset and thereafter: A reset can only be performed when there are no remaining quantities of "Common Items," and the reset will reset the remaining quantity of "Common Items" to the limit, while "Special Items" will no longer be reset.]]
  },
  Lottery_52046_Name = {
    Text = "Altar of Souls"
  },
  Lottery_52047_Name = {
    Text = "Altar of Blood"
  },
  Lottery_52048_DrawBtnText = {
    Text = "Offer Sacrifice"
  },
  Lottery_52048_DrawTitle = {
    Text = "The Abyss Responds"
  },
  Lottery_52048_Name = {
    Text = "Altar of Tears"
  },
  Lottery_52048_RuleContent = {
    Text = [[
<Title:Introduction>
1. "The Abyss Responds" has three altars with the following opening times:
"Altar of Tears": June 17, 9:00 AM ~ July 8, 9:00 AM.
"Altar of Blood": June 19, 9:00 AM ~ July 8, 9:00 AM.
"Altar of Souls": June 21, 9:00 AM ~ July 8, 9:00 AM.
2. Each offering consumes 500 "Sacrificial Tears"/"Sacrificial Blood"/"Sacrificial Marrow", granting five random item rewards from the altar.
3. The item rewards from each altar are divided into "Gifts of the Divine Realm" and "Mundane Rewards". During resets, the remaining quantity of specified item rewards can be reset to the maximum limit according to the following rules:
(1) For the first two resets: When "Gifts of the Divine Realm" have no remaining quantity, Keepers may choose to reset. After resetting, both "Gifts of the Divine Realm" and "Mundane Rewards" will have their remaining quantities reset to the maximum limit. Alternatively, Keepers may continue offering, but when "Mundane Rewards" also have no remaining quantity, a reset is required to continue offering.
(2) Starting from the third reset: Resetting is only possible when "Mundane Rewards" have no remaining quantity. Resetting will reset the remaining quantity of "Mundane Rewards" to the maximum limit, while "Gifts of the Divine Realm" will no longer be reset.]]
  },
  Lottery_55169_DrawBtnText = {
    Text = "Poetry Exchange"
  },
  Lottery_55169_DrawTitle = {
    Text = "Colette's Flower House"
  },
  Lottery_55169_Name = {
    Text = "Iris Garden"
  },
  Lottery_55169_RuleContent = {
    Text = [[
<Title:Introduction>
1. "Colette's Flower House" has three gardens, and their opening times are as follows:
"Iris Garden": Opens at 9:00 AM on August 25.
"Bellflower Garden": Opens at 9:00 AM on August 27.
"Rose Garden": Opens at 9:00 AM on August 29.
2. Each exchange will consume 750 "Poems of Sorrow"/"Poems of Regret"/"Poems of Joy," granting five random items from the garden.
3. The item rewards in each garden are divided into "Special Items" and "Common Items." When resetting, the remaining quantity of special item rewards can be reset to the maximum limit. The specific rules are as follows:
(1) For the first two resets: When there are no remaining "Special Items," you can choose to reset, which will restore both "Special Items" and "Common Items" to their maximum limits. Alternatively, you can continue exchanging. If there are no remaining "Common Items," you must perform a reset to continue exchanging.
(2) From the third reset onward: You can only reset when there are no remaining "Common Items." Resetting will restore the remaining quantity of "Common Items" to the maximum limit, while "Special Items" will no longer reset.
4. After 9:00 AM on September 15 (GMT+8), any remaining "Poems of Sorrow"/"Poems of Regret"/"Poems of Joy" that have not been exchanged will be converted at the rate of "Rose Scrip*40" each. Please check your mail and claim them in time.]]
  },
  Lottery_55170_Name = {
    Text = "Bellflower Garden"
  },
  Lottery_55171_Name = {
    Text = "Rose Garden"
  },
  Lottery_58139_Name = {
    Text = "Smith's Special Sale"
  },
  Lottery_58140_Name = {
    Text = "Big John's Magical Bazaar"
  },
  Lottery_58141_DrawBtnText = {
    Text = "Exchange Goods"
  },
  Lottery_58141_DrawTitle = {
    Text = "Church Charity Bazaar"
  },
  Lottery_58141_Name = {
    Text = "Mrs. Gray's Shop"
  },
  Lottery_58141_RuleContent = {
    Text = [[
<Title:Introduction>
1. The "Church Charity Sale" consists of three shops, with the opening times as follows:
"Mrs. Gray's Little Shop": Opens March 24 at 9:00.
"Big John's Miraculous Sale": Opens March 27 at 9:00.
"Smith's Special Sale": Opens March 30 at 9:00.
2. Each exchange will consume 750 "Charity Coupons" to randomly obtain five item rewards from the shop.
3. The items in each shop are divided into "Special Items" and "Regular Items." Resetting allows the remaining quantity of special item rewards to be restored to the maximum. Specific rules are as follows:
(1) First 2 resets: After the "Special Items" have no remaining quantity, the Keeper can choose to reset. After resetting, the remaining quantity of "Special Items" and "Regular Items" will be restored to the maximum, or they can choose to continue exchanging. Once the "Regular Items" also have no remaining quantity, a reset is required to continue exchanging.
(2) From the 3rd reset onwards: A reset can only be performed after "Regular Items" have no remaining quantity. Resetting will restore the remaining quantity of "Regular Items" to the maximum, while "Special Items" will not be reset.]]
  },
  Lottery_58889_DrawBtnText = {
    Text = "Offer Sacrifice"
  },
  Lottery_58889_DrawTitle = {
    Text = "The Abyss Responds"
  },
  Lottery_58889_Name = {
    Text = "Altar of Tears"
  },
  Lottery_58889_RuleContent = {
    Text = [[
<Title:Introduction>
1. "The Abyss Responds" has three altars with the following opening times:
"Altar of Tears": Opens at March 9, 9:00 am.
"Altar of Blood": Opens at March 11, 9:00 am.
"Altar of Souls": Opens at March 13, 9:00 am.
2. Each offering consumes 750 "Sacrificial Tears"/"Sacrificial Blood"/"Sacrificial Marrow", granting five random item rewards from the altar.
3. The item rewards from each altar are divided into "Gifts of the Divine Realm" and "Mundane Rewards". During resets, the remaining quantity of specified item rewards can be reset to the maximum limit according to the following rules:
(1) For the first 3 resets: When "Gifts of the Divine Realm" have no remaining quantity, Keepers may choose to reset. After resetting, both "Gifts of the Divine Realm" and "Mundane Rewards" will have their remaining quantities reset to the maximum limit. Alternatively, Keepers may continue offering, but when "Mundane Rewards" also have no remaining quantity, a reset is required to continue offering.
(2) Starting from the 4th reset: Resetting is only possible when "Mundane Rewards" have no remaining quantity. Resetting will reset the remaining quantity of "Mundane Rewards" to the maximum limit, while "Gifts of the Divine Realm" will no longer be reset.]]
  },
  Lottery_58890_Name = {
    Text = "Altar of Souls"
  },
  Lottery_58891_Name = {
    Text = "Altar of Blood"
  },
  Lottery_62136_DrawBtnText = {
    Text = "Bud Exchange"
  },
  Lottery_62136_DrawTitle = {
    Text = "Mountain Maw"
  },
  Lottery_62136_Name = {
    Text = "Insatiable Ambition"
  },
  Lottery_62136_RuleContent = {
    Text = [[
<Title:Introduction>
1. "Mountain Maw" includes three exchange shops, with opening times as follows:
"Devouring Ambition": Opens on May 19 at 9:00.
"Vengeous Spirit": Opens on May 21 at 9:00.
"Resurrection Hope": Opens on May 23 at 9:00.
2. Each exchange consumes 750 "Frozen Buds"/"Silver Frost Buds"/"Sunlight Buds" and randomly rewards five items from the exchange shop.
3. The items in each exchange shop are divided into "Special Items" and "Regular Items". Resetting will restore the remaining quantity of "Special Items" to its limit. Specific rules are as follows:
(1) For the first two resets: When "Special Items" have no remaining quantity, the Keeper can choose to reset, which restores the remaining quantities of both "Special Items" and "Regular Items" to their limits; or continue exchanges. If "Regular Items" also have no remaining quantity, a reset is required to continue exchanges.
(2) Starting from the third reset: A reset can only occur when "Regular Items" have no remaining quantity. The reset restores the remaining quantity of "Regular Items" to the limit, while "Special Items" are no longer reset.
4. After 9:00 on June 9 (GMT+8), any remaining "Buds" that have not been exchanged will be collected at a ratio of 40 "Rose Scrip Coupons" each. Keepers, please check your mail.]]
  },
  Lottery_62137_Name = {
    Text = "Fury of Vengeance"
  },
  Lottery_62138_Name = {
    Text = "Resurrection hope"
  },
  Lottery_71333_DrawBtnText = {
    Text = "Exchange Parts"
  },
  Lottery_71333_DrawTitle = {
    Text = "Mentor's Teachings"
  },
  Lottery_71333_Name = {
    Text = "Mentor's Teachings"
  },
  Lottery_71333_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each "Exchange Parts" will consume 750 "Puppet Parts," randomly obtaining five item rewards from "Mentor's Teachings."
2. The item rewards from "Mentor's Teachings" are divided into "Special Items" and "Common Items" categories. Resetting allows the remaining quantity of special item rewards to reset to the limit. The specific rules are as follows:
(1) For the first 5 resets: After the remaining quantity of "Special Items" is depleted, Keepers can choose to reset, which restores the remaining quantity of both "Special Items" and "Common Items" to their limits. Alternatively, they can continue exchanging. If the remaining quantity of "Common Items" is also depleted, a reset is required to continue exchanging.
(2) From the 6th reset onward: Resetting is only possible when the remaining quantity of "Common Items" is depleted. Resetting restores the remaining quantity of "Common Items" to the limit, while "Special Items" will no longer reset.]]
  },
  Lottery_76317_Name = {
    Text = "Treasured Curiosities"
  },
  Lottery_76318_Name = {
    Text = "Glorious Secrets"
  },
  Lottery_76319_DrawBtnText = {
    Text = "Exchange Items"
  },
  Lottery_76319_DrawTitle = {
    Text = "Witch's Vault"
  },
  Lottery_76319_Name = {
    Text = "Worry-Free Treasures"
  },
  Lottery_76319_RuleContent = {
    Text = [[
<Title:Introduction>
1. There're 3 "Witch's Vault", with the following opening times: 
 "Worry-Free Treasures": January 12th 9:00 - February 2nd 9:00. 
 "Glorious Secrets": January 14th 9:00 - February 2nd 9:00. 
 "Treasured Curiosities": January 16th 9:00 - February 2nd 9:00. 
2. Each exchange consumes 750 "Pale Beast Skulls"/"Shadowy Beast Skulls"/"Crimson Beast Skulls" to randomly obtain five item rewards from the treasury. 
3. Rewards in each treasury are divided into two types: "Special Items" and "Common Items." Resetting replenishes the stock of special items to their maximum. The specific rules are as follows: 
(1) First 2 Resets: Once "Special Items" are depleted, the Keeper can reset to fully replenish both "Special Items" and "Common Items"; Keeper can also continue exchanging untill the "Common Items" are also depleted, then reset to continue exchanging.
(2) 3rd Reset Onwards: Keeper can only reset after "Common Items" are depleted. Resetting replenishes only "Common Items"; "Special Items" are no longer replenished.]]
  },
  Lottery_79567_DrawBtnText = {
    Text = "Submit Report"
  },
  Lottery_79567_DrawTitle = {
    Text = "Neurotherapy room"
  },
  Lottery_79567_Name = {
    Text = "Neurotherapy Room"
  },
  Lottery_79567_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each "Submit a Report" consumes 1000 "Diagnostic Reports" to randomly obtain five item rewards from the "Neuro Treatment Room."
2. Rewards in "Neuro Treatment Room" are categorized as "Special Items" and "Common Items." Resetting replenishes the stock of special items to their maximum. The specific rules are as follows:
(1) First 5 Resets: Once "Special Items" are depleted, the Keeper can reset to fully replenish both "Special Items" and "Common Items"; Keeper can also continue exchanging untill the "Common Items" are also depleted, then reset to continue exchanging.
(2)6th Reset Onwards: Keeper can only reset after "Common Items" are depleted. Resetting replenishes only "Common Items"; "Special Items" are no longer replenished.]]
  },
  Lottery_81263_DrawBtnText = {
    Text = "Deliver Flags"
  },
  Lottery_81263_DrawTitle = {
    Text = "Crewmates' Treasures"
  },
  Lottery_81263_Name = {
    Text = "Crewmates' Treasures"
  },
  Lottery_81263_RuleContent = {
    Text = [[
<Title:Overview>
1. Each "Flag Delivery" will consume 750 "Signal Flags, " and you will randomly receive five item rewards from "Crewmates' Treasures."
2. The item rewards in "Crewmates' Treasures" are divided into two types: "Special Items" and "Common Items." When resetting, the remaining quantity of special items can be reset to the maximum limit. The specific rules are as follows:
(1) For the first 5 resets: When there are no remaining "Special Items, " the Keeper can choose to reset, which will reset both the remaining quantities of "Special Items" and "Common Items" to their maximum limits. Alternatively, they can choose to continue exchanging; if there are no remaining "Common Items, " a reset is required to continue exchanging.
(2) For the 6th and subsequent resets: A reset can only be performed when there are no remaining "Common Items." The reset will reset the remaining quantity of "Common Items" to the maximum limit, but "Special Items" will not be reset.]]
  },
  Lottery_95604_DrawBtnText = {
    Text = "Request Dishes"
  },
  Lottery_95604_DrawTitle = {
    Text = "Ossuary Banquet"
  },
  Lottery_95604_Name = {
    Text = "Ossuary Banquet"
  },
  Lottery_95604_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each "Request Dishes" consumes 750  "Rotten Phalanges" and randomly grants one of five item rewards from the "Ossuary Banquet".
2. The item rewards from the "Ossuary Banquet" are divided into two types: "Special Items" and "Common Items". When resetting, the remaining quantity of special item rewards can be reset to the upper limit. Specific rules are as follows:
(1) First 5 resets: When there are no "Special Items" remaining, the Keeper may choose to reset, which will refill both "Special Items" and "Common Items" to their maximum quantities; alternatively, they may continue exchanging. When there are also no "Common Items" remaining, a reset is required to continue exchanging.
(2) From the 6th reset onward: Resetting can only occur when there are no "Common Items" remaining. A reset will refill the remaining quantity of "Common Items" to its upper limit, but "Special Items" will no longer be refilled.]]
  },
  Lottery_96822_DrawBtnText = {
    Text = "Purchase Tools"
  },
  Lottery_96822_DrawTitle = {
    Text = "Pickman's Studio"
  },
  Lottery_96822_Name = {
    Text = "Studio of Truth"
  },
  Lottery_96822_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each exchange consumes 750 "Paint of Truth"/"Paint of Dreams"/"Paint of Madness" to randomly obtain five item rewards from the studio.
2. Rewards in each studio are divided into two categories: "Special Items" and "Common Items."esetting replenishes the stock of special items to their maximum. The specific rules as follows:
(1) First 2 Resets: Once "Special Items" are depleted, the Keeper can reset to fully replenish both "Special Items" and "Common Items"; Keeper can also continue exchanging untill the "Common Items" are also depleted, then reset to continue exchanging.
(2) 3rd Reset Onwards: Keeper can only reset after "Common Items" are depleted. Resetting replenishes only "Common Items"; "Special Items" are no longer replenished.]]
  },
  Lottery_96823_Name = {
    Text = "Studio of Illusions"
  },
  Lottery_96824_Name = {
    Text = "Studio of Madness"
  },
  Lottery_97424_Name = {
    Text = "Dream of Godbirth"
  },
  Lottery_97425_Name = {
    Text = "Nightmare of Despair"
  },
  Lottery_97426_DrawBtnText = {
    Text = "Offer Incense"
  },
  Lottery_97426_DrawTitle = {
    Text = "Holy Bedchamber"
  },
  Lottery_97426_Name = {
    Text = "Dream of Delight"
  },
  Lottery_97426_RuleContent = {
    Text = [[
<Title:Introduction>
1. Each offering will consume 750 "Soothing Incense"/"Calming Incense"/"Dreamy Incense", randomly granting five item rewards from the Holy Bedchamber. 
2. The item rewards in each sleeping quarter are divided into two types: "Special Items" and "Common Items". During a reset, the remaining quantity of specified item rewards can be reset to the maximum limit, with the specific rules as follows: 
(1) For the first two resets: When there are no remaining "Special Items", the Keeper can choose to reset, which will reset the remaining quantities of both "Special Items" and "Common Items" to their maximum limits; alternatively, the Keeper can choose to continue offering, but when there are also no remaining "Common Items", a reset must be performed to continue offering. 
(2) Starting from the third reset: A reset can only be performed when there are no remaining "Common Items", which will reset the remaining quantities of "Common Items" to their maximum limit, and "Special Items" will no longer be reset.]]
  }
})
return Text_Lottery
