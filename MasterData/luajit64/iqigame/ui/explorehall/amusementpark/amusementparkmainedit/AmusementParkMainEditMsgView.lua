-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMainEdit\\AmusementParkMainEditMsgView.lua

local m = {
	isOpen = true,
	amusementParkMainAssetCells = {},
	amusementParkMainIncomeCells = {},
	recordAttrData = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local AmusementParkMainEditAssetCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainEdit.AmusementParkMainEditAssetCell")
local AmusementParkMainEditIncomeCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMainEdit.AmusementParkMainEditIncomeCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnHideUI()
		self:OnBtnHideUI()
	end

	function self.DelegateBtnNarrow()
		self:OnBtnNarrow()
	end

	function self.DelegateBtnEnlarge()
		self:OnBtnEnlarge()
	end

	self.panelTween = self.View:GetComponent("TweenPosition")

	function self.DelegateBtnShow()
		self:OnBtnShow()
	end

	function self.DelegateBtnHide()
		self:OnBtnHide()
	end

	self.AssetMould:SetActive(false)

	self.amusementParkMainAssetCellPool = UIObjectPool.New(20, function()
		local assetCell = AmusementParkMainEditAssetCell.New(UnityEngine.Object.Instantiate(self.AssetMould))

		return assetCell
	end, function(cell)
		cell:Dispose()
	end)

	self.IncomeMould:SetActive(false)

	self.amusementParkMainIncomeCellPool = UIObjectPool.New(30, function()
		local incomeCell = AmusementParkMainEditIncomeCell.New(UnityEngine.Object.Instantiate(self.IncomeMould))

		return incomeCell
	end, function(cell)
		cell:Dispose()
	end)

	self:ShowBtnState()
	self:AddListener()
end

function m:AddListener()
	self.BtnHideUI:GetComponent("Button").onClick:AddListener(self.DelegateBtnHideUI)
	self.BtnNarrow:GetComponent("Button").onClick:AddListener(self.DelegateBtnNarrow)
	self.BtnEnlarge:GetComponent("Button").onClick:AddListener(self.DelegateBtnEnlarge)
	self.BtnShow:GetComponent("Button").onClick:AddListener(self.DelegateBtnShow)
	self.BtnHide:GetComponent("Button").onClick:AddListener(self.DelegateBtnHide)
end

function m:RemoveListener()
	self.BtnHideUI:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHideUI)
	self.BtnNarrow:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnNarrow)
	self.BtnEnlarge:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEnlarge)
	self.BtnShow:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnShow)
	self.BtnHide:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHide)
end

function m:RecordData()
	self.recordAttrData = AmusementParkModule.AmusementParkInfoPOD.amusementParkAttPOD.attr
end

function m:OnBtnHideUI()
	if self.hideUICallBack then
		self.hideUICallBack()
	end
end

function m:OnBtnNarrow()
	AmusementParkModule.AmusementParkScene.CameraCtrl:ChangeCameraSize(2)
end

function m:OnBtnEnlarge()
	AmusementParkModule.AmusementParkScene.CameraCtrl:ChangeCameraSize(1)
end

function m:UpdateView()
	self:RefreshAsset()
	self:RefreshIncome()
end

function m:RefreshAsset()
	for i, v in pairs(self.amusementParkMainAssetCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.amusementParkMainAssetCellPool:Release(v)
	end

	self.amusementParkMainAssetCells = {}

	local render = self.amusementParkMainAssetCellPool:Obtain()

	render.View:SetActive(true)
	render.View.transform:SetParent(self.AssetSort.transform, false)
	render:SetData(AmusementParkConstant.ParkAttr.ParkAttr_Level, AmusementParkModule.AmusementParkInfoPOD.amusementParkAttPOD.level, nil)
	table.insert(self.amusementParkMainAssetCells, render)

	local render = self.amusementParkMainAssetCellPool:Obtain()

	render.View:SetActive(true)
	render.View.transform:SetParent(self.AssetSort.transform, false)
	render:SetData(AmusementParkConstant.ParkAttr.ParkAttr_PlayerNum, #AmusementParkModule.AmusementParkInfoPOD.amusementParkVoRolesHave or 0, nil)
	table.insert(self.amusementParkMainAssetCells, render)
end

function m:RefreshIncome()
	if not self.View.activeInHierarchy then
		return
	end

	for i, v in pairs(self.amusementParkMainIncomeCells) do
		self.amusementParkMainIncomeCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
	end

	self.amusementParkMainIncomeCells = {}

	local tab = AmusementParkModule.GetRankParkAttr()

	for i = 1, #tab do
		local attrData = tab[i]
		local recordValue = self.recordAttrData[attrData.attrID] or 0
		local render = self.amusementParkMainIncomeCellPool:Obtain()

		render.View:SetActive(true)
		render.View.transform:SetParent(self.IncomeSort.transform, false)
		render:SetData(attrData.attrID, attrData.attrValue, recordValue)
		table.insert(self.amusementParkMainIncomeCells, render)
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

	self.hideUICallBack = nil

	self:RemoveListener()

	for i, v in pairs(self.amusementParkMainAssetCells) do
		self.amusementParkMainAssetCellPool:Release(v)
	end

	self.amusementParkMainAssetCells = {}

	self.amusementParkMainAssetCellPool:Dispose()

	for i, v in pairs(self.amusementParkMainIncomeCells) do
		self.amusementParkMainIncomeCellPool:Release(v)
	end

	self.amusementParkMainIncomeCells = {}

	self.amusementParkMainIncomeCellPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
