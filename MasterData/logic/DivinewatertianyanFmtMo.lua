-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinewatertianyan/model/DivinewatertianyanFmtMo.lua

module("logic.extensions.divinewatertianyan.model.DivinewatertianyanFmtMo", package.seeall)

local DivinewatertianyanFmtMo = class("DivinewatertianyanFmtMo", BaseCustomFmtMo)

function DivinewatertianyanFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._stageCfg = DivinewatertianyanConfig.instance:getStageCfg(activityId, stageId)
	self._stageType = self._stageCfg.stageType
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = DivinewatertianyanConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivinewatertianyanConfig.instance:getCreepsCfgs(self._creepsMasterId)
end

function DivinewatertianyanFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = ""
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
	self:getCurFormation():SetPosition(self._stageCfg.supportPetPosition, self._stageCfg.supportPetCreepsId)
end

function DivinewatertianyanFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineWaterTianYanClgAgent.instance:sendPM_DivineWaterTianYanClgFightReq(self._activityId, self._stageId, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivinewatertianyanFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivinewatertianyanFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivinewatertianyanFmtMo:getStageType()
	return self._stageType
end

function DivinewatertianyanFmtMo:getStageCfg()
	return self._stageCfg
end

function DivinewatertianyanFmtMo:getActId()
	return self._activityId
end

function DivinewatertianyanFmtMo:getExtendViewName()
	return ViewName.DivinewatertianyanextView
end

return DivinewatertianyanFmtMo
