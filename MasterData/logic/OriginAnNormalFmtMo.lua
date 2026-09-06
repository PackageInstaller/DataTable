-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/model/OriginAnNormalFmtMo.lua

module("logic.extensions.originan.model.OriginAnNormalFmtMo", package.seeall)

local OriginAnNormalFmtMo = class("OriginAnNormalFmtMo", BaseCustomFmtMo)

function OriginAnNormalFmtMo:updateCfg(activityId, groupId, stageId)
	self._activityId = activityId
	self._stageId = stageId
	self._groupId = groupId
	self._stageData = OriginAnConfig.instance:getNormalStageData(self._activityId, self._groupId, self._stageId)
	self._creepsMasterId = self._stageData.creepsMasterId
	self._masterData = OriginAnConfig.instance:getMasterData(self._creepsMasterId)
	self._creepsCfg = OriginAnConfig.instance:getCreepsDatas(self._creepsMasterId)
	self.topTitleStr = self._masterData.name or ""
	self.validatorDescStr = self._masterData.missionDesc or ""
	self.ruleDescStr = self._masterData.WinDesc or ""

	self:setFormCondition(self._masterData.formCondition)

	self.useMaxFightPower = true
end

function OriginAnNormalFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginAnController.instance:sendPM_OriginAnNormalClgReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function OriginAnNormalFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginAnNormalFmtMo:getFmtInfoConfig()
	return self._masterData
end

return OriginAnNormalFmtMo
