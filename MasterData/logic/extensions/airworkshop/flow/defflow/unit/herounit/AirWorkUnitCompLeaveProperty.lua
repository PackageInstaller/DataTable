-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/unit/herounit/AirWorkUnitCompLeaveProperty.lua

module("logic.extensions.airworkshop.flow.defflow.unit.herounit.AirWorkUnitCompLeaveProperty", package.seeall)

local M = class("AirWorkUnitCompLeaveProperty", BattleUnitCompBase)

function M:onInit()
	return
end

function M:onReset()
	self:onInit()
end

function M:onDestroy()
	self:onInit()
end

function M:setUnitMO(mo)
	self._leaveMO = mo

	self:setEntityId(self._leaveMO:getEntityId())
end

function M:getUnitMO()
	return self._leaveMO
end

function M:setUnionIndex(unionIndex)
	self._leaveMO:setUnionIndex(unionIndex)
end

function M:getUnionIndex(unionIndex)
	return self._leaveMO:getUnionIndex()
end

function M:setEntityId(entityId)
	self._entityId = entityId
end

function M:getEntityId()
	return self._entityId
end

function M:getName()
	return "撤离点"
end

function M:getMonsterType()
	return BattleEnum.MonsterType.NORMAL
end

function M:getUnitType()
	return AirWorkShopEnum.UnitType.ExitPoint
end

function M:getTabType()
	return AirWorkShopEnum.TabEnum.ExitPoint
end

return M
