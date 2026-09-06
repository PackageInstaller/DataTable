-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinetuntian/model/DivineTunTianExtFmtMo.lua

module("logic.extensions.divinetuntian.model.DivineTunTianExtFmtMo", package.seeall)

local DivineTunTianExtFmtMo = class("DivineTunTianExtFmtMo", BaseCustomFmtMo)

function DivineTunTianExtFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._creepsMasterId = DivineTunTianConfig.instance:getExtCreepMasterId(activityId, stageId)
	self._masterData = DivineTunTianConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineTunTianConfig.instance:getCreepCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)

	self._lockedRaceIdMap = {}

	local lockRaceIds = DivineTunTianModel.instance:getLockRaceIds(activityId)

	for k, v in pairs(lockRaceIds) do
		self._lockedRaceIdMap[v] = true
	end
end

function DivineTunTianExtFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineTunTianController.instance:sendPM_DivineTunTianClgExtremeChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function DivineTunTianExtFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineTunTianExtFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineTunTianExtFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function DivineTunTianExtFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show("精灵已锁定,无法上阵")
	end
end

function DivineTunTianExtFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if DivineTunTianExtFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function DivineTunTianExtFmtMo:_isPetLock(petMo)
	local raceId = petMo and petMo:getDefineId() or 0

	return self._lockedRaceIdMap[raceId]
end

return DivineTunTianExtFmtMo
