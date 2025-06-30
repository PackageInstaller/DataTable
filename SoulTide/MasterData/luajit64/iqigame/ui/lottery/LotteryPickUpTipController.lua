-- chunkname: @IQIGame\\UI\\Lottery\\LotteryPickUpTipController.lua

local m = {
	Cells = {}
}
local LotteryPickUpTipCell = require("IQIGame.UI.Lottery.LotteryPickUpTipCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	local scrollAreaList = self.RewardScrollArea:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end
end

function m:Show(cfgLotteryPackUpData)
	self.View:SetActive(true)

	self.CfgLotteryPackUpData = cfgLotteryPackUpData

	local scrollAreaList = self.RewardScrollArea:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.CfgLotteryPackUpData.UpList)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:OnRenderCell(cell)
	local tipCell = self.Cells[cell.gameObject]

	if tipCell == nil then
		tipCell = LotteryPickUpTipCell.New(cell.gameObject)
		self.Cells[cell.gameObject] = tipCell
	end

	tipCell:SetData(self.CfgLotteryPackUpData.UpType, self.CfgLotteryPackUpData.UpList[cell.index + 1], UIGlobalApi.GetImagePath(self.CfgLotteryPackUpData.Icon))
end

function m:Dispose()
	for gameObject, cell in pairs(self.Cells) do
		cell:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CfgLotteryPackUpData = nil
end

return m
