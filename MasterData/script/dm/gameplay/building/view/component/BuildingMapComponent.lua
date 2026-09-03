-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingMapComponent.lua

BuildingMapComponent = class("BuildingMapComponent", DmBaseUI)

BuildingMapComponent:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingMapComponent:has("_buildingMediator", {
	is = "rw"
})

function BuildingMapComponent:initialize(view)
	super.initialize(self, view)
	self:setupView()

	self._mapCellList = {}
end

function BuildingMapComponent:dispose()
	super.dispose(self)
end

function BuildingMapComponent:enterWithData(data)
	return
end

function BuildingMapComponent:setupView()
	return
end

function BuildingMapComponent:adjustLayout(targetFrame)
	return
end

function BuildingMapComponent:getMapCell(row, col)
	col = col + 1
	row = row + 1
	self._mapCellList[row] = self._mapCellList[row] or {}

	if self._mapCellList[row][col] == nil then
		local cellName = "BuildingMapCell"
		local view = self:getView()
		local cell = ccui.ImageView:create()

		cell:setAnchorPoint(cc.p(0, 0))
		cell:setContentSize(KBUILDING_MAP_CELL_SIZE)

		local mediator = self._buildingMediator:getInjector():instantiate(cellName, {
			view = cell
		})

		mediator:setRowCol(row, col)

		self._mapCellList[row][col] = mediator

		local pos = self._buildingSystem:getMapCellPos(row, col)

		cell:addTo(view):posite(pos.x, pos.y)
	end

	return self._mapCellList[row][col]
end

function BuildingMapComponent:refreshMapCell(row, col)
	local cmapCell = self:getMapCell(row, col)

	cmapCell:update()
end

function BuildingMapComponent:showMapCell(row, col)
	local cmapCell = self:getMapCell(row, col)

	cmapCell:show()
end

function BuildingMapComponent:hideMapCell(row, col)
	local cmapCell = self:getMapCell(row, col)

	cmapCell:hide()
end
