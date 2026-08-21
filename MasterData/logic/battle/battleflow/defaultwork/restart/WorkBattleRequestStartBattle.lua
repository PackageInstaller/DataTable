-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/restart/WorkBattleRequestStartBattle.lua

module("logic.battle.battleflow.defaultwork.restart.WorkBattleRequestStartBattle", package.seeall)

local WorkBattleRequestStartBattle = class("WorkBattleRequestStartBattle", WorkBase)

function WorkBattleRequestStartBattle:ctor(isRealEnd, restartType)
	WorkBattleRequestStartBattle.super.ctor(self)

	self._isRealEnd = isRealEnd
	self._restartType = restartType
end

function WorkBattleRequestStartBattle:onEnter(context)
	if self._isRealEnd then
		context:sendRestartRequest(self._restartType)
		self:onDone(WorkResult.Succeed)

		return
	end

	self:_setEvent(true)
	BattleAgent.instance:sendSurrenderRequest(BattleExtension_pb.EndType.RESTART)
end

function WorkBattleRequestStartBattle:onExit(isInterrupt)
	self:_setEvent(false)
end

function WorkBattleRequestStartBattle:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_SURRENDER_REPLY, self._onReceiveSurrenderReply, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_SURRENDER_REPLY, self._onReceiveSurrenderReply, self)
	end
end

function WorkBattleRequestStartBattle:_onReceiveSurrenderReply()
	self.context:sendRestartRequest(self._restartType)
	self:onDone(WorkResult.Succeed)
end

return WorkBattleRequestStartBattle
