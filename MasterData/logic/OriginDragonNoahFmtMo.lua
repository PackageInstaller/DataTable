-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/model/OriginDragonNoahFmtMo.lua

module("logic.extensions.origindragonnoah.model.OriginDragonNoahFmtMo", package.seeall)

local OriginDragonNoahFmtMo = class("OriginDragonNoahFmtMo", BaseCustomFmtMo)

function OriginDragonNoahFmtMo:updateCfg(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)

	local stageCfg = OriginDragonNoahConfig.instance:getStageCfgById(activityId, stageId)

	self._creepsMasterId = OriginDragonNoahConfig.instance:getCreepMasterId(activityId, stageId)
	self._masterData = OriginDragonNoahConfig.instance:getCreepMasterCfg(self._creepsMasterId)
	self._creepsCfg = OriginDragonNoahConfig.instance:getCreepsCfg(self._creepsMasterId)
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc
	self.validatorDescStr = stageCfg.fmtRule
	self._lockRaceIdMap = OriginDragonNoahModel.instance:getLockRaceIdMap(activityId)

	self:setFormCondition(self._masterData.formCondition)
end

function OriginDragonNoahFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginDragonNoahController:sendPM_OriginDragonNoahClgChallengeReq(self._activityId, self._stageId, simpleForm)
	end, nil)
end

function OriginDragonNoahFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OriginDragonNoahFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginDragonNoahFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OriginDragonNoahFmtMo:checkPetIsForbit(petMo, baseCheck)
	return self._lockRaceIdMap[petMo.raceId] ~= nil
end

function OriginDragonNoahFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return OriginDragonNoahFmtMo
