-- chunkname: @IQIGame\\UI\\DualTeamExploreExBossRewardUI.lua

local DualTeamExploreExBossRewardUI = {
	rewardCellPool = {}
}

DualTeamExploreExBossRewardUI = Base:Extend("DualTeamExploreExBossRewardUI", "IQIGame.Onigao.UI.DualTeamExploreExBossRewardUI", DualTeamExploreExBossRewardUI)

local DualTeamBossRewardCell = require("IQIGame.UI.DualTeamExplore.DualTeamBossChallenge.DualTeamBossRewardCell")

function DualTeamExploreExBossRewardUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, DualTeamExploreExBossRewardUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextReward, DualTeamExploreExBossRewardUIApi:GetString("TextRewardTitle"))
	UGUIUtil.SetText(self.TextMsg, DualTeamExploreExBossRewardUIApi:GetString("TextMsg"))
	UGUIUtil.SetText(self.TextNoRank, DualTeamExploreExBossRewardUIApi:GetString("TextNoRank"))

	function self.DelegateOnClickBtnBack()
		self:OnClickBtnClose()
	end

	self.scrollPageList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function DualTeamExploreExBossRewardUI:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreExBossRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreExBossRewardUI:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreExBossRewardUI:GetBGM(userData)
	return nil
end

function DualTeamExploreExBossRewardUI:OnOpen(userData)
	self.myRanking = userData[1]
	self.rankType = userData[2]

	self:UpdateView()
end

function DualTeamExploreExBossRewardUI:OnClose(userData)
	return
end

function DualTeamExploreExBossRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function DualTeamExploreExBossRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function DualTeamExploreExBossRewardUI:OnPause()
	return
end

function DualTeamExploreExBossRewardUI:OnResume()
	return
end

function DualTeamExploreExBossRewardUI:OnCover()
	return
end

function DualTeamExploreExBossRewardUI:OnReveal()
	return
end

function DualTeamExploreExBossRewardUI:OnRefocus(userData)
	return
end

function DualTeamExploreExBossRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreExBossRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreExBossRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreExBossRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreExBossRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function DualTeamExploreExBossRewardUI:UpdateView()
	self.exBossRankReward = {}
	self.cfgMyRank = nil

	for i, v in pairsCfg(CfgDualTeamExploreEXBossRewardTable) do
		if v.Group == DualTeamExploreModule.DailyDupPOD.common.openCount then
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

		UGUIUtil.SetText(self.TextRank, DualTeamExploreExBossRewardUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = DualTeamExploreExBossRewardUIApi:GetString("MazeBossRankIconPath", self.myRanking, true, self.rankType)

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

function DualTeamExploreExBossRewardUI:OnRenderGridCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = DualTeamBossRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	local cfgReward = self.exBossRankReward[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

function DualTeamExploreExBossRewardUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.DualTeamExploreExBossRewardUI)
end

return DualTeamExploreExBossRewardUI
