-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BagCommonPart.lua

local ResRearHouse = require("ClientData/ResRearHouse")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local UIControls = UIControls
local FILTER_ALL = 0
local FILTER_MONEY = 1
local FILTER_BREAK = 2
local FILTER_OTHER = 3
local FILTER_REAR_HOUSE = 4
local REAR_HOUSE_TYPE_ORDER = {
	7,
	6,
	5,
	4,
	nil,
	2,
	3,
	1
}
local strClassName = "BagCommonPart"
local BagCommonPart = Class(strClassName, UIControls.Child)

function BagCommonPart:ctor()
	self:initUI()
end

function BagCommonPart:initUI()
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "ItemListScroll")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.imgNone = UIControls.Image(self, "ImgNone")
	self.btnFilterAll = UIControls.Button(self, "TabPanel/Btn1")

	self.btnFilterAll:addEventClick(self.onFilterSelect)

	self.btnFilterMoney = UIControls.Button(self, "TabPanel/Btn2")

	self.btnFilterMoney:addEventClick(self.onFilterSelect)

	self.btnFilterOther = UIControls.Button(self, "TabPanel/Btn3")

	self.btnFilterOther:addEventClick(self.onFilterSelect)

	self.btnFilterRearHouse = UIControls.Button(self, "TabPanel/Btn4")

	self.btnFilterRearHouse:addEventClick(self.onFilterSelect)
	self.btnFilterAll:setEnable(false)
	self.btnFilterMoney:setEnable(true)
	self.btnFilterOther:setEnable(true)

	self.filter = FILTER_ALL
end

function BagCommonPart:onFilterSelect(sender)
	self.btnFilterAll:setEnable(sender ~= self.btnFilterAll)
	self.btnFilterMoney:setEnable(sender ~= self.btnFilterMoney)
	self.btnFilterOther:setEnable(sender ~= self.btnFilterOther)
	self.btnFilterRearHouse:setEnable(sender ~= self.btnFilterRearHouse)

	if sender == self.btnFilterAll then
		self.filter = FILTER_ALL
	elseif sender == self.btnFilterMoney then
		self.filter = FILTER_MONEY
	elseif sender == self.btnFilterOther then
		self.filter = FILTER_OTHER
	elseif sender == self.btnFilterRearHouse then
		self.filter = FILTER_REAR_HOUSE
	end

	self:refreshData()
end

local function sortByQuality(a, b)
	if a.quality ~= b.quality then
		return a.quality > b.quality
	else
		return a.id > b.id
	end
end

local function sortAllPart(a, b)
	if (a.subType == Const.ITEM_STYPE_UPGRADE_SKIN or b.subType == Const.ITEM_STYPE_UPGRADE_SKIN) and a.subType ~= b.subType then
		return a.subType == Const.ITEM_STYPE_UPGRADE_SKIN and CurAvatar:checkUseItemByHasSkin(a)
	end

	if a.resData.is_hint ~= b.resData.is_hint then
		return a.resData.is_hint ~= nil
	elseif a.isCanUse ~= b.isCanUse then
		return a.isCanUse > b.isCanUse
	elseif a.isCanUse == 1 then
		if a.subType ~= b.subType then
			return a.subType < b.subType
		elseif a.quality ~= b.quality then
			return a.quality > b.quality
		else
			return a.id > b.id
		end
	elseif (a.subType == Const.ITEM_STYPE_EQUIP_EVOLVE_MATERIAL or b.subType == Const.ITEM_STYPE_EQUIP_EVOLVE_MATERIAL) and a.subType ~= b.subType then
		return a.subType == Const.ITEM_STYPE_EQUIP_EVOLVE_MATERIAL
	elseif (a.subType == Const.ITEM_STYPE_REAR_HOUSE_PROPS or b.subType == Const.ITEM_STYPE_REAR_HOUSE_PROPS) and a.subType ~= b.subType then
		return a.subType ~= Const.ITEM_STYPE_REAR_HOUSE_PROPS
	elseif a.quality ~= b.quality then
		return a.quality > b.quality
	else
		return a.id > b.id
	end
end

local function sortForRearHouse(a, b)
	local a_data = ResRearHouse[a.id]
	local b_data = ResRearHouse[b.id]

	if a_data and b_data then
		if REAR_HOUSE_TYPE_ORDER[a_data.type_id] == REAR_HOUSE_TYPE_ORDER[b_data.type_id] then
			return sortByQuality(a, b)
		else
			return REAR_HOUSE_TYPE_ORDER[a_data.type_id] < REAR_HOUSE_TYPE_ORDER[b_data.type_id]
		end
	else
		return sortByQuality(a, b)
	end
end

function BagCommonPart:refreshData()
	if not CurAvatar then
		return
	end

	if self.filter == FILTER_ALL then
		self.items = CurAvatar:getAllCommonItems()

		self:filterRearHouseUsedPart()
	elseif self.filter == FILTER_MONEY then
		self.items = CurAvatar:getItemsByStype(Const.ITEM_DICT_MONEY)
	elseif self.filter == FILTER_OTHER then
		self.items = CurAvatar:getItemsByStype(Const.ITEM_DICT_OTHER)
	elseif self.filter == FILTER_REAR_HOUSE then
		self.items = CurAvatar:getItemsByStype(Const.ITEM_DICT_REAR_HOUSE)

		self:filterRearHouseUsedPart()
	else
		self.items = {}
	end

	local sortFunc = sortAllPart

	if self.filter == FILTER_REAR_HOUSE then
		sortFunc = sortForRearHouse
	end

	table.sort(self.items, sortFunc)

	if #self.items == 0 then
		self.imgNone:setVisible(true)
		self.scroll:setVisible(false)
	else
		self.imgNone:setVisible(false)
		self.scroll:setVisible(true)
		self.scroll:setTotalCount(#self.items)
	end
end

function BagCommonPart:filterRearHouseUsedPart(...)
	local item

	for i = #self.items, 1, -1 do
		item = self.items[i]

		if item.subType == Const.ITEM_STYPE_REAR_HOUSE_PROPS and item.num - (item.frozenNum or 0) <= 0 then
			table.remove(self.items, i)
		end
	end
end

function BagCommonPart:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.ItemGridLoop(sender, "System/Common/Grid/GridMaterialItem", newIdx)
		targetCell.mTipsConfig = self.mParent.tipsFuncItem
	else
		if targetCell.mIndex then
			self.cells[targetCell.mIndex] = nil
		end

		targetCell.mIndex = newIdx
	end

	targetCell.inBag = true
	targetCell.mDisableWays = true
	self.cells[newIdx] = targetCell

	targetCell:setObj(self.items[newIdx])
end

return BagCommonPart
