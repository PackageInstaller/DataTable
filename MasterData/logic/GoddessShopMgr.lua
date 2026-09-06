-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessshop/data/GoddessShopMgr.lua

module("logic.extensions.goddessshop.data.GoddessShopMgr", package.seeall)

local GoddessShopMgr = class("GoddessShopMgr")

function GoddessShopMgr:ctor(activityId)
	self._activityId = activityId
	self._goddessShopMo = GoddessShopController.instance:getGoddessShopMo(self._activityId)
	self._money = 0
end

function GoddessShopMgr:onEnter()
	self:_onResetShopInfo()
	GlobalDispatcher:addListener(GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onResetShopInfo, self)
	settimer(1, self._onTicking, self)
	self:_onTicking()
end

function GoddessShopMgr:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.SurroundByDreamGirlShopMoneyUpdate, self._onResetShopInfo, self)
	self:_clear()
end

function GoddessShopMgr:onDestroy()
	self:_clear()
end

function GoddessShopMgr:_clear()
	removetimer(self._onTicking, self)
end

function GoddessShopMgr:_onTicking()
	self._durationTimeSec = Mathf.Max(ServerTime.now() - self._orginTimeSec, 0)
	self._durationMinute = Mathf.Floor(self._durationTimeSec / 60)

	if self._curMinuteIndex < self._durationMinute then
		local totalMoneyAddSpeed = self._goddessShopMo:getTotalMoneyAddSpeed()

		self._money = self._goddessShopMo:getMoney() + totalMoneyAddSpeed * (self._durationMinute - self._curMinuteIndex)

		self._goddessShopMo:updateClientMoney(self._money)

		self._curMinuteIndex = self._durationMinute

		GlobalDispatcher:dispatch(GlobalNotify.SurroundByDreamGirlShopMoneyUpdate)
	end
end

function GoddessShopMgr:_onResetShopInfo()
	self._money = self._goddessShopMo:getMoney()

	self._goddessShopMo:updateClientMoney(self._money)

	self._orginTimeSec = ServerTime.now()
	self._durationTimeSec = 0
	self._durationMinute = 0
	self._curMinuteIndex = 0
end

return GoddessShopMgr
