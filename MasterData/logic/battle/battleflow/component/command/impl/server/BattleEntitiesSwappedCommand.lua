-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleEntitiesSwappedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleEntitiesSwappedCommand", package.seeall)

local BattleEntitiesSwappedCommand = class("BattleEntitiesSwappedCommand", BattleCommandBase)

function BattleEntitiesSwappedCommand:parseServerCommand(cmdParser, entities)
	local cmd = BattleEntitiesSwappedCommand:createInstance()

	cmd:setEntityIds(entities)
	cmdParser:addCommand(cmd)
end

function BattleEntitiesSwappedCommand:onInit()
	self._entityIds = {}
end

function BattleEntitiesSwappedCommand:onClear()
	BattleTableUtil.clearTable(self._entityIds)
end

function BattleEntitiesSwappedCommand:execute(battleFlow)
	local model = battleFlow.model
	local boardMgr = battleFlow.boardMgr
	local unitMgr = battleFlow.unitMgr
	local isReadyPhase = model:getPhase() == BattleEnum.Phase.READY

	for i = 1, #self._entityIds, 2 do
		local unitA = unitMgr:getUnit(self._entityIds[i])
		local unitB = unitMgr:getUnit(self._entityIds[i + 1])
		local unitBUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unitB.transform:getCoordinates())

		boardMgr:exchangeUnitToUnionIndex(unitA, unitBUnionIndex)

		if isReadyPhase then
			local aUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unitA.transform:getCoordinates())
			local bUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unitB.transform:getCoordinates())

			unitA.meshModel:lookAtDirVec3(BattleCampAdjustmentModel.instance:getBornDirectionOfUnionIndex(aUnionIndex))
			unitB.meshModel:lookAtDirVec3(BattleCampAdjustmentModel.instance:getBornDirectionOfUnionIndex(bUnionIndex))
		end
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnEntitySwapped)
	self:finish(true)
end

function BattleEntitiesSwappedCommand:toString()
	return string.format("[battle entities swapped command,swappedEntityIds = %s]", BattleTableUtil.arrayToString(self._entityIds))
end

function BattleEntitiesSwappedCommand:setEntityIds(entityIds)
	table.insertto(self._entityIds, entityIds)

	return self
end

return BattleEntitiesSwappedCommand
