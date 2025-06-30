-- chunkname: @IQIGame\\UI\\FishingActivityAutoUI.lua

local FishingActivityAutoUI = {
	FishAutoRewardCellPool = {}
}

FishingActivityAutoUI = Base:Extend("FishingActivityAutoUI", "IQIGame.Onigao.UI.FishingActivityAutoUI", FishingActivityAutoUI)

local FishingActivityAutoRewardCell = require("IQIGame.UI.ExploreHall.FishingActivity.FishingActivityAuto.FishingActivityAutoRewardCell")

function FishingActivityAutoUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.ScrollList:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
end

function FishingActivityAutoUI:GetPreloadAssetPaths()
	return nil
end

function FishingActivityAutoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FishingActivityAutoUI:IsManualShowOnOpen(userData)
	return false
end

function FishingActivityAutoUI:GetBGM(userData)
	return nil
end

function FishingActivityAutoUI:OnOpen(userData)
	self.Fishes = userData

	self:UpdateView()
end

function FishingActivityAutoUI:OnClose(userData)
	return
end

function FishingActivityAutoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function FishingActivityAutoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function FishingActivityAutoUI:OnPause()
	return
end

function FishingActivityAutoUI:OnResume()
	return
end

function FishingActivityAutoUI:OnCover()
	return
end

function FishingActivityAutoUI:OnReveal()
	return
end

function FishingActivityAutoUI:OnRefocus(userData)
	return
end

function FishingActivityAutoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FishingActivityAutoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FishingActivityAutoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FishingActivityAutoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FishingActivityAutoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.FishAutoRewardCellPool) do
		v:Dispose()
	end
end

function FishingActivityAutoUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function FishingActivityAutoUI:UpdateView()
	local rewardNum = 0

	for i, v in pairs(self.Fishes) do
		rewardNum = rewardNum + math.floor(CfgFishActiveFishListTable[v.fishId].Price * v.weight / 1000)
	end

	self.ScrollList:GetComponent("ScrollAreaList"):Refresh(#self.Fishes)
	UGUIUtil.SetText(self.TextMoneyNum, rewardNum)

	local cfgControlData = CfgFishActiveControlTable[FishingActivityModule.globalCid]
	local iconPath = ExploreHallUIApi:GetString("FishingActivityMoneyIcon", cfgControlData.MoneyId)

	AssetUtil.LoadImage(self, iconPath, self.ImgMoneyIcon:GetComponent("Image"))
end

function FishingActivityAutoUI:OnRenderGridCell(cell)
	local fishData = self.Fishes[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.FishAutoRewardCellPool[instanceID]

	if renderCell == nil then
		renderCell = FishingActivityAutoRewardCell.New(cell.gameObject)
		self.FishAutoRewardCellPool[instanceID] = renderCell
	end

	renderCell:SetData(fishData)
end

return FishingActivityAutoUI
