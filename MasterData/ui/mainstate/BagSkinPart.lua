-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BagSkinPart.lua

local strClassName = "BagSkinPart"
local BagSkinPart = Class(strClassName, UIControls.Child)

function BagSkinPart:ctor()
	self:initUI()
end

function BagSkinPart:initUI()
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "ItemListScroll")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.btnTabAll = UIControls.Button(self, "TabPanel/Btn1")

	self.btnTabAll:addEventClick(self.onBtnTabClick)
	self.btnTabAll:setEnable(false)
end

function BagSkinPart:onBtnTabClick(sender)
	return
end

function BagSkinPart:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.SkinGridLoop(sender, "System/Common/Grid/GridSkinItemSmall", newIdx)
		targetCell.isShowPreviewTips = true
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setObj(self.skinItems[newIdx])
end

function BagSkinPart:refreshData()
	if not CurAvatar then
		return
	end

	self.skinItems = CurAvatar.skinItems

	self:updateScroll()
end

function BagSkinPart:updateScroll()
	if #self.skinItems == 0 then
		self.scroll:setVisible(false)
	else
		self.scroll:setVisible(true)
		self.scroll:setTotalCount(#self.skinItems)
	end
end

return BagSkinPart
