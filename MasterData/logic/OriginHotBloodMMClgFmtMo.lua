-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhotbloodmmclg/model/OriginHotBloodMMClgFmtMo.lua

module("logic.extensions.originhotbloodmmclg.model.OriginHotBloodMMClgFmtMo", package.seeall)

local OriginHotBloodMMClgFmtMo = class("OriginHotBloodMMClgFmtMo", BaseCustomFmtMo)

function OriginHotBloodMMClgFmtMo:onReset()
	OriginHotBloodMMClgFmtMo.super.onReset(self)

	self._activityId = 0
	self._stageId = 0
	self._stageCfg = nil
	self._cfgEnemy = nil
	self._masterList = nil
end

function OriginHotBloodMMClgFmtMo:initParams(activityId, stageId)
	self._activityId = checknumber(activityId)
	self._stageId = checknumber(stageId)
	self._stageCfg = OriginHotBloodMMClgConfig.instance:getStage(self._activityId, self._stageId)
	self._cfgEnemy = nil
	self._masterList = {}
	self.topTitleStr = nil
	self.ruleDescStr = nil

	if not self._stageCfg then
		return
	end

	local creepsMasterId = checknumber(self._stageCfg.creepsMasterId)

	self._cfgEnemy = OriginHotBloodMMClgConfig.instance:getMaster(creepsMasterId)
	self._masterList = OriginHotBloodMMClgConfig.instance:getCreeps(creepsMasterId) or {}

	if self._cfgEnemy then
		self.topTitleStr = self._cfgEnemy.name
		self.ruleDescStr = self._cfgEnemy.ruleDesc or self._cfgEnemy.winId

		self:setFormCondition(self._cfgEnemy.formCondition)
	end

	self:clearAllFixedEffects()

	local markPosId = checknumber(self._stageCfg.markPosId)

	if markPosId > 0 then
		self:setFixedEffect(markPosId, "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab")
	end
end

function OriginHotBloodMMClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		OriginHotBloodMMClgAgent.instance:sendPM_OriginHotBloodedMMClgChallengeReq(self._activityId, self._stageId, self:getCurSimpleForm())
	end

	self:setFightHandler(handler, nil)
end

function OriginHotBloodMMClgFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if OriginHotBloodMMClgFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack) then
		return true
	end

	local markPosId = checknumber(self._stageCfg and self._stageCfg.markPosId)
	local curFormation = self:getCurFormation()
	local petId = curFormation and curFormation:GetPosition(markPosId) or 0

	if markPosId > 0 and checknumber(petId) <= 0 then
		TipsFacade.instance:openPopupWindow(lang("提示"), lang("己方标记站位未上阵精灵，将无法击败敌阵精灵"), posLimitCallback, nil, lang("确定"), lang("取消"), UnityEngine.TextAnchor.MiddleCenter)

		return true
	end

	return false
end

function OriginHotBloodMMClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function OriginHotBloodMMClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function OriginHotBloodMMClgFmtMo:getActivityId()
	return self._activityId
end

function OriginHotBloodMMClgFmtMo:getStageId()
	return self._stageId
end

function OriginHotBloodMMClgFmtMo:getStageData()
	return self._stageCfg
end

function OriginHotBloodMMClgFmtMo:getExtendViewName()
	return ViewName.OriginHotBloodMMClgFmtView
end

return OriginHotBloodMMClgFmtMo
