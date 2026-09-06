-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/iceqibugame/data/IceQibuGameSubMo.lua

module("logic.extensions.iceqibugame.data.IceQibuGameSubMo", package.seeall)

local IceQibuGameSubMo = class("IceQibuGameSubMo")

function IceQibuGameSubMo:ctor(activityId)
	self._activityId = activityId

	self:_resetData()
end

function IceQibuGameSubMo:_resetData()
	self._todayGameTimes = 0
	self._minCostTime = 0
	self._serverKey = 0
	self._clientKey = 0
end

function IceQibuGameSubMo:dispose()
	self:_resetData()
end

function IceQibuGameSubMo:handlePM_IceQibuGameInfoRes(msg)
	self._todayGameTimes = msg.todayGameTimes
	self._minCostTime = msg.minCostTime
end

function IceQibuGameSubMo:handlePM_IceQibuGameStartGameRes(msg)
	self._serverKey = msg.serverKey
end

function IceQibuGameSubMo:handlePM_IceQibuGameEndGameRes(msg)
	self._todayGameTimes = msg.todayGameTimes
	self._minCostTime = msg.minCostTime
	self._clientKey = nil
	self._serverKey = nil
end

function IceQibuGameSubMo:handlePM_IceQibuGameSweepRes(msg)
	self._todayGameTimes = msg.todayGameTimes
end

function IceQibuGameSubMo:getTodayGameTimes()
	return self._todayGameTimes
end

function IceQibuGameSubMo:getMaxGameTimes()
	local data = IceQibuGameConfig.instance:getActivityData(self._activityId)

	return (data or nil) and (data.dailyGameTimes or 0)
end

function IceQibuGameSubMo:getLeftGameTimes()
	local cur = self:getTodayGameTimes()
	local max = self:getMaxGameTimes()

	return Mathf.Max(0, max - cur)
end

function IceQibuGameSubMo:getMinCostTime()
	return self._minCostTime
end

function IceQibuGameSubMo:getEncryptedKey(costTime)
	return GameUtil.getClientEncryptedKey(self._clientKey, self._serverKey, {
		self._activityId,
		costTime
	})
end

function IceQibuGameSubMo:getServerKey()
	return self._serverKey
end

function IceQibuGameSubMo:getClientKey()
	return self._clientKey
end

function IceQibuGameSubMo:setClientKey(value)
	self._clientKey = value
end

return IceQibuGameSubMo
