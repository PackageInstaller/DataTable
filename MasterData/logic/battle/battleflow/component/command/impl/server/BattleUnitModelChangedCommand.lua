-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleUnitModelChangedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleUnitModelChangedCommand", package.seeall)

local M = class("BattleUnitModelChangedCommand", BattleCommandBase)

function M:parseServerCommand(cmdParser, attributeModifiedEventNO)
	local cmd = M:createInstance()

	cmd:setEntityId(attributeModifiedEventNO.entity)
	cmd:setModelId(attributeModifiedEventNO.modelId)
	cmd:setAnimState(attributeModifiedEventNO.action)
	cmdParser:addCommand(cmd)
end

function M:onInit()
	self._resLoader = SingleResLoader.New()
	self._entityId = false
	self._modelId = false
	self._animState = false
	self._soloPlayer = false
	self._isChangeModeTriggerred = false
end

function M:onClear()
	self:_clearEffect()
	self._resLoader:clear()

	self._entityId = false
	self._modelId = false
	self._animState = false
	self._isChangeModeTriggerred = false
end

function M:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("cannot find entity[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	local modelCO = ModelConfig.instance:getModelConfig(self._modelId)
	local url = ModelCOUtil.getLowModelUrl(modelCO)

	self._resLoader:load(url, self._onResLoaded, self)
end

function M:_onResLoaded()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)
	local timelineResPath = SkillPerformanceConfig.instance:getSkillPerformanceTimeline(self._animState, unit.property:getModelCode())
	local url = BattleSkillAssist.getNormal3dEffectSkillUrl(timelineResPath)
	local player = SkillSimpleSoloPlayer:createInstance()

	self._soloPlayer = player

	player:setUnit(unit)
	player:setEventListener(self._onTimelineEvent, self)
	player:setFinishListener(self._onTaskFinish, self)
	player:setupAudioName(SkillPerformanceAssistant:getSkillAudioName(timelineResPath))
	player:setTimelineResPath(timelineResPath)
	player:play(url)
end

function M:_onTimelineEvent(eventName)
	if eventName == BattleTimelineEventName.AttackPoint then
		self:_changedModel()
	end
end

function M:_onTaskFinish()
	self:finish(true)
end

function M:_clearEffect()
	if self._soloPlayer then
		self._soloPlayer:returnSelf()

		self._soloPlayer = false
	end
end

function M:_changedModel()
	if self._isChangeModeTriggerred then
		return
	end

	self._isChangeModeTriggerred = true

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)
	local modelCO = ModelConfig.instance:getModelConfig(self._modelId)

	unit.property:setModelCode(self._modelId)

	local modelCO = ModelConfig.instance:getModelConfig(self._modelId)

	unit.meshModel:loadCacheModel(modelCO)
	unit.meshModel:setBody(ModelCOUtil.getLowModelUrl(modelCO))
end

function M:toString()
	return string.format("[BattleUnitModelChangedCommand entityId = %s,modelId = %s, animState = %s]", self._entityId, self._modelId, self._animState)
end

function M:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function M:setModelId(modelId)
	self._modelId = modelId

	return self
end

function M:setAnimState(animState)
	self._animState = animState

	return self
end

return M
