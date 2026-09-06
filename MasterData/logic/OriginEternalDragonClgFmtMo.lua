-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origineternaldragonclg/model/OriginEternalDragonClgFmtMo.lua

module("logic.extensions.origineternaldragonclg.model.OriginEternalDragonClgFmtMo", package.seeall)

local OriginEternalDragonClgFmtMo = class("OriginEternalDragonClgFmtMo", BaseCustomFmtMo)

function OriginEternalDragonClgFmtMo:updateCfg(activityId, type, stageId)
	self._activityId = checknumber(activityId)
	self._type = checknumber(type)
	self._stageId = checknumber(stageId)
	self._creepsMasterId = OriginEternalDragonClgConfig.instance:getCreepMasterId(activityId, type, stageId)
	self._masterData = OriginEternalDragonClgConfig.instance:getCreepMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginEternalDragonClgConfig.instance:getCreepsCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OriginEternalDragonClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginEternalDragonClgController.instance:sendPM_OriginEternalDragonClgFightReq(self._activityId, self._type, self._stageId, simpleForm)
	end, nil)
end

function OriginEternalDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginEternalDragonClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

return OriginEternalDragonClgFmtMo
