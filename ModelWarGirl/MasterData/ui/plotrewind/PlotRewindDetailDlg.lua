-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\PlotRewindDetailDlg.lua

local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local ResPlotRewindChapter = require("ClientData/ResPlotRewindChapter")
local ResAchieve = require("ClientData/ResAchieve")
local PlotRewindChapterCell = require("UI/PlotRewind/PlotRewindChapterCell")
local PlotRewindUtils = require("UI/PlotRewind/PlotRewindUtils")
local strClassName = "PlotRewindDetailDlg"
local ChapterEndPanel = require("UI/AVG/ChapterEndPanel")
local HandBookShowAVGName = "handBookShowAVGDlg"
local PlotRewindDetailDlg = Class(strClassName, UIControls.Window)

function PlotRewindDetailDlg:ctor()
	self:initUI()
end

function PlotRewindDetailDlg:initUI()
	self.panelFund = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.storyImage = UIControls.RawImage(self, "StoryImagePanel/MaskImage/StoryImage")
	self.storyTitle = UIControls.Label(self, "StoryImagePanel/InfoPanel/TtileText")
	self.numberText = UIControls.Label(self, "StoryImagePanel/InfoPanel/NumberText")
	self.unlockSlider = UIControls.Slider(self, "StoryImagePanel/InfoPanel/Slider")
	self.unlockText = UIControls.Label(self, "StoryImagePanel/InfoPanel/AttrGroup/TextAttr01")
	self.totalText = UIControls.Label(self, "StoryImagePanel/InfoPanel/AttrGroup/TextAttr02")
	self.chapterEndBtn = UIControls.Button(self, "StoryImagePanel/InfoPanel/LetterBtn01")
	self.chapterEndIconNew = UIControls.Image(self, "StoryImagePanel/InfoPanel/LetterBtn01/IconNew")

	self.chapterEndBtn:addEventClick(self.onBtnChapterEnd)

	self.posterBtn = UIControls.Button(self, "StoryImagePanel/InfoPanel/LetterBtn02")
	self.posterIconNew = UIControls.Image(self, "StoryImagePanel/InfoPanel/LetterBtn02/IconNew")

	self.posterBtn:addEventClick(self.onBtnPoster)

	self.chapterInfoRootPath = "StoryListPanel/ChaptersList/Content"
	self.chapterCellPrefab = "System/HandBook/ChaptersMainCell"
	self.scrollList = UIControls.ScrollView(self, "StoryListPanel/ChaptersList")

	self.scrollList:addEventValueChanged(self._onScrollValueChanged)

	self.arrowNext = UIControls.Panel(self, "StoryListPanel/ArrowNext")
	self.unlockPercent = 0

	local mParentUI = UIManager.tryGetUI("plotRewindMainLineDlg")

	if mParentUI then
		mParentUI:checkNew()
	end

	mParentUI = UIManager.tryGetUI("plotRewindSideLineDlg")

	if mParentUI then
		mParentUI:checkNew()
	end
end

function PlotRewindDetailDlg:onBtnClose()
	self:setVisible(false)
end

function PlotRewindDetailDlg:onBtnChapterEnd()
	local chapter_end_id = self.mainChapterInfo.chapter_end_id
	local ui = UIManager.getUI(HandBookShowAVGName, true)

	ui:showChapterEnd(chapter_end_id)
end

function PlotRewindDetailDlg:closechapterEnd()
	self.chapterEndChild:destroy()

	self.chapterEndChild = nil
end

function PlotRewindDetailDlg:onBtnPoster()
	local ui = UIManager.getUI(HandBookShowAVGName, true)

	ui:showChapterPoster(self.mainChapterInfo.poster_path, self.mainChapterInfo.hd_poster_path)
end

function PlotRewindDetailDlg:setMainChapterInfo(mainChapterInfo)
	if mainChapterInfo.bg_detail_image then
		self.storyImage:setImage(mainChapterInfo.bg_detail_image)
	elseif mainChapterInfo.bg_image then
		self.storyImage:setImage(mainChapterInfo.bg_image)
	end

	if mainChapterInfo.title then
		self.storyTitle:setText(mainChapterInfo.title)
	end

	self.numberText:setText(string.format("%02d", mainChapterInfo.index))
	self.chapterEndBtn:setVisible(mainChapterInfo.chapter_end_id ~= nil and self.unlockPercent >= 1)
	self.posterBtn:setVisible((mainChapterInfo.poster_path ~= nil or mainChapterInfo.hd_poster_path ~= nil) and self.unlockPercent >= 1)
end

function PlotRewindDetailDlg:setData(mainChapterInfo)
	self.mainChapterInfo = mainChapterInfo
	self.chapters = ResPlotRewindChapter[mainChapterInfo.id]
	self.chapterCellList = {}

	local curIndex = 1

	if self.chapters then
		self.totalCount = #self.chapters
		self.chapterUnlocked = 0

		for index, chapter in ipairs(self.chapters) do
			local chapterCell = PlotRewindChapterCell(self, self.chapterInfoRootPath, self.chapterCellPrefab)
			local conditionId = chapter.unlock_condition
			local isLocked = false
			local desc

			if conditionId then
				local achieveGot = CurAvatar.achieveQualify[conditionId]

				isLocked = not achieveGot

				if ResAchieve[conditionId] then
					desc = ResAchieve[conditionId].action_desc
				end
			end

			if not isLocked then
				curIndex = index
			end

			local complete = PlotRewindUtils.checkChapterProgress(chapter.id)

			if complete then
				self.chapterUnlocked = self.chapterUnlocked + 1
			end

			chapterCell:setData(chapter, index)
			chapterCell:setLocked(isLocked, desc)
			table.insert(self.chapterCellList, chapterCell)
		end

		self.unlockText:setText(self.chapterUnlocked)
		self.totalText:setText(self.totalCount)

		self.unlockPercent = self.chapterUnlocked / self.totalCount

		self.unlockSlider:setValue(self.unlockPercent)
		self:setMainChapterInfo(mainChapterInfo)
	end

	local height = 0

	if curIndex > 2 then
		height = UIConst.CHAPTER_CELL_HEIGHT * (curIndex - 2) + (curIndex - 3) * 4
	end

	self.scrollList:setContentY(height)
end

function PlotRewindDetailDlg:setScrollIndex(index)
	for i = 1, #self.chapterCellList do
		if i ~= index then
			self.chapterCellList[i]:setDetailState(false)
		end
	end

	local height = (UIConst.CHAPTER_CELL_HEIGHT + 4) * (index - 1)

	self.scrollList:setContentY(height)
end

function PlotRewindDetailDlg:_onScrollValueChanged(sender, valueX, valueY)
	if not self.scrollList:isScroll() then
		self.arrowNext:setVisible(false)

		return
	end

	local barValue = self.scrollList:getVerticalValue()

	if barValue == self.oldBarValue then
		return
	end

	self.oldBarValue = barValue

	if barValue == 0 then
		self.arrowNext:setVisible(false)
	else
		self.arrowNext:setVisible(true)
	end
end

return PlotRewindDetailDlg
