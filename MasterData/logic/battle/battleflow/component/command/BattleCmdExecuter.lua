-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/BattleCmdExecuter.lua

module("logic.battle.battleflow.component.command.BattleCmdExecuter", package.seeall)

local BattleCmdExecuter = class("BattleCmdExecuter", IBattleFlowComp, IBattleContainerCommand, IBattleCommandHandler)

function BattleCmdExecuter:onInit()
	self._context = BattleCmdRunningContext.New()
	self._pauseSignal = SignalAmount.New()
	self._cmdList = {}
	self._isExecuting = false
end

function BattleCmdExecuter:onStart()
	self._isExecuting = false

	self._context:clear()
end

function BattleCmdExecuter:onClear()
	self:clearCommands()
	self._pauseSignal:clear()

	self._isExecuting = false

	self._context:clear()
end

function BattleCmdExecuter:getContext()
	return self._context
end

function BattleCmdExecuter:setPause(isPause, key)
	if isPause then
		self._pauseSignal:addUnique(key)
	else
		self._pauseSignal:remove(key)
	end

	if self._pauseSignal:isUnactive() then
		self:_tryNextCommand()
	end
end

function BattleCmdExecuter:addCommand(cmd)
	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleCmdExecuter::add commands %s", cmd:toString()))
	end

	table.insert(self._cmdList, cmd)

	return self
end

function BattleCmdExecuter:clearCommands()
	if BattleLog.enableLog then
		BattleLog.log("BattleCmdExecuter::clear commands")
	end

	for _, cmd in ipairs(self._cmdList) do
		cmd:clear(true)
	end

	if self._curCommand and not self._curCommand:isDestroyed() then
		self._curCommand:clear(true)
	end

	self._isExecuting = false

	BattleTableUtil.clearTable(self._cmdList)

	if self._curCommand then
		self._curCommand:safeInterrupt()

		self._curCommand = false
	end
end

function BattleCmdExecuter:submit()
	self:_tryNextCommand()
end

function BattleCmdExecuter:executeCommand(cmd, handler)
	cmd:setCommandHandler(handler)
	cmd:execute(self.flow, self._context)
end

function BattleCmdExecuter:onCommandFinish(cmd, success)
	self._curCommand = false
	self._isExecuting = false

	self:_tryNextCommand()
end

function BattleCmdExecuter:_tryNextCommand()
	if self._pauseSignal:isActive() then
		if BattleLog.enableLog then
			BattleLog.log("BattleCmdExecuter::pause")
		end

		return
	end

	if self._isExecuting then
		if BattleLog.enableLog then
			BattleLog.log("BattleCmdExecuter::executing")
		end

		return
	end

	local cmdList = self._cmdList

	if not cmdList or #cmdList <= 0 then
		self.flow.netEventMgr:tryNextEvent()

		if BattleLog.enableLog then
			BattleLog.log("BattleCmdExecuter::cmdList is empty")
		end

		return
	end

	self._isExecuting = true

	local cmd = table.remove(cmdList, 1)

	self._curCommand = cmd

	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleCmdExecuter::execute commands %s", cmd:toString()))
	end

	cmd:setCommandHandler(self)
	cmd:execute(self.flow, self._context)
end

return BattleCmdExecuter
