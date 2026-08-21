-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/property/BattleBooleanStateValue.lua

module("logic.battle.unit.comp.property.BattleBooleanStateValue", package.seeall)

local BattleBooleanStateValue = class("BattleBooleanStateValue", AbstractGlobalReusable)

function BattleBooleanStateValue:getCapacity()
	return BattleConst.ObjPoolCapacityMax
end

function BattleBooleanStateValue:ctor()
	self._key2State = {}
	self._activeCount = 0
end

function BattleBooleanStateValue:reset()
	self:clear()
end

function BattleBooleanStateValue:destroy()
	self:clear()
end

function BattleBooleanStateValue:activeState(key)
	if self:_isKeyActive(key) then
		return
	end

	self._key2State[key] = true
	self._activeCount = self._activeCount + 1
end

function BattleBooleanStateValue:inactiveState(key)
	if not self:_isKeyActive(key) then
		return
	end

	self._key2State[key] = false
	self._activeCount = self._activeCount - 1
end

function BattleBooleanStateValue:isActive()
	return self._activeCount > 0
end

function BattleBooleanStateValue:clear()
	self._activeCount = 0

	BattleTableUtil.clearTable(self._key2State)
end

function BattleBooleanStateValue:_isKeyActive(key)
	return self._key2State[key] or false
end

return BattleBooleanStateValue
