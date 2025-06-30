-- chunkname: @IQIGame\\UI\\MazeExBossRewardUI.lua

local MazeExBossRewardUI = {
	rewardCellPool = {}
}

MazeExBossRewardUI = Base:Extend("MazeExBossRewardUI", "IQIGame.Onigao.UI.MazeExBossRewardUI", MazeExBossRewardUI)

local MazeExBossRewardCell = require("IQIGame.UI.RpgMaze.MazeExBossRewardCell")

function MazeExBossRewardUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, MazeBossChallengeDetailUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextReward, MazeBossChallengeDetailUIApi:GetString("TextRewardTitle"))
	UGUIUtil.SetText(self.TextMsg, MazeBossChallengeDetailUIApi:GetString("TextMsg"))
	UGUIUtil.SetText(self.TextNoRank, MazeBossChallengeDetailUIApi:GetString("TextNoRank"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	self.scrollPageList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function MazeExBossRewardUI:GetPreloadAssetPaths()
	return nil
end

function MazeExBossRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeExBossRewardUI:IsManualShowOnOpen(userData)
	return false
end

function MazeExBossRewardUI:GetBGM(userData)
	return nil
end

function MazeExBossRewardUI:OnOpen(userData)
	self.myRanking = userData[1]
	self.rankType = userData[2]

	self:UpdateView()
end

function MazeExBossRewardUI:OnClose(userData)
	return
end

function MazeExBossRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
end

function MazeExBossRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
end

function MazeExBossRewardUI:OnPause()
	return
end

function MazeExBossRewardUI:OnResume()
	return
end

function MazeExBossRewardUI:OnCover()
	return
end

function MazeExBossRewardUI:OnReveal()
	return
end

function MazeExBossRewardUI:OnRefocus(userData)
	return
end

function MazeExBossRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeExBossRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeExBossRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeExBossRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeExBossRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function MazeExBossRewardUI:UpdateView()
	self.exBossRankReward = {}
	self.cfgMyRank = nil

	for i, v in pairsCfg(CfgRPGMazeExBossRewardTable) do
		table.insert(self.exBossRankReward, v)

		if self.rankType == v.RankType and self.cfgMyRank == nil and self.myRanking >= v.RankLowerLimit and self.myRanking <= v.RankUpperLimit then
			self.cfgMyRank = v
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

		UGUIUtil.SetText(self.TextRank, MazeBossChallengeDetailUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = MazeBossChallengeDetailUIApi:GetString("MazeBossRankIconPath", self.myRanking, true, self.rankType)

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

function MazeExBossRewardUI:OnRenderGridCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = MazeExBossRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	local cfgReward = self.exBossRankReward[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

function MazeExBossRewardUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.MazeExBossRewardUI)
end

return MazeExBossRewardUI
