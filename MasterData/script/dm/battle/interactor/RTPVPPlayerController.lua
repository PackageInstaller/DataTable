-- chunkname: @/tmp/or_script/lua_compile/dm/battle/interactor/RTPVPPlayerController.lua

require("dm.battle.logic.simulator.BattlePlayerController")

RTPVPPlayerController = class("RTPVPPlayerController", BattlePlayerController)

RTPVPPlayerController:has("_director", {
	is = "r"
})
RTPVPPlayerController:has("_battlePlayer", {
	is = "r"
})

function RTPVPPlayerController:initialize(director)
	super.initialize(self)

	self._director = director
end

function RTPVPPlayerController:bindPlayer(playerId)
	self._battlePlayer = playerId

	return self
end

function RTPVPPlayerController:bindPlayers(players)
	self._players = players
	self._battlePlayer = players[1]

	return self
end

function RTPVPPlayerController:setCurPlayer(playerId)
	for _, player in ipairs(self._players) do
		if playerId == player then
			self._battlePlayer = playerId

			return
		end
	end
end

function RTPVPPlayerController:sendOpCommand(op, args, callback)
	return self._director:sendMessage(op, args, callback)
end

function RTPVPPlayerController:sendOpCommandByPlayer(playerId, op, args, callback)
	return self._director:sendMessage(op, args, callback)
end

function RTPVPPlayerController:runCommand(op, args, callback)
	return self._director:getBattleSimulator():getInputManager():appendInput(self._battlePlayer, op, args, callback)
end
