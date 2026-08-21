-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/attackpoint/ModelChangedAttackPointHandler.lua

module("logic.battle.skill.attackpoint.ModelChangedAttackPointHandler", package.seeall)

local M = class("ModelChangedAttackPointHandler", AbstractGlobalReusable, ISkillAttackPointHandler)

function M:parseEventNO(modelChangedEventNO)
	local handler = M:createInstance()

	handler:setEntityId(modelChangedEventNO.entity)
	handler:setModelId(modelChangedEventNO.modelId)

	return handler
end

function M:ctor()
	self:reuse()
end

function M:reset()
	self._isExecuted = false
	self._entityId = false
	self._modelId = false
end

function M:clear()
	self:reset()
end

function M:destroy()
	self:reset()
end

function M:collectEntityIds(entityIdList)
	return
end

function M:build(context)
	return
end

function M:handleAttackPoint(context, weight)
	if self._isExecuted then
		return
	end

	self._isExecuted = true

	self:_changedModel()
end

function M:_changedModel()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableError then
			BattleLog.error("ModelChangedAttackPointHandler unit is null")
		end

		return
	end

	unit.property:setModelCode(self._modelId)

	local modelCO = ModelConfig.instance:getModelConfig(self._modelId)

	unit.meshModel:setBody(ModelCOUtil.getLowModelUrl(modelCO))
end

function M:toString()
	return string.format("[ModelChangedAttackPointHandler, entityId = %s,modelId = %s]", self._entityId, self._modelId)
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:setModelId(modelId)
	self._modelId = modelId
end

return M
