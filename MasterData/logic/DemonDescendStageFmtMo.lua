-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/demondescend/model/DemonDescendStageFmtMo.lua

module("logic.extensions.demondescend.model.DemonDescendStageFmtMo", package.seeall)

local DemonDescendStageFmtMo = class("DemonDescendStageFmtMo", BaseCustomFmtMo)

function DemonDescendStageFmtMo:onReset()
	DemonDescendStageFmtMo.super.onReset(self)
end

function DemonDescendStageFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._subMo = DemonDescendController.instance:getSubMo(self._activityId)

	local stageData = DemonDescendConfig.instance:getStageData(activityId, stageId)

	self._creepsMasterId = stageData.creepsMasterId
	self._masterData = DemonDescendConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = DemonDescendConfig.instance:getCreepsCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DemonDescendStageFmtMo:getActivityId()
	return self._activityId
end

function DemonDescendStageFmtMo:getStageId()
	return self._stageId
end

function DemonDescendStageFmtMo:getCreepsMasterId()
	return self._creepsMasterId
end

function DemonDescendStageFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DemonDescendController.instance:sendPM_DemonDescendStageChallengeReq(self._activityId, simpleForm, self._stageId)
	end

	self:setFightHandler(handler, nil)
end

function DemonDescendStageFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DemonDescendStageFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DemonDescendStageFmtMo:getExtendViewName()
	return ViewName.DemonDescendStageExtisonView
end

return DemonDescendStageFmtMo
