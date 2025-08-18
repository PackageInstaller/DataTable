-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\MonthCardResultBox.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResRecharge = require("ClientData/ResRecharge")
local ResCardClient = require("ClientData/ResCardClient")
local className = "MonthCardResultBox"
local MonthCardResultBox = Class(className, UIControls.Window)

function MonthCardResultBox:ctor()
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.icon = UIControls.Image(self, "Bg/Icon")
	self.imgGet = UIControls.Image(self, "Bg/AwardPanel/EverydayAwardPanel/ImgGet")
	self.panelBuyAward = UIControls.Panel(self, "Bg/AwardPanel/BuyAwardPanel")
	self.gridItems = {}
	self.dayAwardItems = {}
	self.hasDayAwards = false
	self.recharge2id = {}

	for _, data in pairs(ResCardClient) do
		for _, rId in ipairs(data.recharge_id or {}) do
			self.recharge2id[rId] = data
		end
	end
end

function MonthCardResultBox:setData(rechargeId, normalAwards, dayAwards, closeCB)
	self.closeCB = closeCB

	local data = self.recharge2id[rechargeId]

	self.icon:setImage(data.icon_path, data.icon_icon)

	local rechargeData = ResRecharge[rechargeId]

	if rechargeData.result_title then
		self.txtTitle:setText(rechargeData.result_title)
	else
		self.txtTitle:setText(string.format(Lang.get(51871), rechargeData.product_name))
	end

	for _, itemN in ipairs(self.gridItems) do
		itemN:setVisible(false)
	end

	for _, itemD in ipairs(self.dayAwardItems) do
		itemD:setVisible(false)
	end

	if normalAwards ~= nil then
		local buyAwardData = self:getAwards(normalAwards)

		for index, item in ipairs(buyAwardData) do
			if not self.gridItems[index] then
				self.gridItems[index] = UIControls.getGridChild(item, self, "Bg/AwardPanel/BuyAwardPanel")
			end

			self.gridItems[index]:setVisible(true)
			self.gridItems[index]:setObj(item)

			self.gridItems[index].mDisableWays = true
		end
	else
		self.panelBuyAward:setVisible(false)
	end

	if dayAwards then
		self.hasDayAwards = true

		self.imgGet:setVisible(false)

		local dayAwardData = self:getAwards(dayAwards)

		for index, item in ipairs(dayAwardData) do
			if not self.dayAwardItems[index] then
				self.dayAwardItems[index] = UIControls.getGridChild(item, self, "Bg/AwardPanel/EverydayAwardPanel")
			end

			self.dayAwardItems[index]:setVisible(true)
			self.dayAwardItems[index]:setObj(item)

			self.dayAwardItems[index].mDisableWays = true
		end
	else
		self.hasDayAwards = false

		self.imgGet:setVisible(true)
	end
end

function MonthCardResultBox:getAwards(awardList)
	local clientItems = {}

	for _, item in pairs(ClientUtils.getAttrItems(awardList.attr)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonItems(awardList.item)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonEquips(awardList.equip)) do
		table.insert(clientItems, item)
	end

	for _, item in pairs(ClientUtils.getCommonArtifactsById(awardList.artifact)) do
		table.insert(clientItems, item)
	end

	return clientItems
end

function MonthCardResultBox:onClose()
	for _, grid in ipairs(self.gridItems) do
		grid:flyToCommonFuncEntryPanel()
	end

	if self.hasDayAwards then
		for idx, item in ipairs(self.dayAwardItems) do
			item:flyToCommonFuncEntryPanel()
		end
	end

	if self.closeCB then
		self.closeCB()
	end
end

return MonthCardResultBox
