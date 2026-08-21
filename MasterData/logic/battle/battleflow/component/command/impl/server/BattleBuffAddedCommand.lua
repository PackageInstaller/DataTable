-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleBuffAddedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleBuffAddedCommand", package.seeall)

local BattleBuffAddedCommand = class("BattleBuffAddedCommand", BattleTimingCommandBase)

function BattleBuffAddedCommand:parseServerCommand(cmdParser, buffTriggeredEventNO)
	local cmd = BattleBuffAddedCommand:createInstance()

	cmd:setEntityId(buffTriggeredEventNO.entity)
	cmd:setBuffId(buffTriggeredEventNO.id)
	cmd:setBuffCode(buffTriggeredEventNO.code)
	cmd:setBuffRound(buffTriggeredEventNO.round)
	cmd:setBuffLayer(buffTriggeredEventNO.layer)
	cmdParser:addCommand(cmd)
end

function BattleBuffAddedCommand:onInit()
	self._entityId = 0
	self._buffId = 0
	self._buffCode = 0
	self._buffRound = 0
	self._buffLayer = 0
end

function BattleBuffAddedCommand:onClear()
	self._entityId = 0
	self._buffId = 0
	self._buffCode = 0
	self._buffRound = 0
	self._buffLayer = 0
end

function BattleBuffAddedCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleBuffAddedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	if BattleBuffUtil.addBuff(unit, self._buffId, self._buffCode, self._buffRound, self._buffLayer) then
		self:startTimer(BattleConst.HitHalfTime)
	else
		self:finish(true)
	end
end

function BattleBuffAddedCommand:toString()
	return string.format("[buff added command entityId = %s,buffId = %s,buffCode = %s,buffRound = %s,buffLayer = %s]", self._entityId, self._buffId, self._buffCode, self._buffRound, self._buffLayer)
end

function BattleBuffAddedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleBuffAddedCommand:setBuffId(buffId)
	self._buffId = buffId

	return self
end

function BattleBuffAddedCommand:setBuffCode(buffCode)
	self._buffCode = buffCode

	return self
end

function BattleBuffAddedCommand:setBuffRound(round)
	self._buffRound = round

	return self
end

function BattleBuffAddedCommand:setBuffLayer(layer)
	self._buffLayer = layer

	return self
end

return BattleBuffAddedCommand
