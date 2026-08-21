-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/unitmgr/AirWorkShopUnitMgr.lua

module("logic.extensions.airworkshop.flow.defflow.component.unitmgr.AirWorkShopUnitMgr", package.seeall)

local M = class("AirWorkShopUnitMgr", IAirWorkShopFlowComp)

function M:onInit()
	self._entityId2Unit = false
	self._boardModel = self.flow.boardModel
end

function M:onStart()
	self._entityId2Unit = {}
end

function M:onClear()
	if self._entityId2Unit then
		for _, unit in pairs(self._entityId2Unit) do
			self:removeUnit(unit)
			AirWorkShopUnitGenerator.destroyUnit(unit)
		end
	end

	self._entityId2Unit = false
end

function M:getUnitOnUnionIndex(unionIndex, tabType)
	if not unionIndex then
		return false
	end

	local entityId = self._boardModel:getEntityOnBoard(unionIndex, tabType)

	return self:getUnit(entityId)
end

function M:getUnit(entityId)
	if self._entityId2Unit then
		return self._entityId2Unit[entityId]
	end
end

function M:addUnit(unit)
	local entityId = unit.property:getEntityId()

	self._entityId2Unit[entityId] = unit

	unit:dispatchCompInitFinish()
end

function M:removeUnit(unit)
	local entityId = unit.property:getEntityId()

	self._entityId2Unit[entityId] = nil
end

function M:getAllUnit()
	return self._entityId2Unit
end

return M
