-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleTotalChangedHpCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleTotalChangedHpCommand", package.seeall)

local BattleTotalChangedHpCommand = class("BattleTotalChangedHpCommand", BattleCommandBase)

function BattleTotalChangedHpCommand:parseServerCommand(cmdParser, eventNOList)
	local skillCode = cmdParser:getParam(BattleCmdParser.Param_SkillCode)
	local aEntityId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)
	local aUnit = BattleMgr.instance:getUnitMgr():getUnit(aEntityId)
	local isSoloPerformance = SkillPerformanceCOUtil.isSoloPerformance(skillCode, aUnit.skill:getSkillStatus())

	if isSoloPerformance then
		return
	end

	local bEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)
	local cmd = BattleTotalChangedHpCommand:createInstance()

	cmd:setAEntityId(aEntityId)
	cmd:setBEntityId(bEntityId)
	BattleCmdUtil.collectTotalChangedHp(eventNOList, cmd)
	cmdParser:addCommand(cmd)
end

function BattleTotalChangedHpCommand:onInit()
	self._aEntityId = 0
	self._bEntityId = 0
	self._aTotalDeltaHp = 0
	self._bTotalDeltaHp = 0
end

function BattleTotalChangedHpCommand:onClear()
	self._aEntityId = 0
	self._bEntityId = 0
	self._aTotalDeltaHp = 0
	self._bTotalDeltaHp = 0
end

function BattleTotalChangedHpCommand:collectFromDamagedEventNO(damagedEventNO)
	self:collectChangedHP(damagedEventNO.fromEntity, damagedEventNO.entity, -damagedEventNO.hpDecrement)
end

function BattleTotalChangedHpCommand:collectFromCuredEventNO(curedEventNO)
	self:collectChangedHP(curedEventNO.releaser, curedEventNO.entity, curedEventNO.value)
end

function BattleTotalChangedHpCommand:collectChangedHP(attackerEntityId, victimEntityId, deltaHp)
	if self._aEntityId == attackerEntityId and self._bEntityId == victimEntityId then
		self._aTotalDeltaHp = self._aTotalDeltaHp + deltaHp
	elseif self._bEntityId == attackerEntityId and self._aEntityId == victimEntityId then
		self._bTotalDeltaHp = self._bTotalDeltaHp + deltaHp
	elseif BattleLog.enableWarn then
		BattleLog.warn(string.format("invalid collect attackerEntityId = %s,victimEntityId = %s,deltaHp = %s", attackerEntityId, victimEntityId, deltaHp))
	end
end

function BattleTotalChangedHpCommand:execute(battleFlow)
	self:_processTotalDeltaChangedHp(self._aEntityId, self._bEntityId, self._aTotalDeltaHp)
	self:_processTotalDeltaChangedHp(self._bEntityId, self._aEntityId, self._bTotalDeltaHp)
	self:finish(true)
end

function BattleTotalChangedHpCommand:_processTotalDeltaChangedHp(attackerEntityId, victimEntityId, deltaHp)
	local absDeltaValue = math.abs(deltaHp)

	if deltaHp < 0 then
		-- block empty
	elseif deltaHp > 0 then
		BattleCuredCommand:dispatchCuredEvent(attackerEntityId, victimEntityId, absDeltaValue)
	end
end

function BattleTotalChangedHpCommand:containsChangedHp()
	return self._aTotalDeltaHp ~= 0 or self._bTotalDeltaHp ~= 0
end

function BattleTotalChangedHpCommand:toString()
	return string.format("[battle total changed hp command aEntityId = %s, aTotalDeltaHp = %s, bEntityId = %s, bTotalDeltaHp = %s]", self._aEntityId, self._aTotalDeltaHp, self._bEntityId, self._bTotalDeltaHp)
end

function BattleTotalChangedHpCommand:setAEntityId(entityId)
	self._aEntityId = entityId

	return self
end

function BattleTotalChangedHpCommand:setBEntityId(entityId)
	self._bEntityId = entityId

	return self
end

return BattleTotalChangedHpCommand
