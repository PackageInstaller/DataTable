-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkUnitCompBuildingProperty.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkUnitCompBuildingProperty", package.seeall)

local M = class("AirWorkUnitCompBuildingProperty", BattleUnitCompBase)

function M:onInit()
	self._canFly = false
end

function M:onReset()
	self:onInit()
end

function M:onDestroy()
	self:onInit()
end

function M:setUnitMO(mo)
	self._buildingMO = mo
end

function M:getUnitMO()
	return self._buildingMO
end

function M:setUnionIndex(unionIndex)
	self._buildingMO:setUnionIndex(unionIndex)
end

function M:getUnionIndex(unionIndex)
	return self._buildingMO:getUnionIndex()
end

function M:setEntityCode(entityCode)
	self._entityCode = entityCode

	local entityCO = AirWorkShopConfig.instance:getBuildingCO(entityCode)

	self._name = entityCO.name
	self._canFly = entityCO.canFly
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:getEntityId()
	return self._entityId
end

function M:getEntityCode()
	return self._entityCode
end

function M:getName()
	return self._name
end

function M:getMonsterType()
	return BattleEnum.MonsterType.NORMAL
end

function M:getUnitType()
	return self._buildingMO:getUnitType()
end

function M:getTabType()
	return self._buildingMO:getTabType()
end

function M:canFly()
	return self._canFly
end

return M
