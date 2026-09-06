-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/model/HeartOfAoJiuClgFmtMo.lua

module("logic.extensions.heartofaojiuclg.model.HeartOfAoJiuClgFmtMo", package.seeall)

local HeartOfAoJiuClgFmtMo = class("HeartOfAoJiuClgFmtMo", BaseCustomFmtMo)

function HeartOfAoJiuClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = HeartOfAoJiuClgConfig.instance:getStageData(self._activityId, stageId)
	local creepsMasterId = stageData.creepsMasterId

	self._subMo = HeartOfAoJiuClgController.instance:getSubMo(self._activityId)
	self._masterData = HeartOfAoJiuClgConfig.instance:getMonsterData(creepsMasterId)
	self._creepsCfg = HeartOfAoJiuClgConfig.instance:getCreepsData(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function HeartOfAoJiuClgFmtMo:getActivityId()
	return self._activityId
end

function HeartOfAoJiuClgFmtMo:getStageId()
	return self._stageId
end

function HeartOfAoJiuClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		HeartOfAoJiuClgController.instance:sendPM_HeartOfAoJiuClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function HeartOfAoJiuClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function HeartOfAoJiuClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function HeartOfAoJiuClgFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local hp = self._subMo:getPetHp(petMo:getDefineId())
		local hpRatio = hp / 10000

		proxy.binder:onUpdateHp(hpRatio)
	end
end

function HeartOfAoJiuClgFmtMo:checkPetIsForbit(petMo)
	return self:_isPetLock(petMo)
end

function HeartOfAoJiuClgFmtMo:showForbitPetAlert(petMo)
	if self:_isPetLock(petMo) then
		FloatWordMgr.instance:show(lang("moyanfmtrightview__1"))
	end
end

function HeartOfAoJiuClgFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if HeartOfAoJiuClgFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetLock(petMo)
	else
		return false
	end
end

function HeartOfAoJiuClgFmtMo:_isPetLock(petMo)
	local result = false

	if petMo then
		local hpRatio = self._subMo:getPetHp(petMo:getDefineId())

		result = hpRatio and hpRatio <= 0 or false
	end

	return result
end

return HeartOfAoJiuClgFmtMo
