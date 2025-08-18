-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\PlotRewindInfoDlg.lua

local strClassName = "PlotRewindInfoDlg"
local PlotRewindInfoDlg = Class(strClassName, UIControls.Window)
local MainLineStoryCell = require("UI/PlotRewind/MainLineStoryCell")
local SideLineStoryCell = require("UI/PlotRewind/SideLineStoryCell")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local ResAchieve = require("ClientData/ResAchieve")
local ResPlotRewindChapter = require("ClientData/ResPlotRewindChapter")
local PlotRewindUtils = require("UI/PlotRewind/PlotRewindUtils")
local UserData = require("Helper/UserData")

function PlotRewindInfoDlg:ctor()
	self:initUI()
end

function PlotRewindInfoDlg:initUI()
	self.cellRootPath = "MainInfoPanel/ScrollView/Content"
	self.panelFund = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.bgAnim = UIControls.UIAni(self, "")
	self.curPage = 1
	self.pageCount = 0
end

function PlotRewindInfoDlg:onBtnClose()
	self:setVisible(false)
end

function PlotRewindInfoDlg:onNextPage()
	self:goPage(self.curPage + 1)
end

function PlotRewindInfoDlg:onPrePage()
	self:goPage(self.curPage - 1)
end

function PlotRewindInfoDlg:goPage(page)
	if page < 1 then
		return
	end

	local cellStartIndex = (page - 1) * self.pageCount

	for index = 1, self.pageCount do
		local data = self.allMainChapter[cellStartIndex + index]
		local cellRootPath

		if self.storyType == UIConst.PLOT_REWIND_MAIN_LINE then
			cellRootPath = self.mainLineCellRootPath .. index
		end

		if data then
			self.storyCellList[index]:setData(data, cellRootPath)
		else
			self.storyCellList[index]:setVisible(false)
		end
	end

	if self.curPage ~= page then
		self.bgAnim:startAni("HandBookPlotMainLineRefresh", true)
	end

	self.curPage = page

	if self.prePageBtn then
		self.prePageBtn:setVisible(self.curPage > 1)
	end

	if self.nextPageBtn then
		local showNextPage = #self.allMainChapter > self.pageCount * self.curPage

		self.nextPageBtn:setVisible(showNextPage)
	end

	self:checkUnlockTime()
	self:checkNew()
	self:checkConditionLimit()
	self:checkProgress()
	self:scrollToPosition()
end

function PlotRewindInfoDlg:getRealIndex(pageIndex)
	local pageStartIndex = (self.curPage - 1) * self.pageCount

	return pageStartIndex + pageIndex
end

function PlotRewindInfoDlg:isShow(index)
	local pageIndex = index - (self.curPage - 1) * self.pageCount

	if pageIndex > 0 and pageIndex <= self.pageCount then
		return pageIndex
	else
		return nil
	end
end

function PlotRewindInfoDlg:findNewestPage()
	local page = 0
	local pageComplete = true

	while pageComplete do
		page = page + 1

		local cellStartIndex = (page - 1) * self.pageCount
		local isUnlocked = false

		for pageIndex = 1, self.pageCount do
			local dataIndex = cellStartIndex + pageIndex
			local data = self.allMainChapter[dataIndex]

			if data then
				local unlocked, unlockTime = PlotRewindUtils.CheckTimeUnlocked(data)

				if not unlocked then
					pageComplete = false

					break
				end

				local conditionId = data.unlock_condition

				if conditionId then
					local achieveGot = CurAvatar.achieveQualify[conditionId]
					local lockDesc = ResAchieve[conditionId].action_desc
					local locked = not achieveGot

					if locked then
						pageComplete = false

						break
					end
				end

				isUnlocked = true
			else
				pageComplete = false

				break
			end
		end

		if pageComplete or isUnlocked then
			-- block empty
		elseif page > 1 then
			page = page - 1
		end
	end

	return page
end

function PlotRewindInfoDlg:setData(storyType)
	if not storyType then
		return
	end

	self.storyType = storyType
	self.allMainChapter = PlotRewindUtils.getAllMainChapter(storyType)

	if not self.allMainChapter then
		return
	end

	self.storyCellList = {}

	if storyType == UIConst.PLOT_REWIND_MAIN_LINE then
		self.pageCount = 6
		self.nextPageBtn = UIControls.Button(self, "BtnArrowR")

		self.nextPageBtn:addEventClick(self.onNextPage)

		self.prePageBtn = UIControls.Button(self, "BtnArrowL")

		self.prePageBtn:addEventClick(self.onPrePage)

		self.mainLineCellRootPath = "MainInfoPanel/MainLineStoryCell0"

		for index = 1, self.pageCount do
			local cellRootPath = self.mainLineCellRootPath .. index
			local storyCell = MainLineStoryCell(self, cellRootPath)

			table.insert(self.storyCellList, storyCell)
		end
	elseif storyType == UIConst.PLOT_REWIND_SIDE_LINE then
		self.pageCount = #self.allMainChapter
		self.storyCellPrefab = "System/HandBook/SideLineStoryCell"

		for index, data in ipairs(self.allMainChapter) do
			local storyCell = SideLineStoryCell(self, self.cellRootPath, self.storyCellPrefab)

			table.insert(self.storyCellList, storyCell)
		end
	end

	for index = #self.allMainChapter, 1, -1 do
		local data = self.allMainChapter[index]

		if data then
			local unlocked, unlockTime = PlotRewindUtils.CheckTimeUnlocked(data)

			if not unlocked then
				table.remove(self.allMainChapter, index)
			end
		end
	end

	local newestPage = self:findNewestPage()

	self.curPage = newestPage

	self:goPage(newestPage)

	self.isInited = true

	UserData.saveCommonData(CurAvatar.uid .. PlotRewindUtils.ClickTimeString, ClientUtils.getServerTime())
	CurAvatar:checkPlotRewindRedHint()
end

function PlotRewindInfoDlg:scrollToPosition()
	if self.storyType == UIConst.PLOT_REWIND_SIDE_LINE then
		self.scrollView = UIControls.ScrollView(self, "MainInfoPanel/ScrollView")

		if self.unlockIndex > 2 then
			local width = 0

			for index = 1, self.unlockIndex - 2 do
				local visible = self.storyCellList[index]:getVisible()

				if visible then
					width = width + SideLineStoryCell.CellWidth + 20
				end
			end

			self.scrollView:setContentX(-width)
		end
	end
end

function PlotRewindInfoDlg:checkConditionLimit()
	for index = 1, self.pageCount do
		local dataIndex = self:getRealIndex(index)
		local data = self.allMainChapter[dataIndex]

		if data then
			local conditionId = data.unlock_condition

			if conditionId then
				local achieveGot = CurAvatar.achieveQualify[conditionId]
				local lockDesc = ResAchieve[conditionId].action_desc
				local locked = not achieveGot

				self.storyCellList[index]:setLock(locked, lockDesc)
			end
		end
	end
end

function PlotRewindInfoDlg:checkUnlockTime()
	self.unlockIndex = 1

	for index = 1, self.pageCount do
		local dataIndex = self:getRealIndex(index)
		local data = self.allMainChapter[dataIndex]

		if data then
			local unlocked, unlockTime = PlotRewindUtils.CheckTimeUnlocked(data)

			self.storyCellList[index]:setVisible(unlocked)

			if unlocked then
				self.unlockIndex = dataIndex
			end
		end
	end
end

function PlotRewindInfoDlg:checkNew()
	if not self.allMainChapter then
		return
	end

	for index = 1, self.pageCount do
		local dataIndex = self:getRealIndex(index)
		local data = self.allMainChapter[dataIndex]

		if data then
			local hasNew = PlotRewindUtils.CheckNewSideLine(data)

			if self.storyCellList[index].setNewState then
				self.storyCellList[index]:setNewState(hasNew)
			end

			if hasNew and dataIndex < self.unlockIndex then
				self.unlockIndex = dataIndex
			end
		end
	end
end

function PlotRewindInfoDlg:checkProgress()
	for index = 1, self.pageCount do
		local dataIndex = self:getRealIndex(index)
		local data = self.allMainChapter[dataIndex]

		if data then
			local chapters = ResPlotRewindChapter[data.id]

			if not chapters then
				self.storyCellList[index]:setVisible(false)
			else
				local chapterCounts = #chapters
				local chapterUnlocked = 0

				for chapterIndex, chapter in pairs(chapters) do
					local chapterComplete = PlotRewindUtils.checkChapterProgress(chapter.id)

					if chapterComplete then
						chapterUnlocked = chapterUnlocked + 1
					end
				end

				self.storyCellList[index]:setProgress(chapterUnlocked, chapterCounts)
			end
		end
	end
end

return PlotRewindInfoDlg
