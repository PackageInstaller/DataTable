-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PlotRewind\\PlotRewindChapterCell.lua

local strClassName = "PlotRewindChapterCell"
local ResPlotRewindDetail = require("ClientData/ResPlotRewindDetail")
local PlotRewindChapterDetailCell = require("UI/PlotRewind/PlotRewindChapterDetailCell")
local ResAchieve = require("ClientData/ResAchieve")
local PlotRewindChapterCell = Class(strClassName, UIControls.Child)

function PlotRewindChapterCell:ctor()
	self.titleText = UIControls.Label(self, "ChaptersMaininfo/TitleText")
	self.descText = UIControls.Label(self, "ChaptersMaininfo/TipsText")
	self.lockNode = UIControls.Panel(self, "ChaptersMaininfo/LockNode")
	self.detailRootPath = "ChaptersSecondInfo"
	self.detailPrefabPath = "System/HandBook/ChaptersSecondCell"
	self.detailsPanel = UIControls.Panel(self, self.detailRootPath)
	self.detailBtn = UIControls.Button(self, "ChaptersMaininfo")

	self.detailBtn:addEventClick(self.onBtnDetail)

	self.arrowImage = UIControls.Image(self, "ChaptersMaininfo/ArrowBtn")
	self.backImage = UIControls.Image(self, "ChaptersMaininfo/BackImage")
	self.detailList = {}
end

function PlotRewindChapterCell:hideAllDetails()
	for index, detail in pairs(self.detailList) do
		detail:setVisible(false)
	end
end

function PlotRewindChapterCell:setData(chapterInfo, index)
	self.index = index

	self:setVisible(true)

	self.chapterInfo = chapterInfo

	self.titleText:setText(chapterInfo.title)
	self.descText:setText(chapterInfo.desc)

	self.detailInfo = ResPlotRewindDetail[chapterInfo.id]

	self:hideAllDetails()

	self.unlockIndex = 0

	self:setDetailState(false)
end

function PlotRewindChapterCell:onBtnDetail()
	if self.isLocked then
		MsgManager.notice(Lang.get(45495))
	else
		self:setDetailState(not self.detailState)
	end
end

function PlotRewindChapterCell:setDetailState(state)
	state = state or false
	self.detailState = state

	self.detailsPanel:setVisible(state)

	local yScale = -1

	if not state then
		yScale = 1
	end

	self.arrowImage:setScaleXYZ(1, yScale, 1)

	local backImage = "BgChapterNml"

	if state then
		self:initDetailCells()
		self.mParent:setScrollIndex(self.index)

		backImage = "BgChapterSel"
	end

	self.backImage:setImage("Atlas/HandBookAtlas/HandBookPlotRewind01Atlas", backImage)
end

function PlotRewindChapterCell:initDetailCells()
	if self.hasInitedDetails then
		return
	end

	if self.detailInfo then
		for index, detail in ipairs(self.detailInfo) do
			if self.detailList[index] == nil then
				self.detailList[index] = PlotRewindChapterDetailCell(self, self.detailRootPath, self.detailPrefabPath)
			end

			local detailCell = self.detailList[index]

			detailCell:setData(detail)

			local conditionId = detail.unlock_condition
			local isLocked = false
			local lockDesc

			if conditionId then
				local achieveGot = CurAvatar.achieveQualify[conditionId]

				lockDesc = ResAchieve[conditionId].action_desc
				isLocked = not achieveGot
			end

			if not isLocked then
				self.unlockIndex = index
			end

			detailCell:setLocked(isLocked, lockDesc)
			detailCell:setVisible(true)
		end

		self.detailsPanel:setRectSize(UIConst.DETAIL_CELL_WIDTH, UIConst.DETAIL_CELL_HEIGHT * #self.detailInfo + (#self.detailInfo - 1) * 10)
	end

	self.hasInitedDetails = true
end

function PlotRewindChapterCell:setLocked(locked, desc)
	self.lockNode:setVisible(locked)

	self.isLocked = locked

	self.backImage:setVisible(not locked)

	if desc and locked then
		self.descText:setText(desc)
	else
		self.descText:setText(self.chapterInfo.desc)
	end
end

return PlotRewindChapterCell
