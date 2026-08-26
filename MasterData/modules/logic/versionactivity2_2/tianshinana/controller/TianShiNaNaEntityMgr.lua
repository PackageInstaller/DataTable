-- chunkname: @modules/logic/versionactivity2_2/tianshinana/controller/TianShiNaNaEntityMgr.lua

module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaEntityMgr", package.seeall)

local TianShiNaNaEntityMgr = class("TianShiNaNaEntityMgr")

function TianShiNaNaEntityMgr:ctor()
	self._entitys = {}
	self._nodes = {}
end

function TianShiNaNaEntityMgr:addEntity(unitMo, parent)
	local entity = self._entitys[unitMo.co.id]

	if entity then
		entity:reAdd()

		return entity
	end

	local nodeCo = TianShiNaNaModel.instance.mapCo:getNodeCo(unitMo.x, unitMo.y)

	if not nodeCo or nodeCo:isCollapse() then
		return nil
	end

	local unitType = unitMo.co.unitType

	if not TianShiNaNaEnum.UnitTypeToName[unitType] then
		local unitName = ""
		local cls = _G[string.format("TianShiNaNa%sEntity", unitName)] or TianShiNaNaUnitEntityBase
		local go = gohelper.create3d(parent, unitName .. unitMo.co.id)

		entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, cls)

		entity:updateMo(unitMo)

		self._entitys[unitMo.co.id] = entity

		return entity
	end
end

function TianShiNaNaEntityMgr:getEntity(id)
	return self._entitys[id]
end

function TianShiNaNaEntityMgr:removeEntity(id)
	if self._entitys[id] then
		self._entitys[id]:dispose()

		self._entitys[id] = nil
	end
end

function TianShiNaNaEntityMgr:addNode(nodeCo, parent)
	if string.nilorempty(nodeCo.nodePath) then
		return
	end

	if self._nodes[nodeCo] then
		return self._nodes[nodeCo]
	end

	local go = gohelper.create3d(parent, string.format("%d_%d", nodeCo.x, nodeCo.y))
	local node = MonoHelper.addNoUpdateLuaComOnceToGo(go, TianShiNaNaNodeEntity)

	node:updateCo(nodeCo)

	self._nodes[nodeCo] = node

	return node
end

function TianShiNaNaEntityMgr:removeNode(nodeCo)
	if self._nodes[nodeCo] then
		self._nodes[nodeCo]:dispose()

		self._nodes[nodeCo] = nil
	end
end

function TianShiNaNaEntityMgr:clear()
	for _, entity in pairs(self._entitys) do
		entity:dispose()
	end

	for _, node in pairs(self._nodes) do
		node:dispose()
	end

	self._entitys = {}
	self._nodes = {}
end

TianShiNaNaEntityMgr.instance = TianShiNaNaEntityMgr.New()

return TianShiNaNaEntityMgr
