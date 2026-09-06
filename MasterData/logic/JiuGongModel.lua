-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/model/JiuGongModel.lua

module("logic.extensions.challenge.model.JiuGongModel", package.seeall)

local JiuGongModel = class("JiuGongModel", BaseListModel)

JiuGongModel.COUNT_LIMIT = 2

function JiuGongModel:ctor()
	JiuGongModel.super.ctor(self)
	self:onReset()
end

function JiuGongModel:onReset()
	JiuGongModel.super.onReset(self)

	self._prizeInfos = {}
	self._isXiuLianing = false
	self.rcdTime = {}
end

function JiuGongModel:setPrizeInfos(prizeinfo, isstrengthing)
	self._prizeInfos = prizeinfo
	self._isXiuLianing = isstrengthing

	self:setRcdTime()
end

function JiuGongModel:setRcdTime()
	for i, k in ipairs(self._prizeInfos) do
		self.rcdTime[i] = ServerTime.now()
	end
end

function JiuGongModel:setXiuLianing(isstrengthing)
	self._isXiuLianing = isstrengthing
end

function JiuGongModel:isXiuLianing()
	return self._isXiuLianing
end

function JiuGongModel:getPrizeState(index)
	if self._isXiuLianing then
		local obj = self._prizeInfos[index]

		if obj.prizeGainTimes >= JiuGongModel.COUNT_LIMIT then
			return 0
		elseif self.rcdTime[index] + obj.leftMillSec / 1000 - ServerTime.now() <= 0 then
			if obj.finishChallenge then
				return 3
			else
				return 4
			end
		else
			return 1
		end
	else
		return 2
	end
end

function JiuGongModel:setPrizeState(index, leftMillSec)
	self._prizeInfos[index].prizeGainTimes = self._prizeInfos[index].prizeGainTimes + 1

	self:updateTime(index, leftMillSec)
end

function JiuGongModel:updateTime(index, leftMillSec)
	self._prizeInfos[index].leftMillSec = leftMillSec
	self.rcdTime[index] = ServerTime.now()
end

function JiuGongModel:updateFinishFlag(index, finishChallenge)
	self._prizeInfos[index].finishChallenge = finishChallenge
end

function JiuGongModel:getPrizeCount(index)
	return self._prizeInfos[index].prizeGainTimes + 1
end

function JiuGongModel:getPrizeTime(index)
	return self._prizeInfos[index].leftMillSec / 1000
end

function JiuGongModel:getTeamId(index)
	return self._prizeInfos[index].teamId
end

JiuGongModel.instance = JiuGongModel.New()

return JiuGongModel
