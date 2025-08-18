-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\BtnCircleBattleOrder.lua

local strClassName = "BtnCircleBattleOrder"
local BtnCircleBattleOrder = Class(strClassName, UIControls.Child)

function BtnCircleBattleOrder:ctor()
	self:initUI()
end

function BtnCircleBattleOrder:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.imgSel = UIControls.Image(self, "ImgSel")
	self.txtOrder = UIControls.Label(self, "TextOrder")
	self.imgOrder = UIControls.Image(self, "IconOrder")
end

function BtnCircleBattleOrder:setOrderData(orderResData)
	self.orderData = orderResData

	self.txtOrder:setText(orderResData.name)

	if orderResData.icon_path and orderResData.icon then
		self.imgOrder:setImage(orderResData.icon_path, orderResData.icon)
	end
end

function BtnCircleBattleOrder:setSelected(selected)
	self.selected = selected

	self.imgSel:setVisible(self.selected)
	self.btnSelf:setEnable(not self.imgSel:getVisible())
end

function BtnCircleBattleOrder:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function BtnCircleBattleOrder:onBtnSelfClick()
	if self.orderData and self.selectCallback then
		self.selectCallback(self)
	end
end

return BtnCircleBattleOrder
