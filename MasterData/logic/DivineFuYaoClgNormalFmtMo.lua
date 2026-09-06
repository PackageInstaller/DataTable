-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/model/DivineFuYaoClgNormalFmtMo.lua

module("logic.extensions.divinefuyaoclg.model.DivineFuYaoClgNormalFmtMo", package.seeall)

local DivineFuYaoClgNormalFmtMo = class("DivineFuYaoClgNormalFmtMo", BaseCustomFmtMo)

function DivineFuYaoClgNormalFmtMo:updateCfg(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local stageData = DivineFuYaoClgConfig.instance:getNormalStageData(self._activityId, stageId)
	local creepsMasterId = stageData.creepsMasterId

	self._subMo = DivineFuYaoClgController.instance:getSubMo(self._activityId)
	self._masterData = DivineFuYaoClgConfig.instance:getMasterData(creepsMasterId)
	self._creepsCfg = DivineFuYaoClgConfig.instance:getCreepsData(creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)
end

function DivineFuYaoClgNormalFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView, ViewName.ItemGet)

		local simpleForm = self:getCurSimpleForm()

		DivineFuYaoClgController.instance:sendPM_DivineFuYaoClgNormalChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function DivineFuYaoClgNormalFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function DivineFuYaoClgNormalFmtMo:getFmtInfoConfig()
	return self._masterData
end

return DivineFuYaoClgNormalFmtMo
