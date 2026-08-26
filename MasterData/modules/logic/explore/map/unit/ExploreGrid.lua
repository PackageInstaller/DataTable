-- chunkname: @modules/logic/explore/map/unit/ExploreGrid.lua

module("modules.logic.explore.map.unit.ExploreGrid", package.seeall)

local ExploreGrid = class("ExploreGrid", ExploreBaseUnit)

function ExploreGrid:onInit()
	self._resLoader = PrefabInstantiate.Create(self.go)

	self._resLoader:startLoad("modules/explore/prefabs/unit/m_s10_dynamic_ground_01.prefab")
end

function ExploreGrid:setName(name)
	self.go.name = name
end

function ExploreGrid:setPos(pos)
	if gohelper.isNil(self.go) == false then
		pos.y = 10

		local isHit, hitInfo = UnityEngine.Physics.Raycast(pos, Vector3.down, nil, Mathf.Infinity, ExploreHelper.getNavigateMask())

		pos.y = isHit and hitInfo.point.y or self.trans.position.y
		self.position = pos

		transformhelper.setPos(self.trans, self.position.x, self.position.y, self.position.z)

		local node = ExploreHelper.posToTile(pos)

		if node ~= self.nodePos then
			self.nodePos = node
			self.nodeMO = ExploreMapModel.instance:getNode(ExploreHelper.getKey(self.nodePos))
		end
	end
end

return ExploreGrid
