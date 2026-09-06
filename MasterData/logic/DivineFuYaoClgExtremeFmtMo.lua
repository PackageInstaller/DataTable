-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/model/DivineFuYaoClgExtremeFmtMo.lua

module("logic.extensions.divinefuyaoclg.model.DivineFuYaoClgExtremeFmtMo", package.seeall)

local DivineFuYaoClgExtremeFmtMo = class("DivineFuYaoClgExtremeFmtMo", BaseCustomFmtMo)

function DivineFuYaoClgExtremeFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = DivineFuYaoClgConfig.instance:getExtremeStageData(self._activityId, stageId)
	local creepsMasterId = stageData.creepsMasterId

	self._subMo = DivineFuYaoClgController.instance:getSubMo(self._activityId)
	self._masterData = DivineFuYaoClgConfig.instance:getMasterData(creepsMasterId)
	self._creepsCfg = DivineFuYaoClgConfig.instance:getCreepsData(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self._lockedRaceIdMap = {}

	local lockRaceIds = self._subMo:getLockRaceIdList()

	for k, v in pairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = true
	end
end

function DivineFuYaoClgExtremeFmtMo:getActivityId()
	return self._activityId
end

function DivineFuYaoClgExtremeFmtMo:getStageId()
	return self._stageId
end

function DivineFuYaoClgExtremeFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView, ViewName.ItemGet)

		local simpleForm = self:getCurSimpleForm()

		DivineFuYaoClgController.instance:sendPM_DivineFuYaoClgExtremeChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function DivineFuYaoClgExtremeFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineFuYaoClgExtremeFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineFuYaoClgExtremeFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function DivineFuYaoClgExtremeFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function DivineFuYaoClgExtremeFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DivineFuYaoClgExtremeFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function DivineFuYaoClgExtremeFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._lockedRaceIdMap[raceId]
end

return DivineFuYaoClgExtremeFmtMo
