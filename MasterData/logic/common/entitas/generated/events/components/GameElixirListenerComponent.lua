-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/events/components/GameElixirListenerComponent.lua

module("logic.common.entitas.generated.events.components.GameElixirListenerComponent", package.seeall)

local make_component = require("MakeComponent")
local Game_comps = GameComponents
local Matcher = require("Matcher")
local M = {}

GameComponents.ElixirListener = make_component("elixirListener", "value")
GameMatcher.ElixirListener = Matcher({
	Game_comps.ElixirListener
})

return M
