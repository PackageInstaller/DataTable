-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redpoint/model/RedPointModel.lua

module("logic.extensions.redpoint.model.RedPointModel", package.seeall)

local RedPointModel = class("RedPointModel", BaseModel)

RedPointModel.ID_MAIN_TASK = 1
RedPointModel.ID_BRANCH_TASK = 2
RedPointModel.ID_GROW_TASK = 3
RedPointModel.ID_DAILY_TASK = 4
RedPointModel.ID_WEEKLY_TASK = 5
RedPointModel.ID_FRIEND = 6
RedPointModel.ID_EGG = 8
RedPointModel.ID_MOFANG = 9
RedPointModel.ID_ARENA = 10
RedPointModel.ID_WTower = 12
RedPointModel.ID_PLAYER_INFO = 21
RedPointModel.ID_PLAYER_TITLE = 22
RedPointModel.ID_GetSUPPLY = 24
RedPointModel.ID_SEVENDAYS = 25
RedPointModel.ID_TREASUREOX = 58
RedPointModel.ID_FAMILY_DONATE = 28
RedPointModel.ID_RANKRACE = 30
RedPointModel.ID_FAMILY_BOSS = 33
RedPointModel.ID_RANKRACELIMIT = 34
RedPointModel.ID_PETDISPATCH = 35
RedPointModel.ID_KINGWAY = 40
RedPointModel.ID_STARTEAM = 41
RedPointModel.ID_PETPOSTER = 43
RedPointModel.ID_PETPOSTER_RELATION = "ID_PETPOSTER_RELATION"
RedPointModel.ID_SxGame = 45
RedPointModel.ID_RESCOPY1 = 36
RedPointModel.ID_RESCOPY2 = 37
RedPointModel.ID_RESCOPY3 = 38
RedPointModel.ID_RESCOPY4 = 39
RedPointModel.ID_YEAR = 46
RedPointModel.ID_PAYSHOPMIBAO = 48
RedPointModel.ID_SCRATCH = 50
RedPointModel.ID_TOTALRECHARGE = 55
RedPointModel.ID_TOFIRSTCHARGE = 98
RedPointModel.ID_TOFIRSTCHARGE_GIFT = 99
RedPointModel.ID_TOFIRSTCHARGE_PLUS = 534
RedPointModel.ID_TOFIRSTCHARGE_GIFT_PLUS = 536
RedPointModel.ID_FLYNUO = 57
RedPointModel.ID_TEACHING = 59
RedPointModel.ID_MONTHCARD = 60
RedPointModel.ID_HIGH_TITLE = 62
RedPointModel.ID_GOODFEEL = 68
RedPointModel.ID_TIMECAPSULE = 69
RedPointModel.ID_THRONE_ACHIEVE = 71
RedPointModel.ID_AOCORE = 64
RedPointModel.ID_VIP = 72
RedPointModel.ID_DREAMCHAT = 80
RedPointModel.ID_JigSAW = 86
RedPointModel.ID_DREAMTEAM = 91
RedPointModel.ID_SCUFFLE_TASK = 113
RedPointModel.ID_SCUFFLE_REWARD = 114
RedPointModel.ID_DarkDragonKnife = 137
RedPointModel.ID_CYNTHIABUFF = 146
RedPointModel.ID_GROWUP_XINXIN = 160
RedPointModel.ID_GROWUP_NIANNIAN = 161
RedPointModel.ID_WUMMONTOWER_REWARDS = 168
RedPointModel.ID_YEARCARD_PREHEAT = 183
RedPointModel.ID_YEARCARD_SIGNIN = 188
RedPointModel.ID_YEARCARD2022 = 190
RedPointModel.ID_GODDESSWAKEN_EXIST_REWARD = 221
RedPointModel.ID_ANNIMATCH_TASK_REWARD = 223
RedPointModel.ID_FAMILY_TASK = 246
RedPointModel.ID_ROLE_RELATIONSHIP_PRIZE = 253
RedPointModel.ID_HOLY_STRIPE_COPY = 284
RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX = 299
RedPointModel.ID_SAINTKNIGHTMO_PRIZE = 306
RedPointModel.ID_HOLY_STRIPE_EXPLORE_EXIT_TIME = 313
RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_PRIZE = 314
RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_HELP = 322
RedPointModel.ID_PASSPORT_CAMP_TASK = 328
RedPointModel.ID_PASSPORT_CAMP_PRIZE = 329
RedPointModel.ID_FUN_CAMP_ROLE_RELATION = 334
RedPointModel.ID_LONGZUN_CHALLENGE = 343
RedPointModel.ID_CODE_WORD = 350
RedPointModel.ID_ACTIVITY_TASK = 409
RedPointModel.ID_WISHTREE_TASK = 427
RedPointModel.ID_PASSPORT_NEWYEAR_TASK = 429
RedPointModel.ID_DANCING_LION_JUMP = 436
RedPointModel.ID_YEARCARD2023 = 438
RedPointModel.ID_YEARCARD2023_SIGNIN = 439
RedPointModel.ID_YEARCARD_PREHEAT2023_GAME = 440
RedPointModel.ID_YEARCARD_PREHEAT2023_PTRIZE = 441
RedPointModel.ID_CAIQINGDRAW_TASK = 445
RedPointModel.ID_COLLECTBLESSING_TASK = 447
RedPointModel.ID_DANCING_LION_JUMP_TASK = 448
RedPointModel.ID_ROMANTIC_TASK = 450
RedPointModel.ID_PTELITOPEXHIBITIONKUDO = 455
RedPointModel.ID_PASSPORT_GUARDCITY = 463
RedPointModel.ID_WORLD_PROGRESS_TASK = 474
RedPointModel.ID_GOLDENDTEN_TASK = 476
RedPointModel.ID_YISHI = 462
RedPointModel.ID_RECASTGLORYTASK = 467
RedPointModel.ID_CUTEPET_GUEST = 493
RedPointModel.ID_CUTEPET_ADVENTURE = 494
RedPointModel.ID_FANRUILOTTERY = 508
RedPointModel.ID_NEVERLANDTASK = 510
RedPointModel.ID_DIVINECIYUAN = 512
RedPointModel.ID_PASSPORT_DESTROYEVIL = 533
RedPointModel.ID_NEWBREAKFORMATION_PRIZE = 540
RedPointModel.ID_SUMMONMASTERJI_LOGIN = 571
RedPointModel.ID_KINDERGARTEN_TASK = 470
RedPointModel.ID_STARSCRATCH_TASK = 476
RedPointModel.ID_DRAGONPSYCHICCLG_EGG = 563
RedPointModel.ID_MIRACLE_HERO_PET_LEVEL_UP = 588
RedPointModel.ID_YOUNG_CHAMPION_KING_GAIN_COIN = 598
RedPointModel.ID_EVENT_TASK_DOMADV = 617
RedPointModel.ID_PASSPORT_DOMADV = 618
RedPointModel.ID_FUSION_SOUL_PRIZE = 716
RedPointModel.ID_ORIGINAGE_INVITE_PRIZE = 737
RedPointModel.ID_MMTEAM_PASSPORT = 779
RedPointModel.ID_REPAIR_CHANNEL = 781
RedPointModel.ID_ABYSS_GOLD_RUSH_TASK = 793
RedPointModel.ID_NINEPLACE_BATTLE = -10
RedPointModel.ID_UPGRADE_NINEPLACE = -11
RedPointModel.ID_PETTEAMS = -13
RedPointModel.ID_FAMILY_ESCORT = -14
RedPointModel.ID_WORLD_BOSS = -15
RedPointModel.ID_JACKDRAW = -18
RedPointModel.ID_THRONE = -19
RedPointModel.ID_NINEPLACE_CAN_UNLOCK = -20
RedPointModel.ID_StarGodPlus = -21
RedPointModel.ID_SCENARIOCOPY = -22
RedPointModel.ID_ONEPEOPLECOPY = -23
RedPointModel.ID_ActivityExchangShop_FlyNuo = -24
RedPointModel.ID_ActivityExchangShop_Summary = -25
RedPointModel.ID_PayShopHUD = -26
RedPointModel.ID_ActivityExchangShop_MZD = -27
RedPointModel.ID_ANLONGCOPY = -28
RedPointModel.ID_SCENARIOCOPY_NUOYA = -29
RedPointModel.ID_TEACHING_DAILY = -30
RedPointModel.ID_Custom_MonthCard = -31
RedPointModel.ID_WholeLifeCard = -32
RedPointModel.ID_ResMonthCard = -33
RedPointModel.ID_ChallengeCard = -34
RedPointModel.ID_MengxinCard = -35
RedPointModel.ID_DiamondShopReset = -36
RedPointModel.ID_HappyLemon = -37
RedPointModel.ID_BEJ_DOT1 = -38
RedPointModel.ID_WLTOWERRED = -39
RedPointModel.ID_Longnv_Daily = -40
RedPointModel.ID_ACETEAM_HUD = -41
RedPointModel.ID_ACETEAM_PRIZE = -42
RedPointModel.ID_ACETEAM_EXCHANGE = -43
RedPointModel.ID_SCENARIOCOPY_ONE = -44
RedPointModel.ID_SCENARIOCOPY_SCTRIAL_BUFF = -45
RedPointModel.ID_SCENARIOCOPY_SHOP = -46
RedPointModel.ID_SCENARIOCOPY_SCTRIAL_ENERGY = -47
RedPointModel.ID_TIME_WHEEL = -65
RedPointModel.ID_XINXIYA = -66
RedPointModel.ID_GOLDENDIAMONDCARD = -67
RedPointModel.ID_PAYTRUSSMAINHUDFIRSTCLICK = -68
RedPointModel.ID_TONGBATTLE = -69
RedPointModel.ID_DRESSSHOPADDNEWGOODSITEM = -70
RedPointModel.ID_TREASUREBASIN = -152
RedPointModel.ID_TWINDRAGRONCHALLENGE = -153
RedPointModel.ID_GRANDSUMMARYONE = -154
RedPointModel.ID_GRANDSUMMARYTWO = -155
RedPointModel.ID_GRANDSUMMARYTHREE = -156
RedPointModel.ID_GRANDSUMMARYFOUR = -157
RedPointModel.ID_PETNEWNOTICE = -158
RedPointModel.ID_DREAMYOUTH = -159
RedPointModel.ID_BIRTH_TAB_1 = -160
RedPointModel.ID_BIRTH_TAB_2 = -161
RedPointModel.ID_BIRTH_TAB_3 = -162
RedPointModel.ID_BIRTH_TAB_4 = -163
RedPointModel.ID_BIRTH_TAB_5 = -164
RedPointModel.ID_BIRTH_TAB_6 = -165
RedPointModel.ID_BIRTH_TAB_7 = -166
RedPointModel.ID_BIRTH_TAB_8 = -167
RedPointModel.ID_BACKTASK = -168
RedPointModel.ID_GATHER_TASK_NPC = -169
RedPointModel.ID_MOONKINGRED = -170
RedPointModel.ID_NEWHANDWALFARE = -171
RedPointModel.ID_CHUANG_KONG_PLOT = -172
RedPointModel.ID_CHUANG_KONG_TRIAL = -173
RedPointModel.ID_CHUANG_KONG_TASK = -174
RedPointModel.ID_BIRTH_LIKE = -175
RedPointModel.ID_BIRTH_SIGN_IN = -176
RedPointModel.ID_YEARCARD_LOTTERY = -177
RedPointModel.ID_DREAMTEAMHUD_FOURTH = -178
RedPointModel.ID_DREAMTEAMHUD_AX = -179
RedPointModel.ID_DREAMTEAMHUD_AH = -180
RedPointModel.ID_DREAMTEAMHUD_RX = -181
RedPointModel.ID_DREAMTEAMHUD_LJ = -182
RedPointModel.ID_DREAMTEAMHUD_DL = -183
RedPointModel.ID_DRAGONTRAIL_DAILY = -184
RedPointModel.ID_DRAGONTRAIL_EXCHANGESHOP = -185
RedPointModel.ID_DREAMTEAMHUD_SECOND = -186
RedPointModel.ID_DREAMTEAMHUD_THIRD = -187
RedPointModel.ID_PAYTRUSSMAINHUDFIRSTCLICKTWO = -188
RedPointModel.ID_PET_SKIN_GOTO = -189
RedPointModel.ID_GRANDSUMMARYFIVE = -190
RedPointModel.ID_DRAGONLOTTERY = -191
RedPointModel.ID_PETAWAKENVERDAYFIRSTCLICK = -192
RedPointModel.ID_RECHARGEJUMPHUODOT = -193
RedPointModel.ID_PAYTRUSSGODGEMMAINHUDFIRSTCLICK = -194
RedPointModel.ID_IDLEGAME_START = -195
RedPointModel.ID_PETAWAKENVERACTFIRSTCLICK = -196
RedPointModel.ID_INIFITEJIGSAW_PUZZLE = -197
RedPointModel.ID_GODDESSVOTE = -198
RedPointModel.ID_GODDESSDELICACY = -199
RedPointModel.ID_GODDESS_COLLECT_WHOLELIFE = -200
RedPointModel.ID_GODDESSWAKEN = -201
RedPointModel.ID_XINGJIANGPK = -202
RedPointModel.ID_XiaoNuoWeeklyPrize = -203
RedPointModel.ID_FLOWERGODDESSHAVEITEMS = -204
RedPointModel.ID_ANNUALACTIVITY = -205
RedPointModel.ID_JISUMMONER = -206
RedPointModel.ID_HUD_OFFLINE = -207
RedPointModel.ID_HUD_OFFLINE_TAB_1 = -208
RedPointModel.ID_HUD_OFFLINE_TAB_2 = -209
RedPointModel.ID_HUD_OFFLINE_TAB_3 = -210
RedPointModel.ID_HUD_OFFLINE_TAB_4 = -211
RedPointModel.ID_HUD_OFFLINE_TAB_5 = -212
RedPointModel.ID_HUD_FIREWORK = -213
RedPointModel.ID_HUD_ENDLESS = -214
RedPointModel.ID_FORCE_SLIDE = -215
RedPointModel.ID_WEAKPATHFINDING_GOTO = -216
RedPointModel.ID_MONTHCARDS_PACK = -217
RedPointModel.ID_FAMILYCALLORDER = -218
RedPointModel.ID_DISCOUNTDRESSGIFT = -219
RedPointModel.ID_CRAZY_PARTNER_TASK = -220
RedPointModel.ID_CRAZY_PARTNER = -221
RedPointModel.ID_PREFERENTIAL_RECOMMEND_JUMP_WEEKLY_1 = -222
RedPointModel.ID_PREFERENTIAL_RECOMMEND_JUMP_WEEKLY_2 = -223
RedPointModel.ID_BIRTH_SIGN_IN_TWO = -224
RedPointModel.ID_BIRTH_SIGN_IN_THREE = -225
RedPointModel.ID_ESCORT_OTHER = -226
RedPointModel.ID_DISCOUNTDRESS_MOOR = -227
RedPointModel.ID_LUCKDRAW_TIMESTATE = -228
RedPointModel.ID_LUCKDRAW_POINTSTATE = -229
RedPointModel.ID_LUCKDRAW_TIMESTATEAdd = -230
RedPointModel.ID_FAMILYWARRED = -231
RedPointModel.ID_HUD_VIRETA = -232
RedPointModel.ID_VIRETA_CHALLENGE = -233
RedPointModel.ID_HOLY_STRIPE_COPY_ENTER = -234
RedPointModel.ID_SUMMERDOUBLE = -235
RedPointModel.ID_PET_RANK = -236
RedPointModel.ID_FIRE_POWER = -238
RedPointModel.ID_ANNUALWELFARE = -242
RedPointModel.ID_SUMMER_LOTTERY_LOGIN = -239
RedPointModel.ID_OP220701_1 = -240
RedPointModel.ID_OP220701_2 = -241
RedPointModel.ID_PetGainPrize1 = -243
RedPointModel.ID_LAILISI_DAY = -244
RedPointModel.ID_SAINTKNIGHTMO_WEEK = -246
RedPointModel.ID_SAINTKNIGHTTASK_DAY = -247
RedPointModel.ID_SAINTKNIGHTTASK_WORLD_TASK_FIRST = -248
RedPointModel.ID_SAINTKNIGHTTASK_PERSON_TASK_FIRST = -249
RedPointModel.ID_GROUP_RECHARGE_INVITE = -250
RedPointModel.ID_GROUP_RECHARGE_ONCE = -251
RedPointModel.ID_FESTIVE_FLOWER_ONCE = -252
RedPointModel.ID_SAINTKNIGHTTASK_WORLD_TASK_CAN_GAIN_PRIZE = -253
RedPointModel.ID_Custom_MonthCard2020 = -254
RedPointModel.ID_SAINTKNIGHT_RUI_GAME = -255
RedPointModel.ID_SAINTKNIGHT_TIAN_OPEN = -256
RedPointModel.ID_PALADINBATTLE_RED = -257
RedPointModel.ID_PALADINSUMMARYFEATURE = -258
RedPointModel.ID_Custom_ResMonthCardId2022 = -260
RedPointModel.ID_LINKAGE_PV = -261
RedPointModel.ID_LINKAGE_DOCUMENTARY = -262
RedPointModel.ID_VERSIONGIFT_RED = -263
RedPointModel.ID_LINKAGE_ONCE = -264
RedPointModel.ID_COLLECTING_RACE = -265
RedPointModel.ID_GRANDSUMMARYFIVE = -266
RedPointModel.ID_SUMMARY_CULTURAL = -267
RedPointModel.ID_LINKAGE_TVSHOW = -268
RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_BOSS = -269
RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_STAGE = -270
RedPointModel.ID_KINGDRAGON_LANDINGONCE_RED_UNIT = -271
RedPointModel.ID_FUN_CAMP_DAILY = -275
RedPointModel.ID_FUN_CAMP_RANK = -276
RedPointModel.ID_FRIEND_NO_READ = -280
RedPointModel.ID_SUMMARY_DRAGONANCESTOR_NEWTAB = -281
RedPointModel.ID_LINKAGE_SKIN_INTRO = -285
RedPointModel.ID_LINKAGE_SHOWREWARD = -286
RedPointModel.ID_PARTYFOOD_RED = -287
RedPointModel.ID_PARTYFOOD = -288
RedPointModel.ID_TUTOR_BASETASK_STU = -289
RedPointModel.ID_TUTOR_PUZZLETIMES_STU = -290
RedPointModel.ID_TUTOR_PUZZLETIMES_TEA = -291
RedPointModel.ID_TUTOR_SETLEASE_TEA = -292
RedPointModel.ID_TUTOR_NOTIFYPUBLICTASK_STU = -293
RedPointModel.ID_TUTOR_NOTPUBLICTASK_TEA = -294
RedPointModel.ID_MONTHCARDBACK_RED = -295
RedPointModel.ID_LIUDAOMAIN_RED = -296
RedPointModel.ID_XIUNUOBROTHERHOOD_RED = -297
RedPointModel.NSOP_MUSIC_CAN_PLAY = -298
RedPointModel.ID_BROTHER_GROUP_INVITE_RED = -299
RedPointModel.NSOP_MUSIC_PRIZE = -300
RedPointModel.ID_QINGGUHUD_ENTER_EXCHENGE = -301
RedPointModel.ID_MIYACHALLENGE_ENTER = -302
RedPointModel.ID_NUOYA_LANDINGONCE_RED_BOSS = -303
RedPointModel.ID_NUOYA_LANDINGONCE_RED_STAGE = -304
RedPointModel.ID_NUOYA_LANDINGONCE_RED_UNIT = -305
RedPointModel.ID_PT_TOP_FIRSTRED = -306
RedPointModel.ID_AOCORE_DIVINE = -307
RedPointModel.ID_PT_QUA_REWARD_ONCE = -308
RedPointModel.ID_Family_Escort = -309
RedPointModel.ID_DoubleEleven = -310
RedPointModel.ID_RUN_GAME_CAN_PLAY = -311
RedPointModel.ID_WISH_TREE_CAN_WISH = -312
RedPointModel.ID_PT_RED_DAILY_ELIOPEN = -313
RedPointModel.ID_TREASURE_DEFENDNEW = -314
RedPointModel.ID_WHEELFORTUNE_OPEN = -315
RedPointModel.ID_CAIQINGDRAW_TENLOTTERY = -316
RedPointModel.ID_COLLECTBLESSING_CAN_LOTTERY = -317
RedPointModel.ID_KCYC_EXT_BUFF = -318
RedPointModel.ID_COLLECTBLESSING_DAILY_RED = -319
RedPointModel.FightAgainstLandlordsSupplyCanGain = -320
RedPointModel.ID_DANCING_LION_JUMP_LEVEL = -321
RedPointModel.ID_RECASTGLORYSHI = -322
RedPointModel.ID_RECASTGLORYSHIELD = -323
RedPointModel.ID_RECASTGLORYSWORD = -324
RedPointModel.ID_GROUPREDPACK_CAN_GRAB = -325
RedPointModel.ID_RECASTGLORY_BREAKTHROUGH = -326
RedPointModel.ID_GODDESS_CONTEST_VOTE_GODDESS = -327
RedPointModel.ID_GODDESS_CONTEST_VOTE_LEADER = -328
RedPointModel.ID_DUALDRAGON_UNIVERSAL = -329
RedPointModel.ID_DUALDRAGON_EXTREME_REWARD = -330
RedPointModel.ID_ANNIVERSARYKOI_NUMBER = -331
RedPointModel.ID_ANNIVERSARYKOI_RECORD = -332
RedPointModel.ID_HOLYLIGHT_PET_SHOP_REFRESH_TIMES = -333
RedPointModel.ID_ANNUALWELFARE_GOLDENDIAMONDCARD = -334
RedPointModel.ID_HONOUR_TOWER = -335
RedPointModel.ID_PETCARDLOTTERY_SELECT = -336
RedPointModel.ID_PETCARDLOTTERY_PRIZE = -337
RedPointModel.ID_SUNWUKONGCHALLENGE_DAILY_OPEN = -338
RedPointModel.ID_SUNWUKONGCHALLENGE_NEW_CIMELIA = -339
RedPointModel.ID_SUMMERDOUBLE_FIRST_OPEN = -340
RedPointModel.ID_POWERPILLA_BUFF_CAN_UPDATE = -341
RedPointModel.ID_STRONGERTAB_TOTAL_RED = -342
RedPointModel.ID_PLANETARIUM_REWARD = -343
RedPointModel.ID_SEEKFOOD_TOTALFOOD = -344
RedPointModel.ID_SEEKFOOD_CANPRIZE = -345
RedPointModel.ID_SAINTKNIGHTTASK_TWO = -346
RedPointModel.ID_SUMMERHOLIDAY_GAIZHANG = -347
RedPointModel.ID_CUTEPET_INTRODUCE_TAB_1 = -348
RedPointModel.ID_CUTEPET_INTRODUCE_TAB_2 = -349
RedPointModel.ID_CUTEPET_INTRODUCE = -350
RedPointModel.ID_CUTEPET_MANAGEMENT = -351
RedPointModel.ID_TUNTIAN_CHALLENGE_NORMAL = -352
RedPointModel.ID_TUNTIAN_CHALLENGE_EXTREME = -353
RedPointModel.ID_ANNUALWELFARE_GOLDENDIAMONDCARD2 = -354
RedPointModel.ID_ETERNAL_DRAGON_WATER = -355
RedPointModel.ID_ETERNAL_DRAGON_DISPEL = -356
RedPointModel.ID_ETERNAL_DRAGON_CUT = -357
RedPointModel.ID_ETERNAL_CHALLENGE_BUFF = -358
RedPointModel.ID_ETERNAL_CHALLENGE_PET = -359
RedPointModel.ID_DRAGONPOOL_REWARD = -360
RedPointModel.ID_PK_SETFMT_RED = -361
RedPointModel.ID_ETER_HOLYDRAGON_VERIFY = -362
RedPointModel.ID_FANRUI_LOTTERY_LOTTERYABLE = -363
RedPointModel.ID_LINK_GAME_NEW_LEVEL = -364
RedPointModel.ID_KUNLUNCHALLENGE_NORMAL_CLG_TIMES = -365
RedPointModel.ID_DISCOUNTDRESS_COLLECTPRIZE = -366
RedPointModel.ID_Kingji_Courier = -367
RedPointModel.ID_Kingji_Soul = -368
RedPointModel.ID_Kingji_Mix = -369
RedPointModel.ID_CUTEPET_ADVENTURE_ONEKEY = -370
RedPointModel.ID_ADMIREMOON = -371
RedPointModel.ID_WuDiClg_Ext = -372
RedPointModel.ID_WuDiClg_Nor = -373
RedPointModel.ID_NumberPuzzleGame_Nor = -374
RedPointModel.ID_Popularity_Login = -375
RedPointModel.ID_HonourTower_XR = -376
RedPointModel.ID_WISHTREEBOTTLE = -377
RedPointModel.ID_Farnas_NorPrize = -388
RedPointModel.ID_Farnas_ExtPrize = -389
RedPointModel.ID_FAMILY_PARTY = -390
RedPointModel.ID_FAMILY_MGR_PARTY = -391
RedPointModel.ID_ELIZABETHGAME_TIME = -400
RedPointModel.ID_PICKUPIDEA_STORY = -401
RedPointModel.ID_THREEELIMINATION_LEVEL = -402
RedPointModel.ID_BADGE_COMPOSE = -403
RedPointModel.ID_KingSpaceDragon_Daily = -404
RedPointModel.ID_DivineasheslessDragon_Daily = -405
RedPointModel.ID_GoHomeTabFrameWorkMainView = -406
RedPointModel.ID_EQUIPRECYCLE = -407
RedPointModel.ID_GoddessContestCardDayOnceRed = -408
RedPointModel.ID_SummonMasterJiNormalBuffDaily = -409
RedPointModel.ID_Treasureraider_10Min = -410
RedPointModel.ID_ETERNAL_FARM_SELL = -411
RedPointModel.ID_Xplan_Archives = -412
RedPointModel.ID_First_GameSetViewSharetask = -413
RedPointModel.ID_MiracleFindTreasure = -414
RedPointModel.ID_PETCARDLOTTERY_DAILY = -415
RedPointModel.ID_YOUNG_CHAMPION_KING_SCHEDULE = -416
RedPointModel.ID_YOUNG_CHAMPION_KING_MY_SCHEDULE = -417
RedPointModel.ID_First_GameSetViewFormBond = -418
RedPointModel.ID_ElvesRevealed_TAB_COUNT_CHANGE = -419
RedPointModel.ID_DOMADV_GLOBAL_PRIZE = -420
RedPointModel.ID_Custom_MonthCard2024 = -421
RedPointModel.ID_Custom_ResMonthCardId2024 = -422
RedPointModel.ID_MONTHCARDBACK_RED_2024 = -423
RedPointModel.ID_Revive_Elizabeth_Daily_First_Open = -424
RedPointModel.ID_KINGARENA_SEASON_PRIZE = -425
RedPointModel.ID_TONG_LIN_SHI_JI_DAILY = -426
RedPointModel.ID_TONG_LIN_SHI_JI_NOR_REWARD = -427
RedPointModel.ID_TONG_LIN_SHI_JI_EXT_REWARD = -428
RedPointModel.ID_COLLECTING_RACE_ONE = -440
RedPointModel.ID_COLLECTING_RACE_TWO = -441
RedPointModel.ID_DOUSHOUQI_IMG_RULE = -442
RedPointModel.ID_NUMBERPUZZLEGAMEFIRSTREDINSUPER = -443
RedPointModel.ID_DRAGON_AWAKEN_DAILY = -445
RedPointModel.ID_TUTORSYSTEM_ZDLTASKRED = -446
RedPointModel.ID_TUTORSYSTEM_STUDENT_PUZZLE_TIMES = -447
RedPointModel.ID_TUTORSYSTEM_TEACHER_LEASE = -448
RedPointModel.ID_ULTIMATEWAR_TOTAL = -449
RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILY = -450
RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_DAILYFIRSTDISPATCH = -451
RedPointModel.ID_ULTIMATEWAR_FIRSTSTEP_CANDISPATCH = -452
RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_BOSSPRIZE = -453
RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BUFF = -454
RedPointModel.ID_ULTIMATEWAR_THIRDSTEP_BOSSPrize = -455
RedPointModel.ID_ULTIMATEWAR_PET_UP = -456
RedPointModel.ID_ULTIMATEWAR_SECONDSTEP_STAGEPRIZE = -457
RedPointModel.ID_KingOfRadiantGoldClg_Buff = -458
RedPointModel.ID_KingOfRadiantGoldClg_FinialPrize = -459
RedPointModel.ID_Luyngarde_AreaKill_Prize = -460
RedPointModel.ID_AOQI_HERO_NEW_REPORT = -461
RedPointModel.ID_NEWHAND_ONLINE_PRIZE = -462
RedPointModel.ID_DIVINEMIZONGCLG_BUFFUPDATE = -463
RedPointModel.ID_STKNEXP_ISLAND_UPGARDE = -464
RedPointModel.ID_STKNEXP_MINING = -465
RedPointModel.ID_FreeScuffle_Task = -466
RedPointModel.ID_FreeScuffle_WorkEvent = -467
RedPointModel.ID_COMPANIONMALL_GET_RIM = -468
RedPointModel.ID_COMPANIONMALL_ADDRESS = -469
RedPointModel.ID_SURVEY_LIST = -470
RedPointModel.ID_TEEN_CHAMPION_KING_SCHEDULE = -471
RedPointModel.ID_TEEN_CHAMPION_KING_MY_SCHEDULE = -472
RedPointModel.ID_TEEN_CHAMPION_KING_GUESS_ITEM = -473
RedPointModel.ID_STAR_BATTLE_DEF_PRIZE = -474
RedPointModel.ID_STAR_BATTLE_BUFF = -475
RedPointModel.ID_STAR_BATTLE_BOSS_PRIZE = -476
RedPointModel.ID_ORIMATGAMESEASONPRIZE = -477
RedPointModel.ID_ORIMATGAMETALENTTREE = -478
RedPointModel.ID_ORIMATGAMEALLSEASONPRIZE = -479
RedPointModel.ID_BUDDYLUCKYBAG_CARD_GAIN = -480
RedPointModel.ID_SHOW_VIP_TIPS = -481
RedPointModel.ID_ETERNALCITY_PETSHOP = -482
RedPointModel.ID_ETERNALCITY_PROSPERITY = -483
RedPointModel.ID_DUMMPLINGFEAST_INTIMACY_PRIZE = -484
RedPointModel.ID_DUMMPLINGFEAST_BOSS_DAMAGE_PRIZE = -485
RedPointModel.ID_BOCCACCIOCHAPTER_CHAPTER_FIRST = -486
RedPointModel.ID_COMPANIONMALL_GET_RIM_PACK = -487
RedPointModel.ID_COMPANIONMALL_ADDRESS_PACK = -488
RedPointModel.ID_FIVEYEARRECAP_PLAYER_FIRST_OPEN = -489
RedPointModel.ID_Martialcontestfinal = -490
RedPointModel.ID_MMTEAM_PASSPORT_APPLY = -491
RedPointModel.ID_ORIGIN_DUOLAGAME = -492
RedPointModel.ID_DREAM_TEAM_CHAP_ONE_OPEN = -493
RedPointModel.ID_DREAM_TEAM_CHAP_TWO_OPEN = -494
RedPointModel.ID_DREAM_TEAM_CHAP_THREE_OPEN = -495
RedPointModel.ID_DREAM_TEAM_CHAP_KING_MM_DAY_CLICK = -496
RedPointModel.ID_DREAM_TEAM_CHAP_DARK_MM_DAY_CLICK = -497
RedPointModel.ID_DREAM_TEAM_CHAP_HOT_MM_DAY_CLICK = -498
RedPointModel.ID_DREAM_TEAM_CHAP_DUOLA_MM_DAY_CLICK = -499
RedPointModel.ID_DREAM_TEAM_CHAP_ALCHEMY_MM_DAY_CLICK = -500
RedPointModel.ID_DREAM_TEAM_CHAP_LOVE_MM_DAY_CLICK = -501
RedPointModel.ID_DREAM_TEAM_CHAP_ALCHEMY_MM_CAN_GET_PRIZE = -502
RedPointModel.ID_DREAM_TEAM_CHAP_THREE_CAN_REWARD = -503
RedPointModel.ID_DREAM_TEAM_CHAP_AWAKE_ALL_MM = -504
RedPointModel.ID_HOLY_DRAGON_FIELD_BUFF_UPDATE = -505
RedPointModel.ID_YOUTH_ARENA_THIRD_MY_SCHEDULE = -506
RedPointModel.ID_C16 = "c16"
RedPointModel.ID_C17 = "c17"
RedPointModel.ID_C19 = "c19"
RedPointModel.ID_C20 = "c20"
RedPointModel.ID_C21 = "c21"
RedPointModel.ID_c55 = "c55"
RedPointModel.ID_O19 = "o19"
RedPointModel.ID_O21 = "o21"
RedPointModel.ID_O22 = "o22"
RedPointModel.ID_O23 = "o23"
RedPointModel.ID_O24 = "o24"
RedPointModel.ID_YEARCAR_PROG_PRE = "RED_YEAR_PROG_"
RedPointModel.ID_YEARCAR_WEEK_PRE = "RED_YEAR_WEEK_"
RedPointModel.ID_YEARCAR_MONTH_PRE = "RED_YEAR_MONTH_"
RedPointModel.ID_YEARCAR_LOTTERY = "RED_YEAR_LOTTERY_"
RedPointModel.ID_YEARCAR_SPACEPROGRESS = "RED_YEAR_SPACEPROGRESS_"
RedPointModel.ID_HANDBOOK_PRE = "ID_HANDBOOK_COMPOSE_"
RedPointModel.ID_POWER_CRYSTAL = "ID_POWER_CRYSTAL"
RedPointModel.ID_PET_RANK_PRE = "ID_PET_RANK_"
RedPointModel.ID_PET_RANK_TAB_PRE = "ID_PET_RANK_TAB_"
RedPointModel.ID_PET_TOP_RANK_PRE = "ID_PET_TOP_RANK_"
RedPointModel.ID_SHOP = 1001
RedPointModel.ID_BAG = 1002
RedPointModel.ID_SPIRIT = 1003
RedPointModel.ID_PIGRAISE_EVENT = 1006
RedPointModel.ID_PIGRAISE_PRIZE = 1007
RedPointModel.ID_PIGRAISE_NEWPET = 1008
RedPointModel.ID_PIGRAISE_ADVENTURE = 1009
RedPointModel.ID_MOUNT_ENTRANCE = 1010
RedPointModel.ID_BAG_PIECE = 1013
RedPointModel.ID_BAG_PIECE_PRE = "ID_BAG_PIECE_PRE_"
RedPointModel.ID_BAG_ACT_PRE = "ID_BAG_ACT_PRE_"
RedPointModel.ID_COLLECT_PASS_PRE = "ID_COLLECT_PASS_PRE_"
RedPointModel.ID_MONTHCARD_PRE = "ID_MONTHCARD_PRE_"
RedPointModel.ID_GOODFEEL_PRE = "ID_GOODFEEL_PRE_"
RedPointModel.ID_Legend = 1014
RedPointModel.ID_TREASUREMAP = 1016
RedPointModel.ID_MONOPOLY = 1017
RedPointModel.ID_PAYTEMPT = 1018
RedPointModel.ID_MATERIALCHALLENGE = 1019
RedPointModel.ID_FEEDBACK = 1020
RedPointModel.ID_POPULACELEGEND = 1021
RedPointModel.ID_PLOTCOPY = 1022
RedPointModel.ID_BAG_BOX_PRE = "ID_BAG_BOX_PRE_"
RedPointModel.ID_BAG_BOX = 1023
RedPointModel.ID_PETSKIN_PRE = "ID_PETSKIN_PRE_"
RedPointModel.ID_PETSKIN_TRY_PRE = "ID_PETSKIN_TRY_PRE_"
RedPointModel.ID_PETSKIN = 1024
RedPointModel.ID_LUCKYDRAW = 1026
RedPointModel.ID_PK = 1027
RedPointModel.ID_PETRELATION = 1028
RedPointModel.ID_LUCKYDRAW_ENTRANCE = 1029
RedPointModel.ID_OPSUMMARY_NEWONE = 1030
RedPointModel.ID_MANG_TOWER_SWITCH = 1031
RedPointModel.ID_ZOO_PAIR = 1032
RedPointModel.ID_PETSEARCH = "ID_PETSEARCH"
RedPointModel.ID_OPTIONALBUY = 1033
RedPointModel.ID_PIG_SKIN_SELL = 1034
RedPointModel.ID_GET_FLOWER = 1035
RedPointModel.ID_WORLD_BOSS_PRE = "ID_WORLD_BOSS_PRE_"
RedPointModel.ID_SHAREBOSS1 = 888
RedPointModel.ID_SHAREBOSS2 = 889
RedPointModel.ID_PETASSIST = 890
RedPointModel.ID_HOLYCHALL1 = 74
RedPointModel.ID_HOLYCHALL2 = 75
RedPointModel.ID_SEVENSIGN1 = 13
RedPointModel.ID_SEVENSIGN2 = 78
RedPointModel.ID_ACCUMGIFT = 88
RedPointModel.ID_LIMITCHALLENGE_ARS = 76
RedPointModel.ID_LIMITCHALLENGE_PDL = 77
RedPointModel.ID_LIMITCHALLENGE_LH = 87
RedPointModel.ID_LIMITCHALLENGE_MY = 90
RedPointModel.ID_LIMITCHALLENGE_AME = 96
RedPointModel.ID_LIMITCHALLENGE_ELS = 127
RedPointModel.ID_DREAMISLAND = 93
RedPointModel.ID_PETLEASE = 101
RedPointModel.ID_FAMILY_TEAMPLAY = 100
RedPointModel.ID_CARD_HOT = 103
RedPointModel.ID_CARD_HOT_SHOW_HUB = 110
RedPointModel.ID_PLAYERRETURN_SIGN = 111
RedPointModel.ID_PLAYERRETURN_TASK = 112
RedPointModel.ID_PLAYERRETURN_CARD = 363
RedPointModel.ID_PLAYERRETURN = -113
RedPointModel.ID_NUMBERBOMB = 130
RedPointModel.ID_ImageFragmentCollection = 151
RedPointModel.ID_EQUIPALCHEMY = 1100
RedPointModel.ID_SCENEANSWER = 1101
RedPointModel.ID_TIANMANKINGCHALLENGE = -1102
RedPointModel.ID_LOTTERY = 63
RedPointModel.ID_LOTTERY_START = 10000
RedPointModel.ID_LOTTERY_END = 11000
RedPointModel.ID_RETURNTASK1 = -80
RedPointModel.ID_RETURNTASK2 = 154
RedPointModel.ID_RECALLTASK1 = -81
RedPointModel.ID_RECALLTASK2 = 155
RedPointModel.ID_HALLOWEEN1 = -82
RedPointModel.ID_HALLOWEEN2 = 165
RedPointModel.ID_HALLOWEEN3 = 166
RedPointModel.ID_SUMMER_LOTTERY_CAN_DRAW = 287
RedPointModel.ID_CHUANG_KONG_TRIAL_SERVER = 192
RedPointModel.ID_CLEARSTARGAME_TIMES = 710
RedPointModel.COMPANIOIN_MALL_MAIN_VIEW = 718
RedPointModel.COMPANIOIN_MALL_ADDRESS_VIEW = 708

function RedPointModel:ctor()
	return
end

function RedPointModel:onInit()
	self:onReset()
end

function RedPointModel:onReset()
	self._infoDic = {}
	self._redKeys = {}
	self._needRefreshAll = false

	if self.timerPool then
		for k, func in pairs(self.timerPool) do
			removetimer(func)
		end
	end

	self.timerPool = {}

	if self.timerEndPool then
		for k, func in pairs(self.timerEndPool) do
			removetimer(func)
		end
	end

	self.timerEndPool = {}
	self._msRedPool = {}
	self._msReverseTag = {}
end

function RedPointModel:updateRedPointInfo(arrInfo)
	for i = 1, #arrInfo do
		local info = arrInfo[i]

		self._infoDic[info.redPointId .. ""] = info

		self:regTimer(info)
	end

	self:updateAllRedPoint()
end

function RedPointModel:updateSingleRedPointInfo(info, isDispatch)
	if isDispatch == nil then
		isDispatch = true
	end

	self._infoDic[info.redPointId .. ""] = info

	self:regTimer(info)
	self:updateAllRedPoint()
end

function RedPointModel:updateAllRedPoint()
	self._needRefreshAll = true
end

function RedPointModel:refreshAllRedPoint()
	if self._needRefreshAll == true then
		self._needRefreshAll = false

		GlobalDispatcher:dispatch(GlobalNotify.RedPointUpdate)
	end
end

function RedPointModel:getNextShowTime(info)
	local change = false

	if info and info.showTimeArr then
		local now = ServerTime.now()

		while #info.showTimeArr > 0 do
			local time = table.remove(info.showTimeArr, 1)

			if now < time then
				info.showTime = checknumber(time) * 1000
				change = true

				break
			end
		end
	end

	return change
end

function RedPointModel:getNextEndTime(info)
	local change = false

	if info and info.endTimeArr then
		local now = ServerTime.now()

		while #info.endTimeArr > 0 do
			local time = table.remove(info.endTimeArr, 1)

			if now < time then
				info.endTime = checknumber(time) * 1000
				change = true

				break
			end
		end
	end

	return change
end

function RedPointModel:regTimer(info)
	local redPointId = info.redPointId

	if self.timerPool[redPointId] == nil then
		local now = ServerTime.now()

		if checknumber(info.showTime) > 0 and now < checknumber(info.showTime) then
			local time = checknumber(info.showTime) / 1000 - now

			local function func()
				self:updateAllRedPoint()
				removetimer(self.timerPool[redPointId])

				local info = self._infoDic[redPointId .. ""]
				local change = self:getNextShowTime(info)

				if change then
					self.timerPool[redPointId] = nil

					self:regTimer(info)
				end
			end

			self.timerPool[redPointId] = func

			settimer(time, func, nil, false)
		end
	end

	if self.timerEndPool[redPointId] == nil then
		local now = ServerTime.now()

		if checknumber(info.endTime) > 0 and now < checknumber(info.endTime) then
			local time = checknumber(info.endTime) / 1000 - now

			local function func()
				self:updateAllRedPoint()
				removetimer(self.timerEndPool[redPointId])

				local info = self._infoDic[redPointId .. ""]
				local change = self:getNextEndTime(info)

				if change then
					self.timerEndPool[redPointId] = nil

					self:regTimer(info)
				end
			end

			self.timerEndPool[redPointId] = func

			settimer(time, func, nil, false)
		end
	end
end

function RedPointModel:regMasterServantRed(masterRedId, isReverse, ...)
	local masterRedId = tostring(masterRedId)
	local param = {
		...
	}

	isReverse = isReverse or false

	if not string.nilorempty(masterRedId) and #param > 0 then
		self._msRedPool[masterRedId] = param
		self._msReverseTag[masterRedId] = isReverse
	end

	self:updateAllRedPoint()
end

function RedPointModel:unregMasterServantRed(masterRedId)
	masterRedId = tostring(masterRedId)

	if masterRedId then
		self._msRedPool[masterRedId] = nil
		self._msReverseTag[masterRedId] = nil
	end

	self:updateAllRedPoint()
end

function RedPointModel:isMasterRed(masterRedId)
	return self._msRedPool[tostring(masterRedId)] ~= nil
end

function RedPointModel:getMsRedPool()
	return self._msRedPool
end

function RedPointModel:isActive(id)
	local status, result = xpcall(self._isActive, function(errMsg)
		printError(string.format("RedPointModel.isActive call func fail. id=%s msg=%s", tostring(id), tostring(errMsg)))
	end, self, id)

	if not status then
		return false
	else
		return checkbool(result)
	end
end

function RedPointModel:_isActive(id)
	local tem = id

	id = checknumber(id)

	if id == RedPointModel.ID_SHOP then
		return not ShopModel.instance:hasShowShopToday()
	elseif id == RedPointModel.ID_EGG then
		return RedPointEggModel.instance:hasAnyNewEgg() or self:isActiveByServer(id)
	elseif id == RedPointModel.ID_MAIN_TASK then
		return TaskFacade.instance:isExistintBonuedTask(GameEnum.TaskType.Main)
	elseif id == RedPointModel.ID_BRANCH_TASK then
		return TaskFacade.instance:isExistintBonuedTask(GameEnum.TaskType.Branch)
	elseif id == RedPointModel.ID_GROW_TASK then
		return TaskFacade.instance:isExistintBonuedTask(GameEnum.TaskType.Guide)
	elseif id == RedPointModel.ID_FRIEND then
		return FuncOpenModel.instance:getFuncIsOpen(22) and (NewChatModel.instance:getHasNotReadMsg() or self:isActiveByServer(id) or FriendController.instance:checkWelfareRdState())
	elseif id == RedPointModel.ID_FRIEND_NO_READ then
		return NewChatModel.instance:getHasNotReadMsg()
	elseif id == RedPointModel.ID_MOFANG then
		return self:isActiveByServer(id) or MofangModel.instance:hasAnyPuzzleToPlay()
	elseif id == RedPointModel.ID_DAILY_TASK then
		return self:isActiveByServer(id)
	elseif id == RedPointModel.ID_WEEKLY_TASK then
		return self:isActiveByServer(id)
	elseif id == RedPointModel.ID_ARENA then
		return self:isActiveByServer(id)
	elseif id == RedPointModel.ID_GROWUP_XINXIN or id == RedPointModel.ID_GROWUP_NIANNIAN then
		return self:isActiveByServer(id) and FuncOpenModel.instance:getFuncIsOpen(386)
	elseif id == RedPointModel.ID_PLAYER_INFO then
		return self:isActive(RedPointModel.ID_PLAYER_TITLE)
	elseif id == RedPointModel.ID_PLAYER_TITLE then
		return TitleModel.instance:getRedActiveTotal()
	elseif id == RedPointModel.ID_KINGWAY then
		return KingWayModel.instance:GetKingViewRedPoint()
	elseif id == RedPointModel.ID_TWINDRAGRONCHALLENGE then
		local cfg = IntegrationChallengeConfig.instance:getChallengeById(IntegrationChallengeModel.TwinDragon)
		local petInfo1 = GrowUpRoadController.instance:getPetInfo(cfg.raceIds[1])
		local petInfo2 = GrowUpRoadController.instance:getPetInfo(cfg.raceIds[2])
		local _challengeCfg = IntegrationChallengeConfig.instance:getChallengeById(IntegrationChallengeModel.TwinDragon)
		local cfg = IntegrationChallengeConfig.instance:getStageByParam(_challengeCfg.challengePlanId, 2, 1)
		local _openTime = GameUtil.string2time(cfg.openTime)

		if IntegrationChallengeModel.instance:getChallengeStatus() == 0 and _openTime < ServerTime.now() and not GameUtil.getUserDayData("TwinDragonChallengeView") then
			return not petInfo1.sham and not petInfo2.sham
		elseif IntegrationChallengeModel.instance:getChallengeStatus() == 1 then
			return not petInfo2.sham and GrowUpRoadController.instance:isMaxPet(petInfo1) and GrowUpRoadController.instance:isMaxPet(petInfo2)
		else
			return false
		end
	elseif id == RedPointModel.ID_PETTEAMS then
		return HandbookModel.instance:getPetTeamIsRed()
	elseif id == RedPointModel.ID_NINEPLACE_BATTLE then
		return NinePlaceModel.instance:checkBattleFuncRed()
	elseif id == RedPointModel.ID_UPGRADE_NINEPLACE then
		return FuncOpenModel.instance:getFuncIsOpen(96) and FormationNewModel.instance:checkUpgradeFuncRed()
	elseif id == RedPointModel.ID_Legend then
		return LegendController.instance:isActiveRedPoint()
	elseif id == RedPointModel.ID_SxGame then
		return self:isActiveByServer(id) and FuncOpenModel.instance:getFuncIsOpen(16)
	elseif id == RedPointModel.ID_SCRATCH then
		return self:isActiveByServer(id) or ScratchController.instance:isScratchRedPointActive()
	elseif id == RedPointModel.ID_LOTTERY then
		return self:isActiveByServer(id) or LotteryModel.instance:GetLotteryRedpointNew()
	elseif id == RedPointModel.ID_MATERIALCHALLENGE then
		return MaterialChallengeController.instance:isHaveRedPointInAllChapters()
	elseif id == RedPointModel.ID_TREASUREOX then
		return self:isActiveByServer(id) or SevenDaysModel.instance:GetWishCountRedpoint()
	elseif id == RedPointModel.ID_TEACHING then
		return self:isActiveByServer(id) and FuncOpenModel.instance:getFuncIsOpen(68)
	elseif id == RedPointModel.ID_POPULACELEGEND then
		return PopulaceLegendModel.instance:isShowRedPoint()
	elseif id == RedPointModel.ID_PLOTCOPY then
		return PlotCopyModel.instance:isHaveRedPoint()
	elseif id == RedPointModel.ID_THRONE then
		return FuncOpenModel.instance:getFuncIsOpen(174) and (self:isActiveByServer(RedPointModel.ID_THRONE_ACHIEVE) or ThroneModel.instance:checkThoneRedDot())
	elseif id == RedPointModel.ID_PETASSIST then
		return PetAssistModel.instance:GetPetAssistRedPoint()
	elseif id == RedPointModel.ID_WTower then
		local _cfg = FuncOpenConfig.instance:getFunctionOpenById(15)
		local isOpen = FuncOpenController.instance:getConditionReached(_cfg.openCondition)

		return (self:isActiveByServer(id) or self:isActiveByServer(RedPointModel.ID_PETDISPATCH)) and isOpen
	elseif id == RedPointModel.ID_SHAREBOSS1 then
		return ShareTaskModel.instance:IsShowShareBossMianViewEntrance()
	elseif id == RedPointModel.ID_SHAREBOSS2 then
		return ShareTaskModel.instance:GetShareBossFindRewardRed()
	elseif id == RedPointModel.ID_NINEPLACE_CAN_UNLOCK then
		return FuncOpenModel.instance:getFuncIsOpen(96) and NinePlaceModel.instance:checkCanUnlockRed()
	elseif id == RedPointModel.ID_StarGodPlus then
		return StargodplusModel.instance:checkPetCanEquip()
	elseif id == RedPointModel.ID_ActivityExchangShop_FlyNuo then
		return ActivityshopModel.instance:checkDailyRedDot(GameEnum.ActivityType.FlyNuo)
	elseif id == RedPointModel.ID_ActivityExchangShop_Summary then
		return ActivityshopModel.instance:checkDailyRedDot(GameEnum.ActivityType.Summary, 17003)
	elseif id == RedPointModel.ID_ActivityExchangShop_MZD then
		return ActivityshopModel.instance:checkDailyRedDot(GameEnum.ActivityType.Summary, 17004)
	elseif id == RedPointModel.ID_PayShopHUD then
		return FuncOpenModel.instance:getFuncIsOpen(198) and (self:isActiveByServer(RedPointModel.ID_PAYSHOPMIBAO) or self:isActiveByServer(RedPointModel.ID_TOTALRECHARGE) or self:isActiveByServer(RedPointModel.ID_MONTHCARD) or self:isActiveByServer(118) or self:isActive(RedPointModel.ID_DiamondShopReset))
	elseif id == RedPointModel.ID_LUCKYDRAW_ENTRANCE then
		local test1 = self:isActiveByServer(95)
		local test2 = self:isActiveByServer(RedPointModel.ID_LUCKYDRAW)

		return self:isActiveByServer(95) and self:isActiveByServer(RedPointModel.ID_LUCKYDRAW)
	elseif id == RedPointModel.ID_PETRELATION then
		local flag = false

		for i = 1, 6 do
			local teamIds = PetRelationConfig.instance:getPosterByType(i) or {}

			for j, teamId in ipairs(teamIds) do
				if HandbookModel.instance:getIsPosterShowRedPointByTeamId(teamId) then
					flag = true
					i = 7

					break
				end
			end
		end

		for i = 2, 6 do
			if PetRelationController.instance:haveCanActivePet(i) then
				flag = true

				break
			end
		end

		flag = flag and HandbookController.instance:getIsDataInit()

		return (self:isActiveByServer(43) or self:isActiveByServer(67) or self:isActiveByServer(435) or flag) and not PetbookModel.instance:getLoginFirst()
	elseif id == RedPointModel.ID_TEACHING_DAILY then
		return TeachingDungeonModel.instance:checkDailyRedDot()
	elseif id > 0 and TimeLimitedConfig.instance:getCfgByRedPointId(id) then
		local timedChallengeCfg = TimeLimitedConfig.instance:getCfgByRedPointId(id)

		if TLChallengeController.instance:isInOpenTime(timedChallengeCfg.challengeId) and FuncOpenModel.instance:getFuncIsOpen(timedChallengeCfg.openFuncId) then
			return self:isActiveByServer(id) or TLChallengeModel.instance:isDailyRedActive(timedChallengeCfg.challengeId)
		end
	elseif id == RedPointModel.ID_OPSUMMARY_NEWONE then
		return OpSummaryModel.instance:isHaveNewOne()
	elseif id == RedPointModel.ID_FAMILY_TEAMPLAY then
		return self:isActiveByServer(RedPointModel.ID_FAMILY_TEAMPLAY) and FamilyteamplayModel.instance:isFunOpen()
	elseif id == RedPointModel.ID_PLAYERRETURN then
		return PlayerReturnModel.instance:getPlayerReturnRedpoint()
	elseif id == RedPointModel.ID_EQUIPALCHEMY then
		return PetEquipModel.instance:getAllEquipAlchemyRedpoint()
	elseif id == 115 then
		return self:isActiveByServer(id) and BreakFormationModel.instance:isQuickRedActive()
	elseif id == 119 then
		local challengeId = LightKingModel.instance:getChallengeId()
		local timedChallengeCfg = TimeLimitedConfig.instance:getCfgById(challengeId)

		return self:isActiveByServer(id) and TLChallengeController.instance:isInOpenTime(challengeId) and FuncOpenModel.instance:getFuncIsOpen(timedChallengeCfg.openFuncId) and LightKingModel.instance:isDailyRedActive()
	elseif id == RedPointModel.ID_Custom_MonthCard then
		return MonthCardModel.instance:checkCardRedDot(1)
	elseif id == RedPointModel.ID_WholeLifeCard then
		return MonthCardModel.instance:checkCardRedDot(2)
	elseif id == RedPointModel.ID_ResMonthCard then
		return MonthCardModel.instance:checkCardRedDot(3)
	elseif id == RedPointModel.ID_ChallengeCard then
		return MonthCardModel.instance:checkCardRedDot(4)
	elseif id == RedPointModel.ID_MengxinCard then
		return MonthCardModel.instance:checkCardRedDot(5)
	elseif id == RedPointModel.ID_Custom_MonthCard2020 then
		return MonthCardModel.instance:checkCardRedDot(MonthCardModel.MonthCardId2022)
	elseif id == RedPointModel.ID_Custom_ResMonthCardId2022 then
		return MonthCardModel.instance:checkCardRedDot(MonthCardModel.ResMonthCardId2022)
	elseif id == RedPointModel.ID_MONTHCARDBACK_RED then
		return MonthCardModel.instance:checkCardRedDot(MonthCardModel.MonthCardBackId)
	elseif id == RedPointModel.ID_Custom_MonthCard2024 then
		return MonthCardModel.instance:checkCardRedDot(MonthCardModel.MonthCardId2024)
	elseif id == RedPointModel.ID_Custom_ResMonthCardId2024 then
		return MonthCardModel.instance:checkCardRedDot(MonthCardModel.ResMonthCardId2024)
	elseif id == RedPointModel.ID_MONTHCARDBACK_RED_2024 then
		return MonthCardModel.instance:checkCardRedDot(MonthCardModel.MonthCardBackId2024)
	elseif id == RedPointModel.ID_DiamondShopReset then
		return PayShopModel.instance:checkDiamondRechagerResetDot()
	elseif id == RedPointModel.ID_HappyLemon then
		return BounsModel.instance:checkHappyLemonDot()
	elseif id == RedPointModel.ID_OPTIONALBUY then
		return PetEquipModel.instance:getOptionalRedpoint()
	elseif checknumber(id) >= RedPointModel.ID_LOTTERY_START and checknumber(id) <= RedPointModel.ID_LOTTERY_END then
		return LotteryModel.instance:GetSubRedpointByRP(id)
	elseif id == RedPointModel.ID_BEJ_DOT1 then
		return HdsummerlotteryrecommendModel.instance:checkRedDot()
	elseif id == RedPointModel.ID_ONEPEOPLECOPY then
		return ScenariocopyController.instance:isOnePeopleCopyShowRedPoint()
	elseif id == RedPointModel.ID_SCENEANSWER then
		return AnswerSceneModel.instance:getData() and not AnswerSceneModel.instance:isAllQuestionFinish() and AnswerSceneController.instance:checkAnswerSceneOpen()
	elseif id == RedPointModel.ID_WLTOWERRED then
		return WaterdraktowerModel.instance:getWLTowerRedpoint()
	elseif id == RedPointModel.ID_ANLONGCOPY then
		return ScenariocopyController.instance:isAnLongCopyShowRedPoint()
	elseif id == RedPointModel.ID_XINXIYA then
		return XinxiyaMirrorModel.instance:getXinxiyaRedpoint()
	elseif id == RedPointModel.ID_TIANMANKINGCHALLENGE then
		return FuncOpenModel.instance:getFuncIsOpen(5013) and (self:isActiveByServer(143) or self:isActiveByServer(144) or self:isActiveByServer(145))
	elseif id == RedPointModel.ID_TONGBATTLE then
		return TongBattleModel.instance:getTongBattleRedpoint()
	elseif id == RedPointModel.ID_RETURNTASK1 then
		return RecallTaskModel.instance:getReturnViewRedpoint()
	elseif id == RedPointModel.ID_RECALLTASK1 then
		return self:isActiveByServer(RedPointModel.ID_RECALLTASK2) or RecallTaskModel.instance:getRecallViewRedpoint()
	elseif id == RedPointModel.ID_HALLOWEEN1 then
		return HalloweenGuestModel.instance:getHalloweenRedpoint()
	elseif id == RedPointModel.ID_TREASUREBASIN then
		local activityInfo = HeartMoneyCatController.instance:getActivityInfo()

		if activityInfo then
			return HeartMoneyCatController.instance:isCanMoney(activityInfo.consumeId)
		else
			return false
		end
	elseif id == RedPointModel.ID_WUMMONTOWER_REWARDS then
		return not SummontowerController.instance:hasEverOpenedSummonter() or self:isActiveByServer(tem)
	elseif id == RedPointModel.ID_PETNEWNOTICE then
		return GameUtil.getUserDayData("petnoticered") == nil
	elseif id == RedPointModel.ID_PETBLESS then
		return AthenaBlessController.instance:isActiveRedPoint()
	elseif id == RedPointModel.ID_BACKTASK then
		return PlayerReturnModel.instance:getBackTaskRedpoint()
	elseif id == RedPointModel.ID_MOONKINGRED then
		return MoonKingModel.instance:getMoonkingRedpoint()
	elseif id == RedPointModel.ID_NEWHANDWALFARE then
		return NewhandwelfareModel.instance:checkRedDot()
	elseif id == RedPointModel.ID_SEVENSIGN1 or id == RedPointModel.ID_STARTEAM then
		if NewhandwelfareModel.instance:isNewHandActivePlayer() then
			return false
		else
			return self:isActiveByServer(id)
		end
	elseif id == RedPointModel.ID_DRAGONTRAIL_DAILY then
		return DragontrialModel.instance:checkDailyRedDot()
	elseif id == RedPointModel.ID_DRAGONTRAIL_EXCHANGESHOP then
		return DragontrialModel.instance:checkExchangeShopRedPoint()
	elseif id == RedPointModel.ID_DRAGONLOTTERY then
		return DragonModel.instance:getDragonRedpoint()
	elseif id == RedPointModel.ID_RECHARGEJUMPHUODOT then
		return OpSummaryModel.instance:checkRechargeJumpHudDot()
	elseif id == RedPointModel.ID_INIFITEJIGSAW_PUZZLE then
		return InfiniteJigsawModel.instance:isShowDailyRedPoint()
	elseif id == RedPointModel.ID_GODDESSVOTE then
		return GoddessVoteModel.instance:getGoddessVoteRedpoint()
	elseif id == RedPointModel.ID_GODDESSDELICACY then
		return GoddessDelicacyModel.instance:getGoddessDelicacyRedpoint()
	elseif id == RedPointModel.ID_GODDESS_COLLECT_WHOLELIFE then
		return GoddesscollectorModel.instance:checkWholeLifeDot()
	elseif id == RedPointModel.ID_GODDESSWAKEN then
		return GoddessWakenModel.instance:isShowDailyRedPoint()
	elseif id == RedPointModel.ID_ANNUALACTIVITY then
		return AnnualActivityModel.instance:getAnnualActivityRedpoint()
	elseif id == RedPointModel.ID_XINGJIANGPK then
		return GameUtil.getUserDayData("ID_XINGJIANGPK") == nil
	elseif id == RedPointModel.ID_JISUMMONER then
		return JiSummonerController.instance:getJiSummonerRedpoint()
	elseif id == RedPointModel.ID_MONTHCARDS_PACK then
		return MonthCardPackController.instance:checkRedPoint()
	elseif id == RedPointModel.ID_FAMILYCALLORDER then
		return GameUtil.getUserDayData("ID_FAMILYCALLORDER") == nil
	elseif id == RedPointModel.ID_ESCORT_OTHER then
		return EscortModel.instance:setOtherViewShowRed()
	elseif id == RedPointModel.ID_FAMILYWARRED then
		return FamilyWarModel.instance:getFamilyWarRedpoint()
	elseif id == RedPointModel.ID_VIRETA_CHALLENGE then
		return GameUtil.getUserWeekData("ID_VIRETA_CHALLENGE") == nil
	elseif id == RedPointModel.ID_HOLY_STRIPE_COPY_ENTER then
		return FuncOpenModel.instance:getFuncIsOpen(HolyStripeCopyModel.instance:getFuncOpenId()) and (self:isActive(RedPointModel.ID_HOLY_STRIPE_COPY) or self:isActive(RedPointModel.ID_HOLY_STRIPE_EXPLORE_EXIT_TIME) or self:isActive(RedPointModel.ID_HOLY_STRIPE_ASSISTANCE_BOX_PRIZE))
	elseif id == RedPointModel.ID_SUMMERDOUBLE then
		return BonusController.instance:getSummerDoubleRedpoint()
	elseif id == RedPointModel.ID_VERSIONGIFT_RED then
		return BonusController.instance:getVersionGiftViewRed()
	elseif id == RedPointModel.ID_SUMMER_LOTTERY_CAN_DRAW then
		return self:isActiveByServer(tem) and SummerLotteryController.instance:isItemEnough()
	elseif id == RedPointModel.ID_LAILISI_DAY then
		return GameUtil.getUserDayData("ID_LAILISI_DAY") == nil
	elseif id == RedPointModel.ID_PALADINBATTLE_RED then
		return MoonKingModel.instance:getPaladinRedpoint()
	elseif self:isActiveByServantMaster(tem) then
		return true
	else
		return self:isActiveByServer(tem) and self:isFuncOpenByClient(tem)
	end
end

function RedPointModel:getRedPoingInfo(id)
	return self._infoDic[id .. ""]
end

function RedPointModel:isActiveByServer(redId)
	return self:isAttrActivated(redId) and self:isFuncOpenByServer(redId) and self:isInTime(redId)
end

function RedPointModel:isInTime(redId)
	local info = self:getRedPoingInfo(redId)

	if info == nil then
		return false
	end

	local nowStamp = ServerTime.now() * 1000
	local isNotEnd = info.endTime == nil or info.endTime == 0 or nowStamp < tonumber(info.endTime)
	local isHasStart = info.showTime == nil or info.showTime == 0 or nowStamp > tonumber(info.showTime)

	return isNotEnd and isHasStart
end

function RedPointModel:isAttrActivated(redId)
	local info = self:getRedPoingInfo(redId)

	return (info or nil) and (info.isActivated or false)
end

function RedPointModel:isFuncOpenByServer(redId)
	redId = checknumber(redId)

	local funcData = RedPointConfig.instance:getCfgById(redId)

	if funcData and not string.nilorempty(funcData.funcIds) then
		local funcIds = string.split(funcData.funcIds, "#")

		for _, funcId in ipairs(funcIds) do
			if not FuncOpenModel.instance:getFuncIsOpen(checknumber(funcId)) then
				return false
			end
		end
	end

	return true
end

function RedPointModel:isFuncOpenByClient(redId)
	local info = self:getRedPoingInfo(redId)

	if info == nil then
		return false
	end

	if info.funcIdList then
		for _, funcId in ipairs(info.funcIdList) do
			if not FuncOpenModel.instance:getFuncIsOpen(checknumber(funcId)) then
				return false
			end
		end
	end

	return true
end

function RedPointModel:isActiveByServantMaster(redId)
	redId = tostring(redId)

	local result = false
	local servantRedIdList = self._msRedPool[redId]

	if servantRedIdList and #servantRedIdList > 0 then
		local isReverse = self._msReverseTag[redId]

		if isReverse then
			result = true

			for _, id in ipairs(servantRedIdList) do
				if not RedPointModel.instance:isActive(id) then
					result = false

					break
				end
			end
		else
			for _, id in ipairs(servantRedIdList) do
				if RedPointModel.instance:isActive(id) then
					result = true

					break
				end
			end
		end
	end

	return result
end

RedPointModel.instance = RedPointModel.New()

return RedPointModel
