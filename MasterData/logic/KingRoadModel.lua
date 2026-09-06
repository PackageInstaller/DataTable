-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingroad/model/KingRoadModel.lua

module("logic.extensions.kingroad.model.KingRoadModel", package.seeall)

local KingRoadModel = class("KingRoadModel", BaseModel)

KingRoadModel.EState = {
	Strengthing = 3,
	NeedChallenge = 1,
	FinishChallenge = 2
}
KingRoadModel.COUNT_LIMIT = 2

function KingRoadModel:ctor()
	KingRoadModel.super.ctor(self)
	self:onReset()
end

function KingRoadModel:onReset()
	KingRoadModel.super.onReset(self)

	self._prizeInfos = {}
	self._isCanPopTip = false
	self._challengeLevel = 1
	self._totalZDL = 0
	self._totalSpeed = 0
	self.rcdTime = {}
end

function KingRoadModel:setPrizeInfos(prizeinfo, state, challengeLevel, totalZDL, totalSpeed)
	self._prizeInfos = prizeinfo
	self._xiuLianState = true
	self._challengeLevel = challengeLevel
	self._totalZDL = totalZDL
	self._totalSpeed = totalSpeed

	self:setRcdTime()
end

function KingRoadModel:getChallengeLevel()
	return self._challengeLevel
end

function KingRoadModel:getTotalZDL()
	return self._totalZDL
end

function KingRoadModel:getTotalSpeed()
	return self._totalSpeed
end

function KingRoadModel:setXiuLianing(state)
	self._xiuLianState = state
end

function KingRoadModel:getXiuLianState()
	if self._xiuLianState == false then
		return 1
	else
		return 3
	end
end

function KingRoadModel:setRcdTime()
	for i, k in ipairs(self._prizeInfos) do
		self.rcdTime[i] = ServerTime.now()
	end
end

function KingRoadModel:getPrizeState(index)
	if self._xiuLianState then
		local obj = self._prizeInfos[index]

		if obj.prizeGainTimes >= KingRoadModel.COUNT_LIMIT then
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

function KingRoadModel:setPrizeState(index, leftMillSec)
	self._prizeInfos[index].prizeGainTimes = self._prizeInfos[index].prizeGainTimes + 1

	self:updateTime(index, leftMillSec)
end

function KingRoadModel:updateTime(index, leftMillSec)
	self._prizeInfos[index].leftMillSec = leftMillSec
	self.rcdTime[index] = ServerTime.now()
	self._prizeInfos[index].finishChallenge = false
end

function KingRoadModel:getPrizeTime(index)
	return self._prizeInfos[index].leftMillSec / 1000
end

function KingRoadModel:getPrizeCount(index)
	return self._prizeInfos[index].prizeGainTimes + 1
end

function KingRoadModel:getTeamId(index)
	return self._prizeInfos[index].teamId
end

function KingRoadModel:setCanPopTip(isTrue)
	self._isCanPopTip = isTrue
end

function KingRoadModel:isCanPopTip()
	local battleResult = BattleController.instance:getLastBattleResult()

	if self._isCanPopTip then
		local isCanPop = battleResult == GameEnum.BattleResult.Success

		self._isCanPopTip = false

		return isCanPop
	end
end

KingRoadModel.instance = KingRoadModel.New()

return KingRoadModel
