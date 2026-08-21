-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBattleWaitingDispatch.lua

module("logic.battle.battleflow.defaultwork.WorkBattleWaitingDispatch", package.seeall)

local M = class("WorkBattleWaitingDispatch", WorkBase)

function M:ctor(eventType)
	self._eventType = eventType

	M.super.ctor(self)
end

function M:onEnter(context)
	BattleDispatcher:addEventListener(self._eventType, self._onFinish, self)
end

function M:onExit(isInterrupt)
	BattleDispatcher:removeEventListener(self._eventType, self._onFinish, self)
end

function M:_onFinish()
	BattleDispatcher:removeEventListener(self._eventType, self._onFinish, self)
	self:onDone(WorkResult.Succeed)
end

return M
