-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\AdvanceBPConfirmDlg.lua

local RechargeManager = require("System/Recharge/RechargeManager")
local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "AdvanceBPConfirmDlg"
local AdvanceBPConfirmDlg = Class(strClassName, UIControls.Window)

function AdvanceBPConfirmDlg:ctor(...)
	self:initUI()
end

function AdvanceBPConfirmDlg:initUI(...)
	self.closeBtn = UIControls.Button(self, "Bg/BtnClose")

	self.closeBtn:addEventClick(self.onClickClose)

	self.buyBtn = UIControls.Button(self, "Bg/BtnFunc")

	self.buyBtn:addEventClick(self.onClickBuy)

	self.priceTxt = UIControls.Label(self, "Bg/BtnFunc/TextPrice")
	self.ruleTxt = UIControls.Label(self, "Bg/TextRule")
	self.awardGridPath = "Bg/GridPanel"
	self.awardGrids = {}

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "Bg/BtnFunc/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "Bg/BtnFunc/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function AdvanceBPConfirmDlg:setBPInfo(rechargeId, ruleTxt)
	self.rechargeId = rechargeId

	local product = RechargeManager.getProductByRechargeId(self.rechargeId)

	if product then
		self.priceTxt:setText(product.priceText)

		local randId = product.randId

		if randId and ResRandClient[randId] then
			for i, itemId in ipairs(ResRandClient[randId].show_ids) do
				local itemNum = ResRandClient[randId].show_nums[i]
				local fakeItem = BaseObject.GetObject(itemId, itemNum)
				local grid = UIControls.getGridChild(fakeItem, self, self.awardGridPath)

				grid:setVisible(true)

				grid.mDisableWays = true

				grid:setObj(fakeItem)

				self.awardGrids[i] = grid
			end
		end
	end

	self.ruleTxt:setText(ruleTxt)
end

function AdvanceBPConfirmDlg:onClickClose(...)
	self:setVisible(false)
end

function AdvanceBPConfirmDlg:onClickBuy(...)
	if self.rechargeId then
		RechargeManager.startRecharge(self.rechargeId)
		self:setVisible(false)
	end
end

return AdvanceBPConfirmDlg
