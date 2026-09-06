-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/model/OriginJiuBossFmtMo.lua

module("logic.extensions.originjiu.model.OriginJiuBossFmtMo", package.seeall)

local OriginJiuBossFmtMo = class("OriginJiuBossFmtMo", BaseCustomFmtMo)

function OriginJiuBossFmtMo:initParams(activityId, modelId)
	self._activityId = activityId
	self._modelId = modelId

	OriginJiuModel.instance:resetAllPetLockState(activityId, modelId)

	local modelData = OriginJiuConfig.instance:getModelData(activityId, modelId)
	local creepsMasterId = modelData.bossCreepsMasterId

	self._masterData = OriginJiuConfig.instance:getTeamData(creepsMasterId)
	self._creepsCfg = OriginJiuConfig.instance:getCreepsDatas(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginJiuBossFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginJiuClgAgent.instance:sendPM_OriginJiuClgBossChallengeReq(self._activityId, self._modelId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OriginJiuBossFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginJiuBossFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginJiuBossFmtMo:checkPetIsForbit(petMo, baseCheck)
	return OriginJiuModel.instance:checkLockPet(petMo)
end

return OriginJiuBossFmtMo
