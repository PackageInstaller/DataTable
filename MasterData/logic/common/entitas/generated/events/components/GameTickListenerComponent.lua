-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/events/components/GameTickListenerComponent.lua

module("logic.common.entitas.generated.events.components.GameTickListenerComponent", package.seeall)

local make_component = require("MakeComponent")
local Game_comps = GameComponents
local Matcher = require("Matcher")
local M = {}

GameComponents.TickListener = make_component("tickListener", "value")
GameMatcher.TickListener = Matcher({
	Game_comps.TickListener
})

return M
