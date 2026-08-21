-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Management\\ManagementToyInfoDlg.lua

local ResBusinessToyConfig = require("ClientData/ResBusinessToyConfig")
local ManagementToyCell = require("UI/OpActivity/Management/ManagementToyCell")
local ManagementToyInfoDlg = Class("ManagementToyInfoDlg", UIControls.Window)

function ManagementToyInfoDlg:ctor()
	self.txtName = UIControls.Label(self, "BgPanel/TextTitle")
	self.txtDes = UIControls.Label(self, "BgPanel/TextDes")
	self.txtToyName = UIControls.Label(self, "BgPanel/ToyInfoPanel/TextToyName")
	self.txtToyLv = UIControls.Label(self, "BgPanel/ToyInfoPanel/TextLvNum")
	self.txtToyDes = UIControls.Label(self, "BgPanel/ToyInfoPanel/TextToyDes")
	self.txtUnlock = UIControls.Label(self, "BgPanel/ToyInfoPanel/TextUnlock")
	self.toyCell = ManagementToyCell(self, "BgPanel/ToyInfoPanel", "System/Activity/ActivityManagement1/ToyNeedCell")

	self.toyCell:init(true)
	self.toyCell:setVisible(true)

	self.toyCellList = {}
	self.slotOnClickToyCell = Slot(self.onClickToyCell, self)
end

function ManagementToyInfoDlg:setData(actId, type, quality, unlockQuality)
	self.actId = actId
	self.unlockQuality = unlockQuality

	local dataList = ResBusinessToyConfig[self.actId][type]

	self.maxQuality = #dataList

	local cellList = self.toyCellList
	local dataNum = #dataList
	local cellNum = #cellList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = ManagementToyCell(self, "BgPanel/ToyLvPanel", "System/Activity/ActivityManagement1/ToyNeedCell")

			cell:init(true, nil, self.slotOnClickToyCell)
			table.insert(cellList, cell)
		end

		cell:setVisible(true)

		local toyConfig = dataList[i]

		cell:setData(self.actId, toyConfig.id, toyConfig.quality, nil, toyConfig.quality > self.unlockQuality)

		if toyConfig.id == type and toyConfig.quality == quality then
			self:onClickToyCell(cell)
		end
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end
end

function ManagementToyInfoDlg:onClickToyCell(toyCell)
	if not toyCell then
		return
	end

	if self.selectToyCell ~= toyCell then
		if self.selectToyCell then
			self.selectToyCell:setSelect(false)
		end

		self.selectToyCell = toyCell

		self.selectToyCell:setSelect(true)
	end

	local type = toyCell.type
	local quality = toyCell.quality
	local checkLock = quality > self.unlockQuality
	local checkMax = quality == self.maxQuality

	self.toyCell:setData(self.actId, type, quality, nil, checkLock)

	if Const.REVIEW_VERSION then
		self.txtToyLv:setText(checkMax and Lang.get(1699) or Lang.get(1203) .. quality)
	else
		self.txtToyLv:setText(checkMax and "Max" or "Lv." .. quality)
	end

	local toyConfig = ResBusinessToyConfig[self.actId][type][quality]

	self.txtName:setText(toyConfig.type_name)
	self.txtDes:setText(toyConfig.type_des)
	self.txtUnlock:setVisible(checkLock)
	self.txtToyName:setVisible(not checkLock)
	self.txtToyDes:setVisible(not checkLock)

	if checkLock then
		self.txtUnlock:setText(toyConfig.unlock_des)
	else
		local item = BaseObject.GetObject(toyConfig.item_id, 1)

		self.txtToyName:setText(item.name)
		self.txtToyDes:setText(item.resData.desc)
	end
end

return ManagementToyInfoDlg
