-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpvp/view/RTPVPDelegate.lua

RTPVPDelegate = class("RTPVPDelegate", Facade)

RTPVPDelegate:has("_battleSimulator", {
	is = "r"
})
RTPVPDelegate:has("_players", {
	is = "r"
})
RTPVPDelegate:has("_playersData", {
	is = "r"
})
RTPVPDelegate:has("_mainPlayer", {
	is = "r"
})
RTPVPDelegate:has("_mainPlayerId", {
	is = "r"
})
RTPVPDelegate:has("_opponent", {
	is = "r"
})
RTPVPDelegate:has("_opponentId", {
	is = "r"
})
RTPVPDelegate:has("_", {
	is = "r"
})
RTPVPDelegate:has("_battleRecorder", {
	is = "r"
})
RTPVPDelegate:has("_service", {
	is = "r"
})
RTPVPDelegate:has("_finishCallback", {
	is = "r"
})

function RTPVPDelegate:initialize(rid, battleData, simulator, finishCallback, roomId)
	super.initialize(self)

	self._battleSimulator = simulator

	local battleLogic = self._battleSimulator:getBattleLogic()
	local player1 = battleLogic:getTeamA():getPlayerByIndex(1)
	local player2 = battleLogic:getTeamB():getPlayerByIndex(1)

	self._mainPlayer = player1:getId() == rid and player1 or player2
	self._mainPlayerId = self._mainPlayer:getId()
	self._opponent = player1:getId() ~= rid and player1 or player2
	self._opponentId = self._opponent:getId()
	self._players = {
		{
			players = {
				player1:getId()
			}
		},
		{
			players = {
				player2:getId()
			}
		}
	}
	self._playersData = battleData
	self._battleRecorder = self._battleSimulator:getBattleRecorder()
	self._finishCallback = finishCallback
	self._roomId = roomId
end

function RTPVPDelegate:setupBattleEnvironment()
	return
end

function RTPVPDelegate:onSkipBattle(sender)
	self._service:onSkipBattle()
end

function RTPVPDelegate:onBattleFinished(sender, result)
	self._finishCallback(result)
end

function RTPVPDelegate:onBattleFinish(result)
	return
end

function RTPVPDelegate:getRoomId()
	return self._roomId
end
