-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/util/GuideUtility.lua

module("logic.extensions.guide.util.GuideUtility", package.seeall)

local GuideUtility = {}

function GuideUtility.isUnitAtTargetCell(entityCode, x, z)
	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(x, z)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnitOnUnionIndex(unionIndex)

	return unit and unit.property:getEntityCode() == entityCode
end

return GuideUtility
