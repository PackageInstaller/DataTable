-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/base/BattleUnitCompBase.lua

module("logic.battle.unit.comp.base.BattleUnitCompBase", package.seeall)

local BattleUnitCompBase = class("BattleUnitCompBase", IBattleUnitComponent)

function BattleUnitCompBase:ctor(unit)
	self._unit = unit
end

function BattleUnitCompBase:onInit()
	return
end

function BattleUnitCompBase:onReuse()
	return
end

function BattleUnitCompBase:onReset()
	return
end

function BattleUnitCompBase:onDestroy()
	return
end

return BattleUnitCompBase
