-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattlePlayerTeam.lua

local ipairs = _G.ipairs
local floor = math.floor

BattlePlayerTeam = class("BattlePlayerTeam")

BattlePlayerTeam:has("_side", {
	is = "rw"
})

function BattlePlayerTeam:initialize(side)
	super.initialize(self)

	self._players = {}
	self._side = side
	self._initiative = AttributeNumber:new()
	self._initiativeAggregation = nil
end

function BattlePlayerTeam:setSide(side)
	if self._side == side then
		return
	end

	self._side = side

	local players = self._players

	for i = 1, #players do
		players[i]:setSide(side)
	end
end

function BattlePlayerTeam:getInitiative()
	return self._initiative
end

function BattlePlayerTeam:getInitiativeValue()
	return self._initiative:value()
end

function BattlePlayerTeam:setInitiativeBase(base)
	self._initiative:setBase(base)
end

local initiativeAggregations = {
	sum = function(values)
		local x, n = 0, #values

		for i = 1, n do
			x = x + values[i]
		end

		return x
	end,
	maximum = function(values)
		local x, n = 0, #values

		for i = 1, n do
			tmp = values[i]

			if x < tmp then
				x = tmp
			end
		end

		return x
	end,
	average = function(values)
		local x, n = 0, #values

		for i = 1, n do
			x = x + values[i]
		end

		return floor(x / n)
	end
}

initiativeAggregations.__default__ = initiativeAggregations.sum

function BattlePlayerTeam:setInitiativeAggregation(mode)
	self._initiativeAggregation = string.lower(mode)
end

function BattlePlayerTeam:calcInitiative(initiatives)
	local aggrFunc = initiativeAggregations[self._initiativeAggregation]

	if aggrFunc == nil then
		aggrFunc = initiativeAggregations.__default__
	end

	return aggrFunc(initiatives)
end

function BattlePlayerTeam.class:findPriorTeam(team1, team2)
	local initiative1 = team1:getInitiativeValue()
	local initiative2 = team2:getInitiativeValue()

	if initiative2 < initiative1 then
		return team1
	elseif initiative1 < initiative2 then
		return team2
	end

	return nil
end

function BattlePlayerTeam:addPlayer(player)
	local players = self._players
	local n = #players

	for i = 1, n do
		if players[i] == player then
			return
		end
	end

	players[n + 1] = player

	player:setTeam(self)
	player:setIndex(n + 1)
end

function BattlePlayerTeam:removePlayer(player)
	local players = self._players
	local n = #players

	for i = 1, n do
		if players[i] == player then
			player:setTeam(nil)
			table.remove(players, i)

			break
		end
	end
end

function BattlePlayerTeam:clearPlayers()
	if self._players == nil or #self._players > 0 then
		self._players = {}
	end
end

function BattlePlayerTeam:countPlayers()
	return #self._players
end

function BattlePlayerTeam:getPlayerByIndex(idx)
	return self._players[idx]
end

function BattlePlayerTeam:players()
	return ipairs(self._players)
end

function BattlePlayerTeam:start(battleContext)
	assert(nil, "please implent me!!!")
end

function BattlePlayerTeam:update(dt, battleContext)
	assert(nil, "please implent me!!!")
end

function BattlePlayerTeam:adjustEnergyBaseSpeed(energySpeed)
	assert(nil, "please implent me!!!")
end

function BattlePlayerTeam:canContinue()
	assert(nil, "please implent me!!!")
end

function BattlePlayerTeam:nextBout(battleContext)
	assert(nil, "please implent me!!!")
end
