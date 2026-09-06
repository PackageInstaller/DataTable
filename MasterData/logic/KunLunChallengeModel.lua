-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/model/KunLunChallengeModel.lua

module("logic.extensions.kunlunchallenge.model.KunLunChallengeModel", package.seeall)

local KunLunChallengeModel = class("KunLunChallengeModel", BaseModel)

function KunLunChallengeModel:ctor()
	return
end

function KunLunChallengeModel:onInit()
	self:onReset()
end

function KunLunChallengeModel:onReset()
	self._dailyTimes = 0
	self._lockRaceIds = {}
	self._bossLeftHp = 0
	self._damage = 0
	self._extClgMoPool = self._extClgMoPool or {}

	table.clear(self._extClgMoPool)

	self._norClgCustomFmtMo = nil
	self._extClgCustomFmtMo = nil
end

function KunLunChallengeModel:handlePM_KunLunCommonClgInfoRes(msg)
	self._dailyTimes = msg.dailyTimes

	table.clear(self._lockRaceIds)
	table.insertto(self._lockRaceIds, msg.lockRaceIds)

	self._bossLeftHp = msg.bossLeftHp
end

function KunLunChallengeModel:handlePM_KunLunCommonClgFightRes(msg)
	return
end

function KunLunChallengeModel:handlePM_NotifyKunLunCommonClgFightEndRes(msg)
	self._damage = msg.damage
	self._bossLeftHp = msg.bossLeftHp
end

function KunLunChallengeModel:handlePM_KunLunExtremeClgInfoRes(msg)
	local extClgMo = self:getKunLunExtClgMo(msg.activityId)

	for _, v in ipairs(msg.stages) do
		extClgMo:setPassStage(v.stageId, v.isPass)
		extClgMo:setCardIdListOfStage(v.stageId, v.cardIds)
	end

	extClgMo:setAllStagePass(msg.isAllStagePass)
end

function KunLunChallengeModel:handlePM_KunLunExtremeClgSetCardRes(msg)
	local extClgMo = self:getKunLunExtClgMo(msg.activityId)

	extClgMo:setCardIdListOfStage(msg.stageId, msg.cardIds)
end

function KunLunChallengeModel:handlePM_KunLunExtremeClgResetStageRes(msg)
	local extClgMo = self:getKunLunExtClgMo(msg.activityId)

	extClgMo:setPassStage(msg.stageId, false)
	extClgMo:setCardIdListOfStage(msg.stageId, {})
end

function KunLunChallengeModel:handlePM_KunLunExtremeClgFightRes(msg)
	return
end

function KunLunChallengeModel:handlePM_NotifyKunLunExtremeClgFightEndRes(msg)
	local extClgMo = self:getKunLunExtClgMo(msg.activityId)

	extClgMo:setPassStage(msg.stageId, msg.isWin)
	extClgMo:setAllStagePass(msg.isAllStagePass)
end

function KunLunChallengeModel:getCustomFmtMoOfNorClg()
	if self._norClgCustomFmtMo == nil then
		self._norClgCustomFmtMo = KunLunNorClgCustomFmtMo.New()
	end

	return self._norClgCustomFmtMo
end

function KunLunChallengeModel:getCustomFmtMoOfExtClg()
	if self._extClgCustomFmtMo == nil then
		self._extClgCustomFmtMo = KunLunExtClgCustomFmtMo.New()
	end

	return self._extClgCustomFmtMo
end

function KunLunChallengeModel:getDailyTimesOfNorClg()
	return self._dailyTimes
end

function KunLunChallengeModel:getBossLeftHpOfNorClg()
	return self._bossLeftHp
end

function KunLunChallengeModel:getLockRaceIdsOfNorClg()
	return self._lockRaceIds
end

function KunLunChallengeModel:getDamageOfNorClg()
	return self._damage
end

function KunLunChallengeModel:getKunLunExtClgMo(activityId)
	if self._extClgMoPool[activityId] == nil then
		self._extClgMoPool[activityId] = KunLunExtClgMo.New(activityId)
	end

	return self._extClgMoPool[activityId]
end

KunLunChallengeModel.instance = KunLunChallengeModel.New()

return KunLunChallengeModel
