-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/model/IntegrationChallengeModel.lua

module("logic.extensions.twindragonchallenge.model.IntegrationChallengeModel", package.seeall)

local IntegrationChallengeModel = class("IntegrationChallengeModel", BaseModel)

IntegrationChallengeModel.TwinDragon = 1

function IntegrationChallengeModel:onReset()
	IntegrationChallengeModel.super.onReset(self)

	self._finishFlag = false
end

function IntegrationChallengeModel:setChallengeStatus(challengeStatus)
	self._challengeStatus = challengeStatus
end

function IntegrationChallengeModel:getChallengeStatus()
	return self._challengeStatus
end

function IntegrationChallengeModel:setRound(roundList)
	self._roundList = roundList
end

function IntegrationChallengeModel:getRound()
	return self._roundList
end

function IntegrationChallengeModel:setBuffLevel(buffLevel)
	self._buffLevel = buffLevel
end

function IntegrationChallengeModel:getBuffLevel()
	return self._buffLevel
end

function IntegrationChallengeModel:setHasGainedBuff(hasGainedBuff)
	self._hasGainedBuff = hasGainedBuff
end

function IntegrationChallengeModel:getHasGainedBuff()
	return self._hasGainedBuff
end

function IntegrationChallengeModel:setFinishChallenge(flag)
	self._finishFlag = flag
end

function IntegrationChallengeModel:getFinishChallenge()
	return self._finishFlag
end

IntegrationChallengeModel.instance = IntegrationChallengeModel.New()

return IntegrationChallengeModel
