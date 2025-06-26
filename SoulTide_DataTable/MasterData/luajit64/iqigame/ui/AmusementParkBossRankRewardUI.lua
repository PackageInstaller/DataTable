-- chunkname: @IQIGame\\UI\\AmusementParkBossRankRewardUI.lua

local AmusementParkBossRankRewardUI = {
	rewardCellPool = {}
}

AmusementParkBossRankRewardUI = Base:Extend("AmusementParkBossRankRewardUI", "IQIGame.Onigao.UI.AmusementParkBossRankRewardUI", AmusementParkBossRankRewardUI)

require("IQIGame.UIExternalApi.AmusementParkBossRankRewardUIApi")

local AmusementParkBossRankRewardCell = require("IQIGame.UI.ExploreHall.AmusementPark.AmusementParkBoss.AmusementParkBossRankRewardCell")

function AmusementParkBossRankRewardUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
end

function AmusementParkBossRankRewardUI:GetPreloadAssetPaths()
	return nil
end

function AmusementParkBossRankRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AmusementParkBossRankRewardUI:IsManualShowOnOpen(userData)
	return false
end

function AmusementParkBossRankRewardUI:GetBGM(userData)
	return nil
end

function AmusementParkBossRankRewardUI:OnOpen(userData)
	self.myRanking = userData.MyRanking
	self.rankType = userData.RankType

	self:UpdateView()
end

function AmusementParkBossRankRewardUI:OnClose(userData)
	return
end

function AmusementParkBossRankRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function AmusementParkBossRankRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function AmusementParkBossRankRewardUI:OnPause()
	return
end

function AmusementParkBossRankRewardUI:OnResume()
	return
end

function AmusementParkBossRankRewardUI:OnCover()
	return
end

function AmusementParkBossRankRewardUI:OnReveal()
	return
end

function AmusementParkBossRankRewardUI:OnRefocus(userData)
	return
end

function AmusementParkBossRankRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AmusementParkBossRankRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AmusementParkBossRankRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AmusementParkBossRankRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AmusementParkBossRankRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function AmusementParkBossRankRewardUI:UpdateView()
	self.bossRankRewardData = {}
	self.cfgMyRank = nil

	for i, v in pairs(AmusementParkModule.AmusementParkBossRankData) do
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

		UGUIUtil.SetText(self.TextRank, AmusementParkBossRankRewardUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = AmusementParkBossRankRewardUIApi:GetString("MazeBossRankIconPath", self.myRanking, true, self.rankType)

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

function AmusementParkBossRankRewardUI:OnRenderGridCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = AmusementParkBossRankRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	local cfgReward = self.bossRankRewardData[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

function AmusementParkBossRankRewardUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

return AmusementParkBossRankRewardUI
