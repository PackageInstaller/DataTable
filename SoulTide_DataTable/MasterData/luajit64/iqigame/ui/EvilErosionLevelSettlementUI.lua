-- chunkname: @IQIGame\\UI\\EvilErosionLevelSettlementUI.lua

require("IQIGame.UIExternalApi.EvilErosionLevelSettlementUIApi")

local EvilErosionSettlementRewardCell = require("IQIGame.UI.EvilErosion.EvilErosionSettlementRewardCell")
local EvilErosionLevelSettlementUI = {
	LevelRewardCells = {},
	RatingRewardCells = {}
}

EvilErosionLevelSettlementUI = Base:Extend("EvilErosionLevelSettlementUI", "IQIGame.Onigao.UI.EvilErosionLevelSettlementUI", EvilErosionLevelSettlementUI)

function EvilErosionLevelSettlementUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	for i = 1, 5 do
		local cell = EvilErosionSettlementRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		cell.View.transform:SetParent(self.RewardGrid1.transform, false)

		self.LevelRewardCells[i] = cell
	end

	for i = 1, 5 do
		local cell = EvilErosionSettlementRewardCell.New(UnityEngine.Object.Instantiate(self.RewardPrefab))

		cell.View.transform:SetParent(self.RewardGrid2.transform, false)

		self.RatingRewardCells[i] = cell
	end

	UGUIUtil.SetTextInChildren(self.CloseBtn, EvilErosionLevelSettlementUIApi:GetString("CloseBtnText"))
	UGUIUtil.SetText(self.RatingLabel, EvilErosionLevelSettlementUIApi:GetString("RatingLabel"))
	UGUIUtil.SetText(self.NormalPassTimeLabel, EvilErosionLevelSettlementUIApi:GetString("NormalPassTimeLabel"))
	UGUIUtil.SetText(self.RewardLabel1, EvilErosionLevelSettlementUIApi:GetString("RewardLabel1"))
	UGUIUtil.SetText(self.RewardLabel2, EvilErosionLevelSettlementUIApi:GetString("RewardLabel2"))
end

function EvilErosionLevelSettlementUI:GetPreloadAssetPaths()
	return nil
end

function EvilErosionLevelSettlementUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EvilErosionLevelSettlementUI:IsManualShowOnOpen(userData)
	return false
end

function EvilErosionLevelSettlementUI:GetBGM(userData)
	return nil
end

function EvilErosionLevelSettlementUI:OnOpen(userData)
	self:UpdateView(userData.levelCid, userData.isWin, userData.getItems, userData.rating, userData.ratingTime)
end

function EvilErosionLevelSettlementUI:OnClose(userData)
	return
end

function EvilErosionLevelSettlementUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EvilErosionLevelSettlementUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EvilErosionLevelSettlementUI:OnPause()
	return
end

function EvilErosionLevelSettlementUI:OnResume()
	return
end

function EvilErosionLevelSettlementUI:OnCover()
	return
end

function EvilErosionLevelSettlementUI:OnReveal()
	return
end

function EvilErosionLevelSettlementUI:OnRefocus(userData)
	return
end

function EvilErosionLevelSettlementUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EvilErosionLevelSettlementUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EvilErosionLevelSettlementUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EvilErosionLevelSettlementUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EvilErosionLevelSettlementUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i = 1, #self.LevelRewardCells do
		local cell = self.LevelRewardCells[i]

		cell:Dispose()
	end

	for i = 1, #self.RatingRewardCells do
		local cell = self.RatingRewardCells[i]

		cell:Dispose()
	end
end

function EvilErosionLevelSettlementUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EvilErosionLevelSettlementUI:UpdateView(levelCid, isWin, getItems, rating, ratingTime)
	self.SuccessView:SetActive(isWin)
	self.FailView:SetActive(not isWin)

	local cfgEvilErosionLevelData = CfgEvilErosionLevelTable[levelCid]

	UGUIUtil.SetText(self.LevelNameText, EvilErosionLevelSettlementUIApi:GetString("LevelNameText", cfgEvilErosionLevelData.Name, isWin))
	UGUIUtil.SetText(self.PassLabel, EvilErosionLevelSettlementUIApi:GetString("PassLabel", isWin))

	if isWin then
		local isFirstPass = ratingTime == 0

		self.FirstPassView:SetActive(isFirstPass)
		self.NormalPassView:SetActive(not isFirstPass)

		if isFirstPass then
			UGUIUtil.SetText(self.FirstPassText, EvilErosionLevelSettlementUIApi:GetString("FirstPassText"))
		else
			local elapsedTimeStr = getTimeDurationText(ratingTime, 3)

			UGUIUtil.SetText(self.NormalPasTimeText, EvilErosionLevelSettlementUIApi:GetString("NormalPasTimeText", elapsedTimeStr))
		end

		AssetUtil.LoadImage(self, EvilErosionLevelSettlementUIApi:GetString("RatingImage", rating, isFirstPass), self.RatingImage:GetComponent("Image"))
		GameEntry.Effect:PlayUIMountPointEffect(EvilErosionLevelSettlementUIApi:GetString("RatingEffect", rating, isFirstPass), 50000, 0, self.RatingEffectPoint, self.UIController:GetComponent("Canvas").sortingOrder + 1)

		local levelRewards = {}
		local ratingRewards = {}

		for i = 1, #getItems do
			local itemShowPOD = getItems[i]

			if itemShowPOD.tag == 2 then
				table.insert(ratingRewards, itemShowPOD)
			else
				table.insert(levelRewards, itemShowPOD)
			end
		end

		for i = 1, #self.LevelRewardCells do
			local cell = self.LevelRewardCells[i]
			local itemShowPOD = levelRewards[i]
			local itemCid = itemShowPOD ~= nil and itemShowPOD.cid or 0
			local itemNum = itemShowPOD ~= nil and itemShowPOD.num or 0

			cell:SetData(itemCid, itemNum)
		end

		for i = 1, #self.RatingRewardCells do
			local cell = self.RatingRewardCells[i]
			local itemShowPOD = ratingRewards[i]
			local itemCid = itemShowPOD ~= nil and itemShowPOD.cid or 0
			local itemNum = itemShowPOD ~= nil and itemShowPOD.num or 0

			cell:SetData(itemCid, itemNum)
		end
	end
end

return EvilErosionLevelSettlementUI
