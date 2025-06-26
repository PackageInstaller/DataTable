-- chunkname: @IQIGame\\UI\\StoryChapterUI.lua

local StoryChapterUI = {
	ChapterLevelCellTable = {},
	ChapterLevelCellDic = {},
	AwardCellList = {},
	ChapterBranchItemList = {}
}

StoryChapterUI = Base:Extend("StoryChapterUI", "IQIGame.Onigao.UI.StoryChapterUI", StoryChapterUI)

local StoryStageIconPanel = require("IQIGame.UI.Chapter.StoryChapter.StoryStageIconPanel")
local StoryStageDetailUI = require("IQIGame.UI.Chapter.StoryChapter.StoryStageDetailUI")

function StoryChapterUI:OnInit(userData)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.StoryStageDetailView = StoryStageDetailUI.New(self.StoryStageDetailPanel)

	self.StoryStageDetailView:Hide()

	function self.delegateOnClickPreviousChapterButton()
		self:OnClickPreviousChapterButton()
	end

	function self.delegateOnClickNextChapterButton()
		self:OnClickNextChapterButton()
	end

	self.SimpleScrollSnap = self.StageIconScrollView:GetComponent(typeof(DanielLochner.Assets.SimpleScrollSnap.SimpleScrollSnap))
	self.CurrencyCell = CurrencyCell.New(self.CurrencyPanel)
end

function StoryChapterUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	self.StoryStageDetailView:OnDestroy()
	self:ResetStageIconScrollView()
	self.CurrencyCell:Dispose()
	AssetUtil.UnloadAsset(self)
end

function StoryChapterUI:OnOpen(storyChapterData)
	self.chapterID = storyChapterData.chapterID

	AssetUtil.LoadImage(self, StoryChapterPassUIApi:GetChapterBgImagePath(self.chapterID), self.BgImage:GetComponent(typeof(UnityEngine.UI.Image)))
	UGUIUtil.SetText(self.ChapterName, StoryChapterModule.GetChapterByID(self.chapterID).Name)
	self.CurrencyCell:RefreshItem(Constant.TopMoneyType.GameLevelUI)
	self:InitStageIcon(storyChapterData.stageID)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "OpenChapterPassUI")
	GuideModule.GoNextSubEventDispatch()
end

function StoryChapterUI:InitStageIcon(stageID)
	self.StageIconPrefab:SetActive(false)

	local startStage = StoryChapterModule:GetStartStage(self.chapterID, stageID)

	self.SimpleScrollSnap.StartingPanel = startStage.Index

	self:ResetStageIconScrollView()

	for _, stage in pairs(StoryChapterModule.GetStageListByChapterID(self.chapterID)) do
		if ConditionModule.Check(stage.UnlockConditionId) then
			local stageIconPanel = StoryStageIconPanel.New(self, self.StageIconPrefab, self.SimpleScrollSnap.Content.transform, stage.Id)

			stageIconPanel.gameObject.name = stage.Id

			self:AddStageIconScrollViewItem(stage.Id, stageIconPanel)
		end
	end

	local latestStage = StoryChapterModule.GetLatestUnlockedStage({
		chapterID = self.chapterID
	})

	if StoryChapterModule.FinishDupDict[latestStage.Id] then
		local nextStage = StoryChapterModule.GetNextStageByStageID(self.chapterID, latestStage.Index)

		if nextStage then
			local stageIconPanel = StoryStageIconPanel.New(self, self.StageIconPrefab, self.SimpleScrollSnap.Content.transform, nextStage.Id)

			self:AddStageIconScrollViewItem(nextStage.Id, stageIconPanel)
		end
	end

	self.SimpleScrollSnap:Reload()
end

function StoryChapterUI:InitStageIconScrollView()
	self.StageIconScrollViewItems = {}
end

function StoryChapterUI:GetStageIconScrollViewItemById(id)
	return self.StageIconScrollViewItems[id]
end

function StoryChapterUI:AddStageIconScrollViewItem(id, panel)
	self.StageIconScrollViewItems[id] = panel
end

function StoryChapterUI:ResetStageIconScrollView()
	if getTableLength(self.StageIconScrollViewItems or {}) > 0 then
		for _, icon in pairs(self.StageIconScrollViewItems or {}) do
			icon:OnDestroy()
		end

		self.SimpleScrollSnap:Deactivate()
	end

	self.StageIconScrollViewItems = {}
end

function StoryChapterUI:OnClose(userData)
	self:ResetStageIconScrollView()
end

function StoryChapterUI:OnAddListeners()
	self.PreviousChapterButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateOnClickPreviousChapterButton)
	self.NextChapterButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateOnClickNextChapterButton)
end

function StoryChapterUI:OnRemoveListeners()
	self.PreviousChapterButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateOnClickPreviousChapterButton)
	self.NextChapterButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateOnClickNextChapterButton)
end

function StoryChapterUI:OnClickPreviousChapterButton()
	local chapterLinkedList = StoryChapterModule.GetChapterLinkedList()
	local currentChapter = chapterLinkedList[StoryChapterModule.GetChapterByID(self.chapterID).Index]

	if currentChapter.Prev then
		if not ConditionModule.Check(currentChapter.Prev.UnlockConditionId) then
			NoticeModule.ShowNotice(49005)

			return
		end

		self:OnOpen({
			chapterID = currentChapter.Prev.Id
		})
	end
end

function StoryChapterUI:OnClickNextChapterButton()
	local chapterLinkedList = StoryChapterModule.GetChapterLinkedList()
	local currentChapter = chapterLinkedList[StoryChapterModule.GetChapterByID(self.chapterID).Index]

	if currentChapter.Next then
		if not ConditionModule.Check(currentChapter.Next.UnlockConditionId) then
			NoticeModule.ShowNotice(49005)

			return
		end

		self:OnOpen({
			chapterID = currentChapter.Next.Id
		})
	end
end

function StoryChapterUI:GetPreloadAssetPaths()
	return nil
end

function StoryChapterUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function StoryChapterUI:IsManualShowOnOpen(userData)
	return false
end

function StoryChapterUI:GetBGM(userData)
	return nil
end

function StoryChapterUI:OnPause()
	return
end

function StoryChapterUI:OnResume()
	return
end

function StoryChapterUI:OnCover()
	return
end

function StoryChapterUI:OnReveal()
	return
end

function StoryChapterUI:OnRefocus(userData)
	return
end

function StoryChapterUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function StoryChapterUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function StoryChapterUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function StoryChapterUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

return StoryChapterUI
