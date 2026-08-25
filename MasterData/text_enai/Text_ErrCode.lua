__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ErrCode = readonly({
  ErrCode_CMD_UNDEFINED_Desc = {
    Text = "Command does not exist"
  },
  ErrCode_ERR_ACTIVITY_FINISH_Desc = {
    Text = "The event has ended."
  },
  ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc = {
    Text = "Insufficient login days, unable to claim rewards"
  },
  ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc = {
    Text = "Conditions for participating in the event not met"
  },
  ErrCode_ERR_ACTIVITY_NOT_FIND_Desc = {
    Text = "This event does not exist"
  },
  ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc = {
    Text = "This event is under development"
  },
  ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc = {
    Text = "This event has not started yet"
  },
  ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc = {
    Text = "Event mission not completed"
  },
  ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc = {
    Text = "Demo event: rewards cannot be claimed for incomplete stages"
  },
  ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc = {
    Text = "Trial event: this level was not found"
  },
  ErrCode_ERR_ASSISTED_ONCE_Desc = {
    Text = "This Keeper has already provided support assistance once for this event"
  },
  ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc = {
    Text = "This event requires mutually followed Keepers to provide battle support"
  },
  ErrCode_ERR_ASSIST_STAR_LIMIT_Desc = {
    Text = "You have added too many Favorite Supports. Please adjust the list."
  },
  ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc = {
    Text = "Skill upgrade conditions not met"
  },
  ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc = {
    Text = "Insufficient Level"
  },
  ErrCode_ERR_AWAKER_START_DROP_DATE_Desc = {
    Text = "The Awakener is not yet available"
  },
  ErrCode_ERR_AWAKER_USED_Desc = {
    Text = "Awakener has already been used"
  },
  ErrCode_ERR_AlREADY_BAN_Desc = {
    Text = "Cannot be blocked again"
  },
  ErrCode_ERR_BANNED_Desc = {
    Text = "You have been blacklisted by this player and cannot operate"
  },
  ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc = {
    Text = "You are blacklisted by this user and cannot follow or like them"
  },
  ErrCode_ERR_BAN_FOLLOW_LIKE_Desc = {
    Text = "You've blacklisted this user and cannot like or follow them"
  },
  ErrCode_ERR_BAN_NUM_LIMIT_Desc = {
    Text = "Blacklist limit reached"
  },
  ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc = {
    Text = "Insufficient currency to purchase Pass level"
  },
  ErrCode_ERR_BP_FAIL_Desc = {
    Text = "Operation failed"
  },
  ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc = {
    Text = "Pass purchase privilege price not configured"
  },
  ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc = {
    Text = "The Pass privilege level is maxed out, unable to purchase again"
  },
  ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc = {
    Text = "Insufficient privilege level to claim the reward"
  },
  ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc = {
    Text = "Reward does not exist"
  },
  ErrCode_ERR_BP_REWARD_RECEIVED_Desc = {
    Text = "Reward Claimed"
  },
  ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc = {
    Text = "Insufficient Silver Prime"
  },
  ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc = {
    Text = "Insufficient voucher purchase attempts"
  },
  ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc = {
    Text = "Relics do not support enhancement"
  },
  ErrCode_ERR_CARD_MAX_LEVEL_Desc = {
    Text = "This card has reached the maximum level and cannot be strengthened"
  },
  ErrCode_ERR_CARD_NOT_UPDRADE_Desc = {
    Text = "This card cannot be strengthened"
  },
  ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc = {
    Text = "Your comment contains blocked words."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc = {
    Text = "You already commented."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc = {
    Text = "You already deleted this."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc = {
    Text = "You already liked this."
  },
  ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc = {
    Text = "Unliked too fast."
  },
  ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc = {
    Text = "Comment is too long."
  },
  ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc = {
    Text = "This comment is deleted."
  },
  ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc = {
    Text = "Comment timed out. Please try again."
  },
  ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc = {
    Text = "No exclusive card upgrade attempts remaining"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc = {
    Text = "No storyline found for the instance challenge"
  },
  ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc = {
    Text = "No storyline quests found for instance challenges"
  },
  ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc = {
    Text = "Phantasmal Dive updating. Please try again later."
  },
  ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc = {
    Text = "Challenge completed. Rewards cannot be claimed again."
  },
  ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc = {
    Text = "Challenge not completed. Rewards unavailable."
  },
  ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc = {
    Text = "Chapter rewards not reaching the required points"
  },
  ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc = {
    Text = "Chapter rewards have been claimed"
  },
  ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc = {
    Text = "Current node not found"
  },
  ErrCode_ERR_CHREATE_ROLE_Desc = {
    Text = "Character name already taken"
  },
  ErrCode_ERR_CLIENT_DATA_Desc = {
    Text = "Client data input error"
  },
  ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc = {
    Text = "Current node not found. Unable to close."
  },
  ErrCode_ERR_CONFIG_Desc = {
    Text = "Config data error"
  },
  ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc = {
    Text = "Unable to claim rewards"
  },
  ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc = {
    Text = "Reward conditions not yet fulfilled"
  },
  ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc = {
    Text = "No level task data available"
  },
  ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc = {
    Text = "No points for this instance's quest"
  },
  ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc = {
    Text = "Module for the subject score not found"
  },
  ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc = {
    Text = "No tasks found so far"
  },
  ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc = {
    Text = "No unit data found for the topic"
  },
  ErrCode_ERR_COURSE_PRIZE_Desc = {
    Text = "Unit has been submitted. No need to resubmit."
  },
  ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc = {
    Text = "Subtasks in the mission are incomplete"
  },
  ErrCode_ERR_COURSE_TASK_FINISH_Desc = {
    Text = "Mission completed"
  },
  ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc = {
    Text = "Tasks under the unit have not been fully completed and cannot be submitted"
  },
  ErrCode_ERR_CREATE_ROLE_CLOSE_Desc = {
    Text = "The registration of new Keepers is currently paused"
  },
  ErrCode_ERR_CREATE_ROLE_Desc = {
    Text = "No character found. Please create one."
  },
  ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc = {
    Text = "Custom command usage limit reached"
  },
  ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc = {
    Text = "Relic has been enhanced"
  },
  ErrCode_ERR_ENERGY_STORE_MAX_Desc = {
    Text = "Menophin is sufficient, no need to refill"
  },
  ErrCode_ERR_ENHANCE_RELIC_Desc = {
    Text = "Sacrifices cannot be offered at this time."
  },
  ErrCode_ERR_EQUIP_NOT_FIND_Desc = {
    Text = "Accessory does not exist"
  },
  ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc = {
    Text = "Error in the event area"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc = {
    Text = "Selected card for the event does not exist"
  },
  ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc = {
    Text = "Too many cards selected for the event"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc = {
    Text = "Selected Relic for the event does not exist"
  },
  ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc = {
    Text = "Too many Relics selected for the event"
  },
  ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc = {
    Text = "Incorrect event type entry in the instance configuration table"
  },
  ErrCode_ERR_EVENT_DATA_Desc = {
    Text = "Event data error"
  },
  ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc = {
    Text = "No battle drop cards refreshes remaining"
  },
  ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc = {
    Text = "No battle drop Relics refreshes remaining"
  },
  ErrCode_ERR_EVENT_FINISH_Desc = {
    Text = "Event completed"
  },
  ErrCode_ERR_EVENT_NOT_FIND_Desc = {
    Text = "Event does not exist in the instance"
  },
  ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc = {
    Text = "Insufficient Silver. Unable to purchase."
  },
  ErrCode_ERR_EVENT_NOT_NODE_Desc = {
    Text = "Event not found at this node"
  },
  ErrCode_ERR_EVENT_RANDOM_POND_Desc = {
    Text = "No data in the event random pool"
  },
  ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc = {
    Text = "Junction function is locked"
  },
  ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc = {
    Text = "The camp has already selected a function and cannot make another selection"
  },
  ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc = {
    Text = "The camp function has no remaining uses"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "No event shop refreshes remaining"
  },
  ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc = {
    Text = "Attempts to remove cards in the event shop have been exhausted"
  },
  ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc = {
    Text = "Insufficient number of cards selected for the event"
  },
  ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc = {
    Text = "Insufficient Relics selected for the event"
  },
  ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc = {
    Text = "Cannot find the specified exclusive card information"
  },
  ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc = {
    Text = "The upgrade path does not have a configured character ID"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc = {
    Text = "Designated exclusive card not unlocked"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc = {
    Text = "Change exclusive card to switch"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc = {
    Text = "Failed to switch the exclusive card"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc = {
    Text = "Upgrade exclusive card to switch"
  },
  ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc = {
    Text = "Cannot find the UUID for this exclusive card"
  },
  ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc = {
    Text = "The assisting Awakener has become invalid. Please refresh the assistance list and reselect an assisting Awakener."
  },
  ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc = {
    Text = "Synthesis item not unlocked"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc = {
    Text = "Insufficient currency to craft the item"
  },
  ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc = {
    Text = "Insufficient materials to craft the required item"
  },
  ErrCode_ERR_FACTORY_EXIST_Desc = {
    Text = "Building already exists and cannot be constructed again"
  },
  ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc = {
    Text = "Location already occupied by an Awakener, unable to enter"
  },
  ErrCode_ERR_FACTORY_MAX_LEVEL_Desc = {
    Text = "Building has reached the maximum level"
  },
  ErrCode_ERR_FACTORY_NOT_EXIST_Desc = {
    Text = "The building does not exist"
  },
  ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc = {
    Text = "Insufficient conditions to upgrade/construct buildings"
  },
  ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc = {
    Text = "Not enough items for upgrade/construction"
  },
  ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc = {
    Text = "No rewards available at the current node."
  },
  ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc = {
    Text = "No challenge attempts remaining"
  },
  ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc = {
    Text = "Your current HP is too low, and you are now in a Weakness state"
  },
  ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc = {
    Text = "Unlocks when exploration level reaches 2"
  },
  ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc = {
    Text = "After completing an exploration, you can instantly explore again."
  },
  ErrCode_ERR_GAMECOPY_NOT_Desc = {
    Text = "Instance error"
  },
  ErrCode_ERR_GAMECOPY_NOT_FIND_Desc = {
    Text = "No instance found"
  },
  ErrCode_ERR_GEAR_BLOCK_Desc = {
    Text = "Node locked"
  },
  ErrCode_ERR_GEAR_FINISH_Desc = {
    Text = "Node completed"
  },
  ErrCode_ERR_GEAR_NOT_FINISH_Desc = {
    Text = "Node not completed"
  },
  ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc = {
    Text = "Nodes are not adjacent"
  },
  ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc = {
    Text = "Insufficient store refreshes"
  },
  ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc = {
    Text = "Player level insufficient"
  },
  ErrCode_ERR_ILLEGAL_CHARACTER_Desc = {
    Text = "Description contains illegal characters. Please re-enter."
  },
  ErrCode_ERR_INOTHERBATTLE_Desc = {
    Text = "Opponent is currently busy"
  },
  ErrCode_ERR_INVALID_INDEX_Desc = {
    Text = "Invalid index value"
  },
  ErrCode_ERR_INVITE_EACH_Desc = {
    Text = "You are already their inviter."
  },
  ErrCode_ERR_INVITE_REPEAT_Desc = {
    Text = "The Inviter Already Exists"
  },
  ErrCode_ERR_IN_COPIES_Desc = {
    Text = "Instance state error, please log in again"
  },
  ErrCode_ERR_ITEM_BAG_FULL_Desc = {
    Text = "Inventory full"
  },
  ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc = {
    Text = "You have reached the daily purchase limit"
  },
  ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc = {
    Text = "Item has been equipped"
  },
  ErrCode_ERR_ITEM_HAS_LOCKED_Desc = {
    Text = "Item is locked"
  },
  ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc = {
    Text = "Item not locked"
  },
  ErrCode_ERR_ITEM_MAX_STAGE_Desc = {
    Text = "Item has reached the maximum tier"
  },
  ErrCode_ERR_ITEM_NOT_ENOUGH_Desc = {
    Text = "Insufficient items"
  },
  ErrCode_ERR_ITEM_NOT_FIND_Desc = {
    Text = "Item not found"
  },
  ErrCode_ERR_ITEM_NOT_MATCH_Desc = {
    Text = "Item mismatch"
  },
  ErrCode_ERR_ITEM_NOT_USE_Desc = {
    Text = "Item cannot be used"
  },
  ErrCode_ERR_ITEM_REPEAT_Desc = {
    Text = "Duplicate item"
  },
  ErrCode_ERR_ITEM_START_DROP_DATE_Desc = {
    Text = "The Wheel of Destiny or Posse is not yet available"
  },
  ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc = {
    Text = "Incorrect item usage quantity"
  },
  ErrCode_ERR_ITEM_UNUSABLE_Desc = {
    Text = "Item cannot be used"
  },
  ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc = {
    Text = "Previous trigger node not found"
  },
  ErrCode_ERR_LEAVE_NOT_CONDITION_Desc = {
    Text = "The currently collected energy is insufficient to activate the portal. {s1} energy points are required"
  },
  ErrCode_ERR_LEVEL_MAX_Desc = {
    Text = "Max level reached"
  },
  ErrCode_ERR_LOCKED_Desc = {Text = "Locked"},
  ErrCode_ERR_LOCK_COPIESAREA_Desc = {
    Text = "Instance area has not been unlocked yet"
  },
  ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc = {
    Text = "Storyline sweep not yet unlocked"
  },
  ErrCode_ERR_LOCK_COPIES_Desc = {
    Text = "The selected instance has not been unlocked yet"
  },
  ErrCode_ERR_LOCK_SROTYLINE_Desc = {
    Text = "The selected storyline has not been unlocked yet"
  },
  ErrCode_ERR_LOGIN_SERVER_Desc = {
    Text = "Login server error"
  },
  ErrCode_ERR_MAIL_ITEM_GAIN_Desc = {
    Text = "Attachment claimed"
  },
  ErrCode_ERR_MAIL_NOT_FIND_Desc = {
    Text = "Mail does not exist"
  },
  ErrCode_ERR_MATCH_FAIL_Desc = {
    Text = "Match failed"
  },
  ErrCode_ERR_MAXSUMMONLIMIT_Desc = {
    Text = "Maximum Awakenings reached!"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc = {
    Text = "Unable to challenge the specified Gold Dungeon"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc = {
    Text = "Select an Awakener to deploy"
  },
  ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc = {
    Text = "Designated Gold instance locked - please complete the specified investigation instance"
  },
  ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc = {
    Text = "You cannot rename yet. Please wait."
  },
  ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc = {
    Text = "The name contains invalid characters. Please re-enter."
  },
  ErrCode_ERR_NAME_NOT_LENGTH_Desc = {
    Text = "Name must be 2-4 characters long"
  },
  ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc = {
    Text = "Input string is too long"
  },
  ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc = {
    Text = "Insufficient points"
  },
  ErrCode_ERR_NOT_HAVE_ITEM_Desc = {
    Text = "Item not owned"
  },
  ErrCode_ERR_NOT_MOVE_Desc = {
    Text = "Cannot move"
  },
  ErrCode_ERR_NOT_OPEN_Desc = {
    Text = "Feature locked"
  },
  ErrCode_ERR_NOT_PRIZE_CONDITION_Desc = {
    Text = "Reward conditions not met. Unable to claim."
  },
  ErrCode_ERR_NO_AWAKER_DETAIL_Desc = {
    Text = "Updating profile, please check back later"
  },
  ErrCode_ERR_NO_FRIEND_GAME_Desc = {
    Text = "No ongoing friendly match"
  },
  ErrCode_ERR_NO_TRINKET_Desc = {
    Text = "No idle Covenant"
  },
  ErrCode_ERR_NPC_DATA_Desc = {
    Text = "NPC data error"
  },
  ErrCode_ERR_NPC_FINISH_Desc = {
    Text = "NPC has already been triggered"
  },
  ErrCode_ERR_NPC_NOT_FIND_Desc = {
    Text = "NPC does not exist"
  },
  ErrCode_ERR_OFFLINE_Desc = {
    Text = "The opponent is currently offline"
  },
  ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc = {
    Text = "Insufficient player level"
  },
  ErrCode_ERR_PLOTMOP_STARLIMIT_Desc = {
    Text = "Not enough storyline stars to sweep"
  },
  ErrCode_ERR_PLOTSAY_NOT_END_Desc = {
    Text = "No storyline dialogue event found"
  },
  ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc = {
    Text = "Insufficient purchase attempts for storyline challenges"
  },
  ErrCode_ERR_PRIZE_GAIN_Desc = {
    Text = "Reward Claimed"
  },
  ErrCode_ERR_PRIZE_NOT_FIND_Desc = {
    Text = "No such reward"
  },
  ErrCode_ERR_PUTENCHANT_FAIL_Desc = {
    Text = "Rune embedding failed"
  },
  ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc = {
    Text = "PVP collection not obtained"
  },
  ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc = {
    Text = "Insufficient Posses for Traphase team deployment"
  },
  ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc = {
    Text = "Insufficient WoDs for Traphase team deployment"
  },
  ErrCode_ERR_PVP_DRAFT_LOCK_Desc = {
    Text = "Draft Pick mode requirements not met"
  },
  ErrCode_ERR_PVP_NOT_COOLTIME_Desc = {
    Text = "Challenge on cooldown"
  },
  ErrCode_ERR_PVP_NOT_COUNT_Desc = {
    Text = "No challenge attempts remaining"
  },
  ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc = {
    Text = "No opponents to challenge"
  },
  ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc = {
    Text = "Select an Awakener to deploy"
  },
  ErrCode_ERR_PVP_OverWinTime_Desc = {
    Text = "One of the two players has achieved two victories. No additional rounds are allowed."
  },
  ErrCode_ERR_PVP_QUIT_Desc = {
    Text = "Opponent has quit the game"
  },
  ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc = {
    Text = "Password Mode invalid or expired"
  },
  ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc = {
    Text = "No such configuration exists in the recharge settings"
  },
  ErrCode_ERR_RECHARGE_NOT_FREE_Desc = {
    Text = "You have already received the free top-up and cannot recharge again"
  },
  ErrCode_ERR_REFRESH_NUM_LIMIT_Desc = {
    Text = "Item refresh limit reached"
  },
  ErrCode_ERR_RELATION_Desc = {
    Text = "You must follow each other"
  },
  ErrCode_ERR_RELIC_FULL_Desc = {
    Text = "Relics full"
  },
  ErrCode_ERR_REQUEST_CD_Desc = {
    Text = "Request too frequent. Please try again later."
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc = {
    Text = "Insufficient materials for elite enhancement"
  },
  ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc = {
    Text = "Insufficient currency to upgrade the Awakener"
  },
  ErrCode_ERR_ROLE_DATA_Desc = {
    Text = "Character data error"
  },
  ErrCode_ERR_ROLE_ENERGY_FULL_Desc = {
    Text = "The Awakener's arrival rate is maxed out and cannot be increased further"
  },
  ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc = {
    Text = "Awakener level insufficient"
  },
  ErrCode_ERR_ROLE_MAX_LEVEL_Desc = {
    Text = "Awakener has reached the maximum level and cannot be upgraded"
  },
  ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc = {
    Text = "Insufficient Currency"
  },
  ErrCode_ERR_ROLE_NOT_ADVANCE_Desc = {
    Text = "The Awakener has reached the highest Edify level."
  },
  ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc = {
    Text = "Reach max level to advance"
  },
  ErrCode_ERR_ROLE_NOT_FIND_Desc = {
    Text = "No Awakener data found"
  },
  ErrCode_ERR_ROLE_NOT_SKILL_Desc = {
    Text = "The Awakener has no skills"
  },
  ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc = {
    Text = "No slot information available"
  },
  ErrCode_ERR_ROLE_POTENCY_MAX_Desc = {
    Text = "The Awakener's potential has reached the highest level"
  },
  ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc = {
    Text = "Insufficient items to upgrade the Awakener's potential"
  },
  ErrCode_ERR_ROLE_SKILL_LOCKED_Desc = {
    Text = "Awakener skills not yet unlocked"
  },
  ErrCode_ERR_ROLE_SKILL_MAX_Desc = {
    Text = "Skill has reached the maximum level"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc = {
    Text = "Not enough skill upgrade items"
  },
  ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc = {
    Text = "Insufficient currency for skill upgrades"
  },
  ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc = {
    Text = "Max Level Reached"
  },
  ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc = {
    Text = "No more manual upgrade slots available"
  },
  ErrCode_ERR_ROLE_STAGE_Desc = {
    Text = "Already advanced; cannot advance again"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc = {
    Text = "Insufficient items for Awakener upgrade consumption"
  },
  ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc = {
    Text = "Insufficient currency to upgrade the Awakener"
  },
  ErrCode_ERR_SCHOOL_NOT_MATCH_Desc = {
    Text = "Realm does not meet the conditions"
  },
  ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc = {
    Text = "Awakeners deployed in the Realm Tower do not meet the Realm requirements"
  },
  ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc = {
    Text = "The level you have entered is not currently available"
  },
  ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc = {
    Text = "Cannot deploy identical Awakeners in the Realm Tower"
  },
  ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc = {
    Text = "Insufficient Silvers"
  },
  ErrCode_ERR_SERVER_CLOSED_Desc = {
    Text = "Campus maintenance in progress. Please wait for completion."
  },
  ErrCode_ERR_SERVER_NOT_START_Desc = {
    Text = "Service not started"
  },
  ErrCode_ERR_SHOP_BUY_Desc = {
    Text = "Already purchased"
  },
  ErrCode_ERR_SHOP_CUSTOM_CMD_Desc = {
    Text = "Currently unable to sense"
  },
  ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc = {
    Text = "The item has expired and cannot be redeemed"
  },
  ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc = {
    Text = "The item for sale is out of stock"
  },
  ErrCode_ERR_SHOP_NOT_DATA_Desc = {
    Text = "No store data available"
  },
  ErrCode_ERR_SHOP_NOT_Desc = {
    Text = "No store of this type"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_Desc = {
    Text = "No such item for sale"
  },
  ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc = {
    Text = "The store does not carry this item"
  },
  ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc = {
    Text = "No refresh attempts available"
  },
  ErrCode_ERR_SHOP_NOT_SELL_Desc = {
    Text = "This item is not available in the shop"
  },
  ErrCode_ERR_SHOP_REFRESH_Desc = {
    Text = "Current is not a shop node and cannot be refreshed."
  },
  ErrCode_ERR_SOCIAL_NO_ROLE_Desc = {
    Text = "The player does not exist."
  },
  ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc = {
    Text = "All avatars of the Primordial Vision have been defeated"
  },
  ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc = {
    Text = "Daily challenge limit for this stage type has been reached"
  },
  ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc = {
    Text = "Clicking too frequent. Please try again later."
  },
  ErrCode_ERR_SUMMON_NOT_OPEN_Desc = {
    Text = "Awakening function not enabled"
  },
  ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc = {
    Text = "Activation conditions not met"
  },
  ErrCode_ERR_TALENT_ACTIVE_Desc = {
    Text = "Resonance already active. No need to activate again."
  },
  ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc = {
    Text = "Initial Resonance cannot be reset"
  },
  ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc = {
    Text = "Insufficient Resonance materials"
  },
  ErrCode_ERR_TALENT_MAX_LEVEL_Desc = {
    Text = "Resonance point has reached the maximum level"
  },
  ErrCode_ERR_TALENT_NOT_COPIES_Desc = {
    Text = "No Resonance found in the instance"
  },
  ErrCode_ERR_TALENT_NOT_FIND_Desc = {
    Text = "No Resonance data found"
  },
  ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc = {
    Text = "No Resonance level-related data found"
  },
  ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc = {
    Text = "No reset attempts available"
  },
  ErrCode_ERR_TALENT_UNLOCK_Desc = {
    Text = "Awakener production effects unlocked; no need to unlock again."
  },
  ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc = {
    Text = "Reward Claimed"
  },
  ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc = {
    Text = "The delegated mission is complete and cannot be recalled"
  },
  ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc = {
    Text = "Insufficient assignment conditions"
  },
  ErrCode_ERR_TASK_FINISH_Desc = {
    Text = "Mission Completed"
  },
  ErrCode_ERR_TASK_NOT_FIND_Desc = {
    Text = "Task not found"
  },
  ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc = {
    Text = "Quest incomplete, reward unavailable"
  },
  ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc = {
    Text = "The team name can only contain Chinese or English characters"
  },
  ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc = {
    Text = "Team name length cannot exceed 8 characters"
  },
  ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc = {
    Text = "Requires 4 Awakeners in team"
  },
  ErrCode_ERR_TEAM_NO_TEAM_Desc = {
    Text = "Team configuration not found"
  },
  ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc = {
    Text = "The team's Awakener has not set up the Wheel of Destiny"
  },
  ErrCode_ERR_TEAM_SCHOOLMIX_Desc = {
    Text = "There is a Realm Conflict with the Awakeners in the team, please make adjustments"
  },
  ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc = {
    Text = "Wheel of Destiny does not exist"
  },
  ErrCode_ERR_TICKET_NOT_ENOUGH_Desc = {
    Text = "Insufficient Vouchers"
  },
  ErrCode_ERR_TOKEN_Desc = {
    Text = "Login token error"
  },
  ErrCode_ERR_TRIGGER_NOT_FIND_Desc = {
    Text = "Current trigger node not found"
  },
  ErrCode_ERR_TRINKET_NOT_TRAINING_Desc = {
    Text = "Accessory not recorded, unable to replace attributes"
  },
  ErrCode_ERR_UNATTEN_FIRST_Desc = {
    Text = "Unfollow first, then block"
  },
  ErrCode_ERR_UNIT_USED_ONCE_Desc = {
    Text = "Awakeners, Wheel of Destiny, or Posse have been used in this gameplay today"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc = {
    Text = "Failed to unlock side quest: side quest is already available"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc = {
    Text = "Failed to unlock side quest: side quest not activated"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc = {
    Text = "Failed to unlock side quest: no items required for unlocking"
  },
  ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc = {
    Text = "Failed to unlock side quest: side quest already unlocked"
  },
  ErrCode_ERR_VERSION_TOO_OLD_Desc = {
    Text = "Version mismatch, please update. If updated, please wait for campus maintenance to finish."
  },
  ErrCode_FAILED_Desc = {Text = "Failure"},
  ErrCode_IS_CREATE_ROLE_Desc = {
    Text = "This character already exists; no need to create another"
  },
  ErrCode_SUCCESS_Desc = {Text = "Success"}
})
return Text_ErrCode
