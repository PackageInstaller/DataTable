-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/TLChallengeModel.lua

module("logic.extensions.timelimitedchallenge.model.TLChallengeModel", package.seeall)

local TLChallengeModel = class("TLChallengeModel", BaseModel)

function TLChallengeModel:ctor()
	return
end

function TLChallengeModel:onInit()
	self:onReset()
end

function TLChallengeModel:onReset()
	self._infoDic = {}
	self._exchangeInfoDic = {}
end

function TLChallengeModel:setFightInfo(challengeId, value)
	self._infoDic[challengeId] = value
end

function TLChallengeModel:getFightInfo(challengeId)
	return self._infoDic[challengeId]
end

function TLChallengeModel:setExchangeInfo(challengeId, value)
	self._exchangeInfoDic[challengeId] = value
end

function TLChallengeModel:getExchangeInfo(challengeId)
	return self._exchangeInfoDic[challengeId]
end

function TLChallengeModel:doExchange(challengeId, msg)
	local infoList = self._exchangeInfoDic[challengeId]

	if infoList then
		for _, v in ipairs(infoList) do
			if v.exchangeId == msg.exchangeId then
				v.dailyTimes = msg.dailyTimes
				v.totalTimes = msg.totalTimes
			end
		end
	end
end

function TLChallengeModel:getExchangeInfoByIds(challengeId, exchangeId)
	local infoList = self._exchangeInfoDic[challengeId]

	if infoList then
		for _, v in ipairs(infoList) do
			if v.exchangeId == exchangeId then
				return v
			end
		end
	end
end

function TLChallengeModel:isDailyRedActive(challengeId)
	if challengeId == 13 then
		return ElizabethModel.instance:isDailyFirstIn()
	else
		return false
	end
end

TLChallengeModel.instance = TLChallengeModel.New()

return TLChallengeModel
