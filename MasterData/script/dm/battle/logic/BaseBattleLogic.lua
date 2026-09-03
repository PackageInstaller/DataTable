-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BaseBattleLogic.lua

BaseBattleLogic = class("BaseBattleLogic")

BaseBattleLogic:has("_battleConfig", {
	is = "rw"
})
BaseBattleLogic:has("_battleReferee", {
	is = "r"
})
BaseBattleLogic:has("_randomizer", {
	is = "rw"
})
BaseBattleLogic:has("_battleField", {
	is = "r"
})
BaseBattleLogic:has("_battleMode", {
	is = "rw"
})

function BaseBattleLogic:initialize()
	super.initialize(self)

	self._inputHandlers = {}
end

function BaseBattleLogic:createBattleContext()
	return BattleContext:new()
end

function BaseBattleLogic:getBattleResult()
	return self._battleResult
end

function BaseBattleLogic:getTeamA()
	return self._teamA
end

function BaseBattleLogic:getTeamB()
	return self._teamB
end

function BaseBattleLogic:getPlayerTeam(side)
	if side == kBattleSideA then
		return self._teamA
	elseif side == kBattleSideB then
		return self._teamB
	else
		return nil
	end
end

function BaseBattleLogic:start(battleContext)
	self._battleContext = battleContext
	self._battleRecorder = battleContext:getObject("BattleRecorder")
	self._battleStatist = battleContext:getObject("BattleStatist")

	return true
end

function BaseBattleLogic:setupRandomizer(battleContext)
	local randomizer = self._randomizer

	if self._randomizer == nil then
		randomizer = Random:new()
		self._randomizer = randomizer
	end

	battleContext:setObject("Randomizer", randomizer)
	battleContext:writeVar("random", function(n, m)
		return randomizer:random(n, m)
	end)
end

function BaseBattleLogic:finish(result)
	assert(result ~= nil)

	self._battleResult = result

	return true
end

function BaseBattleLogic:isFinished()
	return self._battleResult ~= nil
end

function BaseBattleLogic:step(dt)
	return self._battleResult
end

function BaseBattleLogic:isReadyForInput()
	return false
end

function BaseBattleLogic:isReadyForAI()
	return self:isReadyForInput()
end

function BaseBattleLogic:isWaiting()
	return false
end

function BaseBattleLogic:registerPlayer(battlePlayer)
	self._battlePlayersRegistry[battlePlayer:getId()] = battlePlayer
end

function BaseBattleLogic:unregisterPlayer(battlePlayer)
	self._battlePlayersRegistry[battlePlayer:getId()] = nil
end

function BaseBattleLogic:getPlayerById(playerId)
	return self._battlePlayersRegistry[playerId]
end

function BaseBattleLogic:setupInputHandler(opType, handler)
	self._inputHandlers[opType] = handler
end

function BaseBattleLogic:handleInputMessage(playerId, op, args, callback)
	local player = self:getPlayerById(playerId) or playerId

	if not self:handlePlayerInput(player, op, args, callback) and callback then
		callback(false, "NoResponder")
	end
end

function BaseBattleLogic:handlePlayerInput(player, op, args, callback)
	local listener = self._inputHandlers[op]

	if listener then
		if callback then
			callback(listener(self, player, op, args))
		else
			listener(self, player, op, args)
		end

		return true
	end

	return false
end
