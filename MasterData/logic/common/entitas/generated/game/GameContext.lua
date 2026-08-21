-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/game/GameContext.lua

module("logic.common.entitas.generated.game.GameContext", package.seeall)

local Game_comps = GameComponents
local M = class("GameContext", Context)

function M:ctor(...)
	self.super.ctor(self, ...)
end

function M:setConsumeElixir(amount)
	if self:has_unique_component(Game_comps.ConsumeElixir) then
		error("ConsumeElixirComponent already have")
	end

	return self:set_unique_component("consumeElixir", Game_comps.ConsumeElixir, amount)
end

function M:replaceConsumeElixir(amount)
	local entity = self.consumeElixirEntity

	if entity == nil then
		self:setConsumeElixir(amount)
	else
		self.consumeElixir = entity:replace(Game_comps.ConsumeElixir, amount)
	end

	return entity
end

function M:getConsumeElixir()
	return self:get_unique_component(Game_comps.ConsumeElixir)
end

function M:removeConsumeElixir()
	self:remove_unique_component("consumeElixir")
end

function M:hasConsumptionHistory()
	local entity = self.consumptionHistoryEntity

	if entity == nil then
		return false
	else
		return entity:hasConsumptionHistory()
	end
end

function M:setConsumptionHistory(entries)
	if self:has_unique_component(Game_comps.ConsumptionHistory) then
		error("ConsumptionHistoryComponent already have")
	end

	return self:set_unique_component("consumptionHistory", Game_comps.ConsumptionHistory, entries)
end

function M:replaceConsumptionHistory(entries)
	local entity = self.consumptionHistoryEntity

	if entity == nil then
		self:setConsumptionHistory(entries)
	else
		self.consumptionHistory = entity:replace(Game_comps.ConsumptionHistory, entries)
	end

	return entity
end

function M:getConsumptionHistory()
	return self:get_unique_component(Game_comps.ConsumptionHistory)
end

function M:removeConsumptionHistory()
	self:remove_unique_component("consumptionHistory")
end

function M:setDestroy(value)
	if value ~= self:hasDestroy() then
		if value then
			self:set_unique_component("destroy", Game_comps.Destroy, true)
		else
			self:remove_unique_component("destroy")
		end
	end

	return self
end

function M:hasDestroy()
	return self:has_unique_component(Game_comps.Destroy)
end

function M:removeDestroy()
	self:remove_unique_component("destroy")
end

function M:setElixir(amount)
	if self:has_unique_component(Game_comps.Elixir) then
		error("ElixirComponent already have")
	end

	return self:set_unique_component("elixir", Game_comps.Elixir, amount)
end

function M:replaceElixir(amount)
	local entity = self.elixirEntity

	if entity == nil then
		self:setElixir(amount)
	else
		self.elixir = entity:replace(Game_comps.Elixir, amount)
	end

	return entity
end

function M:getElixir()
	return self:get_unique_component(Game_comps.Elixir)
end

function M:removeElixir()
	self:remove_unique_component("elixir")
end

function M:setJumpInTime(targetTick)
	if self:has_unique_component(Game_comps.JumpInTime) then
		error("JumpInTimeComponent already have")
	end

	return self:set_unique_component("jumpInTime", Game_comps.JumpInTime, targetTick)
end

function M:replaceJumpInTime(targetTick)
	local entity = self.jumpInTimeEntity

	if entity == nil then
		self:setJumpInTime(targetTick)
	else
		self.jumpInTime = entity:replace(Game_comps.JumpInTime, targetTick)
	end

	return entity
end

function M:getJumpInTime()
	return self:get_unique_component(Game_comps.JumpInTime)
end

function M:removeJumpInTime()
	self:remove_unique_component("jumpInTime")
end

function M:setLogicSystem(systems)
	if self:has_unique_component(Game_comps.LogicSystem) then
		error("LogicSystemComponent already have")
	end

	return self:set_unique_component("logicSystem", Game_comps.LogicSystem, systems)
end

function M:replaceLogicSystem(systems)
	local entity = self.logicSystemEntity

	if entity == nil then
		self:setLogicSystem(systems)
	else
		self.logicSystem = entity:replace(Game_comps.LogicSystem, systems)
	end

	return entity
end

function M:getLogicSystem()
	return self:get_unique_component(Game_comps.LogicSystem)
end

function M:removeLogicSystem()
	self:remove_unique_component("logicSystem")
end

function M:setPause(value)
	if value ~= self:hasPause() then
		if value then
			self:set_unique_component("pause", Game_comps.Pause, true)
		else
			self:remove_unique_component("pause")
		end
	end

	return self
end

function M:hasPause()
	return self:has_unique_component(Game_comps.Pause)
end

function M:removePause()
	self:remove_unique_component("pause")
end

function M:setTick(currentTick)
	if self:has_unique_component(Game_comps.Tick) then
		error("TickComponent already have")
	end

	return self:set_unique_component("tick", Game_comps.Tick, currentTick)
end

function M:replaceTick(currentTick)
	local entity = self.tickEntity

	if entity == nil then
		self:setTick(currentTick)
	else
		self.tick = entity:replace(Game_comps.Tick, currentTick)
	end

	return entity
end

function M:getTick()
	return self:get_unique_component(Game_comps.Tick)
end

function M:removeTick()
	self:remove_unique_component("tick")
end

function M:_create_entity()
	return self._entity_class.New()
end

function M:CreateEntity()
	return self:create_entity()
end

function M.Create()
	return GameContext.New(GameEntity)
end

return M
