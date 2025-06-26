-- chunkname: @IQIGame\\UI\\EndlessPlusExBossRewardUI.lua

local EndlessPlusExBossRewardUI = {
	rewardCellPool = {}
}

EndlessPlusExBossRewardUI = Base:Extend("EndlessPlusExBossRewardUI", "IQIGame.Onigao.UI.EndlessPlusExBossRewardUI", EndlessPlusExBossRewardUI)

require("IQIGame.UIExternalApi.EndlessPlusExBossRewardUIApi")

local EndlessPlusExBossRewardCell = require("IQIGame.UI.ExploreHall.EndlessPlus.EndlessPlusExBossRewardCell")

function EndlessPlusExBossRewardUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, EndlessPlusExBossRewardUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextReward, EndlessPlusExBossRewardUIApi:GetString("TextRewardTitle"))
	UGUIUtil.SetText(self.TextMsg, EndlessPlusExBossRewardUIApi:GetString("TextMsg"))
	UGUIUtil.SetText(self.TextNoRank, EndlessPlusExBossRewardUIApi:GetString("TextNoRank"))

	self.scrollPageList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end
end

function EndlessPlusExBossRewardUI:GetPreloadAssetPaths()
	return nil
end

function EndlessPlusExBossRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessPlusExBossRewardUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessPlusExBossRewardUI:GetBGM(userData)
	return nil
end

function EndlessPlusExBossRewardUI:OnOpen(userData)
	self.myRanking = userData[1]
	self.rankType = userData[2]

	self:UpdateView()
end

function EndlessPlusExBossRewardUI:OnClose(userData)
	return
end

function EndlessPlusExBossRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function EndlessPlusExBossRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function EndlessPlusExBossRewardUI:OnPause()
	return
end

function EndlessPlusExBossRewardUI:OnResume()
	return
end

function EndlessPlusExBossRewardUI:OnCover()
	return
end

function EndlessPlusExBossRewardUI:OnReveal()
	return
end

function EndlessPlusExBossRewardUI:OnRefocus(userData)
	return
end

function EndlessPlusExBossRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessPlusExBossRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessPlusExBossRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessPlusExBossRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessPlusExBossRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function EndlessPlusExBossRewardUI:UpdateView()
	self.exBossRankReward = {}
	self.cfgMyRank = nil

	for i, v in pairsCfg(CfgEndlessPlusBossRankTable) do
		if v.Group == EndlessPlusMazeModule.GlobalCid then
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

		UGUIUtil.SetText(self.TextRank, EndlessPlusExBossRewardUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = EndlessPlusExBossRewardUIApi:GetString("MazeBossRankIconPath", self.myRanking, true, self.rankType)

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

function EndlessPlusExBossRewardUI:OnRenderGridCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = EndlessPlusExBossRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	local cfgReward = self.exBossRankReward[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

function EndlessPlusExBossRewardUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

return EndlessPlusExBossRewardUI
