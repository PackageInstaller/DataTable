-- chunkname: @modules/logic/pcInput/PCInputEvent.lua

module("modules.logic.pcInput.PCInputEvent", package.seeall)

local PCInputEvent = _M

PCInputEvent.NotifySetMainViewVisible = 1
PCInputEvent.NotifyEnterCurActivity = 2
PCInputEvent.NotifyEnterActivityCenter = 3
PCInputEvent.NotifyEnterRoom = 4
PCInputEvent.NotifyEnterRole = 5
PCInputEvent.NotifyEnterSummon = 6
PCInputEvent.NotifyEnterBook = 7
PCInputEvent.NotifyEnterAchievement = 8
PCInputEvent.NotifyEnterFriend = 9
PCInputEvent.NotifyEnterTravelCollection = 10
PCInputEvent.NotifyEnterNotice = 11
PCInputEvent.NotifyEnterSetting = 12
PCInputEvent.NotifyEnterSign = 13
PCInputEvent.NotifyEnterFeedback = 14
PCInputEvent.NotifyEnterStore = 15
PCInputEvent.NotifyThirdDoorItemSelect = 10
PCInputEvent.NotifyThirdDoorOpenBook = 11
PCInputEvent.NotifyThirdDoorHelp = 12
PCInputEvent.NotifyBattleOpenEnemyInfo = 20
PCInputEvent.NotifyBattleOpentips = 21
PCInputEvent.NotifyBattleAutoFight = 22
PCInputEvent.NotifyBattleSpeedUp = 23
PCInputEvent.NotifyBattleSelect = 24
PCInputEvent.NotifyBattleSelectCard = 25
PCInputEvent.NotifyBattleBackPack = 26
PCInputEvent.NotifyBattleMoveCard = 27
PCInputEvent.NotifyBattleMoveCardEnd = 28
PCInputEvent.NotifyBattleSkillOpen = 29
PCInputEvent.NotifyBattleSkillIndex = 30
PCInputEvent.NotifyBattleSelectLeft = 31
PCInputEvent.NotifyBattleSelectRight = 32
PCInputEvent.NotifyRoomBellTower = 40
PCInputEvent.NotifyRoomMarket = 41
PCInputEvent.NotifyRoomCharactorFaith = 42
PCInputEvent.NotifyRoomCharactorFaithFull = 43
PCInputEvent.NotifyHide = 44
PCInputEvent.NotifyEdit = 45
PCInputEvent.NotifyPlace = 46
PCInputEvent.Notifylocate = 47
PCInputEvent.NotifyBuy = 48
PCInputEvent.NotifyLayout = 49
PCInputEvent.NotifyStoryDialogNext = 60
PCInputEvent.NotifyStoryDialogAuto = 61
PCInputEvent.NotifyStoryDialogSkip = 62
PCInputEvent.NotifyStoryDialogExit = 63
PCInputEvent.NotifyStoryDialogSelect = 64
PCInputEvent.NotifyCommonConfirm = 80
PCInputEvent.NotifyCommonCancel = 81

return PCInputEvent
