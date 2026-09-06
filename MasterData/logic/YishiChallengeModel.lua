-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yishichallenge/model/YishiChallengeModel.lua

module("logic.extensions.yishichallenge.model.YishiChallengeModel", package.seeall)

local YishiChallengeModel = class("YishiChallengeModel")

YishiChallengeModel.judgeTable = {
	{
		1,
		2,
		3
	},
	{
		4,
		5,
		6
	},
	{
		7,
		8,
		9
	},
	{
		1,
		5,
		9
	},
	{
		3,
		5,
		7
	},
	{
		1,
		4,
		7
	},
	{
		2,
		5,
		8
	},
	{
		3,
		6,
		9
	}
}

function YishiChallengeModel:ctor()
	return
end

function YishiChallengeModel:onInit()
	self:onReset()
end

function YishiChallengeModel:onReset()
	self._challengeId = 0
	self._stageId = 0
	self._survivals = {}
	self._stagePass = false
	self._stageUnlock = false
	self._fmtMoMap = {}
	self._signInBuffLv = 0
	self._todayCheckIn = false
end

function YishiChallengeModel:setChallengeId(id)
	self._challengeId = id
end

function YishiChallengeModel:getChallengeId()
	return self._challengeId
end

function YishiChallengeModel:getSurvivals()
	return self._survivals
end

function YishiChallengeModel:getStageId()
	return self._stageId
end

function YishiChallengeModel:getStagePass()
	if self._stagePass then
		return true
	end

	return false
end

function YishiChallengeModel:getStageUnlock()
	if self._stageUnlock then
		return true
	end

	return false
end

function YishiChallengeModel:getSignInBuffLv()
	return self._signInBuffLv
end

function YishiChallengeModel:getIsSignInBuff()
	return self._todayCheckIn
end

function YishiChallengeModel:setChallengeInfo(msg)
	self._stageId = msg.stageId
	self._survivals = GameUtil.pbToTable(msg.survivals)
	self._stagePass = msg.stagePass
	self._stageUnlock = msg.stageUnlock
	self._signInBuffLv = msg.signInBuffLv
	self._todayCheckIn = msg.todayCheckIn
end

function YishiChallengeModel:setUpgradeBuffInfo(msg)
	self._todayCheckIn = true
	self._signInBuffLv = msg.signInBuffLv
end

function YishiChallengeModel:getYishiCustomFmtMo(challengeId, stage)
	local fmtMo = self._fmtMoMap[challengeId]

	fmtMo = fmtMo or YishiChallengeCustomFmtMo.New()

	fmtMo:initParams(challengeId, stage)

	self._fmtMoMap[challengeId] = fmtMo

	return fmtMo
end

YishiChallengeModel.instance = YishiChallengeModel.New()

return YishiChallengeModel
