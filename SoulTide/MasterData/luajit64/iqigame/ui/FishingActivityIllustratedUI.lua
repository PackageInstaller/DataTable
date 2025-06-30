-- chunkname: @IQIGame\\UI\\FishingActivityIllustratedUI.lua

local FishingActivityIllustratedUI = {
	SelectQuality = 0,
	FishList = {},
	FishIllustratedCellPool = {}
}

FishingActivityIllustratedUI = Base:Extend("FishingActivityIllustratedUI", "IQIGame.Onigao.UI.FishingActivityIllustratedUI", FishingActivityIllustratedUI)

local FishingActivitySelectQualityView = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityIllustrated.FishingActivitySelectQualityView")
local FishingActivityIllustratedCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityIllustrated.FishingActivityIllustratedCell")

require("IQIGame.UIExternalApi.FishingActivityIllustratedUIApi")

function FishingActivityIllustratedUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateSelectQuality(isOn)
		self:OnSelectToggle(isOn)
	end

	function self.DelegateUpdateFishBook()
		self:OnUpdateFishBook()
	end

	self.SelectQualityView = FishingActivitySelectQualityView.New(self.Select, self)
	self.ScrollList = self.ScrollList:GetComponent("ScrollAreaList")

	function self.ScrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.ScrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function FishingActivityIllustratedUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivityIllustratedUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivityIllustratedUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivityIllustratedUI:GetBGM(userData)
	return nil
end

function FishingActivityIllustratedUI:OnOpen(userData)
	self.SelectQualityToggle:GetComponent("Toggle").isOn = false

	self.SelectQualityView:Close()
	self:SetSelectTog(0)
end

function FishingActivityIllustratedUI:OnClose(userData)
	return
end

function FishingActivityIllustratedUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.SelectQualityToggle:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateSelectQuality)
	EventDispatcher.AddEventListener(EventID.FishingActivityUpdateWeightEvent, self.DelegateUpdateFishBook)
end

function FishingActivityIllustratedUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.SelectQualityToggle:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateSelectQuality)
	EventDispatcher.RemoveEventListener(EventID.FishingActivityUpdateWeightEvent, self.DelegateUpdateFishBook)
end

function FishingActivityIllustratedUI:OnPause()
	return
end

function FishingActivityIllustratedUI:OnResume()
	return
end

function FishingActivityIllustratedUI:OnCover()
	return
end

function FishingActivityIllustratedUI:OnReveal()
	return
end

function FishingActivityIllustratedUI:OnRefocus(userData)
	return
end

function FishingActivityIllustratedUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FishingActivityIllustratedUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivityIllustratedUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivityIllustratedUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivityIllustratedUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.FishIllustratedCellPool) do
		v:Dispose()
	end

	self.SelectQualityView:Dispose()
end

function FishingActivityIllustratedUI:UpdateView()
	self.FishList = {}

	for i, v in pairs(FishingActivityModule.fishIllustratedDataList) do
		if self.SelectQuality > 0 then
			if v:GetCfgData().Quality == self.SelectQuality then
				table.insert(self.FishList, v)
			end
		else
			table.insert(self.FishList, v)
		end
	end

	table.sort(self.FishList, function(a, b)
		local unlockA = a.isUnlock and 1 or 0
		local unlockB = b.isUnlock and 1 or 0

		if unlockA == unlockB then
			return a:GetCfgData().Sort < b:GetCfgData().Sort
		end

		return unlockB < unlockA
	end)
	self.ScrollList:Refresh(#self.FishList)
	self:ShowSelectMsg()
end

function FishingActivityIllustratedUI:OnSelectedGridCell(cell)
	self.SelectFish = self.FishList[cell.index + 1]

	for i, v in pairs(self.FishIllustratedCellPool) do
		if v.View:GetInstanceID() == cell.gameObject:GetInstanceID() then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	self:ShowSelectMsg()
end

function FishingActivityIllustratedUI:OnRenderGridCell(cell)
	local data = self.FishList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.FishIllustratedCellPool[instanceID]

	if renderCell == nil then
		renderCell = FishingActivityIllustratedCell.New(cell.gameObject)
		self.FishIllustratedCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)

	if self.SelectFish ~= nil then
		if self.SelectFish.cid == data.cid then
			renderCell:SetSelect(true)
		else
			renderCell:SetSelect(false)
		end
	else
		self.SelectFish = data

		renderCell:SetSelect(true)
	end
end

function FishingActivityIllustratedUI:ShowSelectMsg()
	local isShow = self.SelectFish and self.SelectFish.isUnlock

	self.SelectFishNode:SetActive(isShow)
	self.LockNode:SetActive(not isShow)

	if self.SelectFish then
		UGUIUtil.SetText(self.TextSelectFish, self.SelectFish:GetCfgData().Name)
		UGUIUtil.SetText(self.TextSelectFishLock, self.SelectFish:GetCfgData().Name)
		UGUIUtil.SetText(self.TextWeight, FishingActivityIllustratedUIApi:GetString("WeightRange", self.SelectFish:GetCfgData().WeightRange[1], self.SelectFish:GetCfgData().WeightRange[2]))
		UGUIUtil.SetText(self.TextPrice, FishingActivityIllustratedUIApi:GetString("Price", self.SelectFish:GetCfgData().Price))
		UGUIUtil.SetText(self.TextArmStrength, FishingActivityIllustratedUIApi:GetString("ArmStrength", self.SelectFish:GetCfgData().Power))
		UGUIUtil.SetText(self.TextAttackSpeed, self.SelectFish:GetCfgData().AttackInterval / 1000)
		UGUIUtil.SetText(self.TextFishingPower, FishingActivityIllustratedUIApi:GetString("FishingPower", self.SelectFish:GetCfgData().NeedPower))
		UGUIUtil.SetText(self.TextCaptureTimes, self.SelectFish.captureTimes)
		UGUIUtil.SetText(self.TextMaxWeight, FishingActivityIllustratedUIApi:GetString("TextMaxWeight", self.SelectFish.maxWeight))
		UGUIUtil.SetText(self.TextSelectDes, self.SelectFish:GetCfgData().Desc)

		local path = CommonSlotUIApi:GetString("QualityBackgroundPath", self.SelectFish:GetCfgData().Quality)

		AssetUtil.LoadImage(self, path, self.ImgQualitySelectFish:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.SelectFish:GetCfgData().Icon), self.ImgSelectFish:GetComponent("Image"))
		self.ImgSelectFish:GetComponent("GrayComponent"):SetGray(not isShow)
	end
end

function FishingActivityIllustratedUI:OnSelectToggle(isOn)
	if isOn then
		self.SelectQualityView:Open()
	else
		self.SelectQualityView:Close()
	end
end

function FishingActivityIllustratedUI:SetSelectTog(num)
	if self.SelectQuality ~= num then
		self.SelectFish = nil
	end

	self.SelectQuality = num
	self.SelectQualityToggle:GetComponent("ToggleHelperComponent").text = FishingActivityIllustratedUIApi:GetString("SelectQualityLabel", num)

	self.SelectQualityView:Close()

	self.SelectQualityToggle:GetComponent("Toggle").isOn = false

	self:UpdateView()
end

function FishingActivityIllustratedUI:OnUpdateFishBook()
	self:UpdateView()
end

function FishingActivityIllustratedUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return FishingActivityIllustratedUI
