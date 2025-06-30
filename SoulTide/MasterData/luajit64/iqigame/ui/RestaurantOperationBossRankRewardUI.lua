-- chunkname: @IQIGame\\UI\\RestaurantOperationBossRankRewardUI.lua

local RestaurantOperationBossRankRewardUI = {
	rewardCellPool = {}
}

RestaurantOperationBossRankRewardUI = Base:Extend("RestaurantOperationBossRankRewardUI", "IQIGame.Onigao.UI.RestaurantOperationBossRankRewardUI", RestaurantOperationBossRankRewardUI)

require("IQIGame.UIExternalApi.RestaurantOperationBossRankRewardUIApi")

local ROBossRankRewardCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationBoss.ROBossRankRewardCell")

function RestaurantOperationBossRankRewardUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
end

function RestaurantOperationBossRankRewardUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationBossRankRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationBossRankRewardUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationBossRankRewardUI:GetBGM(userData)
	return nil
end

function RestaurantOperationBossRankRewardUI:OnOpen(userData)
	self.myRanking = userData.MyRanking
	self.rankType = userData.RankType

	self:UpdateView()
end

function RestaurantOperationBossRankRewardUI:OnClose(userData)
	return
end

function RestaurantOperationBossRankRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function RestaurantOperationBossRankRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function RestaurantOperationBossRankRewardUI:OnPause()
	return
end

function RestaurantOperationBossRankRewardUI:OnResume()
	return
end

function RestaurantOperationBossRankRewardUI:OnCover()
	return
end

function RestaurantOperationBossRankRewardUI:OnReveal()
	return
end

function RestaurantOperationBossRankRewardUI:OnRefocus(userData)
	return
end

function RestaurantOperationBossRankRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationBossRankRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationBossRankRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationBossRankRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationBossRankRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function RestaurantOperationBossRankRewardUI:UpdateView()
	self.bossRankRewardData = {}
	self.cfgMyRank = nil

	for i, v in pairs(RestaurantOperationModule.ROBossRankData) do
		table.insert(self.bossRankRewardData, v)

		if self.rankType == v.RankType and self.cfgMyRank == nil and self.myRanking >= v.RankLowerLimit and self.myRanking <= v.RankUpperLimit then
			self.cfgMyRank = v
		end
	end

	table.sort(self.bossRankRewardData, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.bossRankRewardData)

	local isNoRank = self.cfgMyRank == nil

	self.TextNoRank:SetActive(isNoRank)
	self.Numb:SetActive(not isNoRank)
	self.RewardGrid:SetActive(not isNoRank)
	self.ImgRank:SetActive(false)

	if not isNoRank then
		local isShowImgNum = false

		for i = 1, 3 do
			local numTransform = self.Num123.transform:Find("Image_" .. i)

			if numTransform then
				numTransform.gameObject:SetActive(i == self.myRanking and self.rankType == 1)
			end

			if isShowImgNum == false then
				isShowImgNum = i == self.myRanking
			end
		end

		if self.rankType == 2 then
			self.ImgRank:SetActive(self.myRanking > 0)
		else
			self.ImgRank:SetActive(self.myRanking > 3)
		end

		UGUIUtil.SetText(self.TextRank, RestaurantOperationBossRankRewardUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = RestaurantOperationBossRankRewardUIApi:GetString("MazeBossRankIconPath", self.myRanking, true, self.rankType)

			AssetUtil.LoadImage(self, path, self.ImgRank:GetComponent("Image"))
		end

		self.RewardMould:SetActive(false)

		for i = 1, self.RewardGrid.transform.childCount - 1 do
			local obj = self.RewardGrid.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		for i = 1, #self.cfgMyRank.Reward, 2 do
			local itemId = self.cfgMyRank.Reward[i]
			local itemNum = self.cfgMyRank.Reward[i + 1]
			local itemObj = UnityEngine.Object.Instantiate(self.RewardMould)

			itemObj.transform:SetParent(self.RewardGrid.transform, false)
			itemObj:SetActive(true)

			local itemCell = ItemCell.PackageOrReuseView(self, itemObj.transform:GetChild(0).gameObject)

			itemCell:SetItem(CfgItemTable[itemId])

			if itemNum > 0 then
				itemCell:SetNum(itemNum)
			else
				itemCell:SetNum("")
			end
		end
	end
end

function RestaurantOperationBossRankRewardUI:OnRenderGridCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = ROBossRankRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	local cfgReward = self.bossRankRewardData[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

function RestaurantOperationBossRankRewardUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

return RestaurantOperationBossRankRewardUI
