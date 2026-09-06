-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedakinosclg/model/DivineDakinosClgFmtMo.lua

module("logic.extensions.divinedakinosclg.model.DivineDakinosClgFmtMo", package.seeall)

local DivineDakinosClgFmtMo = class("DivineDakinosClgFmtMo", BaseCustomFmtMo)

function DivineDakinosClgFmtMo:initParams(activityId, phaseId, stageId)
	self.activityId = activityId
	self.phaseId = phaseId
	self.stageId = stageId
	self._phaseCfg = DivineDakinosClgConfig.instance:getPhaseCfg(self.activityId, self.phaseId)
	self._stageCfgs = DivineDakinosClgConfig.instance:getStageCfgs(self._phaseCfg.stagePlanId)
	self._stageCfg = self._stageCfgs[self.stageId]
	self._showCirclePos = self._stageCfg.showCirclePos or {}

	if not self._stageCfg.showCirclePos then
		local showCirclePos = {}

		self:clearAllFixedEffects()

		for _, posId in ipairs(showCirclePos) do
			self:setFixedEffect(posId, "fx_ui_jinglinggezi/fx_ui_buzhen_02.prefab")
		end

		self.creepsMasterId = self._stageCfg.creepsMasterId
		self.masterCfg = DivineDakinosClgConfig.instance:getFormationCfg(self.creepsMasterId)
		self.creeps = DivineDakinosClgConfig.instance:getCreepCfgs(self.creepsMasterId)
		self.isShowTab = false
		self.topTitleStr = self.masterCfg.name
	end
end

function DivineDakinosClgFmtMo:getFormCondition()
	return 0
end

function DivineDakinosClgFmtMo:getMonsterConfigList()
	return self.creeps
end

function DivineDakinosClgFmtMo:getFmtInfoConfig()
	return self.masterCfg
end

function DivineDakinosClgFmtMo:initFightHandler()
	self:setFightHandler(function()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)
		DivineDakinosClgController.instance:sendPM_DivineDakinosClgFightReq(self.activityId, self.phaseId, self.stageId, self:getCurSimpleForm())
	end, nil)
end

function DivineDakinosClgFmtMo:getExtendViewName()
	return ViewName.DivineDakinoscClgFmtExView
end

function DivineDakinosClgFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if self:getMatchCount() <= 0 then
		FloatWordMgr.instance:show(lang("特定站位至少上阵一只精灵"))

		return
	end

	return DivineDakinosClgFmtMo.super.checkFormationEmptyAndPosNumLimit(self, posLimitCallback, hasOneKey, onekeyCallBack)
end

function DivineDakinosClgFmtMo:onFmoSetDown()
	GlobalDispatcher:dispatch(GlobalNotify.DivineDakinosClgBelieverCountChange)
end

function DivineDakinosClgFmtMo:getMatchCount()
	local matchCount = 0

	for i, posId in ipairs(self._showCirclePos) do
		local posValue = checknumber(self:getCurFormation():GetPosition(posId))

		if posValue > 0 then
			matchCount = matchCount + 1
		end
	end

	return matchCount
end

return DivineDakinosClgFmtMo
