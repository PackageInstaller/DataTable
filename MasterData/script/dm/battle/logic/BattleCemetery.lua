-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleCemetery.lua

BattleCemetery = class("BattleCemetery")

function BattleCemetery:initialize()
	super.initialize(self)
	self:reset()
end

function BattleCemetery:reset(side)
	if side then
		self._cemetery[side] = {}
	else
		self._cemetery = {
			[kBattleSideA] = {},
			[kBattleSideB] = {}
		}
	end
end

function BattleCemetery:bury(unit)
	local side = unit:getComponent("Position"):getCellSide()

	if side then
		table.insert(self._cemetery[side], unit)
	end
end

function BattleCemetery:getUnitsBySide(side)
	Bdump("getUnitBySide" .. side .. ":{3}", self._cemetery)

	return self._cemetery[side]
end

function BattleCemetery:untomb(unit)
	local side = unit:getComponent("Position"):getCellSide()

	if side then
		for i, u in ipairs(self._cemetery[side]) do
			if u == unit then
				table.remove(self._cemetery[side], i)

				return true
			end
		end
	end

	return false
end
