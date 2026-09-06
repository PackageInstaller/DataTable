-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklybigbox/model/WeeklyBigBoxModel.lua

module("logic.extensions.weeklybigbox.model.WeeklyBigBoxModel", package.seeall)

local WeeklyBigBoxModel = class("WeeklyBigBoxModel", BaseModel)

function WeeklyBigBoxModel:ctor()
	self:onReset()
end

function WeeklyBigBoxModel:onInit()
	self:onReset()
end

function WeeklyBigBoxModel:onReset()
	self._clientKey = 0
	self._encryptedKey = 0
	self._lastWeeklyDay = nil

	self:resetUserData()
end

function WeeklyBigBoxModel:resetUserData()
	self._surplusTimes = 0
	self._redPackageNum = 0
	self._recordInfos = {}
	self._bExistsFreeTimes = false
end

function WeeklyBigBoxModel:handleGetInfoRes(msg)
	self._surplusTimes = msg.surplusTimes
	self._redPackageNum = msg.redPackageNum
	self._recordInfos = msg.recordInfos or {}
	self._bExistsFreeTimes = msg.existsFreeTimes
end

function WeeklyBigBoxModel:beforeStartGame()
	self._clientKey = math.random(1, 99)

	return self._clientKey
end

function WeeklyBigBoxModel:handleStartGameRes(msg)
	self._encryptedKey = msg.mixedKey
end

function WeeklyBigBoxModel:beforeEndGame(redPackageNum)
	self._cacheRedPackageNum = redPackageNum

	return self:getEncryptedKey(redPackageNum)
end

function WeeklyBigBoxModel:handleEndGameRes(msg)
	if self._cacheRedPackageNum ~= nil then
		self._redPackageNum = self._cacheRedPackageNum
	end
end

function WeeklyBigBoxModel:handleOpenRedPackageRes(msg)
	self._redPackageNum = 0
end

function WeeklyBigBoxModel:getEncryptedKey(...)
	local nums = {
		...
	}
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, self._encryptedKey, nums)

	return tostring(encryptedKey)
end

function WeeklyBigBoxModel:getRecordInfos()
	return self._recordInfos
end

function WeeklyBigBoxModel:getRemainCount()
	return self._surplusTimes
end

function WeeklyBigBoxModel:getRedPackageCount()
	return self._redPackageNum
end

function WeeklyBigBoxModel:isHasFreeTimes()
	return self._bExistsFreeTimes
end

function WeeklyBigBoxModel:getIfNewDay()
	local lastWeekDay = self._lastWeeklyDay
	local curDate = GameUtil.time2date(ServerTime.now())
	local curWeekDay = curDate.wday
	local curHour = curDate.hour

	if curHour >= 0 and curHour < 5 then
		curWeekDay = curWeekDay + 6
	end

	curWeekDay = curWeekDay % 7
	self._lastWeeklyDay = curWeekDay

	if lastWeekDay ~= 0 then
		return curWeekDay ~= lastWeekDay
	else
		return false
	end
end

WeeklyBigBoxModel.instance = WeeklyBigBoxModel.New()

return WeeklyBigBoxModel
