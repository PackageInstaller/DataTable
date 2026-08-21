-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\CommonEquipListPanel.lua

local DragEquipSortPanel = require("UI/Battle/DragEquipSortPanel")
local strClassName = "CommonEquipListPanel"
local CommonEquipListPanel = Class(strClassName, UIControls.Panel)

function CommonEquipListPanel:ctor(...)
	self.isDragTip = true
	self.cells = {}
	self._slot4CellSelect = Slot(self.onEquipCellSelect, self)

	self:initUI()
end

function CommonEquipListPanel:initUI(...)
	self.scrollEquips = UIControls.ScrollViewLoopV(self, self.mPath .. "/EquipList")

	self.scrollEquips:addEventCellChanged(self.onEquipCellChanged)

	self.panelSort = DragEquipSortPanel(self, self.mPath .. "/TabFunPanel")
	self.panelSort.mEventEquipListChanged = Slot(self.onEquipsChanged, self)

	self.panelSort:setVisible(true)

	if UIControls.checkControlFunc(self, self.mPath .. "/BgNothing") then
		self.panelBgNone = UIControls.Panel(self, self.mPath .. "/BgNothing")
	end
end

function CommonEquipListPanel:setEquipAttrFilter(fitlerTable)
	self.attrFilters = fitlerTable

	if self.allEquips then
		for index = #self.allEquips, 1, -1 do
			local equip = self.allEquips[index]
			local filterOK = false

			for _, filterInfo in ipairs(self.attrFilters) do
				if equip[filterInfo[1]] == filterInfo[2] then
					filterOK = true

					break
				end
			end

			if not filterOK then
				table.remove(self.allEquips, index)
			end
		end
	end
end

function CommonEquipListPanel:initEquipList(cellClass, cellPrefab, sortMap, filterMap, allEquips, topFunc)
	self.cellClass = cellClass
	self.cellPrefab = cellPrefab
	self.allEquips = allEquips

	self.panelSort:initSortPanel(sortMap, filterMap, topFunc)
end

function CommonEquipListPanel:refreshSort(...)
	self.panelSort:refreshEquips()
end

function CommonEquipListPanel:updateEquipBag(allEquips, filter, goToTop)
	self.allEquips = allEquips or self.allEquips
	self.filter = filter or {}
	self.showEquips = {}

	for _, equip in ipairs(self.allEquips) do
		if not self.filter[equip.gid] then
			if self.attrFilters then
				for _, filterInfo in ipairs(self.attrFilters) do
					if equip[filterInfo[1]] == filterInfo[2] then
						table.insert(self.showEquips, equip)

						break
					end
				end
			else
				table.insert(self.showEquips, equip)
			end
		end
	end

	local equipCount = #self.showEquips

	for idx, cell in pairs(self.cells) do
		local equip = self.showEquips[idx]

		if equip then
			cell:setObject(equip)
		end
	end

	if self.panelBgNone then
		if equipCount <= 0 then
			self.scrollEquips:setVisible(false)
			self.panelBgNone:setVisible(true)
		else
			self.scrollEquips:setVisible(true)
			self.panelBgNone:setVisible(false)
		end
	end

	if goToTop then
		self.scrollEquips:setTotalCount(equipCount, 1)
	else
		self.scrollEquips:setTotalCount(equipCount)
	end
end

function CommonEquipListPanel:onEquipsChanged(equips, goToTop)
	self:updateEquipBag(equips, self.filter, goToTop)
end

function CommonEquipListPanel:onEquipCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = self.cellClass(sender, self.cellPrefab, newIdx, 0, 0)

		targetCell:setSelectCallback(self._slot4CellSelect)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local equip = self.showEquips[newIdx]

	if equip then
		targetCell:setObject(equip)

		targetCell.isDragTip = self.isDragTip

		targetCell:setSelected(equip.gid == self.tgtEquipGID)
	end

	self.cells[newIdx] = targetCell
end

function CommonEquipListPanel:onEquipCellSelect(tgtCell)
	self.tgtEquipGID = tgtCell.equip.gid

	for idx, cell in pairs(self.cells) do
		cell:setSelected(cell == tgtCell)
	end
end

return CommonEquipListPanel
