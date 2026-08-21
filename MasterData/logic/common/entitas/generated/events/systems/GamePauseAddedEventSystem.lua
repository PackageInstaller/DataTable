-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/events/systems/GamePauseAddedEventSystem.lua

module("logic.common.entitas.generated.events.systems.GamePauseAddedEventSystem", package.seeall)

local Game_comps = GameComponents
local Game_comps_ext = GamePauseListenerComponent
local Matcher = require("Matcher")
local M = class("GamePauseAddedEventSystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context)

	self._listeners = context:get_group(Matcher({
		Game_comps.PauseListener
	}))
end

function M:get_trigger()
	return {
		{
			Matcher({
				Game_comps.Pause
			}),
			BitUtil.BitOR(GroupEvent.ADDED, GroupEvent.REMOVED)
		}
	}
end

function M:filter(entity)
	return true
end

function M:execute(es)
	local buffer = self._listeners:get_entity_buffer()

	es:foreach(function(e)
		local comp = e.pause

		for _, entity in pairs(buffer) do
			local list = entity.pauseListener.value

			list:OnGamePause(e, e:hasPause())
		end
	end)
end

function GameEntity:hasPauseListener()
	return self:has(Game_comps.PauseListener) ~= nil
end

function GameEntity:addPauseListener(value)
	self:add(Game_comps.PauseListener, value)

	return self
end

function GameEntity:replacePauseListener(value)
	self:replace(Game_comps.PauseListener, value)

	return self
end

function GameEntity:removePauseListener()
	self:remove(Game_comps.PauseListener)

	return self
end

return M
