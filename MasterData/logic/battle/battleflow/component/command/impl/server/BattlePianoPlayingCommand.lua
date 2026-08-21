-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattlePianoPlayingCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattlePianoPlayingCommand", package.seeall)

local BattlePianoPlayingCommand = class("BattlePianoPlayingCommand", BattleCommandBase)

function BattlePianoPlayingCommand:parseServerCommand(cmdParser, pianoPlayingEventNOList)
	local cmd = BattlePianoPlayingCommand:createInstance()

	cmd:setPianoPlayingEventNOList(cmdParser, pianoPlayingEventNOList)

	local sequence = BattleSequenceCommand:createInstance()

	sequence:addCommand(cmd)
	sequence:addCommand(BattleAdjustCameraHeightCommand:create(0))
	cmdParser:addCommand(BattleAdjustCameraHeightCommand:create(-8, true))
	cmdParser:addCommand(sequence)
end

function BattlePianoPlayingCommand:onInit()
	self._scale2Cmd = {}
end

function BattlePianoPlayingCommand:onClear()
	for _, cmd in pairs(self._scale2Cmd) do
		cmd:safeInterrupt()
	end

	BattleTableUtil.clearTable(self._scale2Cmd)
end

function BattlePianoPlayingCommand:execute(battleFlow, runningContext)
	local pianoTerrainMgr = BattleMgr.instance:getPianoTerrainMgr()

	pianoTerrainMgr:setupPianoPlayingScaleCommand(self._scale2Cmd)
	pianoTerrainMgr:playFinishMusic(self._onFinish, self)
end

function BattlePianoPlayingCommand:_onFinish()
	BattleMainViewFacade.instance:setForNotOperatable()
	self:finish(true)
end

function BattlePianoPlayingCommand:toString()
	return "BattlePianoPlayingCommand"
end

function BattlePianoPlayingCommand:setPianoPlayingEventNOList(cmdParser, pianoPlayingEventNOList)
	for _, pianoPlayingEventNO in ipairs(pianoPlayingEventNOList) do
		local cmd = self:_getOrCreateCommand(pianoPlayingEventNO.scale)

		cmdParser:pushCmdContainer(cmd)
		BattleCmdUtil.parseServerCommandBatch(cmdParser, pianoPlayingEventNO.events)
		cmdParser:popCmdContainer()
	end

	return self
end

function BattlePianoPlayingCommand:_getOrCreateCommand(scale)
	local cmd = self._scale2Cmd[scale]

	if not cmd then
		cmd = BattleParallelCommand:createInstance()
		self._scale2Cmd[scale] = cmd
	end

	return cmd
end

return BattlePianoPlayingCommand
