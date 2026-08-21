-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\PriceBuyPanel.lua

local PriceBuyPanel = Class("PriceBuyPanel", UIControls.Panel)

function PriceBuyPanel:ctor()
	self:initUI()
end

function PriceBuyPanel:initUI()
	self.textMoney = UIControls.Label(self, self.mPath .. "/TextPrice")

	if ChannelUtil.isDMMGame() then
		if UIControls.checkControlFunc(self, self.mPath .. "/IconCurrency") then
			self.pricePanel = UIControls.Panel(self, self.mPath .. "/IconCurrency")

			self.pricePanel:setVisible(false)
		end

		if UIControls.checkControlFunc(self, self.mPath .. "/TextPt") then
			self.priceDmmPanel = UIControls.Panel(self, self.mPath .. "/TextPt")

			self.priceDmmPanel:setVisible(true)
		end
	end
end

function PriceBuyPanel:setText(text)
	self.textMoney:setText(text)
end

return PriceBuyPanel
