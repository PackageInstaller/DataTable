-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/parallelkingdragon/model/ParallelkingdragonFmtMo.lua

module("logic.extensions.parallelkingdragon.model.ParallelkingdragonFmtMo", package.seeall)

local ParallelkingdragonFmtMo = class("ParallelkingdragonFmtMo", BaseCustomFmtMo)

function ParallelkingdragonFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._stageCfg = ParallelkingdragonConfig.instance:getStageCfg(activityId, stageId)
	self._creepsMasterId = self._stageCfg.creepsMasterId
	self._masterData = ParallelkingdragonConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = ParallelkingdragonConfig.instance:getCreepsCfgs(self._creepsMasterId)
end

function ParallelkingdragonFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = ""
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function ParallelkingdragonFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		ParallelKingDragonAgent.instance:sendPM_ParallelKingDragonChallengeReq(self._activityId, simpleForm, self._stageId)
	end

	self:setFightHandler(handler, nil)
end

function ParallelkingdragonFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function ParallelkingdragonFmtMo:getFmtInfoConfig()
	return self._masterData
end

function ParallelkingdragonFmtMo:getExtendViewName()
	return ViewName.ParallelkingdragonextView
end

return ParallelkingdragonFmtMo
