-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkMain\\AmusementParkMainMsgView.lua

local m = {
	isOpen = true,
	amusementParkMainAssetCells = {},
	amusementParkMainIncomeCells = {}
}
local AmusementParkMainAssetCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMain.AmusementParkMainAssetCell")
local AmusementParkMainIncomeCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkMain.AmusementParkMainIncomeCell")

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

	self.amusementParkMainAssetCells = {}

	local ParkAttr = {
		AmusementParkConstant.ParkAttr.ParkAttr_Level,
		AmusementParkConstant.ParkAttr.ParkAttr_PlayerNum
	}

	for i = 1, #ParkAttr do
		local cid = ParkAttr[i]
		local render = AmusementParkMainAssetCell.New(UnityEngine.Object.Instantiate(self.AssetMould))

		render.View:SetActive(true)
		render.View.transform:SetParent(self.AssetSort.transform, false)
		render:SetData(cid)

		self.amusementParkMainAssetCells[cid] = render
	end

	self.IncomeMould:SetActive(false)

	self.amusementParkMainIncomeCells = {}

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
		v:Refresh()
	end
end

function m:RefreshIncome()
	local tab = AmusementParkModule.GetRankParkAttr()

	for i = 1, #tab do
		local attrData = tab[i]
		local render = self.amusementParkMainIncomeCells[i]

		if render == nil then
			render = AmusementParkMainIncomeCell.New(UnityEngine.Object.Instantiate(self.IncomeMould))
			self.amusementParkMainIncomeCells[i] = render
		end

		render.View:SetActive(true)
		render.View.transform:SetParent(self.IncomeSort.transform, false)
		render:SetData(attrData.attrID, attrData.attrValue)
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
		v:Dispose()
	end

	for i, v in pairs(self.amusementParkMainIncomeCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
