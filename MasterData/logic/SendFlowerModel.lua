-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/model/SendFlowerModel.lua

module("logic.extensions.sendflower.model.SendFlowerModel", package.seeall)

local SendFlowerModel = class("SendFlowerModel", BaseModel)

SendFlowerModel.flowerRecordType = {
	SEND = 2,
	RECEIVE = 1
}

function SendFlowerModel:ctor()
	return
end

function SendFlowerModel:onInit()
	self:onReset()
end

function SendFlowerModel:onReset()
	self._recoredInfos = nil
	self._showSendCount = 0
	self._showTakeCount = 0
	self._dailySupporttimes = 0
end

function SendFlowerModel:getShowSendCount()
	return self._showSendCount
end

function SendFlowerModel:getShowTakeCount()
	return self._showTakeCount
end

function SendFlowerModel:getRecordInfos()
	return self._recoredInfos or {}
end

function SendFlowerModel:setDailySupporttimes(times)
	self._dailySupporttimes = checkint(times)
end

function SendFlowerModel:getDailySupporttimes()
	return self._dailySupporttimes
end

function SendFlowerModel:getIsAbleToSupport()
	return self:getTimesOfSupport() > 0
end

function SendFlowerModel:getTimesOfSupport()
	local limitTimes = checkint(SendFlowerConfig.instance:getCommonParamByKey("SUPPORT_DAILY_TIMES_LIMIT"))

	return limitTimes - self._dailySupporttimes, limitTimes
end

function SendFlowerModel:updateFolwerInfos(msg)
	self._showSendCount = checkint(msg.sendCount)
	self._showTakeCount = checkint(msg.receiveCount)
end

function SendFlowerModel:updateRecordInfos(msg)
	self._recoredInfos = {}

	for _, info in ipairs(msg.records) do
		table.insert(self._recoredInfos, info)
	end

	return self._recoredInfos
end

function SendFlowerModel:getCurShowStr(charmValue)
	local value = checkint(charmValue)

	if value <= 1000 then
		return value
	elseif value > 1000 and value <= 10000 then
		return math.floor(value / 100) / 10 .. "K"
	else
		return math.floor(value / 1000) / 10 .. "W"
	end
end

SendFlowerModel.instance = SendFlowerModel.New()

return SendFlowerModel
