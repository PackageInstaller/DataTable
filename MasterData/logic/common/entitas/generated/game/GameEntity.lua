-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/game/GameEntity.lua

module("logic.common.entitas.generated.game.GameEntity", package.seeall)

local Game_comps = GameComponents
local set = Set
local M = class("GameEntity", Entity)

function M:ctor(...)
	self.super.ctor(self, ...)
end

function M:hasConsumeElixir()
	return self:has(Game_comps.ConsumeElixir) ~= nil
end

function M:addConsumeElixir(amount)
	self:add(Game_comps.ConsumeElixir, amount)

	return self
end

function M:replaceConsumeElixir(amount)
	self:replace(Game_comps.ConsumeElixir, amount)

	return self
end

function M:removeConsumeElixir()
	self:remove(Game_comps.ConsumeElixir)

	return self
end

function M:hasConsumptionHistory()
	return self:has(Game_comps.ConsumptionHistory) ~= nil
end

function M:addConsumptionHistory(entries)
	self:add(Game_comps.ConsumptionHistory, entries)

	return self
end

function M:replaceConsumptionHistory(entries)
	self:replace(Game_comps.ConsumptionHistory, entries)

	return self
end

function M:removeConsumptionHistory()
	self:remove(Game_comps.ConsumptionHistory)

	return self
end

function M:hasDestroy()
	return self:has(Game_comps.Destroy) ~= nil
end

function M:setDestroy(v)
	if v ~= self:hasDestroy() then
		if v then
			self:add(Game_comps.Destroy, true)
		else
			self:remove(Game_comps.Destroy)
		end
	end

	return self
end

function M:hasElixir()
	return self:has(Game_comps.Elixir) ~= nil
end

function M:addElixir(amount)
	self:add(Game_comps.Elixir, amount)

	return self
end

function M:replaceElixir(amount)
	self:replace(Game_comps.Elixir, amount)

	return self
end

function M:removeElixir()
	self:remove(Game_comps.Elixir)

	return self
end

function M:hasJumpInTime()
	return self:has(Game_comps.JumpInTime) ~= nil
end

function M:addJumpInTime(targetTick)
	self:add(Game_comps.JumpInTime, targetTick)

	return self
end

function M:replaceJumpInTime(targetTick)
	self:replace(Game_comps.JumpInTime, targetTick)

	return self
end

function M:removeJumpInTime()
	self:remove(Game_comps.JumpInTime)

	return self
end

function M:hasLogicSystem()
	return self:has(Game_comps.LogicSystem) ~= nil
end

function M:addLogicSystem(systems)
	self:add(Game_comps.LogicSystem, systems)

	return self
end

function M:replaceLogicSystem(systems)
	self:replace(Game_comps.LogicSystem, systems)

	return self
end

function M:removeLogicSystem()
	self:remove(Game_comps.LogicSystem)

	return self
end

function M:hasPause()
	return self:has(Game_comps.Pause) ~= nil
end

function M:setPause(v)
	if v ~= self:hasPause() then
		if v then
			self:add(Game_comps.Pause, true)
		else
			self:remove(Game_comps.Pause)
		end
	end

	return self
end

function M:hasTick()
	return self:has(Game_comps.Tick) ~= nil
end

function M:addTick(currentTick)
	self:add(Game_comps.Tick, currentTick)

	return self
end

function M:replaceTick(currentTick)
	self:replace(Game_comps.Tick, currentTick)

	return self
end

function M:removeTick()
	self:remove(Game_comps.Tick)

	return self
end

return M
