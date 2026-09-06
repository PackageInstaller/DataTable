-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/exploreunder/model/ExploreUnderDialogueFmtMo.lua

module("logic.extensions.exploreunder.model.ExploreUnderDialogueFmtMo", package.seeall)

local ExploreUnderDialogueFmtMo = class("ExploreUnderDialogueFmtMo", BaseCustomFmtMo)

function ExploreUnderDialogueFmtMo:updateCfg(activityId, creepsMasterId, dialogueId)
	self._activityId = activityId
	self._creepsMasterId = creepsMasterId
	self._dialogueId = dialogueId
	self._masterData = ExploreUnderConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._creepsCfg = ExploreUnderConfig.instance:getCreepsMasterCfgs(self._creepsMasterId)
end

function ExploreUnderDialogueFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.WinDesc

	self:setFormCondition(self._masterData.formCondition)

	self.isHideFmtZdl = true
end

function ExploreUnderDialogueFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIStateManager.instance:pushWithoutEnterState(ViewName.ExploreUnderChatEventView, self._dialogueId)
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		ExploreUnderController.instance:sendPM_ExploreUnderDialogueFightReq(self._activityId, simpleForm)
	end, nil)
end

function ExploreUnderDialogueFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function ExploreUnderDialogueFmtMo:getFmtInfoConfig()
	return self._masterData
end

return ExploreUnderDialogueFmtMo
