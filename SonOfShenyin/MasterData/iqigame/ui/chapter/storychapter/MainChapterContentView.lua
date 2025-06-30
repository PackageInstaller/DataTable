-- chunkname: @IQIGame\\UI\\Chapter\\StoryChapter\\MainChapterContentView.lua

local MainChapterContentView = {}
local StoryChapterIconPanel = require("IQIGame.UI.Chapter.StoryChapter.StoryChapterIconPanel")

function MainChapterContentView.New(go, mainView)
	local o = Clone(MainChapterContentView)

	o:Initialize(go, mainView)

	return o
end

function MainChapterContentView:Initialize(go)
	self.gameObject = go

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:OnAddListeners()
end

function MainChapterContentView:OnDestroy()
	self:ResetChapterIconScrollView()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)

	self.gameObject = nil
end

function MainChapterContentView:OnAddListeners()
	return
end

function MainChapterContentView:OnRemoveListeners()
	return
end

function MainChapterContentView:Show()
	self.gameObject:SetActive(true)
	self:Refresh()
end

function MainChapterContentView:Refresh()
	self:InitChapterIcon()
	EventDispatcher.Dispatch(EventID.StoryChapterPopups)
end

function MainChapterContentView:Hide()
	self.gameObject:SetActive(false)
end

function MainChapterContentView:InitChapterIcon()
	self.ChapterIconPrefab:SetActive(false)

	local latestChapter = StoryChapterModule.GetLatestUnlockedChapter()

	self.SimpleScrollSnap = self.ChapterIconScrollView:GetComponent(typeof(DanielLochner.Assets.SimpleScrollSnap.SimpleScrollSnap))
	self.SimpleScrollSnap.StartingPanel = latestChapter.Index

	self:ResetChapterIconScrollView()

	for _, chapter in pairs(StoryChapterModule.GetChapterList()) do
		if ConditionModule.Check(chapter.UnlockConditionId) then
			local chapterIconPanel = StoryChapterIconPanel.New(self.ChapterIconPrefab, self.SimpleScrollSnap.Content, chapter.Id)

			self:AddChapterIconScrollViewItem(chapter.Id, chapterIconPanel)
		end
	end

	local latestStage = StoryChapterModule.GetLatestUnlockedStage({
		chapterID = latestChapter.Id
	})

	if StoryChapterModule.FinishDupDict[latestStage.Id] then
		local nextChapter = StoryChapterModule.GetNextChapterByIndex(latestChapter.Index)

		if nextChapter then
			local chapterIconPanel = StoryChapterIconPanel.New(self.ChapterIconPrefab, self.SimpleScrollSnap.Content, nextChapter.Id)

			self:AddChapterIconScrollViewItem(nextChapter.Id, chapterIconPanel)
		end
	end

	self.SimpleScrollSnap:Reload()
end

function MainChapterContentView:ResetChapterIconScrollView()
	if getTableLength(self.ChapterIconScrollViewItems or {}) > 0 then
		for _, icon in pairs(self.ChapterIconScrollViewItems or {}) do
			icon:OnDestroy()
		end

		self.SimpleScrollSnap:Deactivate()
	end

	self.ChapterIconScrollViewItems = {}
end

function MainChapterContentView:AddChapterIconScrollViewItem(id, panel)
	self.ChapterIconScrollViewItems[id] = panel
end

return MainChapterContentView
