-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineqingguclg/model/DivineQingGuClgFmtMo.lua

module("logic.extensions.divineqingguclg.model.DivineQingGuClgFmtMo", package.seeall)

local DivineQingGuClgFmtMo = class("DivineQingGuClgFmtMo", BaseCustomFmtMo)

function DivineQingGuClgFmtMo:initParams(activityId, stageId)
	self._activityId = activityId
	self._stageId = stageId

	local cfgStage = DivineQingGuClgConfig.instance:getStage(activityId, stageId)

	self._monsterCfg = DivineQingGuClgConfig.instance:getMaster(cfgStage.creepsMasterId)
	self._creepsCfgs = DivineQingGuClgConfig.instance:getCreeps(cfgStage.creepsMasterId)
	self.topTitleStr = self._monsterCfg.name
	self.ruleDescStr = self._monsterCfg.ruleDesc

	self:setFormCondition(self._monsterCfg.formCondition)

	self.isShowRuleDescToggle = true
	self.ruleDescToggleName = self._monsterCfg.name
	self.ruleDestToggleDesc = "今日不再自动提示规则"
	self.nEnterShowRuleFlag = ICustomFmtMo.EEnterShowRuleFlag_Always
	self.strShowRuleFlagKey = "divineqingguclgfmtmo_" .. self._activityId .. "_" .. self._stageId
end

function DivineQingGuClgFmtMo:initFightHandler()
	local function handler()
		local form = self:getCurSimpleForm()

		DivineQingGuClgAgent.instance:sendPM_DivineQingGuClgFightReq(self._activityId, self._stageId, form)
	end

	self:setFightHandler(handler, nil)
end

function DivineQingGuClgFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function DivineQingGuClgFmtMo:getFmtInfoConfig()
	return self._monsterCfg
end

return DivineQingGuClgFmtMo
