-- chunkname: @IQIGame\\UI\\Activity\\ReplacementPass\\ReplacementPassCell.lua

local m = {
	rewardTab = {},
	rewardCellPool = {}
}
local ReplacementPassRewardCell = require("IQIGame.UI.Activity.ReplacementPass.ReplacementPassRewardCell")
local ImageNumber = require("IQIGame.UI.Common.ImageNumber")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.passReplacementNum = ImageNumber.New(self.PassNumBox, 3, function(num)
		return ActivityUIApi:GetString("ReplacementImgNum", num)
	end)
	self.scrollList = self.Scroll:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnBuy()
		self:OnBtnBuy()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnBuy:GetComponent("Button").onClick:AddListener(self.delegateBtnBuy)
end

function m:RemoveListener()
	self.BtnBuy:GetComponent("Button").onClick:RemoveListener(self.delegateBtnBuy)
end

function m:SetData(data)
	self.cfgPassRepurchaseGift = data

	local cfgPayData

	for i, v in pairsCfg(CfgPayTable) do
		if v.MallID == self.cfgPassRepurchaseGift.MallId then
			cfgPayData = v

			break
		end
	end

	UGUIUtil.SetText(self.BtnBuyLabel, ActivityUIApi:GetString("ReplacementBtnBuyLabel", cfgPayData.Amount))
	UGUIUtil.SetText(self.PassName1, ActivityUIApi:GetString("ReplacementPassName1"))
	UGUIUtil.SetText(self.PassName2, self.cfgPassRepurchaseGift.Name)

	local path = UIGlobalApi.GetImagePath(self.cfgPassRepurchaseGift.TitleImage)

	AssetUtil.LoadImage(self, path, self.BackImg:GetComponent("Image"))

	local cfgMallData = CfgMallTable[self.cfgPassRepurchaseGift.MallId]
	local name = CfgConditionTable[cfgMallData.ConditionId].Name

	UGUIUtil.SetText(self.TextCondition, name)

	self.rewardTab = {}

	local itemTab = {}

	for i = 1, #self.cfgPassRepurchaseGift.Reward, 2 do
		local ID = self.cfgPassRepurchaseGift.Reward[i]
		local Num = self.cfgPassRepurchaseGift.Reward[i + 1]

		if itemTab[ID] == nil then
			itemTab[ID] = Num
		else
			itemTab[ID] = itemTab[ID] + Num
		end
	end

	for i, v in pairs(itemTab) do
		local tab = {}

		tab.ID = i
		tab.Num = v

		table.insert(self.rewardTab, tab)
	end

	self.scrollList:Refresh(#self.rewardTab)
	self.passReplacementNum:SetNum(self.cfgPassRepurchaseGift.Id, 2)
end

function m:OnRenderGridCell(cell)
	local data = self.rewardTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardCellPool[instanceID]

	if renderCell == nil then
		renderCell = ReplacementPassRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)
end

function m:OnBtnBuy()
	MallModule.BuyMall(self.cfgPassRepurchaseGift.MallId, 1)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.passReplacementNum:Dispose()

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
