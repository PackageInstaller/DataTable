-- chunkname: @IQIGame\\UI\\PlotChallengeBossRewardUI.lua

local PlotChallengeBossRewardUI = {
	rewardCellPool = {}
}

PlotChallengeBossRewardUI = Base:Extend("PlotChallengeBossRewardUI", "IQIGame.Onigao.UI.PlotChallengeBossRewardUI", PlotChallengeBossRewardUI)

local PlotBossRewardCell = require("IQIGame.UI.ExploreHall.PlotChallenge.PlotChallengeBossRewardCell")

function PlotChallengeBossRewardUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, PlotChallengeBossRewardUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextReward, PlotChallengeBossRewardUIApi:GetString("TextRewardTitle"))
	UGUIUtil.SetText(self.TextMsg, PlotChallengeBossRewardUIApi:GetString("TextMsg"))
	UGUIUtil.SetText(self.TextNoRank, PlotChallengeBossRewardUIApi:GetString("TextNoRank"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	self.scrollPageList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function PlotChallengeBossRewardUI:GetPreloadAssetPaths()
	return nil
end

function PlotChallengeBossRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlotChallengeBossRewardUI:IsManualShowOnOpen(userData)
	return false
end

function PlotChallengeBossRewardUI:GetBGM(userData)
	return nil
end

function PlotChallengeBossRewardUI:OnOpen(userData)
	self.myRanking = userData[1]
	self.rankType = userData[2]

	self:UpdateView()
end

function PlotChallengeBossRewardUI:OnClose(userData)
	return
end

function PlotChallengeBossRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
end

function PlotChallengeBossRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
end

function PlotChallengeBossRewardUI:OnPause()
	return
end

function PlotChallengeBossRewardUI:OnResume()
	return
end

function PlotChallengeBossRewardUI:OnCover()
	return
end

function PlotChallengeBossRewardUI:OnReveal()
	return
end

function PlotChallengeBossRewardUI:OnRefocus(userData)
	return
end

function PlotChallengeBossRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlotChallengeBossRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlotChallengeBossRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlotChallengeBossRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlotChallengeBossRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function PlotChallengeBossRewardUI:UpdateView()
	self.exBossRankReward = {}
	self.cfgMyRank = nil

	for i, v in pairsCfg(CfgPlotChallengeActivityBossRankTable) do
		if v.Group == PlotChallengeModule.GlobalCid then
			table.insert(self.exBossRankReward, v)

			if self.rankType == v.RankType and self.cfgMyRank == nil and self.myRanking >= v.RankLowerLimit and self.myRanking <= v.RankUpperLimit then
				self.cfgMyRank = v
			end
		end
	end

	table.sort(self.exBossRankReward, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)
	self.scrollPageList:Refresh(#self.exBossRankReward)

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

		UGUIUtil.SetText(self.TextRank, PlotChallengeBossRewardUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = PlotChallengeBossRewardUIApi:GetString("MazeBossRankIconPath", self.myRanking, true, self.rankType)

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

function PlotChallengeBossRewardUI:OnRenderGridCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = PlotBossRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	local cfgReward = self.exBossRankReward[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

function PlotChallengeBossRewardUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.PlotChallengeBossRewardUI)
end

return PlotChallengeBossRewardUI
