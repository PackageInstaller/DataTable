local DataCommon = {}
DataCommon.DiamodID = 35001
DataCommon.ManaID = 35002
DataCommon.SpiritID = 35003
DataCommon.SoulDropID = 35008
DataCommon.FriendShipID = 35009
DataCommon.EtherID = 35010
DataCommon.APID = 35013
DataCommon.WhiteLight = 35014
DataCommon.DarkLight = 35015
DataCommon.ColorLight = 35016
DataCommon.AgCoinID = 35017
DataCommon.WhiteCoin = 35011
DataCommon.GoldCoin = 35012
DataCommon.FurnitureCion = 35018
DataCommon.FashionID = 35019
DataCommon.TowerCoin = 35021
DataCommon.PVPKeys = 35022
DataCommon.PVPCoin = 35023
DataCommon.StarCoin = 35024
DataCommon.RedStarCoin = 35025
DataCommon.GuildCoin = 35004
DataCommon.MemoryPieces = 35027
DataCommon.SwimSuitCoinConch = 35031
DataCommon.SwimSuitCoinPearl = 35033
DataCommon.SwimSuitCoinCoral = 35034
DataCommon.SwimSuitWood = 35028
DataCommon.SwimSuitSand = 35029
DataCommon.SwimSuitStone = 35030
DataCommon.Pumpkin = 35035
DataCommon.PumpkinPie = 35036
DataCommon.CrystalBall = 35037
DataCommon.BirthDayCandy = 35041
DataCommon.ChrismasCallStick = 35042
DataCommon.SpringFestivalFu = 35043
DataCommon.SpringFestivalFuRecoverItem = 31279
DataCommon.LoveTownCurrency = 35044
DataCommon.LoveChocolate = 35045
DataCommon.LoveFlowers = 35046
DataCommon.LoveCarefullyPreparedGift = 35047
DataCommon.RoleResetCoin = 35048
DataCommon.Cicada = 35055
DataCommon.LuckyCopperCoin = 35056
DataCommon.TimeCrystal = 35058
DataCommon.KillBossCoin = 35060
DataCommon.WitchSeal = 35059
DataCommon.TimeDice = 35061
local AnniversaryCurrencyList = string.split(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(1).type, ";")
DataCommon.AnniversaryCoin_Easy = tonumber(AnniversaryCurrencyList[1])
DataCommon.AnniversaryCoin_Hard = tonumber(AnniversaryCurrencyList[2])
DataCommon.SpriteEvidence = 31480
DataCommon.SummerEchoesCurrency1 = 35066
DataCommon.SummerEchoesCurrency2 = 35067
DataCommon.ChristmasSing = 35038
DataCommon.ChristmasJump = 35039
DataCommon.ChristmasExpressiveForce = 35040
DataCommon.SpiritItemType = 42
DataCommon.SpringSpiritItemType = 138
DataCommon.PageChatNum = 10
DataCommon.SqlClientId = 0
DataCommon.MagicTree = 100
DataCommon.Explore = 200
DataCommon.Firefly = 300
DataCommon.Alchemy = 400
DataCommon.Cabin = 500
DataCommon.TrainCamp = 600
DataCommon.YardMusic = 700
DataCommon.CabinScene = "CabinScene"
DataCommon.CabinFurniture = "CabinFurniture"
DataCommon.CabinCharacter = "CabinCharacter"
DataCommon.RoleEnergyRatio = 1000
DataCommon.TotalEnergy = BeanManager.GetTableByName("courtyard.cemotioncfg"):GetRecorder(1).total
DataCommon.DefaultImageAsset = BeanManager.GetTableByName("ui.cimagepath"):GetRecorder(11360)
DataCommon.NullImageAsset = BeanManager.GetTableByName("ui.cimagepath"):GetRecorder(11359)
DataCommon.AgCoinActivityID = 2
DataCommon.SignManagerID = 3
DataCommon.StarMirageManagerID = 4
DataCommon.PuzzleActivityID = 5
DataCommon.SummerActivityManagerID = 6
DataCommon.RechargeActivityID = 7
DataCommon.HalloweenActivityID = 8
DataCommon.DoubleElevenActivityID = 9
DataCommon.ChristmasActivityManagerID = 10
DataCommon.BirthDayActivityManagerID = 11
DataCommon.ChristmasCallActivityManagerID = 12
DataCommon.SpringFestivalActivityManagerID = 13
DataCommon.LoverActivityManagerID = 14
DataCommon.AprilFoolsDayActivityManagerID = 15
DataCommon.ChildrenActivityManagerID = 16
DataCommon.DragonBoatFestivalActivityManagerID = 17
DataCommon.GiftOfTimeActivityManagerID = 18
DataCommon.GiftOfTimePuzzleActivityManagerID = 19
DataCommon.GiftOfTimeMazeActivityManagerID = 20
DataCommon.SummerActivityEchoesManagerID = 21
DataCommon.Activities = {}
DataCommon.Activities.StarMirage = 6001
DataCommon.Activities.SwimSuit = 9001
DataCommon.Activities.Halloween = 16001
DataCommon.Activities.Christmas = 18001
DataCommon.Activities.SpringFestival = 25001
DataCommon.Activities.Lover = 27001
DataCommon.Activities.OverseasReturnWelfareActivityId = 28001
DataCommon.Activities.ChildrenDay = 34001
DataCommon.Activities.DragonBoatFestival = 35001
DataCommon.Activities.Anniversary = 40001
DataCommon.Activities.StarMirageCopy = 47002
DataCommon.Activities.SummerEchoes = 46001
DataCommon.Activities.DoubleEleven = 19001
DataCommon.Activities.AccumulateCost = 50001
DataCommon.Activities.OldPlayerBenefits = 51001
DataCommon.Activities.MinDiscount = 53001
DataCommon.AccumulateRewards = {}
DataCommon.AccumulateRewards.StarMirage = 100
DataCommon.AccumulateRewards.StarMirageCopy = 101
DataCommon.Functions = {}
DataCommon.Functions.Mail = 1
DataCommon.Functions.Friend = 2
DataCommon.Functions.Chat = 3
DataCommon.Functions.Welfare = 4
DataCommon.Functions.Shop = 5
DataCommon.Functions.Handbook = 6
DataCommon.Functions.AssistBattle = 7
DataCommon.Functions.BattleAuto = 1011
DataCommon.Functions.BattleRetreat = 1003
DataCommon.Functions.BattlePause = 1005
DataCommon.Functions.AutoExplore = 11
DataCommon.Functions.BossRush = 12
DataCommon.Functions.Gacha = 13
DataCommon.Functions.Task_MainLine = 14
DataCommon.Functions.CourtYard = 15
DataCommon.Functions.ZoneBackToMainCity = 16
DataCommon.Functions.Resource = 42
DataCommon.Functions.Tower = 18
DataCommon.Functions.MiniMapOperate = 1001
DataCommon.Functions.Task_Every = 29
DataCommon.Functions.Dungeon_TeamInfo = 1007
DataCommon.Functions.Dungeon_Bag = 1008
DataCommon.Functions.Dungeon_SetUp = 1009
DataCommon.Functions.Dungeon_MiniMap = 1010
DataCommon.Functions.Role_SkillLevelUp = 23
DataCommon.Functions.Role_Break = 24
DataCommon.Functions.Equip_Break = 25
DataCommon.Functions.Equip_Enchant = 26
DataCommon.Functions.BattlePowerBreakOut = 27
DataCommon.Functions.Clothe = 28
DataCommon.Functions.DreamDelegateTask = 29
DataCommon.Functions.Notice = 30
DataCommon.Functions.AlterNativeRole = 31
DataCommon.Functions.Fragment = 32
DataCommon.Functions.Activity = 33
DataCommon.Functions.GrowGift = 34
DataCommon.Functions.BranchLine = 35
DataCommon.Functions.FirstReCharge = 36
DataCommon.Functions.OffLinePvp = 37
DataCommon.Functions.Equip_Unlock = 38
DataCommon.Functions.BattleLoseGuide = 40
DataCommon.Functions.Signboard = 41
DataCommon.Functions.Guild = 1012
DataCommon.Functions.UniqueEquip = 45
DataCommon.Functions.UndecidedRoad = 44
DataCommon.Functions.RoleReset = 46
DataCommon.Functions.OffLineSweep = 47
DataCommon.Functions.RuneAdvancement = 49
DataCommon.BaseMainFSM = {}
DataCommon.BaseMainFSM[1] = "WitchSkillGuide"
DataCommon.BaseMainFSM[2] = "UnloadStory"
DataCommon.BaseMainFSM[3] = "Normal"
DataCommon.BaseMainFSM[4] = "FunctionUnlock"
DataCommon.GameFSM = {}
DataCommon.GameFSM[1] = "Dungeon"
DataCommon.GameFSM[2] = "CourtYard"
DataCommon.Dialog = {}
DataCommon.Dialog[1] = "task.taskmaindialog"
DataCommon.Dialog[2] = "mainline.mainline.mainlineworlddialog"
DataCommon.Dialog[3] = "gacha.gachamaindialog"
DataCommon.Dialog[4] = "teamedit.teameditprewardialog"
DataCommon.Dialog[5] = "teamedit.teampresetmaindialog"
DataCommon.Dialog[6] = "shop.shopmaindialog"
DataCommon.Dialog[7] = "towerv2.scene.towerv2scenedialog"
DataCommon.Dialog[8] = "alchemy.alchemydialog"
DataCommon.Dialog[9] = "character.newcharacterinfodialog"
DataCommon.Dialog[10] = "dungeon.dungeonnextfloordialog"
DataCommon.Dialog[11] = "towerv2.towerv2buffchoosedialog"
DataCommon.Dialog[12] = "firefly.fireflydialog"
DataCommon.Dialog[13] = "courtcabin.cabinmaindialog"
DataCommon.Dialog[14] = "assistbattle.choosesupportroledialog"
DataCommon.Dialog[15] = "signboard.signboardmaindialog"
DataCommon.Dialog[16] = "character.characterskilldialog"
DataCommon.Dialog[17] = "friend.friendsmaindialog"
DataCommon.Dialog[18] = "activity.swimsuit.swimsuitmaindialog"
DataCommon.Dialog[19] = "equip.bagdialog"
DataCommon.Dialog[20] = "activity.giftoftime.giftoftimemaindialog"
DataCommon.Dialog[21] = "smallbattle.smallbattledialog"
DataCommon.Dialog[22] = "character.basecharacterlistalldialog"
DataCommon.Dialog[23] = "character.quicklevelup.quicklevelupsuccessdialog"
DataCommon.Group = {}
DataCommon.Group[1] = "Default"
DataCommon.WeakGuideId = 33
DataCommon.SDKLoginFail = 106
DataCommon.SDKLogoutActive = 107
DataCommon.IPServerLinkFail = 108
DataCommon.RoleEvalutionLevelMax = 3
DataCommon.GMHideUI = {}
DataCommon.GMHideUI.Dungeon = 2
DataCommon.GMHideUI.Battle = 1
DataCommon.GMHideUI.MainCity = 3
DataCommon.GainTypeEnum = {
  MainLine = 1,
  Resource = 2,
  Tower = 3,
  Shop = 4,
  Yard = 5,
  Special = 6,
  Fragment = 7,
  MainLine_NotSelect = 8,
  Resource_NotSelect = 9,
  ResourceMain = 10,
  UndecidedRoad = 11,
  Lover = 12,
  WeekBoss = 13,
  SeasonPVP = 14
}
DataCommon.ShowDialogType = {
  MonthCardDailyAward = 1,
  RoleAchievementGetShow = 2,
  ItemAccount = 3,
  MainCityFirstAward = 4,
  MainCityAccount = 5,
  TrainAccount = 6,
  MonthCardDiscount = 7,
  GainRole = 8,
  GainRoleSkin = 9,
  UniqueEquipUnlock = 10,
  AprilFoolsDayActivityItems = 11
}
DataCommon.FurnitureShopId = 13
DataCommon.CabinGoodsStatus = {
  Default = -1,
  NewAdd = 0,
  Checked = 1
}
DataCommon.CabinGoodsType = {Theme = "Theme", Furniture = "Furniture"}
DataCommon.ThemeCostCurrencyId = DataCommon.FurnitureCion
DataCommon.GrowGiftShopId = 18
DataCommon.Favour = {
  Skill = 2,
  BackgroundStory = 3,
  Voice = 4
}
DataCommon.LeaderId = 1
DataCommon.StarMirage = {
  Shop = {},
  Function = {},
  Type = {}
}
DataCommon.StarMirage.Shop.EasyId = 21
DataCommon.StarMirage.Shop.HardId = 22
DataCommon.StarMirage.Function.AccumulateRewardsId = 1
DataCommon.StarMirage.Function.ShopId = 2
DataCommon.StarMirage.Function.RoleAddId = 3
DataCommon.StarMirage.Function.RankId = 4
DataCommon.StarMirage.Function.HardId = 5
DataCommon.StarMirage.Type.Easy = 1
DataCommon.StarMirage.Type.Hard = 2
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
DataCommon.StarMirage1 = {
  [DataCommon.Activities.StarMirage] = {
    Shop = {Easy = 21, Hard = 22},
    Function = {
      AccumulateRewards = 1,
      Shop = 2,
      RoleAdd = 3,
      Rank = 4,
      Hard = 5
    },
    Type = {Easy = 1, Hard = 2}
  },
  [DataCommon.Activities.StarMirageCopy] = {
    Shop = {Easy = 54, Hard = 55},
    Function = {
      AccumulateRewards = 9,
      Shop = 10,
      RoleAdd = 11,
      Rank = 12,
      Hard = -1,
      DailySupply = 13
    },
    Type = {Easy = 1, Hard = 2},
    BattleType = CBattleStartProtocol.STARRY_MIRROR,
    Other = {ShopId = 56}
  }
}
DataCommon.SwimSuitActivity = {
  Shop = {ShopID = 26}
}
DataCommon.HalloweenActivity = {
  Shop = {ShopID = 27}
}
DataCommon.SpringFestivalActivity = {
  Shop = {ShopID = 34}
}
DataCommon.AprilFoolsDayActivity = {
  Shop = {
    ShopID = 38,
    RedClownShopID = 39,
    BlueClownShopID = 40
  }
}
DataCommon.ChildrenActivity = {
  Shop = {ShopID = 41}
}
DataCommon.GiftofTime = {
  Shop = {ShopID = 43}
}
DataCommon.Anniversary = {
  Type = {Easy = 1, Hard = 2},
  Function = {
    DailySupply = 1,
    Shop = 2,
    RoleAdd = 3,
    Rank = 4,
    DailyTask = 5,
    Hard = 6
  },
  Shop = {Easy = 44, Hard = 45},
  Other = {ShopId = 47},
  KeepMainCityBGM = tonumber(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(7).type) == 0,
  KeepFashionBtnHide = tonumber(BeanManager.GetTableByName("dungeonselect.canniversaryspecialcfg"):GetRecorder(8).type) == 0
}
DataCommon.LocalTips = {
  Resource_Mana = {
    Tag = "Resource_Mana",
    Default = -1,
    Checked = -2,
    LastTag = "Resource_Mana_last"
  },
  Resource_1 = {
    Tag = "Resource_1",
    Default = -1,
    New = 0,
    Checked = 1,
    typeId = 1
  },
  Resource_2 = {
    Tag = "Resource_2",
    Default = -1,
    New = 0,
    Checked = 1,
    typeId = 2
  },
  Resource_3 = {
    Tag = "Resource_3",
    Default = -1,
    New = 0,
    Checked = 1,
    typeId = 3
  },
  Resource_4 = {
    Tag = "Resource_4",
    Default = -1,
    New = 0,
    Checked = 1,
    typeId = 4
  },
  StarMirageUnlock = {
    Tag = "StarMirageUnlock",
    Default = -1,
    New = 0,
    Checked = -2
  },
  SwimSuitActivityUnlock = {
    Tag = "SwimSuitActivityUnlock",
    Default = -1,
    New = 0,
    Checked = -2
  },
  OpenPuzzleDialog = {
    Tag = "OpenPuzzleDialog",
    Default = -1,
    New = 0,
    Checked = -2
  },
  OpenHalloweenDialog = {
    Tag = "OpenHalloweenDialog",
    Default = -1,
    New = 0,
    Checked = -2
  },
  OpenBirthDayDialog = {
    Tag = "OpenBirthDayDialog",
    Default = -1,
    New = 0,
    Checked = -2
  },
  ChristmasActivityUnlock = {
    Tag = "ChristmasActivityUnlock",
    Default = -1,
    New = 0,
    Checked = -2
  },
  ChristmasCallActivityUnlock = {
    Tag = "ChristmasActivityCallUnlock",
    Default = -1,
    New = 0,
    Checked = -2
  },
  OpenAprilFoolsDayDialog = {
    Tag = "OpenAprilFoolsDayDialog",
    Default = -1,
    New = 0,
    Checked = -2
  },
  OpenChildrenDialog = {
    Tag = "OpenChildrenDialog",
    Default = -1,
    New = 0,
    Checked = -2
  },
  OpenDragonBoatFestivalDialog = {
    Tag = "OpenDragonBoatFestivalDialog",
    Default = -1,
    New = 0,
    Checked = -2
  },
  GuideOpenInstructionDialog_Magictree = {
    Tag = "GuideOpenInstructionDialog_Magictree",
    Default = -1,
    New = 0,
    Checked = 1,
    guideId = 16
  },
  GuideOpenInstructionDialog_Cabin = {
    Tag = "GuideOpenInstructionDialog_Cabin",
    Default = -1,
    New = 0,
    Checked = 1,
    guideId = 17
  },
  GuideOpenInstructionDialog_TrainCamp = {
    Tag = "GuideOpenInstructionDialog_TrainCamp",
    Default = -1,
    New = 0,
    Checked = 1,
    guideId = 18
  },
  GuideOpenInstructionDialog_Alchemy = {
    Tag = "GuideOpenInstructionDialog_Alchemy",
    Default = -1,
    New = 0,
    Checked = 1,
    guideId = 19
  },
  GuideOpenInstructionDialog_Explore = {
    Tag = "GuideOpenInstructionDialog_Explore",
    Default = -1,
    New = 0,
    Checked = 1,
    guideId = 20
  },
  GuideOpenInstructionDialog_Firefly = {
    Tag = "GuideOpenInstructionDialog_Firefly",
    Default = -1,
    New = 0,
    Checked = 1,
    guideId = 21
  },
  GuideOpenInstructionDialog_YardMusic = {
    Tag = "GuideOpenInstructionDialog_YardMusic",
    Default = -1,
    New = 0,
    Checked = 1,
    guideId = 22
  },
  GuideOpenInstructionDialog_RuneAdvancement = {
    Tag = "GuideOpenInstructionDialog_RuneAdvancement",
    Default = -1,
    New = 0,
    Checked = 1,
    guideId = 23
  },
  LimitedInvestmentOpen = {
    Tag = "LimitedInvestmentOpen",
    Default = -1,
    New = 0,
    Checked = -2
  },
  MonthSignOpen = {
    Tag = "MonthSignOpen",
    Default = -1,
    New = 0,
    Checked = 1
  },
  Anniversary = {
    Tag = "Anniversary",
    Default = -1,
    New = 0,
    Checked = 1
  },
  StarMirageCopy = {
    Tag = "StarMirageCopy",
    Default = -1,
    New = 0,
    Checked = 1
  },
  SummerEchoesChallengeFirstOpen = {
    Tag = "SummerEchoesChallengeFirstOpen",
    Default = -1,
    New = 0,
    Checked = 1
  },
  SummerEchoesChallengeFirstVictory = {
    Tag = "SummerEchoesChallengeFirstVictory",
    Default = -1,
    New = 0,
    Checked = 1
  }
}
local CActivityMidAutumnRe = BeanManager.GetTableByName("activity.cactivitymidautumnre")
local allIds = CActivityMidAutumnRe:GetAllIds()
DataCommon.MidAutumnTimeLines = {}
for i = 1, #allIds do
  local key = "OpenMidAutumnDialog_" .. allIds[i]
  DataCommon.LocalTips[key] = {
    Tag = key,
    Default = -1,
    New = 0,
    Checked = -2
  }
  local activityMidAutumnReRecord = CActivityMidAutumnRe:GetRecorder(allIds[i])
  DataCommon.MidAutumnTimeLines[activityMidAutumnReRecord.TimelineId] = allIds[i]
end
DataCommon.LocalCache = {
  StarMirageOpenType = {
    Tag = "StarMirageOpenType",
    Default = DataCommon.StarMirage.Type.Easy
  },
  OpenUpdateJumpStoreDialog = {
    Tag = "OpenUpdateJumpStoreDialog",
    Default = 0
  },
  LimitedInvestmentActId = {
    Tag = "LimitedInvestmentActId",
    Default = 0
  },
  LastBodyAdvancedDailyReminder = {
    Tag = "LastBodyAdvancedDailyReminder",
    Default = 0
  },
  AnniversaryOpenType = {
    Tag = "AnniversaryOpenType",
    Default = DataCommon.Anniversary.Type.Easy
  },
  PopUpGiftAutoOpenType = {
    Tag = "PopUpGiftAutoOpenType",
    Default = 0,
    First = 1,
    Second = 2,
    Third = 3
  },
  PopUpGiftAutoOpenActId = {
    Tag = "PopUpGiftAutoOpenActId",
    Default = 0
  },
  PopUpGift7DayAutoOpenType = {
    Tag = "PopUpGift7DayAutoOpenType",
    Default = 0,
    First = 1,
    Second = 2,
    Third = 3
  },
  PopUpGift7DayAutoOpenActId = {
    Tag = "PopUpGift7DayAutoOpenActId",
    Default = 0
  },
  StarMirageCopyOpenType = {
    Tag = "StarMirageCopyOpenType",
    Default = DataCommon.StarMirage1[DataCommon.Activities.StarMirageCopy].Type.Easy
  }
}
DataCommon.UniqueEquipShopId = 25
DataCommon.AccumulationShopId = 4
DataCommon.ItemType = {UniqueEquip = 107}
DataCommon.DrawCardType = {Role = 1, Equip = 2}
local CPlayerLevel = BeanManager.GetTableByName("role.cplayerlevel")
local allIds = CPlayerLevel:GetAllIds()
DataCommon.MaxPlayerLevel = CPlayerLevel:GetRecorder(allIds[#allIds]).id
DataCommon.TextLimit = {
  CharacterName = 1,
  CharacterIntroduction = 6,
  TeamName = 2,
  GuildName = 3,
  GuildIntroduction = 7,
  CabinName = 4,
  DIYThemeName = 5
}
DataCommon.GeneralCollectionActFuncType = 9
DataCommon.GiftofTimeActFuncType = 18
DataCommon.TaskShopActFuncType = 19
DataCommon.HalloweenTimeLineId = 2014
DataCommon.ChristmasTimeLineId = 2016
DataCommon.ChristmasChatDialogId = 26
DataCommon.ReturnWelfarePopTips = 2022
DataCommon.BirtDayTimeLineId = {}
DataCommon.BirtDayTimeLineId[120001] = 2017
DataCommon.BirtDayTimeLineId[120002] = 2018
DataCommon.BirtDayTimeLineId[120003] = 2019
DataCommon.BirtDayTimeLineId[120004] = 2020
DataCommon.BirtDayTimeLineId[120005] = 2021
DataCommon.DragonBoatFestivalTimeLineId = 2037
DataCommon.ChristmasCallTimeLineId = 2034
DataCommon.AprilFoolsDayTimeLineId = 2035
DataCommon.ChildrenDayTimeLineId = 2036
DataCommon.SummerEchoesTimeLineId = 2044
DataCommon.StarMirageCopyTimeLineId = 2045
DataCommon.ChannelID_MarketPkg = {
  [130005] = {
    marketPkg = "com.huawei.appmarket",
    packageurl = "https://fusdmndlf.leiting.com/full/rw_0.8.0_huawei_sdkV3.0.5_20220217200802553.apk",
    appurl = "https://appgallery.huawei.com/#/app/C102320507"
  },
  [130002] = {
    marketPkg = "com.oppo.market",
    packageurl = "https://storedl.nearme.com.cn/apk/202202/18/1e8a712ea44eee6263e2473af26a6b54.apk",
    appurl = "https://storedl.nearme.com.cn/apk/202202/18/1e8a712ea44eee6263e2473af26a6b54.apk"
  },
  [130008] = {
    marketPkg = "com.bbk.appstore",
    packageurl = "http://appstore.vivo.com.cn/appinfo/downloadApkFile?id=2951246",
    appurl = "https://game.vivo.com.cn/#/detail/75649/?source=2&share_channel=031%7C008%7C01%7C001"
  },
  [110006] = {
    marketPkg = "com.xiaomi.market",
    packageurl = "http://file.market.xiaomi.com/download/AppStore/0849f61e8ff4044089db01bdfc96c065017f18888/com.leiting.fsdmn.mi_0.8.0.apk",
    appurl = "https://game.wali.com/game/62296792"
  },
  [110003] = {
    marketPkg = "cn.ninegame.gamemanager",
    packageurl = "http://downali.game.uc.cn/wm/15/15/rw_0.8.0_uc_sdkV3.0.5_20220217200802553_39206575_185138e355e2.apk",
    appurl = "http://a.9game.cn/fsdmn"
  },
  [130009] = {
    marketPkg = "com.m4399.gamecenter",
    packageurl = "https://fusdmndlf.leiting.com/full/rw_0.8.0_4399_sdkV3.0.5_20220217200532726.apk",
    appurl = "http://a.4399.cn/game-id-143938.html"
  },
  [130061] = {
    marketPkg = "tv.danmaku.bili",
    packageurl = "https://pkg.biligame.com/games/fsdmn_0.8.0_20220221_080002_ddf26.apk",
    appurl = "https://app.biligame.com/page/detail_share.html?id=104744&sourceFrom=23006&_1629099079012"
  }
}
DataCommon.Media_URL = {
  M150480 = "https://www.taptap.com/app/170102",
  M150481 = "https://www.3839.com/a/114434.htm",
  [""] = "https://rw.leiting.com"
}
DataCommon.StartForceUpdate = true
DataCommon.StartForceUpdateGuide = false
local ForceUpdateCfg = BeanManager.GetTableByName("var.cforceupdate")
DataCommon.version_forceUpdate = {
  Android = ForceUpdateCfg:GetRecorder(4).Version,
  iOS = ForceUpdateCfg:GetRecorder(3).Version
}
DataCommon.version_forceUpdateGuide = {
  Android = ForceUpdateCfg:GetRecorder(2).Version,
  iOS = ForceUpdateCfg:GetRecorder(1).Version
}
DataCommon.apple_URL = "https://apps.apple.com/cn/app/%E5%A4%8D%E8%8B%8F%E7%9A%84%E9%AD%94%E5%A5%B3/id1504369739"
DataCommon.apple_URL_EN = "https://apps.apple.com/us/app/revived-witch/id1554968811"
DataCommon.apple_URL_KR = "https://apps.apple.com/kr/app/id1579628318"
DataCommon.android_URL_EN = "https://play.google.com/store/apps/details?id=com.YoStarEN.RevivedWitch"
DataCommon.android_URL_KR = "https://play.google.com/store/apps/details?id=com.YoStarKR.RevivedWitch"
DataCommon.BackPressed_NotResponse = 0
DataCommon.BackPressed_SkipResponse = 1
DataCommon.BirtDayShopID = 31
DataCommon.ChristmasCallShopID = 33
DataCommon.Christmas = {
  Shop = {
    ExpressiveForce = 28,
    Sing = 29,
    Jump = 30
  },
  Function = {
    Eat = 18001501,
    Bag = 18001701,
    Mail = 18001901
  }
}
DataCommon.DragonBoatFestivalShopID = 42
DataCommon.Lover = {
  Shop = {TownCurrency = 35, Chocolate = 36}
}
DataCommon.Shop = {OverseasReturnWelfare = 37}
DataCommon.CommonActivity = {
  Shop = {ShopId = 48}
}
DataCommon.SummerEchoesShopID1 = 51
DataCommon.SummerEchoesShopID2 = 52
DataCommon.SummerEchoesShopID3 = 53
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
DataCommon.SummerEchoesChatId_FirstOpenChallenge = CSRFunction:GetRecorder(46001601).sectionID
DataCommon.SummerEchoesChallengeBlockId = 18
DataCommon.SummerNewShopID = 57
DataCommon.SummerEchoesBGM = 1324
DataCommon.DoubleElevenShopID = 59
DataCommon.GetTextureCount = 20
DataCommon.ActivityEnum = {ReturnBattlePass = 805}
DataCommon.ReturnBattlePass_MailId = 1051
DataCommon.ReturnBattlePass_RoleSelectItemId = 31720
return DataCommon
