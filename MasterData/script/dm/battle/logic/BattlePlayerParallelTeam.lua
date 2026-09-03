-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattlePlayerParallelTeam.lua

local ipairs = _G.ipairs

BattlePlayerParallelTeam = class("BattlePlayerParallelTeam", BattlePlayerTeam)

BattlePlayerParallelTeam:has("_side", {
	is = "rw"
})

function BattlePlayerParallelTeam:initialize(side)
	super.initialize(self, side)
end

function BattlePlayerParallelTeam:start(battleContext)
	local initiatives = {}

	for _, player in ipairs(self._players) do
		player:start(battleContext)

		initiatives[#initiatives + 1] = player:getInitiative()
	end

	self:setInitiativeBase(self:calcInitiative(initiatives))
end

function BattlePlayerParallelTeam:update(dt, battleContext)
	for _, player in ipairs(self._players) do
		player:update(dt, battleContext)
	end
end

function BattlePlayerParallelTeam:adjustEnergyBaseSpeed(energySpeed)
	for _, player in self:players() do
		player:getEnergyReservoir():setBaseSpeed(energySpeed)
	end
end

function BattlePlayerParallelTeam:canContinue()
	for _, player in ipairs(self._players) do
		if not player:beDefeated() then
			return true
		end
	end

	return false
end

function BattlePlayerParallelTeam:nextBout(battleContext)
	local losers = {}
	local result = false

	for _, player in ipairs(self._players) do
		if not player:beDefeated() then
			player:clearStatus(battleContext)

			result = true
		else
			losers[#losers + 1] = player
		end
	end

	if result then
		for i = #losers, 1, -1 do
			local player = losers[i]

			player:kickAllUnits(battleContext)
			self:removePlayer(player)
		end
	end

	return result
end
