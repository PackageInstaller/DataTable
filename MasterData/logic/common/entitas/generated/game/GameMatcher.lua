-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/entitas/generated/game/GameMatcher.lua

module("logic.common.entitas.generated.game.GameMatcher", package.seeall)

local Matcher = require("Matcher")
local Game_comps = GameComponents
local M = {}

M.ConsumeElixir = Matcher({
	Game_comps.ConsumeElixir
})
M.ConsumptionHistory = Matcher({
	Game_comps.ConsumptionHistory
})
M.Destroy = Matcher({
	Game_comps.Destroy
})
M.Elixir = Matcher({
	Game_comps.Elixir
})
M.JumpInTime = Matcher({
	Game_comps.JumpInTime
})
M.LogicSystem = Matcher({
	Game_comps.LogicSystem
})
M.Pause = Matcher({
	Game_comps.Pause
})
M.Tick = Matcher({
	Game_comps.Tick
})

return M
