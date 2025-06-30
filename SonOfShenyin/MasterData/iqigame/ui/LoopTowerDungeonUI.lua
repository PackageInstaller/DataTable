-- chunkname: @IQIGame\\UI\\LoopTowerDungeonUI.lua

local LoopTowerDungeonUI = {}

LoopTowerDungeonUI = Base:Extend("LoopTowerDungeonUI", "IQIGame.Onigao.UI.LoopTowerDungeonUI", LoopTowerDungeonUI)

local ChapterItem = require("IQIGame/UI/Chapter/TowerChapter/LoopTowerDungeonUI_ChapterItem")
local StageItem = require("IQIGame/UI/Chapter/TowerChapter/LoopTowerDungeonUI_StageItem")
local RewardItem = require("IQIGame/UI/Chapter/TowerChapter/LoopTowerDungeonUI_RewardItem")

function LoopTowerDungeonUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function LoopTowerDungeonUI:InitMembers()
	self.chapterCellList = {}
	self.chapterDataArray = {}
	self.stageCellList = {}
	self.stageDataArray = {}
	self.rewardDataArray = {}
	self.rewardCellList = {}
	self.currentChapterItem = nil
	self.currentLevel = nil
	self.currentStageItem = nil
	self.currentSelectStageId = nil
end

function LoopTowerDungeonUI:InitComponent()
	self.chapterScroll = self.chapterScroll:GetComponent("OptimizedScrollRect")

	self.chapterScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateChapterScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.stageScroll = self.stageScroll:GetComponent("OptimizedScrollRect")

	self.stageScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateStageScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.rewardScroll = self.rewardScroll:GetComponent("OptimizedScrollRect")

	self.rewardScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateRewardScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function LoopTowerDungeonUI:InitDelegate()
	function self.delegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.delegateOnClickButtonBackToCurrent()
		self:OnClickButtonBackToCurrent()
	end
end

function LoopTowerDungeonUI:OnAddListeners()
	self.startBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickStartBtn)
	self.buttonBackToCurrent:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonBackToCurrent)
end

function LoopTowerDungeonUI:OnRemoveListeners()
	self.startBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickStartBtn)
	self.buttonBackToCurrent:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonBackToCurrent)
end

function LoopTowerDungeonUI:OnClickButtonBackToCurrent()
	if not self.currentLevel then
		return
	end

	self.stageScroll:ScrollTo(#self.stageDataArray - self.currentLevel - 1)

	for _, v in pairs(self.stageCellList) do
		if v.data.Level == self.currentLevel then
			v:OnClickButtonClick()

			break
		end
	end
end

function LoopTowerDungeonUI:OnClickStartBtn()
	if not ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self.currentStageItem.data.UnlockConditionId)) then
		NoticeModule.ShowNotice(19002)

		return
	end

	local userData = {}

	userData.OpenType = 2
	userData.ChapterType = Constant.ChapterPassType.TYPE_CLIMB_TOWER
	userData.StageId = self.currentSelectStageId

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function LoopTowerDungeonUI:UpdateRewardScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.rewardDataArray[index + 1]

	if not self.rewardCellList[instanceID] then
		self.rewardCellList[instanceID] = RewardItem.New(viewGameObject, self)
	end

	self.rewardCellList[instanceID]:Refresh(data)
end

function LoopTowerDungeonUI:UpdateStageScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.stageDataArray[index + 1]

	if not self.stageCellList[instanceID] then
		self.stageCellList[instanceID] = StageItem.New(viewGameObject, self)
	end

	self.stageCellList[instanceID]:Refresh(data)
end

function LoopTowerDungeonUI:UpdateChapterScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.chapterDataArray[index + 1]

	if not self.chapterCellList[instanceID] then
		self.chapterCellList[instanceID] = ChapterItem.New(viewGameObject, self)
	end

	self.chapterCellList[instanceID]:Refresh(data)
end

function LoopTowerDungeonUI:OnOpen(userData)
	self:Refresh()

	local viewsHolder = self.chapterScroll:GetItemViewsHolder(0)

	if viewsHolder then
		local item = self.chapterCellList[viewsHolder.instanceID]

		item:OnClickButtonClick()
	end

	self:SelectedHighestStage()
end

function LoopTowerDungeonUI:OnClose(userData)
	self.currentChapterItem = nil
	self.currentLevel = nil
	self.currentStageItem = nil
	self.currentSelectStageId = nil
end

function LoopTowerDungeonUI:GetPreloadAssetPaths()
	return nil
end

function LoopTowerDungeonUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LoopTowerDungeonUI:IsManualShowOnOpen(userData)
	return false
end

function LoopTowerDungeonUI:GetBGM(userData)
	return 11000013
end

function LoopTowerDungeonUI:OnPause()
	return
end

function LoopTowerDungeonUI:OnResume()
	return
end

function LoopTowerDungeonUI:OnCover()
	return
end

function LoopTowerDungeonUI:OnReveal()
	return
end

function LoopTowerDungeonUI:OnRefocus(userData)
	return
end

function LoopTowerDungeonUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LoopTowerDungeonUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LoopTowerDungeonUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LoopTowerDungeonUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LoopTowerDungeonUI:Refresh()
	self.chapterDataArray = TowerChapterModule.GetTowerCfgData()

	self.chapterScroll:RefreshByItemCount(#self.chapterDataArray)
end

function LoopTowerDungeonUI:RefreshRightPanel()
	if not self.currentChapterItem then
		return
	end

	local data = self.currentChapterItem.data

	LuaUtility.SetText(self.descContentText, data.Desc)
	LuaUtility.SetText(self.chapterName, data.Name)

	local lv = TowerChapterModule.GetTheLastCanStart(self.currentChapterItem.data.Id)

	LuaUtility.SetText(self.textMaxLayer, lv)
	self:RefreshButton()
end

function LoopTowerDungeonUI:RefreshButton()
	LuaUtility.SetGameObjectShow(self.startBtn, false)
	LuaUtility.SetGameObjectShow(self.towerFinish, false)

	if not self.currentStageItem then
		return
	end

	local chapterDup = TowerChapterModule.GetTowerByID(self.currentChapterItem.data.Id)
	local isFinished = chapterDup and chapterDup.passStatus and chapterDup.passStatus[self.currentSelectStageId] and chapterDup.passStatus[self.currentSelectStageId] ~= 0

	LuaUtility.SetGameObjectShow(self.startBtn, not isFinished)
	LuaUtility.SetGameObjectShow(self.towerFinish, isFinished)
	LuaUtility.SetText(self.lvTitleText, string.format(CfgUtil.GetCfgTipsTextWithID(2100002), self.currentStageItem.data.Level))

	self.rewardDataArray = {}

	local len = #self.currentStageItem.data.PassReward

	for i = 1, len do
		local cfgDrop = CfgUtil.GetCfgDropLibDataWithID(self.currentStageItem.data.PassReward[i])
		local len2 = #cfgDrop.DropShowItem

		for i = 1, len2 do
			local t = {}

			t.id = cfgDrop.DropShowItem[i]
			t.num = cfgDrop.GiftItemCount[i]

			table.insert(self.rewardDataArray, t)
		end
	end

	self.rewardScroll:RefreshByItemCount(#self.rewardDataArray)
end

function LoopTowerDungeonUI:RefreshStage()
	if not self.currentChapterItem then
		return
	end

	self.stageDataArray = TowerChapterModule.GetStageListByTowerID(self.currentChapterItem.data.Id)

	table.sort(self.stageDataArray, function(a, b)
		return a.Level > b.Level
	end)
	self.stageScroll:RefreshByItemCount(#self.stageDataArray)
end

function LoopTowerDungeonUI:OnChapterSelected(chapterItem)
	if self.currentChapterItem then
		self.currentChapterItem:UnSelected()

		self.currentChapterItem = nil
	end

	self.currentChapterItem = chapterItem

	self.currentChapterItem:Selected()

	self.currentLevel = TowerChapterModule.GetTheLastCanStart(self.currentChapterItem.data.Id)

	self:RefreshStage()
	self:RefreshRightPanel()

	if not LuaUtility.StrIsNullOrEmpty(self.currentChapterItem.data.BackPicture) then
		LuaUtility.LoadImage(self, self.currentChapterItem.data.BackPicture, self.imageBg:GetComponent("Image"))
	end
end

function LoopTowerDungeonUI:OnStageSelected(stageItem)
	local currentLevelCfg = TowerChapterModule.GetCfgTowerStageWithLevel(self.currentChapterItem.data.Id, self.currentLevel)

	if stageItem.data.Level > currentLevelCfg.Level + currentLevelCfg.VisibleLevel then
		NoticeModule.ShowNotice(19003)

		return
	end

	if self.currentStageItem then
		self.currentStageItem:UnSelected()

		self.currentStageItem = nil
	end

	self.currentStageItem = stageItem

	self.currentStageItem:Selected()

	self.currentSelectStageId = self.currentStageItem.data.Id

	self:RefreshButton()
end

function LoopTowerDungeonUI:SelectedHighestStage()
	if not self.currentChapterItem then
		return
	end

	local lv = TowerChapterModule.GetTheLastCanStart(self.currentChapterItem.data.Id)

	self.stageScroll:ScrollTo(#self.stageDataArray - lv)

	for _, v in pairs(self.stageCellList) do
		if v.data.Level == lv then
			v:OnClickButtonClick()

			break
		end
	end
end

function LoopTowerDungeonUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

return LoopTowerDungeonUI
