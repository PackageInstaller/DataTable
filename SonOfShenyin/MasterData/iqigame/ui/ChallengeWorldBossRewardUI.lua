-- chunkname: @IQIGame\\UI\\ChallengeWorldBossRewardUI.lua

local RankItemCell = {
	rewardItems = {},
	rankIconTable = {}
}

function RankItemCell.New(view)
	local obj = Clone(RankItemCell)

	obj:__Init(view)

	return obj
end

function RankItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	ForTransformChild(self.RewardItemRoot.transform, function(_trans, _index)
		local itemCell = ItemCell.New(_trans.gameObject, true, true, true)

		itemCell.showMoneyNum = true

		table.insert(self.rewardItems, itemCell)
	end)

	self.rankIconTable[1] = self.RankIcon1.gameObject
	self.rankIconTable[2] = self.RankIcon2.gameObject
	self.rankIconTable[3] = self.RankIcon3.gameObject
end

function RankItemCell:Show(cfgData, isSelfIn)
	self.gameObject:SetActive(true)

	if cfgData.RankLowerLimit == cfgData.RankUpperLimit then
		self.TopRankRoot.gameObject:SetActive(true)
		self.OtherRankRoot.gameObject:SetActive(false)
		ForArray(self.rankIconTable, function(_index, _gameObject)
			local isOn = _index == cfgData.RankLowerLimit

			_gameObject:SetActive(isOn)
		end)
	else
		self.TopRankRoot.gameObject:SetActive(false)
		self.OtherRankRoot.gameObject:SetActive(true)

		self.RankText:GetComponent("Text").text = cfgData.RankRating
		self.RankRangeText:GetComponent("Text").text = cfgData.Desc
	end

	ForArray(self.rewardItems, function(_index, _itemCell)
		local cfgIndex = (_index - 1) * 2 + 1
		local itemCid = GetArrayValue(cfgData.Reward, cfgIndex, 0)

		if itemCid == 0 then
			_itemCell:Hide()

			return
		end

		local itemCount = GetArrayValue(cfgData.Reward, cfgIndex + 1, 1)

		_itemCell:SetItemByCid(itemCid, itemCount)
		_itemCell:Show()
	end)
	self.SelfTag.gameObject:SetActive(isSelfIn)
end

function RankItemCell:Hide()
	self.gameObject:SetActive(false)
end

function RankItemCell:Dispose()
	self.rankIconTable = nil

	ForArray(self.rewardItems, function(_index, _itemCell)
		_itemCell:Dispose()
	end)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local ChallengeWorldBossRewardUI = {
	selfRankRangeCid = 0,
	rankItemCellList = {}
}

ChallengeWorldBossRewardUI = Base:Extend("ChallengeWorldBossRewardUI", "IQIGame.Onigao.UI.ChallengeWorldBossRewardUI", ChallengeWorldBossRewardUI)

function ChallengeWorldBossRewardUI:OnInit()
	self.rankScrollAreaList = self.ScrollViewRoot:GetComponent("ScrollAreaList")

	function self.rankScrollAreaList.onRenderCell(_cell)
		self:__OnRenderRankCell(_cell)
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.CommonReturnBtnRoot, self)
end

function ChallengeWorldBossRewardUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeWorldBossRewardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeWorldBossRewardUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeWorldBossRewardUI:GetBGM(userData)
	return nil
end

function ChallengeWorldBossRewardUI:OnOpen(userData)
	local rankData = userData.rankData

	if rankData.myRanking == -1 then
		self.selfRankRangeCid = 0
	else
		local cfg = ChallengeWorldBossModule.GetRankRangeCfgData(rankData.rankType, rankData.myRanking)

		self.selfRankRangeCid = cfg.Id
	end

	self.cfgList = ChallengeWorldBossModule.GetRankRewardCfgList()

	self.rankScrollAreaList:Refresh(#self.cfgList)
end

function ChallengeWorldBossRewardUI:OnClose(userData)
	return
end

function ChallengeWorldBossRewardUI:OnAddListeners()
	return
end

function ChallengeWorldBossRewardUI:OnRemoveListeners()
	return
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
	self.commonReturnBtn:Dispose()

	self.rankScrollAreaList.onRenderCell = nil
	self.rankScrollAreaList = nil

	ForPairs(self.rankItemCellList, function(_, _cell)
		_cell:Dispose()
	end)
end

function ChallengeWorldBossRewardUI:__OnRenderRankCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rankItemCellList[instanceID]

	if itemCell == nil then
		itemCell = RankItemCell.New(cell.gameObject)
		self.rankItemCellList[instanceID] = itemCell
	end

	local index = cell.index + 1
	local cfg = self.cfgList[index]

	itemCell:Show(cfg, cfg.Id == self.selfRankRangeCid)
end

return ChallengeWorldBossRewardUI
