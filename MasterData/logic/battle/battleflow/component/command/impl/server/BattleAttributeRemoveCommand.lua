-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleAttributeRemoveCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleAttributeRemoveCommand", package.seeall)

local BattleAttributeRemoveCommand = class("BattleAttributeRemoveCommand", BattleTimingCommandBase)

function BattleAttributeRemoveCommand:parseServerCommand(cmdParser, attributeModifiedEventNO)
	local cmd = BattleAttributeRemoveCommand:createInstance()

	cmd:setEntityId(attributeModifiedEventNO.entity)
	cmd:setAttr(attributeModifiedEventNO.attr)
	cmdParser:addCommand(cmd)
end

function BattleAttributeRemoveCommand:onInit()
	self._entityId = false
	self._propertyCode = false
end

function BattleAttributeRemoveCommand:onClear()
	self._entityId = false
	self._propertyCode = false
end

function BattleAttributeRemoveCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("cannot find entity[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.property:setAttribute(self._propertyCode)
	self:_checkSpecialAttributes(unit)
	self:finish(true)
end

function BattleAttributeRemoveCommand:_checkSpecialAttributes(unit)
	if self._propertyCode == BattleExtension_pb.Attribute.CURRENT_SAN then
		unit.effectPlayer:stopLoopEffect(BattleConst.LOW_SANITY)
	end
end

function BattleAttributeRemoveCommand:toString()
	return string.format("[entity player changed command entityId = %s,attrCode = %s]", self._entityId, self._propertyCode)
end

function BattleAttributeRemoveCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleAttributeRemoveCommand:setAttr(attrCode)
	self._propertyCode = attrCode

	return self
end

return BattleAttributeRemoveCommand
