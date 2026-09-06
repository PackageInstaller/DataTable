-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/data/IslandStationMgr.lua

module("logic.extensions.islandstation.data.IslandStationMgr", package.seeall)

local IslandStationMgr = class("IslandStationMgr")

function IslandStationMgr:ctor(activityId)
	self._activityId = activityId
	self._goddessShopMo = GoddessShopController.instance:getGoddessShopMo(self._activityId)
end

function IslandStationMgr:onEnter()
	self:_onResetShopInfo()
	GlobalDispatcher:addListener(GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onResetShopInfo, self)
	settimer(1, self._onTicking, self)
	self:_onTicking()
end

function IslandStationMgr:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onResetShopInfo, self)
	self:_clear()
end

function IslandStationMgr:onDestroy()
	self:_clear()
end

function IslandStationMgr:_clear()
	removetimer(self._onTicking, self)
end

function IslandStationMgr:_onTicking()
	return
end

function IslandStationMgr:_onResetShopInfo()
	self._money = self._goddessShopMo:getMoney()

	self._goddessShopMo:updateClientMoney(self._money)

	self._orginTimeSec = ServerTime.now()
	self._durationTimeSec = 0
	self._durationMinute = 0
	self._curMinuteIndex = 0
end

return IslandStationMgr
