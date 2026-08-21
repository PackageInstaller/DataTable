-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/util/BattleCampRelationUtil.lua

module("logic.battle.util.BattleCampRelationUtil", package.seeall)

local BattleCampRelationUtil = {}

function BattleCampRelationUtil.isSameOrFriendRelation(relationType)
	return relationType == BattleEnum.CampRelation.SAME or relationType == BattleEnum.CampRelation.FRIEND
end

function BattleCampRelationUtil.isSameOfOperateCamp(unit)
	local relationType = BattleCampRelationUtil.getCampRelationWithOperateCamp(unit.property:getCampId())

	return relationType == BattleEnum.CampRelation.SAME
end

function BattleCampRelationUtil.isFriendOfOperateCamp(unit)
	local relationType = BattleCampRelationUtil.getCampRelationWithOperateCamp(unit.property:getCampId())

	return relationType == BattleEnum.CampRelation.FRIEND
end

function BattleCampRelationUtil.isSameOrFriendOfOperateCamp(unit)
	local relationType = BattleCampRelationUtil.getCampRelationWithOperateCamp(unit.property:getCampId())

	return relationType == BattleEnum.CampRelation.SAME or relationType == BattleEnum.CampRelation.FRIEND
end

function BattleCampRelationUtil.isEnemyOfOperateCamp(unit)
	local relationType = BattleCampRelationUtil.getCampRelationWithOperateCamp(unit.property:getCampId())

	return relationType == BattleEnum.CampRelation.ENEMY
end

function BattleCampRelationUtil.getCampRelationWithOperateCamp(campId)
	local model = BattleMgr.instance:getModel()
	local operateCampId = model:getOperateCampId()

	return model:getCampRelation(operateCampId, campId)
end

function BattleCampRelationUtil.areTheySameOrFriendRelation(unitA, unitB)
	local relationType = BattleCampRelationUtil.getCampRelationOfThey(unitA, unitB)

	return relationType == BattleEnum.CampRelation.SAME or relationType == BattleEnum.CampRelation.FRIEND
end

function BattleCampRelationUtil.areTheyEnemyRelation(unitA, unitB)
	local relationType = BattleCampRelationUtil.getCampRelationOfThey(unitA, unitB)

	return relationType == BattleEnum.CampRelation.ENEMY
end

function BattleCampRelationUtil.getCampRelationOfThey(unitA, unitB)
	if unitA and unitB then
		local model = BattleMgr.instance:getModel()

		return model:getCampRelation(unitA.property:getCampId(), unitB.property:getCampId())
	end

	return BattleEnum.CampRelation.NORMAL
end

return BattleCampRelationUtil
