-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleTriggerCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleTriggerCommand", package.seeall)

local BattleTriggerCommand = class("BattleTriggerCommand", BattleCommandBase)

function BattleTriggerCommand:create(callback, callbackSelf, delay)
	local cmd = BattleTriggerCommand:createInstance()

	cmd:setListener(callback, callbackSelf)
	cmd:setDelay(delay)

	return cmd
end

function BattleTriggerCommand:onInit()
	self._delay = false
	self._handler = Handler.New()
	self._timeWaiter = TimeWaiter.New()
end

function BattleTriggerCommand:onClear(interrupt)
	self._delay = false

	self._handler:clear()
	self._timeWaiter:clear()
end

function BattleTriggerCommand:execute(battleFlow)
	if self._delay then
		self._timeWaiter:setTimeScale(BattleTime.timeScale)
		self._timeWaiter:start(self._delay, self._onTimerDone, self)
	else
		self:_onTimerDone()
	end
end

function BattleTriggerCommand:_onTimerDone()
	self._handler:call()
	self:finish(true)
end

function BattleTriggerCommand:toString()
	return string.format("[delay command delay = %s]", tostring(self._delay))
end

function BattleTriggerCommand:setDelay(delay)
	self._delay = delay
end

function BattleTriggerCommand:setListener(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
end

return BattleTriggerCommand
