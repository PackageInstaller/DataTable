-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/container/BattleParallelCommand.lua

module("logic.battle.battleflow.component.command.impl.container.BattleParallelCommand", package.seeall)

local BattleParallelCommand = class("BattleParallelCommand", BattleCommandBase, IBattleContainerCommand, IBattleCommandHandler)

function BattleParallelCommand:create(cmdParser, eventNOList)
	local sequence = BattleParallelCommand:createInstance()

	cmdParser:pushCmdContainer(sequence)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, eventNOList)
	cmdParser:popCmdContainer()

	return sequence
end

function BattleParallelCommand:onInit()
	self._commands = {}
	self._waitingCount = 0
end

function BattleParallelCommand:onClear(interrupt)
	self._waitingCount = 0

	for _, cmd in ipairs(self._commands) do
		cmd:safeInterrupt()
	end

	BattleTableUtil.clearTable(self._commands)
end

function BattleParallelCommand:execute(battleFlow, runningContext)
	local cmdList = self._commands

	self._waitingCount = #cmdList

	if self._waitingCount <= 0 then
		self:finish(true)

		return
	end

	local count = #self._commands

	for index = 1, count do
		local cmd = self._commands[index]

		if BattleLog.enableLog then
			BattleLog.log(string.format("BattleParallelCommand::execute commands %s", cmd:toString()))
		end

		cmd:setCommandHandler(self)
		cmd:execute(battleFlow, runningContext)
	end
end

function BattleParallelCommand:onCommandFinish(cmd, success)
	self._waitingCount = self._waitingCount - 1

	if self._waitingCount <= 0 then
		self:finish(true)
	end
end

function BattleParallelCommand:toString()
	return string.format("[parallel command count = %s]", #self._commands)
end

function BattleParallelCommand:addCommand(command)
	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleParallelCommand::add commands %s", command:toString()))
	end

	table.insert(self._commands, command)

	return self
end

return BattleParallelCommand
