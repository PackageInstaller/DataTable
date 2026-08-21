-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleWeakPointAddedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleWeakPointAddedCommand", package.seeall)

local BattleWeakPointAddedCommand = class("BattleWeakPointAddedCommand", BattleCommandBase)
local kEmptyTable = {}

function BattleWeakPointAddedCommand:parseServerCommand(cmdParser, weakPointAddedEventNO)
	local cmd = BattleWeakPointAddedCommand:createInstance()

	cmd:setEntityId(weakPointAddedEventNO.entity)
	cmd:setWeakPointHp(weakPointAddedEventNO.hp)
	cmd:setWeakPointType(weakPointAddedEventNO.type)
	cmdParser:addCommand(cmd)
end

function BattleWeakPointAddedCommand:onInit()
	self._entityId = false
	self._weakPointHp = false
	self._weakPointType = false
end

function BattleWeakPointAddedCommand:onClear(interrupt)
	self._entityId = false
	self._weakPointHp = false
	self._weakPointType = false
end

function BattleWeakPointAddedCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleWeakPointAddedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.property:setWeakPointHp(self._weakPointHp)
	unit.property:setWeakPointType(self._weakPointType)
	unit.property:activeState(BattleEnum.State.HAS_WEAK_POINT)
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
	self:finish(true)
end

function BattleWeakPointAddedCommand:toString()
	return string.format("[weak point added command entityId = %s,weakPointHp = %s,type = %s]", self._entityId, self._weakPointHp, self._weakPointType)
end

function BattleWeakPointAddedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleWeakPointAddedCommand:setWeakPointHp(weakPointHp)
	self._weakPointHp = weakPointHp

	return self
end

function BattleWeakPointAddedCommand:setWeakPointType(type)
	self._weakPointType = type
end

return BattleWeakPointAddedCommand
