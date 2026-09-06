-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/model/OriginKingCiYuanDragonClgFmtMo.lua

module("logic.extensions.originkingciyuandragonclg.model.OriginKingCiYuanDragonClgFmtMo", package.seeall)

local OriginKingCiYuanDragonClgFmtMo = class("OriginKingCiYuanDragonClgFmtMo", BaseCustomFmtMo)

function OriginKingCiYuanDragonClgFmtMo:onReset()
	OriginKingCiYuanDragonClgFmtMo.super.onReset(self)
end

function OriginKingCiYuanDragonClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._subMo = OriginKingCiYuanDragonClgController.instance:getSubMo(self._activityId)

	local stageData = OriginKingCiYuanDragonClgConfig.instance:getStageData(self._activityId, self._stageId)

	self._creepsMasterId = stageData.creepsMasterId
	self._masterData = OriginKingCiYuanDragonClgConfig.instance:getMonsterData(self._creepsMasterId)
	self._creepsCfg = OriginKingCiYuanDragonClgConfig.instance:getCreepsDatas(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self._lockedRaceIdMap = {}

	local blockCount = self._subMo:getBlockCount()

	for blockId = 1, blockCount do
		local data = OriginKingCiYuanDragonClgConfig.instance:getStageDataByBlock(self._activityId, blockId, stageData.blockStageId)
		local lockRaceIds = self._subMo:getLockRaceIds(data.stageId)

		for k, v in pairs(lockRaceIds) do
			self._lockedRaceIdMap[v] = true
		end
	end
end

function OriginKingCiYuanDragonClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginKingCiYuanDragonClgController.instance:sendPM_OriginKingCiYuanDragonClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginKingCiYuanDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginKingCiYuanDragonClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginKingCiYuanDragonClgFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function OriginKingCiYuanDragonClgFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function OriginKingCiYuanDragonClgFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if OriginKingCiYuanDragonClgFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function OriginKingCiYuanDragonClgFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._lockedRaceIdMap[raceId]
end

return OriginKingCiYuanDragonClgFmtMo
