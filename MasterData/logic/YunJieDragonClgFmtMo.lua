-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/model/YunJieDragonClgFmtMo.lua

module("logic.extensions.yunjiedragonclg.model.YunJieDragonClgFmtMo", package.seeall)

local YunJieDragonClgFmtMo = class("YunJieDragonClgFmtMo", BaseCustomFmtMo)

function YunJieDragonClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._creepsMasterId = YunJieDragonClgConfig.instance:getCreepMasterId(activityId, stageId)
	self._masterData = YunJieDragonClgConfig.instance:getMasterCfg(self._creepsMasterId)
	self._creepsCfg = YunJieDragonClgConfig.instance:getCreepCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function YunJieDragonClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		YunJieDragonClgController.instance:sendPM_YunJieDragonClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function YunJieDragonClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function YunJieDragonClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

return YunJieDragonClgFmtMo
