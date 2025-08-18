-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BagRelicPart.lua

local strClassName = "BagRelicPart"
local BagRelicPart = Class(strClassName, UIControls.Child)

function BagRelicPart:ctor()
	self:initUI()
end

function BagRelicPart:initUI()
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "ItemListScroll")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.imgNone = UIControls.Image(self, "ImgNone")
end

function BagRelicPart:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.RelicGridLoop(sender, "System/Common/Grid/GridRelicItem", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell.inBag = true
	self.cells[newIdx] = targetCell

	targetCell:setObj(self.items[newIdx])
end

function BagRelicPart:refreshData()
	if not CurAvatar then
		return
	end

	self.items = CurAvatar:getAllRelics(nil, true)

	self:updateScroll()
end

function BagRelicPart:updateScroll()
	if #self.items == 0 then
		self.imgNone:setVisible(true)
		self.scroll:setVisible(false)
	else
		self.imgNone:setVisible(false)
		self.scroll:setVisible(true)
		self.scroll:setTotalCount(#self.items)
	end
end

return BagRelicPart
