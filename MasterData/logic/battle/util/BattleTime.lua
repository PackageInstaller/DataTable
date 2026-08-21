-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleTime.lua

module("logic.battle.util.BattleTime", package.seeall)

local BattleTime = {}

BattleTime.timeScale = 1

function BattleTime.getScaledTime(time)
	return time / BattleTime.timeScale
end

return BattleTime
