-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/demo/systems/ConsumeElixirCleanupSystem.lua

module("logic.common.entitas.demo.systems.ConsumeElixirCleanupSystem", package.seeall)

local M = class("ConsumeElixirCleanupSystem", EntitasSystem)

function M:ctor(context)
	M.super.ctor(self, context.game)

	self._context = context.game
	self._entities = self._context:get_group(GameMatcher.ConsumeElixir)
end

function M:tear_down()
	for k, item in self._entities:get_entity_buffer() do
		self._context:destroy_entity(item)
	end
end

return M
