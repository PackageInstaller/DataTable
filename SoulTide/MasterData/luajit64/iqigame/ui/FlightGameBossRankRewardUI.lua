-- chunkname: @IQIGame\\UI\\FlightGameBossRankRewardUI.lua

local FlightGameBossRankRewardUI = {
	rewardCellPool = {}
}

FlightGameBossRankRewardUI = Base:Extend("FlightGameBossRankRewardUI", "IQIGame.Onigao.UI.FlightGameBossRankRewardUI", FlightGameBossRankRewardUI)

require("IQIGame.UIExternalApi.FlightGameBossRankRewardUIApi")

local FlightGameBossRankRewardCell = require("IQIGame.UI.ExploreHall.FlightChallenge.FlightGameBossRankRewardCell")

function FlightGameBossRankRewardUI:OnInit()
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

function FlightGameBossRankRewardUI:GetPreloadAssetPaths()
	return nil
end

function FlightGameBossRankRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FlightGameBossRankRewardUI:IsManualShowOnOpen(userData)
	return false
end

function FlightGameBossRankRewardUI:GetBGM(userData)
	return nil
end

function FlightGameBossRankRewardUI:OnOpen(userData)
	self.myRanking = userData[1]
	self.rankType = userData[2]

	self:UpdateView()
end

function FlightGameBossRankRewardUI:OnClose(userData)
	return
end

function FlightGameBossRankRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function FlightGameBossRankRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function FlightGameBossRankRewardUI:OnPause()
	return
end

function FlightGameBossRankRewardUI:OnResume()
	return
end

function FlightGameBossRankRewardUI:OnCover()
	return
end

function FlightGameBossRankRewardUI:OnReveal()
	return
end

function FlightGameBossRankRewardUI:OnRefocus(userData)
	return
end

function FlightGameBossRankRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FlightGameBossRankRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FlightGameBossRankRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FlightGameBossRankRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FlightGameBossRankRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function FlightGameBossRankRewardUI:UpdateView()
	self.flightChallengeBossRankReward = {}
	self.cfgMyRank = nil

	for i, v in pairs(FlightChallengeModule.flightChallengeBossRankData) do
		table.insert(self.flightChallengeBossRankReward, v)

		if self.rankType == v.RankType and self.cfgMyRank == nil and self.myRanking >= v.RankLowerLimit and self.myRanking <= v.RankUpperLimit then
			self.cfgMyRank = v
		end
	end

	table.sort(self.flightChallengeBossRankReward, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)
	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.flightChallengeBossRankReward)

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

		UGUIUtil.SetText(self.TextRank, FlightGameBossRankRewardUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = FlightGameBossRankRewardUIApi:GetString("MazeBossRankIconPath", self.myRanking, true, self.rankType)

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

function FlightGameBossRankRewardUI:OnRenderGridCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = FlightGameBossRankRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	local cfgReward = self.flightChallengeBossRankReward[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

function FlightGameBossRankRewardUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

return FlightGameBossRankRewardUI
