-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Item\\OpenChoose\\ChooseItemGiftPanel.lua

local strClassName = "BtnChooseItem"
local BtnChooseItem = Class(strClassName, UIControls.Child)

function BtnChooseItem:ctor()
	self:initUI()
end

function BtnChooseItem:initUI()
	self.panelStatePanel = UIControls.Panel(self, "StatePanel")
	self.imgLock = UIControls.Image(self, "StatePanel/ImgStateLock")
	self.imgGet = UIControls.Image(self, "StatePanel/ImgStateGet")

	self.imgGet:setVisible(true)
	self.imgLock:setVisible(false)
end

function BtnChooseItem:onBtnSelectClick(sender)
	self.mParent:onBtnSelectClick(self)
end

function BtnChooseItem:setItem(item)
	self.item = item
	self.itemGrid = UIControls.getGridChild(self.item, self, "GridItem")

	self.itemGrid:setObj(self.item)
	self.itemGrid:setVisible(true)

	self.itemGrid.mDisableWays = true
	self.itemGrid.mEnableTips = false
	self.itemGrid.mEventClick = Slot(self.onBtnSelectClick, self)
end

function BtnChooseItem:setSelected(beSelected)
	self.beSelected = beSelected

	self.panelStatePanel:setVisible(self.beSelected)
	self.itemGrid.btnSensor:setEnable(not self.beSelected)
end

local ChoosePanel = require("UI/MainState/Item/OpenChoose/ChoosePanel")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "ChooseItemGiftPanel"
local ChooseItemGiftPanel = Class(strClassName, ChoosePanel)

function ChooseItemGiftPanel:ctor()
	self:_initUI()
end

function ChooseItemGiftPanel:_initUI()
	self.textTips = UIControls.Label(self, self.mPath .. "/TextTips")
end

function ChooseItemGiftPanel:setItem(itemGift)
	self.itemGift = itemGift

	self.txtTitle:setText(self.itemGift.name)
	self.txtTimes:setText(self.itemGift.num)

	for i, random_id in ipairs(self.itemGift.resData.extend_args3) do
		local itemId = ResRandClient[random_id].show_ids[1]
		local itemNum = ResRandClient[random_id].show_nums[1]
		local item = BaseObject.GetObject(itemId, itemNum)
		local itemGiftCell = BtnChooseItem(self, self.mPath .. "/ItemList/Content", "System/Common/Grid/GridAwardContainer", 0, 0, true)

		itemGiftCell:setItem(item)

		self.btnList[i] = itemGiftCell
	end

	self:onBtnSelectClick(self.btnList[1])
end

function ChooseItemGiftPanel:onBtnSelectClick(sender)
	for i, cell in ipairs(self.btnList) do
		self.btnList[i]:setSelected(sender == cell)

		if sender == cell then
			self.curSelectIdx = i

			local item = self.btnList[self.curSelectIdx].itemGrid.object

			self.textTips:setText(item.name .. " X " .. item.num)
		end
	end
end

return ChooseItemGiftPanel
