-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingwujinlong/model/KingWujinlongFmtMo.lua

module("logic.extensions.kingwujinlong.model.KingWujinlongFmtMo", package.seeall)

local KingWujinlongFmtMo = class("KingWujinlongFmtMo", BaseCustomFmtMo)

function KingWujinlongFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self._lockedRaceMap = KingWujinlongModel.instance:getAllLimitPetMap(self.activityId)

	local cfg = KingWujinlongConfig.instance:getStageCfgById(activityId, phaseId + 1) or {}

	self.creepsMasterId = cfg.creepsMasterId
	self.masterCfg = KingWujinlongConfig.instance:getMonsterCfgById(self.creepsMasterId)
	self.creeps = KingWujinlongConfig.instance:getCreepsById(self.creepsMasterId)

	self:setFormCondition(self.masterCfg.formCondition)

	self.isShowTab = false
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_None
	self.strShowRuleFlagKey = "KingWujinlongFmtMo" .. self.activityId .. "_" .. self.creepsMasterId
	self.topTitleStr = self.masterCfg.name
	self.ruleDescStr = self.masterCfg.ruleDesc
	self.isPopRuleDesc = true
end

function KingWujinlongFmtMo:getMonsterConfigList()
	return self.creeps
end

function KingWujinlongFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function KingWujinlongFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		KingWujinlongController.instance:sendStartFight(self.activityId, self:getCurSimpleForm())
	end, nil)
end

function KingWujinlongFmtMo:getExtendViewName()
	return ViewName.KingwujinlongextView
end

function KingWujinlongFmtMo:checkPetIsForbit(petMo, baseCheck)
	return checkbool(self._lockedRaceMap[petMo.raceId])
end

function KingWujinlongFmtMo:showForbitPetAlert(petMo)
	TipsFacade.instance:openCommonTips("该精灵已封印")
end

return KingWujinlongFmtMo
