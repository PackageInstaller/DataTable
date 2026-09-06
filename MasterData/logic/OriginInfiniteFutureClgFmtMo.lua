-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origininfinitefutureclg/model/OriginInfiniteFutureClgFmtMo.lua

module("logic.extensions.origininfinitefutureclg.model.OriginInfiniteFutureClgFmtMo", package.seeall)

local OriginInfiniteFutureClgFmtMo = class("OriginInfiniteFutureClgFmtMo", BaseCustomFmtMo)

function OriginInfiniteFutureClgFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)

	local actCfg = OriginInfiniteFutureClgConfig.instance:getActivityCfg(activityId)
	local stageCfg = OriginInfiniteFutureClgConfig.instance:getStageCfgById(activityId, stageId)

	self._creepsMasterId = OriginInfiniteFutureClgConfig.instance:getCreepMasterId(activityId, stageId)
	self._masterData = OriginInfiniteFutureClgConfig.instance:getCreepMasterCfg(self._creepsMasterId) or {}
	self._creepsCfg = OriginInfiniteFutureClgConfig.instance:getCreepsCfg(self._creepsMasterId) or {}
	self._lockedRaceIdMap = OriginInfiniteFutureClgController.instance:getLockRaceIdMap(activityId) or {}
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	if actCfg then
		self.validatorDescStr = actCfg.stageTip or ""
	end

	self:setFormCondition(self._masterData.formCondition)
end

function OriginInfiniteFutureClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginInfiniteFutureClgController.instance:sendPM_OriginInfiniteFutureClgFightReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function OriginInfiniteFutureClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginInfiniteFutureClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginInfiniteFutureClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self:_isPetLock(petMo)
end

function OriginInfiniteFutureClgFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips(lang("该精灵已封印"))
end

function OriginInfiniteFutureClgFmtMo:_isPetLock(petMo)
	local raceId = petMo and checknumber(petMo.raceId) or 0

	return self._lockedRaceIdMap[raceId] ~= nil
end

return OriginInfiniteFutureClgFmtMo
