-- chunkname: @IQIGame\\UI\\PlaceGameRankRewardUI.lua

local PlaceGameRankRewardUI = {
	rankRenderPool = {},
	cfgPlaceGameRankRewardDataTab = {}
}

PlaceGameRankRewardUI = Base:Extend("PlaceGameRankRewardUI", "IQIGame.Onigao.UI.PlaceGameRankRewardUI", PlaceGameRankRewardUI)

require("IQIGame.UIExternalApi.PlaceGameRankRewardUIApi")

local PlaceGameRankRewardCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameRankReward.PlaceGameRankRewardCell")

function PlaceGameRankRewardUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderGridCell(cell)
	end
	self.cfgPlaceGameRankRewardDataTab = {}

	for i, v in pairsCfg(CfgPlaceGameTowerRankTable) do
		if v.Group == PlaceGameModule.GlobalCid then
			table.insert(self.cfgPlaceGameRankRewardDataTab, v)
		end
	end

	table.sort(self.cfgPlaceGameRankRewardDataTab, function(a, b)
		return a.Id < b.Id
	end)
end

function PlaceGameRankRewardUI:GetPreloadAssetPaths()
	return nil
end

function PlaceGameRankRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlaceGameRankRewardUI:IsManualShowOnOpen(userData)
	return false
end

function PlaceGameRankRewardUI:GetBGM(userData)
	return nil
end

function PlaceGameRankRewardUI:OnOpen(userData)
	self.myRanking = userData[1]
	self.rankType = userData[2]

	self:UpdateView()
end

function PlaceGameRankRewardUI:OnClose(userData)
	return
end

function PlaceGameRankRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function PlaceGameRankRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function PlaceGameRankRewardUI:OnPause()
	return
end

function PlaceGameRankRewardUI:OnResume()
	return
end

function PlaceGameRankRewardUI:OnCover()
	return
end

function PlaceGameRankRewardUI:OnReveal()
	return
end

function PlaceGameRankRewardUI:OnRefocus(userData)
	return
end

function PlaceGameRankRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlaceGameRankRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlaceGameRankRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlaceGameRankRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlaceGameRankRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.rankRenderPool) do
		v:Dispose()
	end
end

function PlaceGameRankRewardUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function PlaceGameRankRewardUI:UpdateView()
	self.cfgMyRank = nil

	for i, v in pairs(self.cfgPlaceGameRankRewardDataTab) do
		if self.rankType == v.RankType and self.myRanking >= v.RankLowerLimit and self.myRanking <= v.RankUpperLimit then
			self.cfgMyRank = v

			break
		end
	end

	self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.cfgPlaceGameRankRewardDataTab)

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

		UGUIUtil.SetText(self.TextRank, PlaceGameRankRewardUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.cfgMyRank then
			local path = UIGlobalApi.GetImagePath(self.cfgMyRank.Image)

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

function PlaceGameRankRewardUI:OnRenderGridCell(cell)
	local cfgData = self.cfgPlaceGameRankRewardDataTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.rankRenderPool[instanceID]

	if renderCell == nil then
		renderCell = PlaceGameRankRewardCell.New(cell.gameObject)
		self.rankRenderPool[instanceID] = renderCell
	end

	renderCell:SetData(cfgData, cell.index + 1)
end

return PlaceGameRankRewardUI
