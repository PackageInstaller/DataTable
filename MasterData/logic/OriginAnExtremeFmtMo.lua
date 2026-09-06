-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/model/OriginAnExtremeFmtMo.lua

module("logic.extensions.originan.model.OriginAnExtremeFmtMo", package.seeall)

local OriginAnExtremeFmtMo = class("OriginAnExtremeFmtMo", BaseCustomFmtMo)

function OriginAnExtremeFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._subMo = OriginAnController.instance:getSubMo(self._activityId)
	self._stageData = OriginAnConfig.instance:getExtremeStageData(self._activityId, self._stageId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = OriginAnConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = OriginAnConfig.instance:getCreepsDatas(self._creepsMasterId)
	self.topTitleStr = self._masterData.name or ""
	self.validatorDescStr = self._masterData.missionDesc or ""

	self:setFormCondition(self._masterData.formCondition)

	self.ruleDescStr = "光圈站位上的精灵战斗开始后将被眩晕"
	self._lockedRaceIdMap = {}

	local raceIdList = self._subMo:getAllExtremeBanRace()

	for _, raceId in pairs(raceIdList) do
		self._lockedRaceIdMap[raceId] = true
	end

	for posId = 1, 9 do
		local count = self._subMo:getDizzyCountExtreme(posId)

		if count > 0 then
			self:setFixedEffect(posId, "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab")
		end
	end
end

function OriginAnExtremeFmtMo:getActivityId()
	return self._activityId
end

function OriginAnExtremeFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginAnController.instance:sendPM_OriginAnExtremeClgReq(self._activityId, simpleForm, self._stageId)
	end, nil)
end

function OriginAnExtremeFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginAnExtremeFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginAnExtremeFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function OriginAnExtremeFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已封印,无法上阵")
	end
end

function OriginAnExtremeFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if OriginAnExtremeFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function OriginAnExtremeFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._lockedRaceIdMap[raceId]
end

function OriginAnExtremeFmtMo:getExtendViewName()
	return ViewName.OriginAnExtremeFmtExView
end

return OriginAnExtremeFmtMo
