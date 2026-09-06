-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/model/DrogonLordsModel.lua

module("logic.extensions.dragonlords.model.DrogonLordsModel", package.seeall)

local DrogonLordsModel = class("DrogonLordsModel", BaseModel)

function DrogonLordsModel:ctor()
	return
end

function DrogonLordsModel:onInit()
	self:onReset()
end

function DrogonLordsModel:onReset()
	self.activityId = 0
	self.passNum = 0
	self.curLimitStage = 0
	self.lockPetIds = {}
	self.curNormalStageAllInfo = {}
	self.curNormalAllInfo = {}
	self._customFmtMo = nil
	self._limitCustomFmtMo = nil
	self._normalChallengeEnd = {}
	self._limitChallengeEnd = {}
	self._changeSetId = nil
	self._lastDrawItems = nil
	self._lastDrawQuas = nil
	self._lastScore = 0
end

function DrogonLordsModel:getActivityId()
	if self.activityId <= 0 then
		self.activityId = DragonLordsConfig.instance:getOpenActivityId()
	end

	return self.activityId
end

function DrogonLordsModel:setPassNum(num)
	self.passNum = num
end

function DrogonLordsModel:getPassNum()
	return self.passNum
end

function DrogonLordsModel:setLimitChallengeInfo(info)
	self.passNum = info.passNum
	self.lockPetIds = info.lockPetIds
	self.curLimitStage = info.curStage
end

function DrogonLordsModel:getCurLimitStage()
	return self.curLimitStage
end

function DrogonLordsModel:getLockPetIds()
	return self.lockPetIds
end

function DrogonLordsModel:setNormalStageInfo(info)
	self.curNormalStageAllInfo.curStageId = info.curStageId
	self.curNormalStageAllInfo.buffIds = info.buffIds
	self.curNormalStageAllInfo.dailyMaxScore = info.dailyMaxScore
	self.curNormalStageAllInfo.curScore = info.curScore
	self.curNormalStageAllInfo.curstagePlanId = info.curstagePlanId
end

function DrogonLordsModel:getNormalStageInfo()
	return self.curNormalStageAllInfo
end

function DrogonLordsModel:setLastScore(score)
	self._lastScore = score
end

function DrogonLordsModel:getLastScore()
	return self._lastScore
end

function DrogonLordsModel:setNormalInfo(info)
	self.curNormalAllInfo.fusionTimes = info.fusionTimes
	self.curNormalAllInfo.userNamesOfRank = info.userNamesOfRank
	self.curNormalAllInfo.infos = info.infos
end

function DrogonLordsModel:getNormalInfo()
	return self.curNormalAllInfo
end

function DrogonLordsModel:setNormalChallengeEnd(msg)
	self._normalChallengeEnd = msg
end

function DrogonLordsModel:setNormalChallengeScore(score)
	self._normalChallengeEnd.curScore = score
end

function DrogonLordsModel:getNormalChallengeEnd()
	return self._normalChallengeEnd
end

function DrogonLordsModel:setLimitChallengeEnd(msg)
	self._limitChallengeEnd = {}
	self._limitChallengeEnd.curStage = msg.curStage
	self._limitChallengeEnd.passNum = msg.passNum
	self._limitChallengeEnd.lockPetIds = msg.lockPetIds
end

function DrogonLordsModel:getLimitChallengeEnd()
	return self._limitChallengeEnd
end

function DrogonLordsModel:getCustomFmtMo()
	self._customFmtMo = self._customFmtMo or DrogonLordsCustomFmtMo.New()

	return self._customFmtMo
end

function DrogonLordsModel:getLimitCustomFmtMo()
	self._limitCustomFmtMo = self._limitCustomFmtMo or DrogonLordsLimitCustomFmtMo.New()

	return self._limitCustomFmtMo
end

function DrogonLordsModel:setChangeSetId(value)
	self._changeSetId = value
end

function DrogonLordsModel:getChangeSetId()
	return self._changeSetId
end

function DrogonLordsModel:setLastDrawItems(value)
	self._lastDrawItems = value
end

function DrogonLordsModel:getLastDrawItems()
	return self._lastDrawItems
end

function DrogonLordsModel:setLastDrawQuas(value)
	self._lastDrawQuas = value
end

function DrogonLordsModel:getLastDrawQuas()
	return self._lastDrawQuas
end

DrogonLordsModel.instance = DrogonLordsModel.New()

return DrogonLordsModel
