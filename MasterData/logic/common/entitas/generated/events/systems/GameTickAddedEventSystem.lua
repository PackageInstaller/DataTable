-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/events/systems/GameTickAddedEventSystem.lua

module("logic.common.entitas.generated.events.systems.GameTickAddedEventSystem", package.seeall)

local Game_comps = GameComponents
local Game_comps_ext = GameTickListenerComponent
local Matcher = require("Matcher")
local M = class("GameTickAddedEventSystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context)

	self._listeners = context:get_group(Matcher({
		Game_comps.TickListener
	}))
end

function M:get_trigger()
	return {
		{
			Matcher({
				Game_comps.Tick
			}),
			GroupEvent.ADDED
		}
	}
end

function M:filter(entity)
	return entity:hasTick()
end

function M:execute(es)
	local buffer = self._listeners:get_entity_buffer()

	es:foreach(function(e)
		local comp = e.tick

		for _, entity in pairs(buffer) do
			local list = entity.tickListener.value

			list:OnGameTick(e, comp.currentTick)
		end
	end)
end

function GameEntity:hasTickListener()
	return self:has(Game_comps.TickListener) ~= nil
end

function GameEntity:addTickListener(value)
	self:add(Game_comps.TickListener, value)

	return self
end

function GameEntity:replaceTickListener(value)
	self:replace(Game_comps.TickListener, value)

	return self
end

function GameEntity:removeTickListener()
	self:remove(Game_comps.TickListener)

	return self
end

return M
