-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/model/DivineJieShenNorStageCustomFmtMo.lua

module("logic.extensions.divinejieshen.model.DivineJieShenNorStageCustomFmtMo", package.seeall)

local DivineJieShenNorStageCustomFmtMo = class("DivineJieShenNorStageCustomFmtMo", BaseCustomFmtMo)

function DivineJieShenNorStageCustomFmtMo:onReset()
	DivineJieShenNorStageCustomFmtMo.super.onReset(self)
end

function DivineJieShenNorStageCustomFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = DivineJieShenConfig.instance:getNorStageData(self._activityId, self._stageId)

	self._creepsMasterId = stageData.creepsMasterId
	self._masterData = DivineJieShenConfig.instance:getClgMonsterData(self._creepsMasterId)
	self._creepsCfg = DivineJieShenConfig.instance:getClgCreepsCfg(self._creepsMasterId)
end

function DivineJieShenNorStageCustomFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineJieShenNorStageCustomFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineJieShenController.instance:sendPM_DivineJieShenClgNormalChallengeStageReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineJieShenNorStageCustomFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineJieShenNorStageCustomFmtMo:getFmtInfoConfig()
	return self._masterData
end

return DivineJieShenNorStageCustomFmtMo
