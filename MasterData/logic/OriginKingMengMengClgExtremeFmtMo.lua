-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/model/OriginKingMengMengClgExtremeFmtMo.lua

module("logic.extensions.originkingmengmengclg.model.OriginKingMengMengClgExtremeFmtMo", package.seeall)

local OriginKingMengMengClgExtremeFmtMo = class("OriginKingMengMengClgExtremeFmtMo", OriginKingMengMengClgBaseFmtMo)

function OriginKingMengMengClgExtremeFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._subMo = OriginKingMengMengClgController.instance:getSubMo(self._activityId)
	self._stageData = OriginKingMengMengClgConfig.instance:getStageData(self._activityId, self._stageId)
	self._creepsMasterId = self._stageData.extremeClgCreepsMasterId
	self._mustOnFormPetFilter = self._stageData.mustOnFormPetFilter
	self._masterData = OriginKingMengMengClgConfig.instance:getCreepsMasterData(self._creepsMasterId)
	self._creepsCfg = OriginKingMengMengClgConfig.instance:getCreepsDatas(self._creepsMasterId)
	self._lockedRaceIdMap = self._subMo:getAllLockRaceIdMap()
	self.topTitleStr = self._masterData.name or ""
	self.ruleDescStr = self._masterData.ruleDesc or self._masterData.WinDesc or ""
	self.validatorDescStr = self._masterData.ruleDesc or ""

	self:setFormCondition(self._masterData.formCondition)
end

function OriginKingMengMengClgExtremeFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginKingMengMengClgController.instance:sendPM_OriginKingMengMengClgExtremeFightReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function OriginKingMengMengClgExtremeFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginKingMengMengClgExtremeFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginKingMengMengClgExtremeFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLocked(petMo)
end

function OriginKingMengMengClgExtremeFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLocked(petMo) then
		FloatWordMgr.instance:show("该精灵已在其他关卡使用")
	end
end

function OriginKingMengMengClgExtremeFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if OriginKingMengMengClgExtremeFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLocked(petMo)
	end

	return false
end

function OriginKingMengMengClgExtremeFmtMo:_isCandidatePetValid(petMo)
	return not self:_isPetLocked(petMo)
end

function OriginKingMengMengClgExtremeFmtMo:_isPetLocked(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._lockedRaceIdMap[raceId] == true
end

return OriginKingMengMengClgExtremeFmtMo
