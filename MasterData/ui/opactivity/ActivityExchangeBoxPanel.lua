-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityExchangeBoxPanel.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ActivityExchangeBoxPanel = Class("ActivityExchangeBoxPanel", UIControls.Window)

function ActivityExchangeBoxPanel:ctor()
	self:initUI()
end

function ActivityExchangeBoxPanel:initUI()
	self.titleTxt = UIControls.Label(self, "Bg/TextTitle")
	self.descTxt = UIControls.Label(self, "Bg/LackPanel/Text")
	self.iconCost = UIControls.Image(self, "Bg/LackPanel/Icon01")
	self.numCost = UIControls.Label(self, "Bg/LackPanel/TextNum01")
	self.iconGet = UIControls.Image(self, "Bg/LackPanel/Icon02")
	self.numGet = UIControls.Label(self, "Bg/LackPanel/TextNum02")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm", "Text")

	self.btnConfirm:addEventClick(self.onBtnConfirm)
end

function ActivityExchangeBoxPanel:onBtnConfirm()
	if self.confirmCB then
		self.confirmCB()
	end

	self:setVisible(false)
end

function ActivityExchangeBoxPanel:setData(data, confirmCB)
	self.data = data

	local costInfo = ClientUtils.getMoneyIcon(data.itemCost)
	local getInfo = ClientUtils.getMoneyIcon(data.itemGet)

	self.iconCost:setImage(costInfo[1], costInfo[2])
	self.numCost:setText(data.numCost)
	self.iconGet:setImage(getInfo[1], getInfo[2])
	self.numGet:setText(data.numGet)

	if data.titleTxt then
		self.titleTxt:setText(data.titleTxt)
	end

	if data.descTxt then
		self.descTxt:setText(data.descTxt)
	end

	self.confirmCB = confirmCB

	if self.confirmCB == nil then
		self.btnConfirm:setVisible(false)
	end

	self.canFly = nil
	self.target = nil
end

function ActivityExchangeBoxPanel:setFlyConfig(canFly, target)
	self.canFly = canFly
	self.target = target
end

function ActivityExchangeBoxPanel:onClose()
	if self.canFly then
		if self.target then
			FlyIconUtils.setFlyUItoUI(self.iconGet, self.target, self.data.itemGet, self.data.numGet)
		else
			FlyIconUtils.sendFlyEvent(self.iconGet, self.data.itemGet, self.data.numGet)
		end
	end

	ActivityExchangeBoxPanel.super.onClose(self)
end

return ActivityExchangeBoxPanel
