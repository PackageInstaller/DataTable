-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/simulator/BattlePlayerController.lua

BattlePlayerController = class("BattlePlayerController")

function BattlePlayerController:bindPlayer(playerId)
	assert(false, "Implement me!")
end

function BattlePlayerController:sendOpCommand(op, args, callback)
	assert(false, "Implement me!")
end

LocalPlayerController = class("LocalPlayerController", BattlePlayerController)

function LocalPlayerController:initialize(inputManager)
	super.initialize(self)
	assert(inputManager ~= nil, "BattleInputManager is required!")

	self._inputManager = inputManager
end

function LocalPlayerController:bindPlayer(playerId)
	self._playerId = playerId

	return self
end

function LocalPlayerController:bindPlayers(players)
	self._players = players
	self._playerId = players[1]

	return self
end

function LocalPlayerController:setCurPlayer(playerId)
	for _, player in ipairs(self._players) do
		if playerId == player then
			self._playerId = playerId

			return
		end
	end
end

function LocalPlayerController:sendOpCommandByPlayer(playerId, op, args, callback)
	if self._playerId and playerId == self._playerId then
		self._inputManager:appendInput(playerId, op, args, callback)
	elseif self._players then
		for _, player in ipairs(self._players) do
			if playerId == player then
				return self._inputManager:appendInput(playerId, op, args, callback)
			end
		end
	end
end

function LocalPlayerController:sendOpCommand(op, args, callback)
	local playerId = self._playerId

	if playerId == nil then
		return false
	end

	return self._inputManager:appendInput(playerId, op, args, callback)
end
