-- chunkname: @modules/logic/versionactivity2_4/pinball/controller/PinballEvent.lua

module("modules.logic.versionactivity2_4.pinball.controller.PinballEvent", package.seeall)

local PinballEvent = _M
local _get = GameUtil.getUniqueTb()

PinballEvent.OneClickClaimReward = _get()
PinballEvent.DataInited = _get()
PinballEvent.OnClickBuilding = _get()
PinballEvent.AddBuilding = _get()
PinballEvent.UpgradeBuilding = _get()
PinballEvent.RemoveBuilding = _get()
PinballEvent.OperBuilding = _get()
PinballEvent.LearnTalent = _get()
PinballEvent.TalentRedChange = _get()
PinballEvent.OnCurrencyChange = _get()
PinballEvent.EndRound = _get()
PinballEvent.OperChange = _get()
PinballEvent.ClickScene = _get()
PinballEvent.GetReward = _get()
PinballEvent.TweenToHole = _get()
PinballEvent.GuideMainLv = _get()
PinballEvent.GuideAddRes = _get()
PinballEvent.GuideBuildTalent = _get()
PinballEvent.GuideBuildHouse = _get()
PinballEvent.GuideUnlockBallInGame = _get()
PinballEvent.MarblesDead = _get()
PinballEvent.GameResChange = _get()
PinballEvent.GameResRefresh = _get()
PinballEvent.ClickBagItem = _get()
PinballEvent.ClickMarbles = _get()
PinballEvent.DragMarblesEnd = _get()
PinballEvent.OnWaitDragEnd = _get()

return PinballEvent
