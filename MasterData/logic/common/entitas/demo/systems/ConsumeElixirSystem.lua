-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/systems/ConsumeElixirSystem.lua

module("logic.common.entitas.demo.systems.ConsumeElixirSystem", package.seeall)

local Matcher = require("Matcher")
local M = class("ConsumeElixirSystem", ReactiveSystem)

function M:ctor(context)
	M.super.ctor(self, context.game)

	self._context = context.game
end

function M:get_trigger()
	return {
		{
			Matcher({
				GameComponents.ConsumeElixir
			}),
			GroupEvent.ADDED
		}
	}
end

function M:filter(entity)
	return entity:hasConsumeElixir()
end

function M:execute(es)
	local amount = 0

	es:foreach(function(e)
		if self._context.elixir.amount < e.consumeElixir.amount then
			return
		end

		amount = self._context.elixir.amount - e.consumeElixir.amount

		self._context:replaceElixir(amount)
	end)
end

return M
