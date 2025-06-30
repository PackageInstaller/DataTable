-- chunkname: @IQIGame\\UI\\FlightGameSettlementUI.lua

local FlightGameSettlementUI = {
	totalNum = 0,
	rewardCellPool = {}
}

FlightGameSettlementUI = Base:Extend("FlightGameSettlementUI", "IQIGame.Onigao.UI.FlightGameSettlementUI", FlightGameSettlementUI)

local FlightGameSettlementRewardCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameSettlement.FlightGameSettlementRewardCell")

require("IQIGame.UIExternalApi.FlightGameSettlementUIApi")

function FlightGameSettlementUI:OnInit()
	function self.DelegateOnClickBtnCancel()
		self:OnClickBtnCancel()
	end

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
end

function FlightGameSettlementUI:GetPreloadAssetPaths()
	return nil
end

function FlightGameSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FlightGameSettlementUI:IsManualShowOnOpen(userData)
	return false
end

function FlightGameSettlementUI:GetBGM(userData)
	return nil
end

function FlightGameSettlementUI:OnOpen(userData)
	self.distance = userData.Distance
	self.rewards = userData.Reward
	self.flightPoints = userData.FlightPoints

	self:UpdateView()
end

function FlightGameSettlementUI:OnClose(userData)
	return
end

function FlightGameSettlementUI:OnAddListeners()
	self.BtnCancel:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnCancel)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function FlightGameSettlementUI:OnRemoveListeners()
	self.BtnCancel:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnCancel)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function FlightGameSettlementUI:OnPause()
	return
end

function FlightGameSettlementUI:OnResume()
	return
end

function FlightGameSettlementUI:OnCover()
	return
end

function FlightGameSettlementUI:OnReveal()
	return
end

function FlightGameSettlementUI:OnRefocus(userData)
	return
end

function FlightGameSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FlightGameSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FlightGameSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FlightGameSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FlightGameSettlementUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function FlightGameSettlementUI:UpdateView()
	UGUIUtil.SetText(self.TextDistance, FlightGameModule.flightDistance)
	UGUIUtil.SetText(self.TextFlightPoint, FlightGameModule.GetFlightPoints())

	if FlightGameModule.gamePlayerData then
		local path = UIGlobalApi.GetImagePath(FlightGameModule.gamePlayerData:GetConfigData().EndImage)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	end

	self.totalNum = 0

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.rewards)
	UGUIUtil.SetText(self.TextTotalNum, FlightGameSettlementUIApi:GetString("TextTotalNum", self.totalNum))
end

function FlightGameSettlementUI:OnRenderGridCell(cell)
	local data = self.rewards[cell.index + 1]

	if data == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rewardCellPool[instanceID]

	if renderCell == nil then
		renderCell = FlightGameSettlementRewardCell.New(cell.gameObject, self.root)
		self.rewardCellPool[instanceID] = renderCell
	end

	renderCell:SetData(data)

	self.totalNum = self.totalNum + data.num
end

function FlightGameSettlementUI:OnClickBtnCancel()
	self:QuitGame()
end

function FlightGameSettlementUI:OnClickBtnClose()
	self:QuitGame()
end

function FlightGameSettlementUI:QuitGame()
	UIModule.CloseSelf(self)
	FlightGameModule.ExitFlightGame()
end

return FlightGameSettlementUI
