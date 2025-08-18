-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonopolyAchievePageDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local BaseObject = require("Common/Object/BaseObject")
local DragTwoPages = require("UI/Control/DragTwoPages")
local MonopolyAchievePageRoundCell = Class("MonopolyAchievePageRoundCell", UIControls.Child)

function MonopolyAchievePageRoundCell:ctor()
	self.txtNum = UIControls.Label(self, "TextNum")
	self.imgIcon = UIControls.Image(self, "Icon")

	if self.mWindow.needIconPath then
		self.imgIcon:setImage(self.mWindow.needIconPath[1], self.mWindow.needIconPath[2])
	end

	self.grids = {}
	self.panelBig = UIControls.Panel(self, "ImgSpe1")
end

function MonopolyAchievePageRoundCell:setState(achieveData, state, startParam, bigBonus)
	self.data = achieveData
	self.state = state

	ClientUtils.CreateBonusGrid(self, self.grids, "AwardPanel", self.data.award, true, nil, true)

	for _, grid in ipairs(self.grids) do
		grid.isShowPreviewTips = true

		if self.mWindow.bonusGridConfigId then
			grid:setContainerConfig(self.mWindow.bonusGridConfigId)
		end

		grid:setGet(self.state == Const.ACT_ACHIEVE_STATE_GOT)
	end

	if self.state == Const.ACT_ACHIEVE_STATE_GOT then
		if bigBonus then
			self:playStateAnimator("ActivityMonopolyAwardGotSpe")
		else
			self:playStateAnimator("ActivityMonopolyAwardNml")
		end
	else
		self:playStateAnimator("ActivityMonopolyAwardDis")
	end

	self.txtNum:setText(achieveData.param - startParam)

	if bigBonus then
		self.panelBig:setVisible(true)
	else
		self.panelBig:setVisible(false)
	end
end

local ActivityMonopolyAchievePage = Class("ActivityMonopolyAchievePage", UIControls.Child)

function ActivityMonopolyAchievePage:ctor()
	self.panelSelf = UIControls.Panel(self, "")
	self.imgItem = UIControls.Image(self, "BgTotal/Icon")
	self.txtItemNum = UIControls.Label(self, "BgTotal/TextTotalNum")
	self.cells = {}
end

function ActivityMonopolyAchievePage:_setData(showRound, nowRound, nowPro)
	self.showRound = showRound
	self.achieveData = {}

	local roundInfo = self.mParent.actObj.actData.clientFakeRound[showRound]
	local startIndex = 1
	local roundProStart = 0
	local preRoundData = self.mParent.actObj.actData.clientFakeRound[showRound - 1]

	if preRoundData then
		startIndex = preRoundData.detail_index + 1

		local preEnd = self.mParent.clientData[preRoundData.detail_index]

		if preEnd and preEnd.param then
			roundProStart = preEnd.param
		end
	end

	local eIndex = roundInfo.detail_index

	for index = startIndex, eIndex do
		table.insert(self.achieveData, self.mParent.clientData[index])
	end

	for index = #self.cells, #self.achieveData - 1 do
		local newCell = MonopolyAchievePageRoundCell(self, "ContentPanel", self.mParent.childPath .. "/ActivityMonopolyAwardCell")

		table.insert(self.cells, newCell)
	end

	for index, cell in ipairs(self.cells) do
		local achieveData = self.achieveData[index]

		if achieveData then
			cell:setVisible(true)

			local state = self.mParent.actObj.actData:getAchieveState(achieveData.type, achieveData.index)

			if showRound < nowRound then
				state = Const.ACT_ACHIEVE_STATE_GOT
			end

			cell:setState(achieveData, state, roundProStart, roundInfo.super_award_flag and index == #self.achieveData)
		else
			cell:setVisible(false)
		end
	end

	if showRound < nowRound then
		self.panelSelf:setObjGray(false, true)
		self.txtItemNum:setText(self.mParent.clientData[eIndex].param - roundProStart)
	elseif nowRound < showRound then
		self.panelSelf:setObjGray(true, true)
		self.txtItemNum:setText(0)
	else
		self.panelSelf:setObjGray(false, true)
		self.txtItemNum:setText(nowPro)
	end

	self.isSuper = roundInfo.super_award_flag
end

local strClassName = "ActivityMonopolyAchievePageDlg"
local ActivityMonopolyAchievePageDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityMonopolyAchievePageDlg, ActivityPanelMixin)

function ActivityMonopolyAchievePageDlg:initUI()
	self.dragPages = DragTwoPages(self, "BgPanel/Mask/ContentPanel1", "BgPanel/Mask/ContentPanel2", "BgPanel/BtnPre", "BgPanel/BtnNext")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.childPath = "System/Activity/ActivityMonopoly"

	if self.windowReplaceableCellPath and self.windowReplaceableCellPath[1] then
		self.childPath = "System/Activity/" .. self.windowReplaceableCellPath[1]
	end

	self.eventAtlas = "Atlas/ActivityAtlas/ActivityMonopolyAwardAtlas"

	if self.windowReplaceableCellPath and self.windowReplaceableCellPath[3] then
		self.eventAtlas = "Atlas/ActivityAtlas/" .. self.windowReplaceableCellPath[3]
	end

	local page1 = ActivityMonopolyAchievePage(self, "BgPanel/Mask/ContentPanel1", self.childPath .. "/RoundAwardInfoPanel")

	page1:setVisible(true)

	local page2 = ActivityMonopolyAchievePage(self, "BgPanel/Mask/ContentPanel2", self.childPath .. "/RoundAwardInfoPanel")

	page2:setVisible(true)

	self.pages = {
		page1,
		page2
	}
	self.needItemId = nil

	local miscData = ResOpActivityAchieveMisc[self.actObj.actId] or {}

	for achieveType, mInfo in pairs(miscData) do
		if mInfo.item_id then
			self.needItemId = mInfo.item_id
			self.needIconPath = BaseObject.getItemIconPath(self.needItemId)

			if self.needIconPath then
				page1.imgItem:setImage(self.needIconPath[1], self.needIconPath[2])
				page2.imgItem:setImage(self.needIconPath[1], self.needIconPath[2])
			end

			break
		end
	end

	self.textCurRound = UIControls.Label(self, "BgPanel/BgRound/TextRound")
	self.bgRound = UIControls.Image(self, "BgPanel/BgRound")
end

function ActivityMonopolyAchievePageDlg:onInitActObj(actObj, achieveObj)
	if actObj.clientTemplateData and actObj.clientTemplateData.grid_id then
		self.bonusGridConfigId = actObj.clientTemplateData.grid_id
	end

	self.windowReplaceableCellPath = actObj.clientTemplateData.src_replace or {}

	self:onShowActivity(achieveObj)
end

function ActivityMonopolyAchievePageDlg:_setData()
	local svrData

	for _, sData in pairs(self.actObj.actData.serverData) do
		svrData = sData
	end

	self.clientData = {}

	for achieveType, cData in pairs(self.actObj.actData.clientData) do
		self.clientData = cData

		break
	end

	local pro = svrData and svrData.progress or 0
	local roundProStart = 0
	local finishRound = 0

	self.maxRound = #self.actObj.actData.clientFakeRound

	for round, roundInfo in ipairs(self.actObj.actData.clientFakeRound) do
		local eIndex = roundInfo.detail_index
		local indexData = self.clientData[eIndex]

		if indexData and indexData.param and pro >= indexData.param and round ~= self.maxRound then
			finishRound = round
			roundProStart = indexData.param
		else
			break
		end
	end

	self.curRound = finishRound + 1
	self.nowPro = pro - roundProStart

	self.dragPages:initPage(self.maxRound, self.curRound)
end

function ActivityMonopolyAchievePageDlg:onDragEvent(sender, currentPageIndex, panelIndex, isOnOpen)
	self.currentPageIndex = currentPageIndex
	self.currentPanelIndex = panelIndex

	self.pages[panelIndex]:_setData(self.currentPageIndex, self.curRound, self.nowPro)
	self.textCurRound:setText(self.currentPageIndex)

	if self.pages[panelIndex].isSuper then
		self.bgRound:setImage(self.eventAtlas, "TxtRoundD")
	else
		self.bgRound:setImage(self.eventAtlas, "TxtRoundX")
	end
end

function ActivityMonopolyAchievePageDlg:refreshRealPanel()
	return
end

return ActivityMonopolyAchievePageDlg
