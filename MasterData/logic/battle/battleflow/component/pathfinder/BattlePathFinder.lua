-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/pathfinder/BattlePathFinder.lua

module("logic.battle.battleflow.component.pathfinder.BattlePathFinder", package.seeall)

local BattlePathFinder = class("BattlePathFinder", IBattleFlowComp)
local kTempPathUnionIndexList = {}

function BattlePathFinder:onInit()
	BattlePathFinder_private:init()

	self._nodeArray = false
end

function BattlePathFinder:onStart()
	self._nodeArray = Array2D.New()
	self._boardModel = self.flow.boardModel or false
	self._model = self.flow.model or false
	self._unitMgr = self.flow.unitMgr or false
end

function BattlePathFinder:onEnterDone()
	self:_buildNodes()
end

function BattlePathFinder:onClear()
	self._nodeArray = false
	self._boardModel = false
	self._model = false
	self._unitMgr = false
end

function BattlePathFinder:signDefaultStopableAndAttackableArea(unit)
	local skillId = unit.skill:getNormalSkill():getSkillId()

	return self:signStopableAndAttackableArea(unit, skillId)
end

function BattlePathFinder:signStopableAndAttackableArea(unit, skillId)
	self:signStopableArea(unit)
	self:signAttackableArea(unit, skillId)

	return self._nodeArray
end

function BattlePathFinder:signStopableArea(unit)
	local fromUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

	return self:internal_signStopableArea(unit, fromUnionIndex)
end

function BattlePathFinder:internal_signStopableArea(unit, fromUnionIndex)
	local isDisableMove = BattleUnitUtil.isDisableMove(unit)
	local walkCostMax = isDisableMove and 0 or unit.property:getAttribute(BattleExtension_pb.Attribute.MOVE)

	self:_prepareForSignArea(unit)
	self:signWalkableArea(unit, fromUnionIndex, walkCostMax)
	self:signPrettyPath(unit, fromUnionIndex)

	return self._nodeArray
end

function BattlePathFinder:signWalkableArea(unit, fromUnionIndex, walkCostMax)
	if unit.property:isStateActive(BattleEnum.State.IGNORE_BARRIER) then
		self:_signWalkableAreaForTransportMove(unit, fromUnionIndex, walkCostMax)
	else
		self:_signWalkableArea(unit, fromUnionIndex, walkCostMax)
	end
end

function BattlePathFinder:signAttackableArea(unit, skillId)
	self:_signAttackableArea(unit, skillId)

	return self._nodeArray
end

function BattlePathFinder:signTransportableArea(unit, shape, fromUnionIndex)
	self:_signTransportableArea(unit, shape, fromUnionIndex)

	return self._nodeArray
end

function BattlePathFinder:signSelectableArea(shape, fromUnionIndex)
	self:_signSelectableArea(shape, fromUnionIndex)

	return self._nodeArray
end

function BattlePathFinder:signSkillRangeArea(shape, targetUnionIndex, unitUnionIndex)
	self:_signSkillRangeArea(shape, targetUnionIndex, unitUnionIndex)
end

function BattlePathFinder:signCanAttackTarget(attacker, fromUnionIndex, targetUnionIndex, skillId)
	self:_signCanAttackTarget(attacker, fromUnionIndex, targetUnionIndex, skillId)
end

function BattlePathFinder:signPrettyPath(unit, fromUnionIndex, currentPathUnionIndexs)
	self:_signPrettyPath(unit, fromUnionIndex, currentPathUnionIndexs)
end

function BattlePathFinder:findNearestAttackUnionIndexOnSignResult(unit, attackUnionIndex)
	return self:_findNearestAttackUnionIndexBaseOnSignResult(unit, attackUnionIndex)
end

function BattlePathFinder:findPathForServer(unit, skillId, fromUnionIndex, toUnionIndex)
	if unit.property:isStateActive(BattleEnum.State.IGNORE_BARRIER) then
		return {
			toUnionIndex
		}
	end

	local originalUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

	self._boardModel:setUnitToUnionIndex(unit, fromUnionIndex, true)
	self:internal_signStopableArea(unit, fromUnionIndex)

	local resultList = self:_exportPathOnSignResult(unit, toUnionIndex)

	table.remove(resultList, 1)
	self._boardModel:setUnitToUnionIndex(unit, originalUnionIndex, true)

	return resultList
end

function BattlePathFinder:findPrettyPath(unit, toUnionIndex)
	local resultList = kTempPathUnionIndexList

	BattleTableUtil.clearTable(resultList)
	self:_findPrettyPath(toUnionIndex, resultList)
	BattleTableUtil.reverse(resultList)

	return resultList
end

function BattlePathFinder:findShortestPath(unit, toUnionIndex)
	local fromUnionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())

	self:_findPathBaseOnSignResult(unit, fromUnionIndex, toUnionIndex)

	local resultList = self:_exportPathOnSignResult(unit, toUnionIndex)

	return resultList
end

function BattlePathFinder:findShortestPath2(unit, fromUnionIndex, toUnionIndex)
	self:_findPathBaseOnSignResult(unit, fromUnionIndex, toUnionIndex)

	local resultList = self:_exportPathOnSignResult(unit, toUnionIndex)

	return resultList
end

function BattlePathFinder:_exportPathOnSignResult(unit, toUnionIndex)
	local resultList = kTempPathUnionIndexList

	BattleTableUtil.clearTable(resultList)

	if toUnionIndex then
		self:_findPathToList(toUnionIndex, resultList)
	end

	BattleTableUtil.reverse(resultList)

	return resultList
end

function BattlePathFinder:isInCanAttackTargetArea(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local resultNode = self._nodeArray:getElement(x, z)

	return resultNode.isCanAttackTarget
end

function BattlePathFinder:isInBestCanAttackTargetArea(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local resultNode = self._nodeArray:getElement(x, z)

	return resultNode.isBestCanAttackTarget
end

function BattlePathFinder:isInStopableArea(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local resultNode = self._nodeArray:getElement(x, z)

	return resultNode.isStopable
end

function BattlePathFinder:isInAttackableArea(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local resultNode = self._nodeArray:getElement(x, z)

	return resultNode.isAttackable
end

function BattlePathFinder:isInTransportableArea(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local resultNode = self._nodeArray:getElement(x, z)

	return resultNode.isTransportable
end

function BattlePathFinder:isInSelectableArea(unionIndex)
	local x, z = BoardIndexConverter.unionIndexToCoordinates(unionIndex)
	local resultNode = self._nodeArray:getElement(x, z)

	return resultNode.isSelectable
end

function BattlePathFinder:getNodeArray()
	return self._nodeArray
end

return BattlePathFinder
