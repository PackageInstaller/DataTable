-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/events/components/GamePauseListenerComponent.lua

module("logic.common.entitas.generated.events.components.GamePauseListenerComponent", package.seeall)

local make_component = require("MakeComponent")
local Game_comps = GameComponents
local Matcher = require("Matcher")
local M = {}

GameComponents.PauseListener = make_component("pauseListener", "value")
GameMatcher.PauseListener = Matcher({
	Game_comps.PauseListener
})

return M
