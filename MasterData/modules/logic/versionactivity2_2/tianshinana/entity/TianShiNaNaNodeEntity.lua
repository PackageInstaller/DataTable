-- chunkname: @modules/logic/versionactivity2_2/tianshinana/entity/TianShiNaNaNodeEntity.lua

module("modules.logic.versionactivity2_2.tianshinana.entity.TianShiNaNaNodeEntity", package.seeall)

local TianShiNaNaNodeEntity = class("TianShiNaNaNodeEntity", LuaCompBase)

function TianShiNaNaNodeEntity:init(go)
	self.go = go
end

function TianShiNaNaNodeEntity:updateCo(nodeCo)
	local loader = PrefabInstantiate.Create(self.go)

	loader:startLoad(nodeCo.nodePath)

	local pos = TianShiNaNaHelper.nodeToV3(TianShiNaNaHelper.getV2(nodeCo.x, nodeCo.y))

	transformhelper.setLocalPos(self.go.transform, pos.x, pos.y, pos.z)
end

function TianShiNaNaNodeEntity:dispose()
	gohelper.destroy(self.go)
end

return TianShiNaNaNodeEntity
