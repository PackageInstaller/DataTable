-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/statehandler/BattleStateHandler_Silent.lua

module("logic.battle.unit.comp.property.statehandler.BattleStateHandler_Silent", package.seeall)

local BattleStateHandler_Silent = class("BattleStateHandler_Silent", IBattleStateHandler)

function BattleStateHandler_Silent:handleStateAdded(unit, runningContext)
	unit.skillAreaWarning:clearSkillArea()
end

function BattleStateHandler_Silent:handleStateRemoved(unit, runningContext)
	return
end

return BattleStateHandler_Silent
