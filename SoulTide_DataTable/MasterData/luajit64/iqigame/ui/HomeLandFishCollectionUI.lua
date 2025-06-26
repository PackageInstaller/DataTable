-- chunkname: @IQIGame\\UI\\HomeLandFishCollectionUI.lua

local HomeLandFishCollectionUI = {
	selectQuality = 0,
	fishList = {},
	fishCollectionCellPool = {}
}

HomeLandFishCollectionUI = Base:Extend("HomeLandFishCollectionUI", "IQIGame.Onigao.UI.HomeLandFishCollectionUI", HomeLandFishCollectionUI)

local FishCollectionCell = require("IQIGame.UI.Fishing.FishCollectionCell")
local FishCollectionSelectQualityView = require("IQIGame.UI.Fishing.FishCollectionSelectQualityView")

function HomeLandFishCollectionUI:OnInit()
	UGUIUtil.SetText(self.TitleText, HomeLandFishCollectionUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.LockNameText, HomeLandFishCollectionUIApi:GetString("LockNameText"))
	UGUIUtil.SetText(self.LockInfoPanelTitle, HomeLandFishCollectionUIApi:GetString("LockInfoPanelTitle"))
	UGUIUtil.SetText(self.LockDescText, HomeLandFishCollectionUIApi:GetString("LockDescText"))
	UGUIUtil.SetText(self.InfoPanelTitle, HomeLandFishCollectionUIApi:GetString("InfoPanelTitle"))
	UGUIUtil.SetText(self.DescText, HomeLandFishCollectionUIApi:GetString("DescText"))

	self.selectQualityView = FishCollectionSelectQualityView.New(self.SelectQualityNode, self)
	self.scrollList = self.ElementGrid:GetComponent("ScrollAreaList")

	function self.scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function self.scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateSelectQuality(isOn)
		self:OnSelectToggle(isOn)
	end
end

function HomeLandFishCollectionUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandFishCollectionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandFishCollectionUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandFishCollectionUI:GetBGM(userData)
	return nil
end

function HomeLandFishCollectionUI:OnOpen(userData)
	self.SelectQuality:GetComponent("Toggle").isOn = false

	self.selectQualityView:Close()
	self:SetSelectTog(0)
end

function HomeLandFishCollectionUI:OnClose(userData)
	return
end

function HomeLandFishCollectionUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.SelectQuality:GetComponent("Toggle").onValueChanged:AddListener(self.delegateSelectQuality)
end

function HomeLandFishCollectionUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.SelectQuality:GetComponent("Toggle").onValueChanged:RemoveListener(self.delegateSelectQuality)
end

function HomeLandFishCollectionUI:OnPause()
	return
end

function HomeLandFishCollectionUI:OnResume()
	return
end

function HomeLandFishCollectionUI:OnCover()
	return
end

function HomeLandFishCollectionUI:OnReveal()
	return
end

function HomeLandFishCollectionUI:OnRefocus(userData)
	return
end

function HomeLandFishCollectionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandFishCollectionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandFishCollectionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandFishCollectionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandFishCollectionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.fishCollectionCellPool) do
		v:Dispose()
	end

	self.selectQualityView:Dispose()
end

function HomeLandFishCollectionUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandFishCollectionUI)
end

function HomeLandFishCollectionUI:UpdateView()
	self.fishList = {}

	for i, v in pairsCfg(CfgFishListTable) do
		if self.selectQuality > 0 then
			if v.Quality == self.selectQuality then
				table.insert(self.fishList, v)
			end
		else
			table.insert(self.fishList, v)
		end
	end

	table.sort(self.fishList, function(a, b)
		return a.Sort < b.Sort
	end)
	self.scrollList:Refresh(#self.fishList)

	local openNum = 0

	for i, v in pairs(self.fishList) do
		if FishingModule.specimenData[v.Id] ~= nil then
			openNum = openNum + 1
		end
	end

	UGUIUtil.SetText(self.UnlockNum, HomeLandFishCollectionUIApi:GetString("UnlockNum", openNum, #self.fishList))
	self:ShowSelectMsg()
end

function HomeLandFishCollectionUI:OnSelectedGridCell(cell)
	self.selectFish = self.fishList[cell.index + 1]

	for i, v in pairs(self.fishCollectionCellPool) do
		if v.View:GetInstanceID() == cell.gameObject:GetInstanceID() then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	self:ShowSelectMsg()
end

function HomeLandFishCollectionUI:OnRenderGridCell(cell)
	local data = self.fishList[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.fishCollectionCellPool[instanceID]

	if renderCell == nil then
		renderCell = FishCollectionCell.New(cell.gameObject)
		self.fishCollectionCellPool[instanceID] = renderCell
	end

	local unlock = FishingModule.specimenData[data.Id] ~= nil

	renderCell:SetData(data, unlock)

	if self.selectFish ~= nil then
		if self.selectFish.Id == data.Id then
			renderCell:SetSelect(true)
		else
			renderCell:SetSelect(false)
		end
	else
		self.selectFish = data

		renderCell:SetSelect(true)
	end
end

function HomeLandFishCollectionUI:ShowSelectMsg()
	if self.selectFish then
		local isUnlock = FishingModule.specimenData[self.selectFish.Id] ~= nil

		self.Lock:SetActive(not isUnlock)
		self.Normal:SetActive(isUnlock)

		local cfgItemData = CfgItemTable[self.selectFish.ItemID]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.NormalPoint:GetComponent("Image"))
		UGUIUtil.SetText(self.NameText, cfgItemData.Name)
		UGUIUtil.SetText(self.InfoPanelTitle, self.selectFish.Desc)

		local attributeTab = {}

		for i = 1, #self.selectFish.AtlasAttributeType do
			local type = self.selectFish.AtlasAttributeType[i]
			local value = self.selectFish.AtlasAttributeNum[i]

			attributeTab[type] = value
		end

		UGUIUtil.SetText(self.AttributeDesc, HomeLandFishCollectionUIApi:GetString("AttributeDesc", attributeTab))

		local count = FishingModule.specimenData[self.selectFish.Id]

		if count == nil then
			count = 0
		end

		UGUIUtil.SetText(self.GetCount, HomeLandFishCollectionUIApi:GetString("GetCount", count))
	end
end

function HomeLandFishCollectionUI:OnSelectToggle(isOn)
	if isOn then
		self.selectQualityView:Open()
	else
		self.selectQualityView:Close()
	end
end

function HomeLandFishCollectionUI:SetSelectTog(num)
	if self.selectQuality ~= num then
		self.selectFish = nil
	end

	self.selectQuality = num
	self.SelectQuality:GetComponent("ToggleHelperComponent").text = HomeLandFishCollectionUIApi:GetString("SelectQualityLabel", num)

	self.selectQualityView:Close()

	self.SelectQuality:GetComponent("Toggle").isOn = false

	self:UpdateView()
end

return HomeLandFishCollectionUI
