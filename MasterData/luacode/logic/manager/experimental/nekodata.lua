local DM_BattleEditor = require("logic.manager.experimental.datamanager.dm_battleeditor")
local DM_Game = require("logic.manager.experimental.datamanager.dm_game")
local DM_Chat = require("logic.manager.experimental.datamanager.dm_chat")
local DM_Battle = require("logic.manager.experimental.datamanager.dm_battle")
local DM_SBattleStart = require("logic.manager.experimental.datamanager.dm_sbattlestart")
local DM_SBattleEnd = require("logic.manager.experimental.datamanager.dm_sbattleend")
local DM_BagInfo = require("logic.manager.experimental.datamanager.dm_baginfo")
local DM_Login = require("logic.manager.experimental.datamanager.dm_login")
local DM_Mail = require("logic.manager.experimental.datamanager.dm_mail")
local DM_Counter = require("logic.manager.experimental.datamanager.dm_counter")
local DM_AllRoles = require("logic.manager.experimental.datamanager.dm_allroles")
local DM_Task = require("logic.manager.experimental.datamanager.dm_task")
local DM_Team = require("logic.manager.experimental.datamanager.dm_team")
local DM_Dungeon = require("logic.manager.experimental.datamanager.dm_dungeon")
local DM_SEnterDungeon = require("logic.manager.experimental.datamanager.dm_senterdungeon")
local DM_SEnterMainCity = require("logic.manager.experimental.datamanager.dm_sentermaincity")
local DM_Currency = require("logic.manager.experimental.datamanager.dm_currency")
local DM_NPC = require("logic.manager.experimental.datamanager.dm_npc")
local DM_Gacha = require("logic.manager.experimental.datamanager.dm_gacha")
local DM_Guide = require("logic.manager.experimental.datamanager.dm_guide")
local DM_Guild = require("logic.manager.experimental.datamanager.dm_guild")
local DM_Message = require("logic.manager.experimental.datamanager.dm_message")
local DM_MiniMap = require("logic.manager.experimental.datamanager.dm_minimap")
local DM_Friends = require("logic.manager.experimental.datamanager.dm_friends")
local DM_FriendsChat = require("logic.manager.experimental.datamanager.dm_friendschat")
local DM_Shop = require("logic.manager.experimental.datamanager.dm_shop")
local DM_Welfare = require("logic.manager.experimental.datamanager.dm_welfare")
local DM_ReturnWelfare = require("logic.manager.experimental.datamanager.dm_returnwelfare")
local DM_MagicTree = require("logic.manager.experimental.datamanager.dm_magictree")
local DM_Explore = require("logic.manager.experimental.datamanager.dm_explore")
local DM_Firefly = require("logic.manager.experimental.datamanager.dm_firefly")
local DM_Alchemy = require("logic.manager.experimental.datamanager.dm_alchemy")
local DM_Cabin = require("logic.manager.experimental.datamanager.dm_cabin")
local DM_TrainCamp = require("logic.manager.experimental.datamanager.dm_traincamp")
local DM_YardMusic = require("logic.manager.experimental.datamanager.dm_yardmusic")
local DM_HandBook = require("logic.manager.experimental.datamanager.dm_handbook")
local DM_Activity = require("logic.manager.experimental.datamanager.dm_activity")
local DM_TimeScale = require("logic.manager.experimental.datamanager.dm_timescale")
local DM_Tower = require("logic.manager.experimental.datamanager.dm_tower")
local DM_Voice = require("logic.manager.experimental.datamanager.dm_voice")
local DM_ItemAccountShow = require("logic.manager.experimental.datamanager.dm_itemaccountshow")
local DM_Vocation = require("logic.manager.experimental.datamanager.dm_vocation")
local DM_TowerV2 = require("logic.manager.experimental.datamanager.dm_towerv2")
local DM_SevenGrow = require("logic.manager.experimental.datamanager.dm_sevengrow")
local DM_ActivityTasks = require("logic.manager.experimental.datamanager.dm_activitytasks")
local DM_RedDot = require("logic.manager.experimental.datamanager.dm_reddot")
local DM_UndecidedRoad = require("logic.manager.experimental.datamanager.dm_undecidedroad")
local DM_RedPoint = require("logic.manager.experimental.datamanager.dm_redpoint")
local DM_SimpleRank = require("logic.manager.experimental.datamanager.dm_simplerank")
local DM_OfflineSweep = require("logic.manager.experimental.datamanager.dm_offlinesweep")
local DM_Foresight = require("logic.manager.experimental.datamanager.dm_foresight")
local DM_SkinList = require("logic.manager.experimental.datamanager.dm_skinlist")
local DM_WeekBoss = require("logic.manager.experimental.datamanager.dm_weekboss")
local DM_Anniversary = require("logic.manager.experimental.datamanager.dm_anniversary")
local DM_AnniversaryShare = require("logic.manager.experimental.datamanager.dm_anniversaryshare")
local DM_CommonActivity = require("logic.manager.experimental.datamanager.dm_commonactivity")
local DM_StarMirageCopy = require("logic.manager.experimental.datamanager.dm_starmiragecopy")
local DM_ClientTimer = require("logic.manager.experimental.datamanager.dm_clienttimer")
local BM_BattleEditor = require("logic.manager.experimental.behaviormanager.bm_battleeditor")
local BM_Game = require("logic.manager.experimental.behaviormanager.bm_game")
local BM_Chat = require("logic.manager.experimental.behaviormanager.bm_chat")
local BM_Battle = require("logic.manager.experimental.behaviormanager.bm_battle")
local BM_SBattleStart = require("logic.manager.experimental.behaviormanager.bm_sbattlestart")
local BM_SBattleEnd = require("logic.manager.experimental.behaviormanager.bm_sbattleend")
local BM_BagInfo = require("logic.manager.experimental.behaviormanager.bm_baginfo")
local BM_Login = require("logic.manager.experimental.behaviormanager.bm_login")
local BM_Mail = require("logic.manager.experimental.behaviormanager.bm_mail")
local BM_Counter = require("logic.manager.experimental.behaviormanager.bm_counter")
local BM_AllRoles = require("logic.manager.experimental.behaviormanager.bm_allroles")
local BM_Task = require("logic.manager.experimental.behaviormanager.bm_task")
local BM_Team = require("logic.manager.experimental.behaviormanager.bm_team")
local BM_Dungeon = require("logic.manager.experimental.behaviormanager.bm_dungeon")
local BM_SEnterDungeon = require("logic.manager.experimental.behaviormanager.bm_senterdungeon")
local BM_SEnterMainCity = require("logic.manager.experimental.behaviormanager.bm_sentermaincity")
local BM_Currency = require("logic.manager.experimental.behaviormanager.bm_currency")
local BM_NPC = require("logic.manager.experimental.behaviormanager.bm_npc")
local BM_Gacha = require("logic.manager.experimental.behaviormanager.bm_gacha")
local BM_Guide = require("logic.manager.experimental.behaviormanager.bm_guide")
local BM_Guild = require("logic.manager.experimental.behaviormanager.bm_guild")
local BM_Message = require("logic.manager.experimental.behaviormanager.bm_message")
local BM_MiniMap = require("logic.manager.experimental.behaviormanager.bm_minimap")
local BM_Friends = require("logic.manager.experimental.behaviormanager.bm_friends")
local BM_FriendsChat = require("logic.manager.experimental.behaviormanager.bm_friendschat")
local BM_Shop = require("logic.manager.experimental.behaviormanager.bm_shop")
local BM_Welfare = require("logic.manager.experimental.behaviormanager.bm_welfare")
local BM_ReturnWelfare = require("logic.manager.experimental.behaviormanager.bm_returnwelfare")
local BM_NPCChat = require("logic.manager.experimental.behaviormanager.bm_npcchat")
local BM_MagicTree = require("logic.manager.experimental.behaviormanager.bm_magictree")
local BM_Explore = require("logic.manager.experimental.behaviormanager.bm_explore")
local BM_Firefly = require("logic.manager.experimental.behaviormanager.bm_firefly")
local BM_Alchemy = require("logic.manager.experimental.behaviormanager.bm_alchemy")
local BM_Cabin = require("logic.manager.experimental.behaviormanager.bm_cabin")
local BM_TrainCamp = require("logic.manager.experimental.behaviormanager.bm_traincamp")
local BM_YardMusic = require("logic.manager.experimental.behaviormanager.bm_yardmusic")
local BM_HandBook = require("logic.manager.experimental.behaviormanager.bm_handbook")
local BM_Activity = require("logic.manager.experimental.behaviormanager.bm_activity")
local BM_TimeScale = require("logic.manager.experimental.behaviormanager.bm_timescale")
local BM_Tower = require("logic.manager.experimental.behaviormanager.bm_tower")
local BM_Voice = require("logic.manager.experimental.behaviormanager.bm_voice")
local BM_Lines = require("logic.manager.experimental.behaviormanager.bm_lines")
local BM_GotoLink = require("logic.manager.experimental.behaviormanager.bm_gotolink")
local BM_GotoDialog = require("logic.manager.experimental.behaviormanager.bm_gotodialog")
local BM_ItemAccountShow = require("logic.manager.experimental.behaviormanager.bm_itemaccountshow")
local BM_Vocation = require("logic.manager.experimental.behaviormanager.bm_vocation")
local BM_TipsCondition = require("logic.manager.experimental.behaviormanager.bm_tipscondition")
local BM_TowerV2 = require("logic.manager.experimental.behaviormanager.bm_towerv2")
local BM_SevenGrow = require("logic.manager.experimental.behaviormanager.bm_sevengrow")
local BM_ActivityTasks = require("logic.manager.experimental.behaviormanager.bm_activitytasks")
local BM_RoleTouch = require("logic.manager.experimental.behaviormanager.bm_roletouch")
local BM_UndecidedRoad = require("logic.manager.experimental.behaviormanager.bm_undecidedroad")
local BM_RedPoint = require("logic.manager.experimental.behaviormanager.bm_redpoint")
local BM_SimpleRank = require("logic.manager.experimental.behaviormanager.bm_simplerank")
local BM_OfflineSweep = require("logic.manager.experimental.behaviormanager.bm_offlinesweep")
local BM_Foresight = require("logic.manager.experimental.behaviormanager.bm_foresight")
local BM_SkinList = require("logic.manager.experimental.behaviormanager.bm_skinlist")
local BM_WeekBoss = require("logic.manager.experimental.behaviormanager.bm_weekboss")
local BM_Anniversary = require("logic.manager.experimental.behaviormanager.bm_anniversary")
local BM_AnniversaryShare = require("logic.manager.experimental.behaviormanager.bm_anniversaryshare")
local BM_CommonActivity = require("logic.manager.experimental.behaviormanager.bm_commonactivity")
local BM_StarMirageCopy = require("logic.manager.experimental.behaviormanager.bm_starmiragecopy")
local BM_ClientTimer = require("logic.manager.experimental.behaviormanager.bm_clienttimer")
local RedData = require("logic.manager.experimental.types.reddata")
local NekoData = {}
NekoData.DataManager = {}
NekoData.BehaviorManager = {}

function NekoData.CreateAll()
  NekoData.DataManager = {}
  NekoData.DataManager.DM_BattleEditor = DM_BattleEditor.Create()
  NekoData.DataManager.DM_Game = DM_Game.Create()
  NekoData.DataManager.DM_Chat = DM_Chat.Create()
  NekoData.DataManager.DM_Battle = DM_Battle.Create()
  NekoData.DataManager.DM_SBattleStart = DM_SBattleStart.Create()
  NekoData.DataManager.DM_SBattleEnd = DM_SBattleEnd.Create()
  NekoData.DataManager.DM_BagInfo = DM_BagInfo.Create()
  NekoData.DataManager.DM_Login = DM_Login.Create()
  NekoData.DataManager.DM_Mail = DM_Mail.Create()
  NekoData.DataManager.DM_Counter = DM_Counter.Create()
  NekoData.DataManager.DM_AllRoles = DM_AllRoles.Create()
  NekoData.DataManager.DM_Task = DM_Task.Create()
  NekoData.DataManager.DM_Team = DM_Team.Create()
  NekoData.DataManager.DM_Dungeon = DM_Dungeon.Create()
  NekoData.DataManager.DM_SEnterDungeon = DM_SEnterDungeon.Create()
  NekoData.DataManager.DM_SEnterMainCity = DM_SEnterMainCity.Create()
  NekoData.DataManager.DM_Currency = DM_Currency.Create()
  NekoData.DataManager.DM_NPC = DM_NPC.Create()
  NekoData.DataManager.DM_Gacha = DM_Gacha.Create()
  NekoData.DataManager.DM_Guide = DM_Guide.Create()
  NekoData.DataManager.DM_Guild = DM_Guild.Create()
  NekoData.DataManager.DM_Message = DM_Message.Create()
  NekoData.DataManager.DM_MiniMap = DM_MiniMap.Create()
  NekoData.DataManager.DM_Friends = DM_Friends.Create()
  NekoData.DataManager.DM_FriendsChat = DM_FriendsChat.Create()
  NekoData.DataManager.DM_Shop = DM_Shop.Create()
  NekoData.DataManager.DM_Welfare = DM_Welfare.Create()
  NekoData.DataManager.DM_ReturnWelfare = DM_ReturnWelfare.Create()
  NekoData.DataManager.DM_MagicTree = DM_MagicTree.Create()
  NekoData.DataManager.DM_Explore = DM_Explore.Create()
  NekoData.DataManager.DM_Firefly = DM_Firefly.Create()
  NekoData.DataManager.DM_Alchemy = DM_Alchemy.Create()
  NekoData.DataManager.DM_Cabin = DM_Cabin.Create()
  NekoData.DataManager.DM_TrainCamp = DM_TrainCamp.Create()
  NekoData.DataManager.DM_YardMusic = DM_YardMusic.Create()
  NekoData.DataManager.DM_HandBook = DM_HandBook.Create()
  NekoData.DataManager.DM_Activity = DM_Activity.Create()
  NekoData.DataManager.DM_TimeScale = DM_TimeScale.Create()
  NekoData.DataManager.DM_Tower = DM_Tower.Create()
  NekoData.DataManager.DM_Voice = DM_Voice.Create()
  NekoData.DataManager.DM_ItemAccountShow = DM_ItemAccountShow.Create()
  NekoData.DataManager.DM_Vocation = DM_Vocation.Create()
  NekoData.DataManager.DM_TowerV2 = DM_TowerV2.Create()
  NekoData.DataManager.DM_SevenGrow = DM_SevenGrow.Create()
  NekoData.DataManager.DM_ActivityTasks = DM_ActivityTasks.Create()
  NekoData.DataManager.DM_RedDot = DM_RedDot.Create()
  NekoData.DataManager.DM_RedPoint = DM_RedPoint.Create()
  NekoData.DataManager.DM_SimpleRank = DM_SimpleRank.Create()
  NekoData.DataManager.DM_UndecidedRoad = DM_UndecidedRoad.Create()
  NekoData.DataManager.DM_OfflineSweep = DM_OfflineSweep.Create()
  NekoData.DataManager.DM_Foresight = DM_Foresight.Create()
  NekoData.DataManager.DM_SkinList = DM_SkinList.Create()
  NekoData.DataManager.DM_WeekBoss = DM_WeekBoss.Create()
  NekoData.DataManager.DM_Anniversary = DM_Anniversary.Create()
  NekoData.DataManager.DM_AnniversaryShare = DM_AnniversaryShare.Create()
  NekoData.DataManager.DM_CommonActivity = DM_CommonActivity.Create()
  NekoData.DataManager.DM_StarMirageCopy = DM_StarMirageCopy.Create()
  NekoData.DataManager.DM_ClientTimer = DM_ClientTimer.Create()
  NekoData.BehaviorManager = {}
  NekoData.BehaviorManager.BM_BattleEditor = BM_BattleEditor.Create()
  NekoData.BehaviorManager.BM_Game = BM_Game.Create()
  NekoData.BehaviorManager.BM_Chat = BM_Chat.Create()
  NekoData.BehaviorManager.BM_Battle = BM_Battle.Create()
  NekoData.BehaviorManager.BM_SBattleStart = BM_SBattleStart.Create()
  NekoData.BehaviorManager.BM_SBattleEnd = BM_SBattleEnd.Create()
  NekoData.BehaviorManager.BM_BagInfo = BM_BagInfo.Create()
  NekoData.BehaviorManager.BM_Login = BM_Login.Create()
  NekoData.BehaviorManager.BM_Mail = BM_Mail.Create()
  NekoData.BehaviorManager.BM_Counter = BM_Counter.Create()
  NekoData.BehaviorManager.BM_AllRoles = BM_AllRoles.Create()
  NekoData.BehaviorManager.BM_Task = BM_Task.Create()
  NekoData.BehaviorManager.BM_Team = BM_Team.Create()
  NekoData.BehaviorManager.BM_Dungeon = BM_Dungeon.Create()
  NekoData.BehaviorManager.BM_SEnterDungeon = BM_SEnterDungeon.Create()
  NekoData.BehaviorManager.BM_SEnterMainCity = BM_SEnterMainCity.Create()
  NekoData.BehaviorManager.BM_Currency = BM_Currency.Create()
  NekoData.BehaviorManager.BM_NPC = BM_NPC.Create()
  NekoData.BehaviorManager.BM_Gacha = BM_Gacha.Create()
  NekoData.BehaviorManager.BM_Guide = BM_Guide.Create()
  NekoData.BehaviorManager.BM_Guild = BM_Guild.Create()
  NekoData.BehaviorManager.BM_Message = BM_Message.Create()
  NekoData.BehaviorManager.BM_MiniMap = BM_MiniMap.Create()
  NekoData.BehaviorManager.BM_Friends = BM_Friends.Create()
  NekoData.BehaviorManager.BM_FriendsChat = BM_FriendsChat.Create()
  NekoData.BehaviorManager.BM_Shop = BM_Shop.Create()
  NekoData.BehaviorManager.BM_Welfare = BM_Welfare.Create()
  NekoData.BehaviorManager.BM_ReturnWelfare = BM_ReturnWelfare.Create()
  NekoData.BehaviorManager.BM_NPCChat = BM_NPCChat.Create()
  NekoData.BehaviorManager.BM_MagicTree = BM_MagicTree.Create()
  NekoData.BehaviorManager.BM_Explore = BM_Explore.Create()
  NekoData.BehaviorManager.BM_Firefly = BM_Firefly.Create()
  NekoData.BehaviorManager.BM_Alchemy = BM_Alchemy.Create()
  NekoData.BehaviorManager.BM_Cabin = BM_Cabin.Create()
  NekoData.BehaviorManager.BM_TrainCamp = BM_TrainCamp.Create()
  NekoData.BehaviorManager.BM_YardMusic = BM_YardMusic.Create()
  NekoData.BehaviorManager.BM_HandBook = BM_HandBook.Create()
  NekoData.BehaviorManager.BM_Activity = BM_Activity.Create()
  NekoData.BehaviorManager.BM_TimeScale = BM_TimeScale.Create()
  NekoData.BehaviorManager.BM_Tower = BM_Tower.Create()
  NekoData.BehaviorManager.BM_Voice = BM_Voice.Create()
  NekoData.BehaviorManager.BM_Lines = BM_Lines.Create()
  NekoData.BehaviorManager.BM_GotoLink = BM_GotoLink.Create()
  NekoData.BehaviorManager.BM_GotoDialog = BM_GotoDialog.Create()
  NekoData.BehaviorManager.BM_ItemAccountShow = BM_ItemAccountShow.Create()
  NekoData.BehaviorManager.BM_Vocation = BM_Vocation.Create()
  NekoData.BehaviorManager.BM_TipsCondition = BM_TipsCondition.Create()
  NekoData.BehaviorManager.BM_TowerV2 = BM_TowerV2.Create()
  NekoData.BehaviorManager.BM_SevenGrow = BM_SevenGrow.Create()
  NekoData.BehaviorManager.BM_ActivityTasks = BM_ActivityTasks.Create()
  NekoData.BehaviorManager.BM_RoleTouch = BM_RoleTouch.Create()
  NekoData.BehaviorManager.BM_UndecidedRoad = BM_UndecidedRoad.Create()
  NekoData.BehaviorManager.BM_RedPoint = BM_RedPoint.Create()
  NekoData.BehaviorManager.BM_SimpleRank = BM_SimpleRank.Create()
  NekoData.BehaviorManager.BM_OfflineSweep = BM_OfflineSweep.Create()
  NekoData.BehaviorManager.BM_Foresight = BM_Foresight.Create()
  NekoData.BehaviorManager.BM_SkinList = BM_SkinList.Create()
  NekoData.BehaviorManager.BM_WeekBoss = BM_WeekBoss.Create()
  NekoData.BehaviorManager.BM_Anniversary = BM_Anniversary.Create()
  NekoData.BehaviorManager.BM_AnniversaryShare = BM_AnniversaryShare.Create()
  NekoData.BehaviorManager.BM_CommonActivity = BM_CommonActivity.Create()
  NekoData.BehaviorManager.BM_StarMirageCopy = BM_StarMirageCopy.Create()
  NekoData.BehaviorManager.BM_ClientTimer = BM_ClientTimer.Create()
end

NekoData.Events = {
  Task = {
    n_InitTasks = "iInitTasks",
    n_AcceptTask = "iAcceptTask",
    n_RefreshTask = "iRefreshTask",
    n_GetDailyTask = "iGetDailyTask",
    n_GetActiveAward = "iGetActiveAward",
    n_RefreshTaskOfGuide = "iRefreshTaskOfGuide"
  },
  Activity = {
    n_ActivityStart = "iActivityStart",
    n_ActivityStop = "iActivityStop"
  }
}
NekoData.Data = {
  battleeditor = {},
  game = {},
  chat = {},
  battle = {},
  sbattlestartinfo = {},
  sbattleendinfo = {},
  baginfo = {},
  login = {},
  mail = {},
  counter = {},
  allroles = {},
  tasks = {
    list = {},
    sorted = {},
    typed = {},
    params = {},
    choice = {},
    finished = {},
    redData = RedData.Create(Common.n_TaskRedChange, 8)
  },
  teams = {},
  towerteams = {},
  dungeoninfo = {},
  senterdungeoninfo = {},
  senterMainCityInfo = {},
  currency = {
    moneyInfo = {}
  },
  npc = {},
  plotConfig = {},
  gacha = {},
  guide = {},
  guild = {},
  message = {},
  friends = {
    list = {},
    redData = RedData.Create(Common.n_FriendsRedChange, 3),
    recommendList = {},
    worldMsgBlockList = {},
    roleInfo = {}
  },
  friendsChat = {
    localChat = {},
    onlineChat = {}
  },
  shops = {},
  miniMap = {},
  welfare = {},
  returnWelfare = {},
  magicTree = {},
  explore = {},
  alchemy = {},
  firefly = {},
  cabin = {},
  trainCamp = {},
  yardMusic = {},
  handBookList = {
    equipList = {},
    monsterList = {},
    roleList = {},
    npcList = {},
    worldList = {},
    forceList = {},
    activities = {},
    lockedRoleList = {}
  },
  activities = {
    time = {},
    spiritdiscount = {},
    agCoinData = {},
    sign = {},
    starmirage = {},
    summerActivity = {},
    summerechoesActivity = {},
    puzzle = {},
    recharge = {},
    halloween = {},
    doubleeleven = {},
    christmas = {},
    birthday = {},
    chrismascall = {},
    springfestival = {},
    lover = {},
    aprilfoolsday = {},
    children = {},
    dragonboatfestival = {},
    giftoftime = {},
    giftoftimepuzzle = {},
    giftoftimemaze = {}
  },
  timeScale = {},
  tower = {},
  voice = {},
  itemAccountData = {},
  cacheItemAccountData = {},
  towerv2 = {},
  undecidedroad = {},
  sevengrow = {},
  activityTasks = {
    allTaskList = {},
    finishedTaskList = {}
  },
  redPoint = {},
  simpleRank = {},
  offlineSweep = {},
  foresight = {},
  skinlist = {},
  weekboss = {},
  anniversary = {},
  anniversaryshare = {},
  taskshopactivity = {},
  starMirageCopy = {},
  clientTimer = {}
}
setmetatable(NekoData.Data, {
  __newindex = function()
    LogError("NekoData", "__newindex")
  end
})

function NekoData.ClearAll()
  NekoData.DataManager.DM_BattleEditor:Clear()
  NekoData.DataManager.DM_Game:Clear()
  NekoData.DataManager.DM_Chat:Clear()
  NekoData.DataManager.DM_Battle:Clear()
  NekoData.DataManager.DM_SBattleStart:Clear()
  NekoData.DataManager.DM_SBattleEnd:Clear()
  NekoData.DataManager.DM_BagInfo:Clear()
  NekoData.DataManager.DM_Login:Clear()
  NekoData.DataManager.DM_Mail:Clear()
  NekoData.DataManager.DM_Counter:Clear()
  NekoData.DataManager.DM_AllRoles:Clear()
  NekoData.DataManager.DM_Task:Clear()
  NekoData.DataManager.DM_Team:Clear()
  NekoData.DataManager.DM_Dungeon:Clear()
  NekoData.DataManager.DM_SEnterDungeon:Clear()
  NekoData.DataManager.DM_SEnterMainCity:Clear()
  NekoData.DataManager.DM_Currency:Clear()
  NekoData.DataManager.DM_NPC:Clear()
  NekoData.DataManager.DM_Gacha:Clear()
  NekoData.DataManager.DM_Guide:Clear()
  NekoData.DataManager.DM_Guild:Clear()
  NekoData.DataManager.DM_Message:Clear()
  NekoData.DataManager.DM_MiniMap:Clear()
  NekoData.DataManager.DM_Friends:Clear()
  NekoData.DataManager.DM_FriendsChat:Clear()
  NekoData.DataManager.DM_Shop:Clear()
  NekoData.DataManager.DM_Welfare:Clear()
  NekoData.DataManager.DM_ReturnWelfare:Clear()
  NekoData.DataManager.DM_MagicTree:Clear()
  NekoData.DataManager.DM_Explore:Clear()
  NekoData.DataManager.DM_Firefly:Clear()
  NekoData.DataManager.DM_Alchemy:Clear()
  NekoData.DataManager.DM_Cabin:Clear()
  NekoData.DataManager.DM_TrainCamp:Clear()
  NekoData.DataManager.DM_YardMusic:Clear()
  NekoData.DataManager.DM_Activity:Clear()
  NekoData.DataManager.DM_TimeScale:Clear()
  NekoData.DataManager.DM_Tower:Clear()
  NekoData.DataManager.DM_Voice:Clear()
  NekoData.DataManager.DM_ItemAccountShow:Clear()
  NekoData.DataManager.DM_Vocation:Clear()
  NekoData.DataManager.DM_SevenGrow:Clear()
  NekoData.DataManager.DM_ActivityTasks:Clear()
  NekoData.DataManager.DM_RedDot:Clear()
  NekoData.DataManager.DM_TowerV2:Clear()
  NekoData.DataManager.DM_UndecidedRoad:Clear()
  NekoData.DataManager.DM_HandBook:Clear()
  NekoData.DataManager.DM_RedPoint:Clear()
  NekoData.DataManager.DM_SimpleRank:Clear()
  NekoData.DataManager.DM_OfflineSweep:Clear()
  NekoData.DataManager.DM_Foresight:Clear()
  NekoData.DataManager.DM_SkinList:Clear()
  NekoData.DataManager.DM_Anniversary:Clear()
  NekoData.DataManager.DM_AnniversaryShare:Clear()
  NekoData.DataManager.DM_StarMirageCopy:Clear()
  NekoData.DataManager.DM_ClientTimer:Clear()
end

return NekoData
