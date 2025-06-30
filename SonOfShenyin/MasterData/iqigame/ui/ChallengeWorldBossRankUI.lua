-- chunkname: @IQIGame\\UI\\ChallengeWorldBossRankUI.lua

local UITabList = require("IQIGame/UI/Common/UITabList")
local ChallengeWorldBossRankUI_RolePopup = require("IQIGame/UI/ChallengeWorldBossUI/ChallengeWorldBossRankUI_RolePopup")
local SelfRankCell = {}

function SelfRankCell.New(view)
	local obj = Clone(SelfRankCell)

	obj:__Init(view)

	return obj
end

function SelfRankCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function SelfRankCell:Show(rankData)
	self.gameObject:SetActive(true)

	if rankData.myRanking == -1 then
		self.NoScoreRoot.gameObject:SetActive(true)
		self.ScoreRoot.gameObject:SetActive(false)

		self.BossLevel:GetComponent("Text").text = "0"
		self.DamageText:GetComponent("Text").text = "0"
	else
		self.NoScoreRoot.gameObject:SetActive(false)
		self.ScoreRoot.gameObject:SetActive(true)

		if rankData.rankType == Constant.CenterRankRankType.Specific then
			self.RankingRoot.gameObject:SetActive(false)
			self.ScoreText.gameObject:SetActive(true)

			self.ScoreText:GetComponent("Text").text = rankData.myRanking
		else
			self.ScoreText.gameObject:SetActive(false)
			self.RankingRoot.gameObject:SetActive(true)

			local rewardCfg = ChallengeWorldBossModule.GetRankRangeCfgData(rankData.rankType, rankData.myRanking)

			self.RankingText:GetComponent("Text").text = rewardCfg.RankRating
		end

		local customDataArray = string.split(rankData.customData, ",")

		self.BossLevel:GetComponent("Text").text = TryToNumber(customDataArray[1], 0)
		self.DamageText:GetComponent("Text").text = TryToNumber(customDataArray[2], 0)
	end

	self.LvText:GetComponent("Text").text = PlayerModule.PlayerInfo.baseInfo.pLv
	self.NameText:GetComponent("Text").text = PlayerModule.PlayerInfo.baseInfo.pName

	local skinCid = PlayerModule.GetPlayerKanBanSkinCid()
	local path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, path, self.HeadIcon:GetComponent("Image"))
end

function SelfRankCell:Hide()
	self.gameObject:SetActive(false)
end

function SelfRankCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local GoalieRankItemCell = {}

function GoalieRankItemCell.New(view)
	local obj = Clone(GoalieRankItemCell)

	obj:__Init(view)

	return obj
end

function GoalieRankItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function GoalieRankItemCell:Show(podData, rank, rankType)
	self.gameObject:SetActive(true)

	local rewardCfg = ChallengeWorldBossModule.GetRankRangeCfgData(rankType, rank)

	self.RankingText:GetComponent("Text").text = rewardCfg.RankRating
	self.LevelText:GetComponent("Text").text = podData.pLv
	self.NameText:GetComponent("Text").text = podData.name

	local customDataArray = string.split(podData.customData, ",")

	self.BossLevelText:GetComponent("Text").text = TryToNumber(customDataArray[1], 0)
	self.DamageText:GetComponent("Text").text = TryToNumber(customDataArray[2], 0)

	local skinCid = SkinModule.GetSkinCidByHeroSkinPOD(podData.heroSkin)
	local path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, path, self.HeadIcon:GetComponent("Image"))
end

function GoalieRankItemCell:Hide()
	self.gameObject:SetActive(false)
end

function GoalieRankItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local RankItemCell = {
	topRankTextTable = {}
}

function RankItemCell.New(view)
	local obj = Clone(RankItemCell)

	obj:__Init(view)

	return obj
end

function RankItemCell:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.topRankTextTable[1] = self.TopRank1.gameObject
	self.topRankTextTable[2] = self.TopRank2.gameObject
	self.topRankTextTable[3] = self.TopRank3.gameObject
end

function RankItemCell:Show(podData, rank, rankType)
	self.gameObject:SetActive(true)

	self.rankingPODData = podData

	local rewardCfg = ChallengeWorldBossModule.GetRankRangeCfgData(rankType, rank)

	if rank <= 3 then
		self.OtherRankRoot.gameObject:SetActive(false)
		self.TopRankRoot.gameObject:SetActive(true)

		self.TopRankingText:GetComponent("Text").text = rewardCfg.RankRating

		ForArray(self.topRankTextTable, function(_index, _gameObject)
			local isOn = _index == rank

			_gameObject:SetActive(isOn)
		end)
	else
		self.TopRankRoot.gameObject:SetActive(false)
		self.OtherRankRoot.gameObject:SetActive(true)

		self.RankText:GetComponent("Text").text = rank
	end

	self.LevelText:GetComponent("Text").text = podData.pLv
	self.NameText:GetComponent("Text").text = podData.name

	local customDataArray = string.split(podData.customData, ",")

	self.BossLevelText:GetComponent("Text").text = TryToNumber(customDataArray[1], 0)
	self.DamageText:GetComponent("Text").text = TryToNumber(customDataArray[2], 0)

	local skinCid = SkinModule.GetSkinCidByHeroSkinPOD(podData.heroSkin)
	local path = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(skinCid, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, path, self.HeadIcon:GetComponent("Image"))
end

function RankItemCell:Hide()
	self.gameObject:SetActive(false)
end

function RankItemCell:Dispose()
	self.topRankTextTable = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local ChallengeWorldBossRankUI = {
	rankItemCellList = {}
}

ChallengeWorldBossRankUI = Base:Extend("ChallengeWorldBossRankUI", "IQIGame.Onigao.UI.ChallengeWorldBossRankUI", ChallengeWorldBossRankUI)

function ChallengeWorldBossRankUI:OnInit()
	self:__InitTabList()

	self.selfRankCell = SelfRankCell.New(self.SelfItemRoot)
	self.goalieRankCell = GoalieRankItemCell.New(self.GoalieItemRoot)
	self.commonReturnBtn = CommonReturnBtn.New(self.CommonReturnBtnRoot, self)
	self.roleInfoPopup = ChallengeWorldBossRankUI_RolePopup.New(self.RolePopupRoot)
end

function ChallengeWorldBossRankUI:__InitTabList()
	self.tabList = UITabList.Create()

	self.tabList:AddTableItem(self.CollectionTabItem, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__ShowCurrentRanking()
	end)
	self.tabList:AddTableItem(self.MemoryTabItem, nil, function(_isOn, _view)
		if not _isOn then
			return
		end

		self:__ShowLastRanking()
	end)

	self.rankScrollAreaList = self.ScrollViewRoot:GetComponent("ScrollAreaList")

	function self.rankScrollAreaList.onRenderCell(_cell)
		self:__OnRenderRankCell(_cell)
	end

	function self.rankScrollAreaList.onSelectedCell(_cell)
		self:__OnRankCellSelect(_cell)
	end
end

function ChallengeWorldBossRankUI:OnOpen(userData)
	self.roleInfoPopup:Hide()

	self.rankData = userData.rankData
	self.goalieData = userData.goalieData

	self.tabList:ChangeSelectIndex(1)
end

function ChallengeWorldBossRankUI:OnAddListeners()
	return
end

function ChallengeWorldBossRankUI:OnRemoveListeners()
	return
end

function ChallengeWorldBossRankUI:OnClose(userData)
	return
end

function ChallengeWorldBossRankUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.selfRankCell:Dispose()
	self.goalieRankCell:Dispose()
	self.tabList:Dispose()

	self.rankScrollAreaList.onRenderCell = nil
	self.rankScrollAreaList.onSelectedCell = nil
	self.rankScrollAreaList = nil

	ForPairs(self.rankItemCellList, function(_, _cell)
		_cell:Dispose()
	end)
end

function ChallengeWorldBossRankUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeWorldBossRankUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeWorldBossRankUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeWorldBossRankUI:GetBGM(userData)
	return nil
end

function ChallengeWorldBossRankUI:OnPause()
	return
end

function ChallengeWorldBossRankUI:OnResume()
	return
end

function ChallengeWorldBossRankUI:OnCover()
	return
end

function ChallengeWorldBossRankUI:OnReveal()
	return
end

function ChallengeWorldBossRankUI:OnRefocus(userData)
	return
end

function ChallengeWorldBossRankUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeWorldBossRankUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeWorldBossRankUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeWorldBossRankUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeWorldBossRankUI:__ShowCurrentRanking()
	self.rankingPODList = self.rankData.rankings

	self.EmptyRoot.gameObject:SetActive(#self.rankingPODList == 0)
	self.rankScrollAreaList:Refresh(#self.rankingPODList)
	self:__ShowSelfRankInfo()
end

function ChallengeWorldBossRankUI:__ShowLastRanking()
	self.rankingPODList = self.rankData.lastRankings

	self.EmptyRoot.gameObject:SetActive(#self.rankingPODList == 0)
	self.rankScrollAreaList:Refresh(#self.rankingPODList)
	self:__HideSelfRankInfo()
end

function ChallengeWorldBossRankUI:__ShowSelfRankInfo()
	self.SelfRankRoot.gameObject:SetActive(true)
	self.selfRankCell:Show(self.rankData)

	if self.rankData.myRanking <= 1000 then
		self.goalieRankCell:Hide()
	elseif self.goalieData ~= nil then
		self.goalieRankCell:Show(self.goalieData.rankingPOD, self.goalieData.ranking)
	else
		self.goalieRankCell:Hide()
	end
end

function ChallengeWorldBossRankUI:__HideSelfRankInfo()
	self.SelfRankRoot.gameObject:SetActive(false)
end

function ChallengeWorldBossRankUI:__OnRenderRankCell(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rankItemCellList[instanceID]

	if itemCell == nil then
		itemCell = RankItemCell.New(cell.gameObject)
		self.rankItemCellList[instanceID] = itemCell
	end

	local rank = cell.index + 1
	local rankData = self.rankingPODList[rank]

	itemCell:Show(rankData, rank, Constant.CenterRankRankType.Specific)
end

function ChallengeWorldBossRankUI:__OnRankCellSelect(cell)
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rankItemCellList[instanceID]

	self.roleInfoPopup:Show(itemCell.rankingPODData)
end

return ChallengeWorldBossRankUI
