-- chunkname: @modules/logic/fight/controller/replay/FightReplayErrorFix.lua

module("modules.logic.fight.controller.replay.FightReplayErrorFix", package.seeall)

local FightReplayErrorFix = class("FightReplayErrorFix")
local ErrorTime = 5

function FightReplayErrorFix:ctor()
	self._hasStartErrorCheck = false
	self._lostConnect = false
	self._startTime = Time.time
end

function FightReplayErrorFix:addConstEvents()
	FightController.instance:registerCallback(FightEvent.PushEndFight, self._stopReplay, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, self._onLostConnect, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, self._onReconnectSucc, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnServerKickedOut, self._onServerKickedOut, self)
end

function FightReplayErrorFix:reInit()
	self:_stopReplay()
end

function FightReplayErrorFix:startReplayErrorFix()
	self._lostConnect = false
	self._hasStartErrorCheck = true
	self._startTime = Time.time

	TaskDispatcher.runRepeat(self._onSecond, self, 1)

	self._callbackDict = {}

	for _, evtId in pairs(FightEvent) do
		local function callback()
			self._startTime = Time.time
		end

		self._callbackDict[evtId] = callback

		FightController.instance:registerCallback(evtId, callback, nil)
	end

	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, self._onApplicationPause, self)
end

function FightReplayErrorFix:_onApplicationPause()
	self._startTime = Time.time
end

function FightReplayErrorFix:_onLostConnect()
	self._lostConnect = true
end

function FightReplayErrorFix:_onReconnectSucc()
	self._startTime = Time.time
	self._lostConnect = false
end

function FightReplayErrorFix:_onServerKickedOut()
	self:_stopReplay()
end

function FightReplayErrorFix:_stopReplay()
	if self._hasStartErrorCheck then
		self._hasStartErrorCheck = false

		TaskDispatcher.cancelTask(self._onSecond, self)
		self:_clearEvtCbs()
	end

	self._hasLog = nil
end

function FightReplayErrorFix:_clearEvtCbs()
	if self._callbackDict then
		for evtId, callback in pairs(self._callbackDict) do
			FightController.instance:unregisterCallback(evtId, callback, nil)
		end

		self._callbackDict = nil
	end

	GameStateMgr.instance:unregisterCallback(GameStateEvent.onApplicationPause, self._onApplicationPause, self)
end

function FightReplayErrorFix:_onSecond()
	if self._lostConnect then
		return
	end

	if #ConnectAliveMgr.instance:getUnresponsiveMsgList() > 0 then
		return
	end

	local now = Time.time

	if now - self._startTime > ErrorTime then
		self:_fixErrorState()
	end
end

function FightReplayErrorFix:_fixErrorState()
	FightMsgMgr.sendMsg(FightMsgId.ForceReleasePlayFlow)

	if FightModel.instance:isFinish() then
		FightRpc.instance:sendEndFightRequest(false)
	else
		FightReplayController.instance:doneCardStage()
		FightRpc.instance:sendBeginRoundRequest({})
	end
end

function FightReplayErrorFix:_log(str)
	if not self._hasLog then
		self._hasLog = true

		local fightParam = FightModel.instance:getFightParam()
		local episodeId = fightParam and fightParam.episodeId
		local battleId = fightParam and fightParam.battleId

		if episodeId then
			logError(str .. " episode_" .. episodeId)
		else
			logError(str .. " battle_" .. (battleId or "nil"))
		end
	end
end

return FightReplayErrorFix
