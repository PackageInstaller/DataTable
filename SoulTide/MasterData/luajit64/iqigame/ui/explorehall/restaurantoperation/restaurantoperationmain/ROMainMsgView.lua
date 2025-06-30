-- chunkname: @IQIGame\\UI\\ExploreHall\\RestaurantOperation\\RestaurantOperationMain\\ROMainMsgView.lua

local m = {
	isOpen = true,
	roMainAssetCells = {},
	roMainIncomeCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local ROMainAssetCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationMain.ROMainAssetCell")
local ROMainIncomeCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationMain.ROMainIncomeCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.panelTween = self.View:GetComponent("TweenPosition")

	function self.DelegateBtnShow()
		self:OnBtnShow()
	end

	function self.DelegateBtnHide()
		self:OnBtnHide()
	end

	self.AssetMould:SetActive(false)

	self.roMainAssetCellPool = UIObjectPool.New(20, function()
		local assetCell = ROMainAssetCell.New(UnityEngine.Object.Instantiate(self.AssetMould))

		return assetCell
	end, function(cell)
		cell:Dispose()
	end)

	self.IncomeMould:SetActive(false)

	self.roMainIncomeCellPool = UIObjectPool.New(30, function()
		local incomeCell = ROMainIncomeCell.New(UnityEngine.Object.Instantiate(self.IncomeMould))

		return incomeCell
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
	self:ShowBtnState()
end

function m:AddListener()
	self.BtnShow:GetComponent("Button").onClick:AddListener(self.DelegateBtnShow)
	self.BtnHide:GetComponent("Button").onClick:AddListener(self.DelegateBtnHide)
end

function m:RemoveListener()
	self.BtnShow:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnShow)
	self.BtnHide:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHide)
end

function m:UpdateView()
	self:RefreshAsset()
	self:RefreshIncome()
end

function m:RefreshAsset()
	for i, v in pairs(self.roMainAssetCells) do
		self.roMainAssetCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.roMainAssetCells = {}

	local render = self.roMainAssetCellPool:Obtain()

	render.View:SetActive(true)
	render.View.transform:SetParent(self.AssetSort.transform, false)
	render:SetData(-1, RestaurantOperationMainUIApi:GetString("TextLv"), RestaurantOperationModule.ROAttributePOD.level, nil)
	table.insert(self.roMainAssetCells, render)

	local moneyIncome = RestaurantOperationModule.moneyIncome

	for i = 1, #moneyIncome do
		local cfgData = moneyIncome[i]
		local num = WarehouseModule.GetItemNumByCfgID(cfgData.IncomeItem)
		local render = self.roMainAssetCellPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.AssetSort.transform, false)
		render:SetData(cfgData.IncomeItem, CfgItemTable[cfgData.IncomeItem].Name, num, cfgData.ImageIcon)
		table.insert(self.roMainAssetCells, render)
	end
end

function m:RefreshIncome()
	if not self.View.activeInHierarchy then
		return
	end

	for i, v in pairs(self.roMainIncomeCells) do
		self.roMainIncomeCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.roMainIncomeCells = {}

	local tab = RestaurantOperationModule.ROAttributePOD.income

	for i, v in pairs(tab) do
		local render = self.roMainIncomeCellPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.IncomeSort.transform, false)
		render:SetData(i, v)
		table.insert(self.roMainIncomeCells, render)
	end
end

function m:OnBtnShow()
	self.panelTween.enabled = true

	self.panelTween:PlayReverse()
	self.panelTween:SetOnFinished(function()
		self.isOpen = true

		self:ShowBtnState()
	end)
end

function m:OnBtnHide()
	self.panelTween.enabled = true

	self.panelTween:PlayForward()
	self.panelTween:SetOnFinished(function()
		self.isOpen = false

		self:ShowBtnState()
	end)
end

function m:ShowBtnState()
	self.BtnShow:SetActive(not self.isOpen)
	self.BtnHide:SetActive(self.isOpen)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.roMainAssetCells) do
		self.roMainAssetCellPool:Release(v)
	end

	self.roMainAssetCells = {}

	self.roMainAssetCellPool:Dispose()

	for i, v in pairs(self.roMainIncomeCells) do
		self.roMainIncomeCellPool:Release(v)
	end

	self.roMainIncomeCells = {}

	self.roMainIncomeCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
