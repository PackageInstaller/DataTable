-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BagFragPart.lua

local UIControls = UIControls
local ResHero = require("ClientData/ResHero")
local FILTER_ALL = 0
local FILTER_HERO = 1
local FILTER_ARTIFACT = 2
local FILTER_EQUIP = 3
local strClassName = "BagFragPart"
local BagFragPart = Class(strClassName, UIControls.Child)

function BagFragPart:ctor()
	self:initUI()
end

function BagFragPart:initUI()
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "ItemListScroll")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.imgNone = UIControls.Image(self, "ImgNone")
	self.btnFilterAll = UIControls.Button(self, "TabPanel/Btn1")

	self.btnFilterAll:addEventClick(self.onFilterSelect)

	self.btnFilterHero = UIControls.Button(self, "TabPanel/Btn2")

	self.btnFilterHero:addEventClick(self.onFilterSelect)

	self.btnFilterArtifact = UIControls.Button(self, "TabPanel/Btn3")

	self.btnFilterArtifact:addEventClick(self.onFilterSelect)
	self.btnFilterAll:setEnable(false)
	self.btnFilterHero:setEnable(true)
	self.btnFilterArtifact:setEnable(true)

	self.filter = FILTER_ALL
end

function BagFragPart:onFilterSelect(sender)
	self.btnFilterAll:setEnable(sender ~= self.btnFilterAll)
	self.btnFilterHero:setEnable(sender ~= self.btnFilterHero)
	self.btnFilterArtifact:setEnable(sender ~= self.btnFilterArtifact)

	if sender == self.btnFilterAll then
		self.filter = FILTER_ALL
	elseif sender == self.btnFilterHero then
		self.filter = FILTER_HERO
	elseif sender == self.btnFilterArtifact then
		self.filter = FILTER_ARTIFACT
	end

	self:refreshData()
end

local function checkFragSortRedDot(object)
	local compose = object.resData.extend_args1

	if compose and compose > 0 then
		return compose <= object.num
	end

	return false
end

local function _sortFragFunc(a, b)
	local aRedFlag, bRedFlag

	aRedFlag = checkFragSortRedDot(a)
	bRedFlag = checkFragSortRedDot(b)

	if aRedFlag and not bRedFlag then
		return true
	elseif not aRedFlag and bRedFlag then
		return false
	elseif a.subType ~= b.subType then
		return a.subType > b.subType
	elseif a.quality ~= b.quality then
		return a.quality > b.quality
	else
		return a.id > b.id
	end
end

function BagFragPart:refreshData()
	if not CurAvatar then
		return
	end

	if self.filter == FILTER_ALL then
		self.items = CurAvatar:getAllFragmentItems()
	elseif self.filter == FILTER_HERO then
		self.items = CurAvatar:getItemsByStype(Const.ITEM_DICT_HERO_FRAG)
	elseif self.filter == FILTER_ARTIFACT then
		self.items = CurAvatar:getItemsByStype(Const.ITEM_DICT_ARTIFACT_FRAG)
	elseif self.filter == FILTER_EQUIP then
		self.items = CurAvatar:getItemsByStype(Const.ITEM_DICT_EQUIP_FRAG)
	else
		self.items = {}
	end

	if #self.items == 0 then
		self.imgNone:setVisible(true)
		self.scroll:setVisible(false)
	else
		self.imgNone:setVisible(false)
		self.scroll:setVisible(true)
		table.sort(self.items, _sortFragFunc)
		self.scroll:setTotalCount(#self.items)
	end
end

function BagFragPart:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.FragItemGridLoop(sender, "System/Common/Grid/GridShatterItem", newIdx)
		targetCell.mTipsConfig = self.mParent.tipsFuncFragItem
		targetCell.inBag = true
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setObj(self.items[newIdx])
end

return BagFragPart
