-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/redo/BattleLightColumnRedoCommand.lua

module("logic.battle.battleflow.component.command.impl.redo.BattleLightColumnRedoCommand", package.seeall)

local BattleLightColumnRedoCommand = class("BattleLightColumnRedoCommand", BattleCommandBase)

function BattleLightColumnRedoCommand:parseServerRedoCommand(cmdParser, lightColumnNO)
	local cmd = BattleLightColumnRedoCommand:createInstance()

	cmd:setEntityId(lightColumnNO.column)
	cmd:setEffectId(lightColumnNO.lightRes)
	cmdParser:addCommand(cmd)
end

function BattleLightColumnRedoCommand:onInit()
	self._entityId = false
	self._effectId = false
end

function BattleLightColumnRedoCommand:onClear(interrupt)
	self._entityId = false
	self._effectId = false
end

function BattleLightColumnRedoCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local boardMgr = battleFlow.boardMgr
	local effectPlayer = battleFlow.effectPlayer
	local terrainUnit = unitMgr:getUnit(self._entityId)
	local tx, tz = terrainUnit.transform:getCoordinates()
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(tx, tz)
	local effectUnit = effectPlayer:playLoopEffect(self._effectId, string.format("%s_%d", self._effectId, unionIndex), 1)
	local wx, wy, wz = boardMgr:getCellPositionXYZ(unionIndex)

	effectUnit.transform:setPositionXYZ(wx, wy, wz)
	self:finish(true)
end

function BattleLightColumnRedoCommand:toString()
	return string.format("[redo][battle light column redo command column = %s,lightRes = %s]", self._entityId, self._effectId)
end

function BattleLightColumnRedoCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleLightColumnRedoCommand:setEffectId(effectId)
	self._effectId = tonumber(effectId)

	return self
end

return BattleLightColumnRedoCommand
