-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/model/OriginXiuErFmtMo.lua

module("logic.extensions.originxiuer.model.OriginXiuErFmtMo", package.seeall)

local OriginXiuErFmtMo = class("OriginXiuErFmtMo", BaseCustomFmtMo)

function OriginXiuErFmtMo:updateCfg(activityId, stageId)
	self._proxyPool = {}
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)

	local stageCfg = OriginXiuErConfig.instance:getStageCfgById(activityId, stageId)

	self._creepsMasterId = OriginXiuErConfig.instance:getCreepMasterId(activityId, stageId)
	self._masterData = OriginXiuErConfig.instance:getCreepMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginXiuErConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._lockPetMap, self._unlockPetMap = OriginXiuErController.instance:getLockAndUnlockPetMap(activityId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.validatorDescStr = stageCfg.fmtRule

	self:setFormCondition(self._masterData.formCondition)
end

function OriginXiuErFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginXiuErController:sendPM_OriginXiuErChallengeReq(self._activityId, simpleForm, self._stageId)
	end, nil)
end

function OriginXiuErFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginXiuErFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginXiuErFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginXiuErFmtMo:getExtendViewName()
	return ViewName.OriginXiuErFmtView
end

function OriginXiuErFmtMo:getActivityId()
	return self._activityId
end

function OriginXiuErFmtMo:getStageId()
	return self._stageId
end

function OriginXiuErFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self._lockPetMap[petMo.raceId] ~= nil
end

function OriginXiuErFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return OriginXiuErFmtMo
