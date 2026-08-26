-- chunkname: @modules/logic/player/controller/PlayerEvent.lua

module("modules.logic.player.controller.PlayerEvent", package.seeall)

local PlayerEvent = _M

PlayerEvent.PlayerbassinfoChange = 1
PlayerEvent.SetShowHero = 2
PlayerEvent.SetPortrait = 3
PlayerEvent.SelectPortrait = 4
PlayerEvent.ChangePlayerinfo = 5
PlayerEvent.PlayerLevelUp = 6
PlayerEvent.ChangePlayerName = 7
PlayerEvent.NickNameConfirmNo = 8
PlayerEvent.NickNameConfirmYes = 9
PlayerEvent.RenameReplyFail = 10
PlayerEvent.SelectCloth = 11
PlayerEvent.ShowClothSkillTips = 12
PlayerEvent.UpdateSimpleProperty = 13
PlayerEvent.UpdateAssistRewardCount = 14
PlayerEvent.OnDailyRefresh = 15
PlayerEvent.RenameFlagUpdate = 20
PlayerEvent.ChangeBgTab = 1000
PlayerEvent.ShowHideRoot = 1001

return PlayerEvent
