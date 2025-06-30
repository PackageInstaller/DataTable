-- chunkname: @IQIGame\\UI\\ChallengeWorldBossRewardUI.lua

local ChallengeWorldBossRewardUI = Base:Extend("ChallengeWorldBossRewardUI", "IQIGame.Onigao.UI.ChallengeWorldBossRewardUI", {})
local ChallengeWorldBossRewardCell = require("IQIGame.UI.ChallengeWorldBoss.ChallengeWorldBossRewardCell")

function ChallengeWorldBossRewardUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, ChallengeWorldBossDetailUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextReward, ChallengeWorldBossDetailUIApi:GetString("TextRewardTitle"))
	UGUIUtil.SetText(self.TextMsg, ChallengeWorldBossDetailUIApi:GetString("TextMsg"))
	UGUIUtil.SetText(self.TextNoRank, ChallengeWorldBossDetailUIApi:GetString("TextNoRank"))

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	self.scrollPageList = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollPageList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end
end

function ChallengeWorldBossRewardUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeWorldBossRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeWorldBossRewardUI:OnOpen(userData)
	self.myRanking = userData[1]
	self.rankType = userData[2]

	self:UpdateView()
end

function ChallengeWorldBossRewardUI:OnClose(userData)
	return
end

function ChallengeWorldBossRewardUI:OnAddListeners()
	self.BtnBack:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
end

function ChallengeWorldBossRewardUI:OnRemoveListeners()
	self.BtnBack:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
end

function ChallengeWorldBossRewardUI:OnPause()
	return
end

function ChallengeWorldBossRewardUI:OnResume()
	return
end

function ChallengeWorldBossRewardUI:OnCover()
	return
end

function ChallengeWorldBossRewardUI:OnReveal()
	return
end

function ChallengeWorldBossRewardUI:OnRefocus(userData)
	return
end

function ChallengeWorldBossRewardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeWorldBossRewardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeWorldBossRewardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeWorldBossRewardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeWorldBossRewardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	ChallengeWorldBossRewardCell.DisposeIn(self)
end

function ChallengeWorldBossRewardUI:UpdateView()
	self.worldBossRankReward = {}
	self.cfgMyRank = nil

	for i, v in pairsCfg(CfgWorldBossRewardTable) do
		table.insert(self.worldBossRankReward, v)

		if self.rankType == v.RankType and self.cfgMyRank == nil and self.myRanking >= v.RankLowerLimit and self.myRanking <= v.RankUpperLimit then
			self.cfgMyRank = v
		end
	end

	table.sort(self.worldBossRankReward, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)
	self.scrollPageList:Refresh(#self.worldBossRankReward)

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

		UGUIUtil.SetText(self.TextRank, ChallengeWorldBossDetailUIApi:GetString("TextRewardIndex", self.cfgMyRank.RankLowerLimit, self.cfgMyRank.RankUpperLimit, self.cfgMyRank.RankType))

		if self.myRanking > 0 then
			local path = ChallengeWorldBossDetailUIApi:GetString("ChallengeRankIconPath", self.myRanking, true, self.rankType)

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

function ChallengeWorldBossRewardUI:OnRenderGridCell(cell)
	local item = cell.gameObject
	local itemCell = ChallengeWorldBossRewardCell.PackageOrReuseView(self, item)
	local cfgReward = self.worldBossRankReward[cell.index + 1]

	itemCell:SetData(cfgReward, cell.index + 1)
end

function ChallengeWorldBossRewardUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.ChallengeWorldBossRewardUI)
end

return ChallengeWorldBossRewardUI
