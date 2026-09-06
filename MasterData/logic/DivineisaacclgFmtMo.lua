-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/model/DivineisaacclgFmtMo.lua

module("logic.extensions.divineisaacclg.model.DivineisaacclgFmtMo", package.seeall)

local DivineisaacclgFmtMo = class("DivineisaacclgFmtMo", BaseCustomFmtMo)

function DivineisaacclgFmtMo:initParams(activityId, phase, stageId, creepsMasterId)
	self._activityId = activityId
	self._phaseId = phase
	self._stageId = stageId
	self._creepsMasterId = creepsMasterId

	local usePuppetsKv = DivineisaacclgModel.instance:getUsePuppets(self._activityId, self._phaseId)

	self._usePuppets = table.values(usePuppetsKv)
	self._masterData = DivineisaacclgConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = DivineisaacclgConfig.instance:getCreepsCfgs(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineisaacclgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		DivineIsaacClgAgent.instance:sendPM_DivineIsaacClgChallengeReq(self._activityId, self._phaseId, self._stageId, self._usePuppets, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function DivineisaacclgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineisaacclgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function DivineisaacclgFmtMo:getExtendViewName()
	return ViewName.DivineisaacclgextView
end

function DivineisaacclgFmtMo:setUsePupPets(list)
	self._usePuppets = list
end

return DivineisaacclgFmtMo
