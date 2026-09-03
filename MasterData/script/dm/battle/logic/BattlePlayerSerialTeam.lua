-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattlePlayerSerialTeam.lua

local ipairs = _G.ipairs

BattlePlayerSerialTeam = class("BattlePlayerSerialTeam", BattlePlayerTeam)

BattlePlayerSerialTeam:has("_side", {
	is = "rw"
})

function BattlePlayerSerialTeam:initialize(side)
	super.initialize(self, side)

	self._curIndex = 0
end

function BattlePlayerSerialTeam:start(battleContext)
	self._curIndex = 0

	return self:nextBout(battleContext)
end

function BattlePlayerSerialTeam:canContinue()
	local player = self._players[self._curIndex]

	if player and not player:beDefeated() then
		return true
	end

	return false
end

function BattlePlayerSerialTeam:nextBout(battleContext)
	local player = self._players[self._curIndex]

	if player and not player:beDefeated() then
		return true
	end

	self._curIndex = self._curIndex + 1

	local nextPlayer = self._players[self._curIndex]

	if nextPlayer then
		nextPlayer:start(battleContext)
		self:setInitiativeBase(nextPlayer:getInitiative())

		return true
	end

	return false
end

function BattlePlayerSerialTeam:clearStatus(battleContext)
	local player = self._players[self._curIndex]

	if player and not player:beDefeated() then
		player:clearStatus(battleContext)

		return true
	end

	if player then
		player:kickAllUnits(battleContext)
	end
end

function BattlePlayerSerialTeam:hasNextBout()
	if self:canContinue() then
		return true
	end

	local nextPlayer = self._players[self._curIndex + 1]

	if nextPlayer then
		return true
	end
end

function BattlePlayerSerialTeam:getCurPlayer()
	return self._players[self._curIndex]
end

function BattlePlayerSerialTeam:update(dt, battleContext)
	local player = self._players[self._curIndex]

	if player then
		player:update(dt, battleContext)
	end
end

function BattlePlayerSerialTeam:adjustEnergyBaseSpeed(energySpeed)
	local player = self._players[self._curIndex]

	if player then
		player:getEnergyReservoir():setBaseSpeed(energySpeed)
	end
end

function BattlePlayerSerialTeam:getRemainHpInfo()
	local totalMax, totalRemain = 0, 0

	for _, player in ipairs(self._players) do
		local max, remain = player:getRemainHpInfo()

		totalMax = totalMax + max
		totalRemain = totalRemain + remain
	end

	return {
		total = totalMax,
		remain = totalRemain
	}
end
