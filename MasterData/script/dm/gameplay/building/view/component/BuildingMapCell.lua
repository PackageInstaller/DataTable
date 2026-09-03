-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingMapCell.lua

BuildingMapCell = class("BuildingMapCell", DmBaseUI)

BuildingMapCell:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")

function BuildingMapCell:initialize(data)
	super.initialize(self)
	self:setView(data.view)
	self:intiView()

	self._showType = KBuildingMapResource.kReduceThree
end

function BuildingMapCell:update()
	if self._showType == KBuildingMapResource.kNormal then
		return
	end

	local res = self:getRes()

	if res then
		self._image:loadTexture(res)
	end
end

function BuildingMapCell:intiView()
	self._image = self:getView()
end

function BuildingMapCell:getRes()
	local mapShowType = self._buildingSystem:getMapShowType()
	local res

	if mapShowType == KBuildingMapShowType.kAll then
		-- block empty
	elseif mapShowType == KBuildingMapShowType.kInRoom then
		local image = "building_map_" .. self._col .. "_" .. self._row .. ".jpg"

		res = KBuildingMapResource.kNormal .. image
		self._showType = KBuildingMapResource.kNormal
	end

	return res
end

function BuildingMapCell:setRowCol(row, col)
	self._row = row
	self._col = col
end

function BuildingMapCell:show()
	local view = self:getView()

	view:setVisible(true)
end

function BuildingMapCell:hide()
	local view = self:getView()

	view:setVisible(false)
end
