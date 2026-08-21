-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleSheetMusicCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleSheetMusicCommand", package.seeall)

local BattleSheetMusicCommand = class("BattleSheetMusicCommand", BattleCommandBase)

function BattleSheetMusicCommand:parseServerCommand(cmdParser, sheetMusicNO)
	local cmd = BattleSheetMusicCommand:createInstance()

	cmd:setEntityId(sheetMusicNO.entity)
	cmd:setSkillId(sheetMusicNO.skill)
	cmd:setSheetMusicCode(sheetMusicNO.sheetMusicCode)
	cmd:setNoteNOList(sheetMusicNO.notes)

	local sequence = BattleSequenceCommand:createInstance()

	sequence:addCommand(cmd)
	sequence:addCommand(BattleAdjustCameraHeightCommand:create(0))
	cmdParser:addCommand(BattleAdjustCameraHeightCommand:create(-8, true))
	cmdParser:addCommand(sequence)
end

function BattleSheetMusicCommand:onInit()
	self._entityId = false
	self._skillId = false
	self._sheetMusicCode = false
	self._noteNOList = false
end

function BattleSheetMusicCommand:onClear()
	self._entityId = false
	self._skillId = false
	self._sheetMusicCode = false
	self._noteNOList = false
end

function BattleSheetMusicCommand:execute(battleFlow, runningContext)
	local pianoTerrainMgr = BattleMgr.instance:getPianoTerrainMgr()

	pianoTerrainMgr:setupMusic(self._entityId, self._skillId, self._sheetMusicCode, self._noteNOList)
	pianoTerrainMgr:playBeginMusic(self._onFinish, self)
end

function BattleSheetMusicCommand:toString()
	return "BattleSheetMusicCommand"
end

function BattleSheetMusicCommand:_onFinish()
	self:finish(true)
end

function BattleSheetMusicCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleSheetMusicCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

function BattleSheetMusicCommand:setSheetMusicCode(sheetMusicCode)
	self._sheetMusicCode = sheetMusicCode

	return self
end

function BattleSheetMusicCommand:setNoteNOList(noteNOList)
	self._noteNOList = noteNOList

	return self
end

return BattleSheetMusicCommand
