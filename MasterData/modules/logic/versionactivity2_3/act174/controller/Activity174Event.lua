-- chunkname: @modules/logic/versionactivity2_3/act174/controller/Activity174Event.lua

module("modules.logic.versionactivity2_3.act174.controller.Activity174Event", package.seeall)

local Activity174Event = _M

Activity174Event.UpdateGameInfo = 1
Activity174Event.FreshShopReply = 2
Activity174Event.ChangeLocalTeam = 3
Activity174Event.BuyInShopReply = 4
Activity174Event.EndGame = 5
Activity174Event.ClickStartGame = 6
Activity174Event.EnterNextAct174FightReply = 7
Activity174Event.WareHouseTypeChange = 1001
Activity174Event.WareItemInstall = 1002
Activity174Event.WareItemRemove = 1003
Activity174Event.SwitchShopTeam = 1004
Activity174Event.SeasonChange = 1005
Activity174Event.UnEquipCollection = 1006
Activity174Event.UpdateBadgeMo = 1007
Activity174Event.FightReadyViewLevelCount = 9001
Activity174Event.SureEnterEndlessMode = 9002
Activity174Event.EnterGameStore = 9003
Activity174Event.ChooseRolePackage = 9004
Activity174Event.ChooseBuffPackage = 9005

return Activity174Event
