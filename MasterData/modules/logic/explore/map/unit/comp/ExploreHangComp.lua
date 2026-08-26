-- chunkname: @modules/logic/explore/map/unit/comp/ExploreHangComp.lua

module("modules.logic.explore.map.unit.comp.ExploreHangComp", package.seeall)

local ExploreHangComp = class("ExploreHangComp", LuaCompBase)

function ExploreHangComp:ctor(unit)
	self.unit = unit
	self.hangList = {}
end

function ExploreHangComp:setup(go)
	self.go = go

	for hangNode, resPath in pairs(self.hangList) do
		self:addHang(hangNode, resPath)
	end
end

function ExploreHangComp:addHang(hangNode, resPath)
	self.hangList[hangNode] = resPath

	if self.go then
		local child = gohelper.findChild(self.go, hangNode)

		if child then
			local loader = PrefabInstantiate.Create(child)

			if loader:getPath() ~= resPath then
				loader:startLoad(resPath)
			end
		end
	end
end

function ExploreHangComp:clear()
	self.go = nil
end

return ExploreHangComp
