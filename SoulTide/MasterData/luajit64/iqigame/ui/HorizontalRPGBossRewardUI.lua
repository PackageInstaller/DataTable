-- chunkname: @IQIGame\\UI\\HorizontalRPGBossRewardUI.lua

local HorizontalRPGBossRewardUI = {
	rewardCellPool = {}
}

HorizontalRPGBossRewardUI = Base:Extend("HorizontalRPGBossRewardUI", "IQIGame.Onigao.UI.HorizontalRPGBossRewardUI", HorizontalRPGBossRewardUI)

require("IQIGame.UIExternalApi.HorizontalRPGBossRewardUIApi")

local HorizontalRPGBossRewardCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGBossReward.HorizontalRPGBossRewardCell")

function HorizontalRPGBossRewardUI:OnInit()
	function self.DelegateOnClickBtnBack()
		self:OnClickBtnBack()
	end

	self.scrollPageList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function HorizontalRPGBossRewardUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGBossRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGBossRewardUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGBossRewardUI:GetBGM(userData)
	return nil
end

function HorizontalRPGBossRewardUI:OnOpen(userData)
	self.myRanking = userData[1]
	self.rankType = userData[2]

	self:UpdateView()
end

function HorizontalRPGBossRewardUI:OnClose(userData)
	return
end

function HorizontalRPGBossRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnBack)
end

function HorizontalRPGBossRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnBack)
end

function HorizontalRPGBossRewardUI:OnPause()
	return
end

function HorizontalRPGBossRewardUI:OnResume()
	return
end

function HorizontalRPGBossRewardUI:OnCover()
	return
end

function HorizontalRPGBossRewardUI:OnReveal()
	return
end

function HorizontalRPGBossRewardUI:OnRefocus(userData)
	return
end

function HorizontalRPGBossRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGBossRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGBossRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGBossRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGBossRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end
end

function HorizontalRPGBossRewardUI:OnClickBtnBack()
	UIModule.CloseSelf(self)
end

function HorizontalRPGBossRewardUI:UpdateView()
	self.exBossRankReward = {}
	self.cfgMyRank = nil

	for i, v in pairsCfg(CfgHorizontalRPGEXBossRewardTable) do
		if v.Group == HorizontalRPGModule.globalCid then
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

		UGUIUtil.SetText(self.TextRank, HorizontalRPGBossRewardUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = HorizontalRPGBossRewardUIApi:GetString("MazeBossRankIconPath", self.myRanking, true, self.rankType)

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

function HorizontalRPGBossRewardUI:OnRenderGridCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = HorizontalRPGBossRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	local cfgReward = self.exBossRankReward[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

return HorizontalRPGBossRewardUI
