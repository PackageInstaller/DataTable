-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/CommonStageChapterDetailMediator.lua

require("dm.gameplay.stage.view.component.StageCommonCell")
require("dm.gameplay.stage.view.component.StoryStageCommonCell")

CommonStageChapterDetailMediator = class("CommonStageChapterDetailMediator", DmAreaViewMediator, _M)

CommonStageChapterDetailMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
CommonStageChapterDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local onScrollState = false
local kBtnHandlers = {
	["main.btn_left"] = {
		clickAudio = "Se_Click_Tab_1",
		func = "onClickLeft"
	},
	["main.btn_right"] = {
		clickAudio = "Se_Click_Tab_1",
		func = "onClickRight"
	},
	["main.actionNode.btn_heroSystem"] = {
		func = "onGotoHeroSystem"
	},
	["main.actionNode.btn_emBattle"] = {
		func = "onClickEmBattle"
	},
	["main.actionNode.btn_reward"] = {
		func = "onClickEmBattle"
	}
}
local BaseChapterPath = "asset/scene/"
local commonCellWidth = 420
local unSelectCellHeight = 69
local selectedCellHeight = 155
local actionNode3Pos = {
	cc.p(302.73, 64.5),
	cc.p(188, 62.5),
	cc.p(64.15, 65.5)
}
local actionNode2Pos = {
	cc.p(188, 64.5),
	cc.p(64.15, 62.5)
}
local max

function CommonStageChapterDetailMediator:initialize()
	super.initialize(self)

	self._interval = 70
end

function CommonStageChapterDetailMediator:dispose()
	if self._main.timer then
		self._main.timer:stop()

		self._main.timer = nil
	end

	super.dispose(self)
end

function CommonStageChapterDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RETURN_VIEW, self, self.lastViewReturn)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGE_QUICK_CROSS, self, self.refreshCurrentView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_PUSH_PACAKGE_DONE, self, self.createPushBackBoxIcon)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.createPushBackBoxIcon)
end

local btns

function CommonStageChapterDetailMediator:enterWithData(data)
	onScrollState = false
	btns = {
		"btn_heroSystem",
		"btn_emBattle"
	}
	self._closeResumeView = false
	self._data = data
	self._chapterIndex = data.chapterIndex
	self._stageType = data.stageType or StageType.kNormal
	max = self._stageType == StageType.kNormal and ConfigReader:getDataByNameIdAndKey("ConfigValue", "Block_MapList", "content") or ConfigReader:getDataByNameIdAndKey("ConfigValue", "EliteBlock_MapList", "content")
	self._lastPointIndex = 0

	local enterPoint = self._stageSystem:getEnterPoint()

	if enterPoint then
		self._stageSystem._enterPoint = nil
		self._selectedPointId = data.pointId
		self._willEnterPoint = true
	else
		self._selectedPointId = data.selectedPointId
	end

	self:initWigetInfo()
	self:setupTopInfoWidget()
	self:initStages()
	self:createTableView()
	self:setScrollPoint()
	self:initRewardBox()
	self:enableSectionStageBtn()
	self:refreshStarBoxPanel(true)
	self._safeTouchPanel:setVisible(true)
	self:initAnim()

	if enterPoint or self._willEnterPoint then
		self._willEnterPoint = nil

		self:onClickNextAction(self._selectedPointIndex)
	end

	if self._delayLvPop then
		performWithDelay(self:getView(), function()
			self:getDevelopSystem():popPlayerLvlUpView()
		end, 2.5)
	else
		self:getDevelopSystem():popPlayerLvlUpView()
	end

	self:createPushBackBoxIcon()
end

function CommonStageChapterDetailMediator:initWigetInfo()
	self._main = self:getView():getChildByFullName("main")
	self._stagePanel = self:getView():getChildByFullName("main.stagePanel")

	self._stagePanel:setLocalZOrder(2)

	self._pointSlider = self:getView():getChildByFullName("main.Slider")

	self._pointSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			self:onSliderChanged()
		end
	end)

	self._starBoxPanel = self:getView():getChildByName("star_panel")
	self._textTitle = self:getView():getChildByFullName("main.title")

	self._textTitle:setFontSize(110)

	self._textContent = self:getView():getChildByFullName("main.titleContent")
	self._stageTypeView = self:getView():getChildByFullName("main.stageType")
	self._safeTouchPanel = self:getView():getChildByName("touchPanel")

	local emBattleText2 = self:getView():getChildByFullName("main.actionNode.btn_emBattle.Text_2")
	local emBattleText3 = self:getView():getChildByFullName("main.actionNode.btn_emBattle.Text_3")
	local emBattleText29 = self:getView():getChildByFullName("main.actionNode.btn_heroSystem.Text_29")
	local emBattleText5 = self:getView():getChildByFullName("main.actionNode.btn_heroSystem.Text_5")
	local rewardtext1 = self:getView():getChildByFullName("main.actionNode.btn_reward.text1")
	local rewardtext3 = self:getView():getChildByFullName("main.actionNode.btn_reward.text3")
	local rewardtext2 = self:getView():getChildByFullName("main.actionNode.btn_reward.text2")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		rewardtext2:setVisible(false)
		emBattleText3:setVisible(false)
		emBattleText5:setVisible(false)
		emBattleText2:setPosition(cc.p(50, 37.71))
		emBattleText29:setPosition(cc.p(62, 37.71))
		rewardtext1:setPosition(cc.p(62, 37.71))
		rewardtext3:setPosition(cc.p(62, 16.71))
		rewardtext1:setFontSize(22)
		rewardtext3:setFontSize(22)
		emBattleText29:setFontSize(24)
		emBattleText2:setFontSize(24)
		self:getView():getChildByFullName("main.actionNode.btn_heroSystem.Text_6"):setVisible(false)
		self:getView():getChildByFullName("main.actionNode.btn_emBattle.Text_4"):setVisible(false)
		self:getView():getChildByFullName("main.actionNode.btn_reward.Text_9"):setVisible(false)
	end

	self:refreshStageType()
	self:setChapterTitle()
end

function CommonStageChapterDetailMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(402, 419))

	local function numberOfCells(view)
		return #self._pointList
	end

	local function cellTouched(table, cell)
		local index = cell:getIdx() + 1

		self:onClickNextAction(index)
	end

	local function cellSize(table, idx)
		if idx + 1 == self._selectedPointIndex then
			return commonCellWidth, selectedCellHeight
		else
			return commonCellWidth, unSelectCellHeight
		end
	end

	local function onScroll(table)
		self:refreshStagePoint()
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = index == self._selectedPointIndex and table:dequeueCellByTag(843) or table:dequeueCellByTag(348)

		if not cell then
			cell = cc.TableViewCell:new()

			local clone_cell = self:getView():getChildByFullName("clone_cell")

			clone_cell:setVisible(false)

			local cellView = clone_cell:clone()

			cellView:setVisible(true)
			cellView:setAnchorPoint(cc.p(0.5, 1))
			cellView:setName("cellView")

			if index == self._selectedPointIndex then
				cell:setTag(843)
				cellView:setPosition(cc.p(210, 145))
				cellView:addTo(cell)
			else
				cell:setTag(348)
				cellView:setPosition(cc.p(210, 78))
				cellView:addTo(cell)
			end

			cell.mediator = StageCommonCell:new(cellView, {
				mediator = self
			})
		end

		cell.mediator:refreshData(self._pointList[index], self._chapterIndex, self._bublingPointId)
		cell.mediator:setCellState(self._selectedPointIndex, index)

		return cell
	end

	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(70, 0))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:addTo(self._stagePanel)
	tableView:reloadData()
	tableView:setBounceable(false)
	tableView:setClippingToBounds(false)

	self._tableView = tableView
end

function CommonStageChapterDetailMediator:refreshChooseBtnState()
	local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex - 1, self._stageType)
	local unlock = chapterInfo and chapterInfo:isUnlock()

	self._leftBtn:setVisible(unlock)

	local leftTouchPanel = self:getView():getChildByFullName("main.btn_left")

	leftTouchPanel:setVisible(unlock)

	local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex + 1, self._stageType)
	local unlock = chapterInfo and chapterInfo:isUnlock()

	self._rightBtn:setVisible(unlock)

	local rightTouchPanel = self:getView():getChildByFullName("main.btn_right")

	rightTouchPanel:setVisible(unlock)
end

function CommonStageChapterDetailMediator:refreshStageType()
	local textMap = {
		NIGHTMARE = "STAGE_DIFFICULTY_NIGHTMARE",
		[StageType.kNormal] = "STAGE_DIFFICULTY_NORMAL",
		[StageType.kElite] = "STAGE_DIFFICULTY_ELITE"
	}

	self._stageTypeView:setString(Strings:get(textMap[self._stageType]))
end

function CommonStageChapterDetailMediator:setChapterTitle()
	local chapterConfig = self:getStageSystem():getMapConfigByIndex(self._chapterIndex, self._stageType)

	if chapterConfig then
		self._textTitle:setString(self._chapterIndex)
		self._textContent:setString(Strings:get(chapterConfig.MapName))

		local bgPanel = self:getView():getChildByFullName("main.bg")

		bgPanel:removeAllChildren()

		local backgroundId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Picture")

		if backgroundId and backgroundId ~= "" then
			local background = cc.Sprite:create(BaseChapterPath .. backgroundId .. ".jpg")

			background:setAnchorPoint(cc.p(0.5, 0.5))
			background:setPosition(cc.p(568, 320))
			background:addTo(bgPanel)
		end

		local flashId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash1")

		if flashId and flashId ~= "" then
			local mc = cc.MovieClip:create(flashId)

			mc:setPosition(cc.p(568, 320))
			mc:addTo(bgPanel)
		end

		local flashId2 = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Flash2")

		if flashId2 and flashId2 ~= "" then
			local mc = cc.MovieClip:create(flashId2)

			mc:setPosition(cc.p(568, 320))
			mc:addTo(bgPanel)
		end

		local winSize = cc.Director:getInstance():getWinSize()

		if winSize.height < 641 then
			bgPanel:setScale(winSize.width / 1386)
		end

		local plistViewId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", chapterConfig.Background, "Extra")

		if plistViewId and plistViewId ~= "" then
			local plistView = cc.CSLoader:createNode("asset/ui/" .. plistViewId .. ".csb")

			plistView:addTo(bgPanel):center(cc.size(1136, 640))
		end

		self._stageTypeView:setPositionX(self._textContent:getPositionX() + self._textContent:getContentSize().width + 10)

		local imageViewNode = self:getView():getChildByFullName("main.titleBg")
		local titleSize = self._textContent:getContentSize().width + self._stageTypeView:getContentSize().width + 45

		imageViewNode:setContentSize(cc.size(titleSize, imageViewNode:getContentSize().height))
	end
end

function CommonStageChapterDetailMediator:setScrollPoint(offY)
	if #self._pointList < 5 then
		self._pointSlider:setVisible(false)

		return
	else
		self._pointSlider:setVisible(true)

		if not self._selectedPointIndex then
			local curPointIndex = 1

			if curPointIndex > 5 then
				if offY then
					self._tableView:setContentOffset(cc.p(0, offY), false)
				else
					local offset = unSelectCellHeight * (curPointIndex - 1)
					local minOffset = self._tableView:minContainerOffset().y

					self._tableView:setContentOffset(cc.p(0, offset + minOffset), false)
				end
			end
		end
	end
end

function CommonStageChapterDetailMediator:refreshStagePoint()
	if not self._tableView or onScrollState then
		return
	end

	local offY = self._tableView:getContentOffset().y
	local maxOffset = self._tableView:minContainerOffset().y
	local percent = math.abs(offY / maxOffset)

	self._pointSlider:setPercent(100 - percent * 100)
end

function CommonStageChapterDetailMediator:onSliderChanged()
	local percent = self._pointSlider:getPercent()
	local maxOffset = self._tableView:minContainerOffset().y

	onScrollState = true

	self._tableView:setContentOffset(cc.p(0, maxOffset * (1 - percent * 0.01)), false)

	onScrollState = false
end

function CommonStageChapterDetailMediator:initStages()
	local chapterConfig = self:getStageSystem():getMapConfigByIndex(self._chapterIndex, self._stageType)
	local action = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
		if chapterConfig.BGM and chapterConfig.BGM ~= "" then
			AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)
		end
	end), cc.CallFunc:create(function()
		local newMapChecker, isNewChapterPop = self:getStageSystem():getNewMapUnlockIndex(self._stageType)

		self:getStageSystem():setIsPlayNewUnlockChapter(false)

		if newMapChecker < self._chapterIndex then
			self:getStageSystem():setIsPlayNewUnlockChapter(true)
		end

		if self:getStageSystem():getIsPlayNewUnlockChapter() then
			self:checkUnlockNewChapter()
		end
	end))

	self:getView():stopAllActions()
	self:getView():runAction(action)

	self._pointList = {}

	for i, v in ipairs(chapterConfig.SubPoint) do
		self._pointList[i] = v
	end

	self._storyPointList = chapterConfig.SubStoryPoint
	self._storyPointView = self._storyPointView or {}

	for k, v in ipairs(self._storyPointList) do
		self:createStoryPointNode(k, v)
	end

	local practicePointList = chapterConfig.SubPracticePoint

	for _, id in ipairs(practicePointList) do
		local prePointId = ConfigReader:getDataByNameIdAndKey("BlockPracticePoint", id, "PrePoint")

		for k, v in ipairs(self._pointList) do
			if v == prePointId then
				table.insert(self._pointList, k + 1, id)

				break
			end
		end
	end

	self:initBublingPointId()

	if not self._selectedPointId then
		for k, v in ipairs(self._pointList) do
			local pointInfo = self:getStageSystem():getPointById(v)

			if pointInfo:isUnlock() then
				self._lastPointIndex = k
			else
				break
			end
		end

		if self._lastPointIndex == #self._pointList then
			local lastPointInfo = self:getStageSystem():getPointById(self._pointList[self._lastPointIndex])

			if not lastPointInfo:isPass() then
				self._selectedPointIndex = self._lastPointIndex
			end
		else
			self._selectedPointIndex = self._lastPointIndex
		end
	else
		self._selectedPointIndex = table.indexof(self._pointList, self._selectedPointId)

		if self._willEnterPoint then
			self._willEnterPoint = nil

			return
		else
			local nextPoint = self._pointList[self._selectedPointIndex + 1]

			if nextPoint then
				local pointInfo = self:getStageSystem():getPointById(nextPoint)

				if not pointInfo:isPass() and pointInfo:isUnlock() then
					self._selectedPointIndex = self._selectedPointIndex + 1

					if pointInfo._config.BlockDetailAuto == 1 and pointInfo:getIsDailyFirstEnter() then
						self._willEnterPoint = true
					end
				end
			else
				local starCount = self._data.selectedPointStarCount

				if starCount == 0 then
					local pointInfo = self._stageSystem:getPointById(self._selectedPointId)
					local curStarCount = pointInfo:getStarCount()

					if curStarCount > 0 then
						self:passChapterMc()
					end
				end
			end
		end
	end
end

function CommonStageChapterDetailMediator:initBublingPointId()
	self._bublingPointId = -1

	for _, v in ipairs(self._pointList) do
		local _point = self._stageSystem:getPointById(v)

		if not _point:isPass() and _point:getBublingTips() then
			self._bublingPointId = v

			break
		end
	end
end

function CommonStageChapterDetailMediator:lastViewReturn()
	self._closeResumeView = true
end

function CommonStageChapterDetailMediator:resumeWithData(data)
	if not self._selectedPointId or self._closeResumeView then
		self._closeResumeView = false

		return
	end

	local nextPoint = self._pointList[self._selectedPointIndex + 1]

	if nextPoint then
		local pointInfo = self._stageSystem:getPointById(nextPoint)

		if not pointInfo:isPass() and pointInfo:isUnlock() then
			self._selectedPointIndex = self._selectedPointIndex + 1
		end
	else
		local starCount = self._data.selectedPointStarCount

		if starCount == 0 then
			local pointInfo = self._stageSystem:getPointById(self._data.selectedPointId)
			local curStarCount = pointInfo:getStarCount()

			if curStarCount > 0 then
				self:passChapterMc()
			end
		end
	end

	self._data.selectedPointId = nil
	self._data.selectedPointStarCount = nil

	self:initBublingPointId()
	self._tableView:reloadData()
	self:setScrollPoint()
	self:refreshStarBoxPanel(true)
	self:enableSectionStageBtn()

	local chapterConfig = self:getStageSystem():getMapConfigByIndex(self._chapterIndex, self._stageType)

	AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)
	self:setupClickEnvs()

	local pointId = self._pointList[self._selectedPointIndex]
	local pointIns = self:getStageSystem():getPointById(pointId)

	if pointIns then
		local config = pointIns._config

		if config.IsAuto == 1 then
			self:onClickPlayStory(pointId)
		elseif config.BlockDetailAuto == 1 and pointIns:getIsDailyFirstEnter() and not pointIns:isPass() then
			self:onClickNextAction(self._selectedPointIndex)
		end
	end

	if self._delayLvPop then
		performWithDelay(self:getView(), function()
			self:getDevelopSystem():popPlayerLvlUpView()
		end, 2.5)
	else
		self:getDevelopSystem():popPlayerLvlUpView()
	end

	if data and data.pushPackage then
		self._developSystem:requstNotEnoughItem("STAGE_FAIL", CurrencyIdKind.kPower)
	end
end

function CommonStageChapterDetailMediator:createStoryPointNode(index, pointId)
	local clone_cell = self:getView():getChildByFullName("storyPoint_cell")
	local stageSystem = self:getStageSystem()
	local storyPointConfig = stageSystem:getStoryPointConfigById(pointId)
	local storyPoint = stageSystem:getPointById(pointId)

	clone_cell:setVisible(false)

	if self._storyPointView[pointId] == nil then
		local cell = clone_cell:clone()
		local pointNode = StoryStageCommonCell:new(cell, {
			mediator = self,
			point = storyPoint
		})

		local function callFunc(sender, eventType)
			self:onClickPlayStory(pointId)
		end

		mapButtonHandlerClick(nil, cell, {
			func = callFunc
		})
		cell:setSwallowTouches(true)
		cell:addTo(self:getView():getChildByName("main")):setPosition(568 + storyPointConfig.Location[1], 320 + storyPointConfig.Location[2])
		cell:setLocalZOrder(1)

		self._storyPointView[pointId] = pointNode

		pointNode:refreshViewWithState(storyPoint:getState(), storyPoint:isUnlock(), storyPoint:isPass())
	else
		self._storyPointView[pointId]:refreshViewWithState(nil, storyPoint:isUnlock(), storyPoint:isPass())
	end

	if not storyPoint:isPass() and storyPointConfig.IsHide ~= 1 then
		local preOpenPointIds = storyPoint:getPrevBPointId()
		local _pointId = preOpenPointIds[1]

		if _pointId then
			for k, v in ipairs(self._pointList) do
				if v == _pointId then
					table.insert(self._pointList, k + 1, pointId)

					break
				end
			end
		else
			table.insert(self._pointList, 1, pointId)
		end
	end
end

function CommonStageChapterDetailMediator:refreshStoryPoint(pointId)
	for pId, pNode in pairs(self._storyPointView) do
		local storyPoint = self:getStageSystem():getPointById(pId)

		pNode:refreshViewWithState(nil, storyPoint:isUnlock(), storyPoint:isPass())
	end

	table.removebyvalue(self._pointList, pointId)

	if self._selectedPointIndex > #self._pointList then
		self._lastPointIndex = 0
		self._selectedPointIndex = nil
		self._selectedPointId = nil

		self:passChapterMc()
	end

	self._tableView:reloadData()

	local pointIns = self:getStageSystem():getPointById(self._pointList[self._selectedPointIndex])

	if pointIns and pointIns:getBlockDetailAuto() == 1 and pointIns:getIsDailyFirstEnter() and not pointIns:isPass() then
		self:onClickNextAction(self._selectedPointIndex)
	end

	self:setScrollPoint()
end

function CommonStageChapterDetailMediator:onClickNextAction(index)
	local tag = index
	local pointId = self._pointList[tag]
	local pointInfo, pointType = self:getStageSystem():getPointById(pointId)

	if not pointInfo:isUnlock() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("Lock2")
		}))

		return
	end

	if self._selectedPointIndex ~= tag then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		self._selectedPointIndex = tag

		local offY = self._tableView:getContentOffset().y

		self._tableView:reloadData()
		self:setScrollPoint(offY)
	else
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		self._data.selectedPointId = pointId
		self._selectedPointId = pointId
		self._data.stageType = self._stageType
		self._data.chapterIndex = self._chapterIndex

		if pointType == kStageTypeMap.point then
			self._data.selectedPointStarCount = pointInfo:getStarCount()

			self:enterCommonPoint(pointId)
		elseif pointType == kStageTypeMap.StoryPoint then
			self:onClickPlayStory(pointId)
		elseif pointType == kStageTypeMap.PracticePoint then
			self:enterPracticePoint(pointId)
		end
	end
end

function CommonStageChapterDetailMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function CommonStageChapterDetailMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(1001)

	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self._topInfoWidget:hideTitle()

	local top = self:getView():getChildByFullName("topinfo_node.starNode")
	local bar1 = topInfoNode:getChildByName("currency_bar_2")

	top:changeParent(bar1)
	top:setPosition(-313, -51)
	top:getChildByName("Text_47"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
	top:getChildByName("count"):enableOutline(cc.c4b(0, 0, 0, 127.5), 1)
end

function CommonStageChapterDetailMediator:initAnim()
	local image1 = self:getView():getChildByFullName("main.Image1")
	local image2 = self:getView():getChildByFullName("main.titleBg")

	image1:setOpacity(0)
	image2:setOpacity(0)
	image1:runAction(cc.FadeIn:create(0.5))
	image2:runAction(cc.FadeIn:create(0.5))
	self._textTitle:setOpacity(0)
	self._textTitle:setScale(2)

	local action1 = cc.Spawn:create(cc.FadeIn:create(0.31), cc.ScaleTo:create(0.31, 0.88))

	self._textTitle:runAction(cc.Sequence:create(action1, cc.ScaleTo:create(0.1, 1)))

	local posX, posY = self._textContent:getPosition()

	self._textContent:setPositionX(posX - 200)
	self._textContent:setOpacity(0)
	self._textContent:runAction(cc.Spawn:create(cc.MoveTo:create(0.22, cc.p(posX, posY)), cc.FadeIn:create(0.2)))

	posX, posY = self._stageTypeView:getPosition()

	self._stageTypeView:setPositionX(posX + 300)
	self._stageTypeView:setOpacity(0)
	self._stageTypeView:runAction(cc.Spawn:create(cc.MoveTo:create(0.22, cc.p(posX, posY)), cc.FadeIn:create(0.2)))
	self._starBoxPanel:setOpacity(0)

	local btnMc = cc.MovieClip:create("qiehuananniu_zhuxianguanka_UIjiaohudongxiao")

	btnMc:addCallbackAtFrame(25, function()
		btnMc:stop()

		self._btnMc = cc.MovieClip:create("qiehuananniu_zhuxianguanka_UIjiaohudongxiao")

		self._btnMc:setPosition(cc.p(365, 313))
		self:getView():getChildByName("main"):addChild(self._btnMc)

		if self._chapterIndex == 1 then
			self._btnMc:gotoAndStop(30)
		elseif self._chapterIndex == #max then
			self._btnMc:gotoAndStop(28)
		else
			self._btnMc:gotoAndStop(25)
		end

		self:setupClickEnvs()
		btnMc:removeFromParent(true)
	end)

	if self._chapterIndex == 1 then
		btnMc:getChildByName("left"):setOpacity(0)
		btnMc:getChildByName("leftClone"):setOpacity(0)
	end

	if self._chapterIndex == #max then
		btnMc:getChildByName("right"):setOpacity(0)
		btnMc:getChildByName("rightClone"):setOpacity(0)
	end

	btnMc:setPlaySpeed(1.6)
	btnMc:gotoAndStop(1)

	local main = self:getView():getChildByName("main")

	btnMc:setPosition(cc.p(365, 313))
	main:addChild(btnMc)
	btnMc:setLocalZOrder(1)

	local j = 0

	for i = 0, #self._pointList - 1 do
		local cell = self._tableView:cellAtIndex(i)

		if cell then
			local cellView = cell:getChildByFullName("cellView")

			cellView:setOpacity(0)

			local posX, posY = cellView:getPosition()

			cellView:setPositionX(posX + 300)

			local easeBackOutAni = cc.EaseBackOut:create(cc.MoveTo:create(0.19, cc.p(posX, posY)))

			easeBackOutAni:update(0.6)

			local enterAction = cc.Spawn:create(cc.FadeIn:create(0.125), easeBackOutAni)

			cellView:runAction(cc.Sequence:create(cc.DelayTime:create(0.1 + j * 0.125), enterAction))

			j = j + 1
		end
	end

	performWithDelay(self._safeTouchPanel, function()
		self._safeTouchPanel:setVisible(false)
	end, 0.25 + j * 0.125)
	performWithDelay(self:getView(), function()
		btnMc:gotoAndPlay(1)
		self._starBoxPanel:runAction(cc.FadeIn:create(0.25))
	end, 0.31)
end

function CommonStageChapterDetailMediator:initRewardBox()
	for i = 1, 3 do
		local imgBox = self._starBoxPanel:getChildByFullName("bar_schedule.box_panel_" .. i .. ".img_box")

		imgBox:setTag(i)
		imgBox:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
				self:onClickRewardBox(sender)
			end
		end)
	end
end

function CommonStageChapterDetailMediator:refreshStarBoxPanel(isInitTop)
	local function setBoxStar(boxPanel, star)
		local textStar = boxPanel:getChildByName("text_star_num")

		textStar:setString(star)
	end

	local function setBoxState(boxPanel, index, state, showRed)
		local imgBox = boxPanel:getChildByName("img_box")

		imgBox:ignoreContentAdaptWithSize(true)

		local mcBox = boxPanel:getChildByName("mc_box")
		local imgRedPoint = boxPanel:getChildByName("red_point")

		imgRedPoint:setVisible(showRed)
	end

	local function setBoxPosition(boxPanel, starNum, totalStarNum)
		local totalWidth = 360
		local offset = 18
		local posX = starNum / totalStarNum * totalWidth - offset

		boxPanel:setPositionX(posX)
	end

	local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex, self._stageType)
	local chapterConfig = self:getStageSystem():getMapConfigByIndex(self._chapterIndex, self._stageType)
	local boxPanel = {}
	local starBar = self._starBoxPanel:getChildByName("bar_schedule")

	for i = 1, 3 do
		boxPanel[i] = starBar:getChildByName("box_panel_" .. i)
	end

	if chapterConfig then
		local boxRewardList = self:getStageSystem():boxReardToTable(chapterConfig.StarBoxReward)
		local totalStarNum = tonumber(boxRewardList[#boxRewardList].starNum)
		local curStarNum = chapterInfo and chapterInfo:getCurrentStarCount() or 0
		local boxNum = #boxRewardList

		boxPanel[1]:setVisible(boxNum >= 3)
		boxPanel[2]:setVisible(boxNum >= 2)

		for index, reward in pairs(boxRewardList) do
			local boxIndex = 3 - boxNum + index

			setBoxStar(boxPanel[boxIndex], reward.starNum)
			setBoxPosition(boxPanel[boxIndex], reward.starNum, totalStarNum)

			local isOpen, showRed

			if curStarNum >= reward.starNum then
				if chapterInfo and chapterInfo:getMapBoxState(reward.starNum) ~= StageBoxState.kCanReceive then
					isOpen = true
					showRed = false
				else
					isOpen = false
					showRed = true
				end
			else
				isOpen = false
				showRed = false
			end

			setBoxState(boxPanel[boxIndex], boxIndex, isOpen, showRed)
		end

		starBar:setPercent(curStarNum / totalStarNum * 100)

		if isInitTop then
			local top = self:getView():getChildByFullName("topinfo_node.currency_bar_2.starNode")
			local topStar = top:getChildByName("count")
			local stageManager = self._stageSystem._stageManager

			topStar:setString(stageManager:getAllStageStar())
		end
	end
end

function CommonStageChapterDetailMediator:onClickRewardBox(sender)
	local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex, self._stageType)
	local chapterConfig = self:getStageSystem():getMapConfigByIndex(self._chapterIndex, self._stageType)
	local boxRewardList = self:getStageSystem():boxReardToTable(chapterConfig.StarBoxReward)
	local index = sender:getTag()
	local boxNum = #boxRewardList
	local boxIndex = index - (3 - boxNum)
	local curStarNum = chapterInfo and chapterInfo:getCurrentStarCount() or 0
	local chapterId = self:getStageSystem():index2MapId(self._chapterIndex, self._stageType)

	local function receiveAward()
		local function requestRewardSuc(data)
			local stageSystem = self._stageSystem
			local curChapterId = stageSystem:index2MapId(self._chapterIndex, self._stageType)

			if chapterId == curChapterId then
				local parent = sender:getParent()
				local redPoint = parent:getChildByName("red_point")

				redPoint:setVisible(false)
			end

			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local view = self:getInjector():getInstance("getRewardView")

			storyDirector:notifyWaiting("getRew_CommonStageChapterDetailMediator")
			stageSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = data
			}))
		end

		self:getStageSystem():requestStageStarsReward(chapterId, boxRewardList[boxIndex].starNum, function(data)
			requestRewardSuc(data)
		end)
	end

	local data = {
		type = StageRewardType.kStarBox,
		rewardId = boxRewardList[boxIndex].rewardId,
		extra = {}
	}

	if curStarNum >= boxRewardList[boxIndex].starNum then
		if chapterInfo and chapterInfo:getMapBoxState(boxRewardList[boxIndex].starNum) ~= StageBoxState.kCanReceive then
			data.state = StageBoxState.kHasReceived
		else
			data.state = StageBoxState.kCanReceive
			data.callback = receiveAward
		end
	else
		data.state = StageBoxState.kCannotReceive
	end

	data.extra[1] = curStarNum
	data.extra[2] = boxRewardList[boxIndex].starNum

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageShowRewardView"), {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, self))
end

function CommonStageChapterDetailMediator:refreshChapterView()
	self._lastPointIndex = 0
	self._selectedPointIndex = nil
	self._selectedPointId = nil

	for _, v in pairs(self._storyPointView) do
		v:getView():removeFromParent(true)
	end

	self._storyPointView = nil

	self:setChapterTitle()
	self:initStages()
	self._tableView:reloadData()
	self:setScrollPoint()
	self:refreshStarBoxPanel()

	if self._chapterIndex == 1 then
		self._btnMc:gotoAndStop(30)
	elseif self._chapterIndex == #max then
		self._btnMc:gotoAndStop(28)
	else
		self._btnMc:gotoAndStop(25)
	end
end

function CommonStageChapterDetailMediator:checkUnlockNewChapter()
	if not self._tipsWidget then
		local tipsNode = ChapterUnlockWidget:createWidgetNode()

		local function callFunc()
			self:getStageSystem():setNewMapUnlockIndex(self._stageType, self._chapterIndex)
			self:getStageSystem():setIsPlayNewUnlockChapter(false)

			local sequence = cc.Sequence:create(cc.CallFunc:create(function()
				local storyDirector = self:getInjector():getInstance(story.StoryDirector)

				storyDirector:notifyWaiting("exit_playNewUnlockChapter_view")
			end))

			self:getView():runAction(sequence)
		end

		local injector = self:getInjector()

		self._tipsWidget = injector:injectInto(ChapterUnlockWidget:new(tipsNode, callFunc))

		local topPanel = self:getView():getChildByName("topPanel")

		topPanel:setLocalZOrder(1300)
		self._tipsWidget:getView():addTo(topPanel):center(topPanel:getContentSize())
	end

	self._tipsWidget:setupView(self._chapterIndex, self._stageType)
end

function CommonStageChapterDetailMediator:refreshCurrentView()
	if self._chapterIndex > #max then
		return
	end

	local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex + 1, self._stageType)

	if chapterInfo then
		local unlock, tips = chapterInfo:isUnlock()

		if unlock then
			self._chapterIndex = self._chapterIndex + 1
		end
	end

	local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex, self._stageType)

	self:refreshChapterView()

	local top = self:getView():getChildByFullName("topinfo_node.currency_bar_2.starNode")
	local topStar = top:getChildByName("count")
	local stageManager = self._stageSystem._stageManager

	topStar:setString(stageManager:getAllStageStar())
end

function CommonStageChapterDetailMediator:onClickLeft()
	if self._chapterIndex == 1 then
		return
	end

	local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex - 1, self._stageType)
	local unlock, tips = chapterInfo:isUnlock()

	if unlock then
		self._chapterIndex = self._chapterIndex - 1

		self:refreshChapterView()
	else
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tips
		}))
	end
end

function CommonStageChapterDetailMediator:onClickRight()
	if self._chapterIndex == #max then
		return
	end

	local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex + 1, self._stageType)
	local unlock, tips = chapterInfo:isUnlock()

	if unlock then
		self._chapterIndex = self._chapterIndex + 1

		self:refreshChapterView()
	else
		if tips == Strings:get("Lock1") then
			tips = Strings:get("Lock4")
		end

		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tips
		}))
	end
end

function CommonStageChapterDetailMediator:onGotoHeroSystem()
	local view = self:getInjector():getInstance("HeroShowListView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view))

	self._selectedPointId = nil
end

function CommonStageChapterDetailMediator:onClickEmBattle()
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local unlock, tips = systemKeeper:isUnlock("Hero_Group")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	local view = self:getInjector():getInstance("StageTeamView")
	local _teamType = self._stageType == StageType.kNormal and StageTeamType.STAGE_NORMAL or StageTeamType.STAGE_ELITE
	local event = ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stageType = _teamType
	})

	self:dispatch(event)

	self._selectedPointId = nil
end

function CommonStageChapterDetailMediator:enableSectionStageBtn()
	local actionNode = self:getView():getChildByFullName("main.actionNode")
	local _btn = actionNode:getChildByName("btn_reward")
	local isOpen, tag, hasRedPoint = self._stageSystem:getSectionStageState()
	local sectionStateTab = ConfigReader:getDataByNameIdAndKey("ConfigValue", "StagePresentOrder", "content")

	if isOpen and self._stageType == StageType.kNormal then
		if #btns < 3 then
			_btn:setVisible(true)

			btns[#btns + 1] = "btn_reward"
		end

		local function callFunc()
			local view = self:getInjector():getInstance("StageProgressPopView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 180
			}, {
				tag = tag,
				mediator = self
			}))
		end

		mapButtonHandlerClick(nil, _btn, {
			func = callFunc
		})
		_btn:getChildByName("redPoint"):setVisible(hasRedPoint)

		local stageInfo = sectionStateTab[tag]

		_btn:loadTextureNormal(stageInfo.Icon .. ".png", ccui.TextureResType.plistType)
		_btn:loadTexturePressed(stageInfo.Icon .. ".png", ccui.TextureResType.plistType)

		for j = 1, 3 do
			local text = _btn:getChildByName("text" .. j)

			text:setString(Strings:get(stageInfo["Button" .. j]))
		end
	else
		_btn:setVisible(false)

		btns[3] = nil
	end

	if #btns == 2 then
		for i = 1, #btns do
			local node = actionNode:getChildByName(btns[i])

			node:setPosition(actionNode2Pos[i])
		end
	else
		for i = 1, #btns do
			local node = actionNode:getChildByName(btns[i])

			node:setPosition(actionNode3Pos[i])
		end

		if tag ~= 1 then
			_btn:offset(0, -4)
		end
	end
end

function CommonStageChapterDetailMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local sequence = cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

		storyDirector:setClickEnv("commonStageChapterDetail.btnBack", btnBack, function()
			AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
			self:onClickBack()
		end)

		for i = 0, #self._pointList - 1 do
			local cell = self._tableView:cellAtIndex(i)
			local btnName = "commonStageChapterDetail.btn_" .. i + 1

			if cell and cell.mediator and cell.mediator._img then
				local pointNode = cell.mediator
				local img_btn = pointNode._img

				storyDirector:setClickEnv(btnName, img_btn, function()
					local index = cell:getIdx() + 1

					self:onClickNextAction(index)
				end)
			else
				storyDirector:setClickEnv(btnName)
			end
		end

		for i = 1, 3 do
			local imgBox = self._starBoxPanel:getChildByFullName("bar_schedule.box_panel_" .. i .. ".img_box")

			storyDirector:setClickEnv("CommonStageChapterDetailMediator.reward" .. i, imgBox, function()
				AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
				self:onClickRewardBox(imgBox)
			end)
		end

		local btn_masterSystem = self:getView():getChildByFullName("main.actionNode.btn_heroSystem")

		storyDirector:setClickEnv("commonStageChapterDetail.btn_heroSystem", btn_masterSystem, function(sender, eventType)
			self:onGotoHeroSystem()
		end)
		storyDirector:notifyWaiting("enter_commonStageChapterDetail_view")
	end))

	self:getView():runAction(sequence)
end

function CommonStageChapterDetailMediator:enterCommonPoint(pointId)
	local data = {}

	data.mapId = self:getStageSystem():index2MapId(self._chapterIndex, self._stageType)
	data.pointId = pointId

	local view = self:getInjector():getInstance("StagePointDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function CommonStageChapterDetailMediator:enterPracticePoint(pointId)
	local data = {}

	data.pointId = pointId
	data.isPracticePoint = true

	local view = self:getInjector():getInstance("StagePointDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function CommonStageChapterDetailMediator:onClickPlayStory(pointId)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local stageSystem = self:getStageSystem()
	local chapterConfig = stageSystem:getMapConfigByIndex(self._chapterIndex, self._stageType)
	local storyLink = ConfigReader:getDataByNameIdAndKey("StoryPoint", pointId, "StoryLink")
	local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
	local storyAgent = storyDirector:getStoryAgent()

	local function endCallBack()
		local storyPoint = stageSystem:getPointById(pointId)
		local isFirst = 0

		if not storyPoint:isPass() then
			isFirst = 1

			stageSystem:requestStoryPass(pointId, function(response)
				local delegate, outSelf = {}, self

				function delegate:willClose(popupMediator, data)
					storyDirector:notifyWaiting("story_play_end")
					outSelf:refreshStoryPoint(pointId)
					outSelf:setupClickEnvs()
				end

				if pointId == "S01S01" then
					local content = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_Hero", "content")
					local id = content[1]
					local view = self:getInjector():getInstance("newHeroView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
						heroId = id
					}, delegate))
				else
					local view = self:getInjector():getInstance("getRewardView")
					local guideSystem = self:getInjector():getInstance(GuideSystem)
					local isRunGuide = guideSystem:runGuideByStage(pointId)

					if isRunGuide and guideSystem:isToHome(pointId) then
						self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
						guideSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
							maskOpacity = 0
						}, {
							rewards = response.data
						}))
					else
						self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
							maskOpacity = 0
						}, {
							rewards = response.data
						}, delegate))
					end
				end
			end, true)
		end

		local endTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
		local statisticsData = storyAgent:getStoryStatisticsData(storyLink)

		StatisticSystem:send({
			point = "plot_end",
			type = "plot_end",
			op_type = "plot_stage",
			stagetype = self._stageType,
			plot_id = storyLink,
			plot_name = storyPoint:getName(),
			id_first = isFirst,
			totaltime = endTs - startTs,
			detail = statisticsData.detail,
			amount = statisticsData.amount,
			misc = statisticsData.misc
		})
		AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)
	end

	storyAgent:setSkipCheckSave(true)

	local bagSystem = self:getDevelopSystem():getBagSystem()
	local changeNameTimes = bagSystem:getTimeRecordById(TimeRecordType.kChangeName)._time

	if storyLink == "story01_2a" and changeNameTimes == 0 then
		storyLink = {
			storyLink
		}
		storyLink[#storyLink + 1] = "story_rename"
	end

	storyAgent:trigger(storyLink, nil, endCallBack)
end

function CommonStageChapterDetailMediator:passChapterMc()
	self._delayLvPop = true

	local mc = cc.MovieClip:create("dh_tongguan")

	mc:addTo(self:getView())
	mc:setPosition(568, 320)
	AudioEngine:getInstance():playEffect("Se_Alert_Chapter_Clear", false)
	mc:addCallbackAtFrame(62, function()
		mc:removeFromParent(true)

		self._delayLvPop = false

		if self._chapterIndex == 1 then
			return
		end

		local function showNext()
			if self._chapterIndex >= #max then
				return
			end

			local chapterNextInfo = self:getStageSystem():getMapByIndex(self._chapterIndex + 1, self._stageType)
			local unlock, tips = chapterNextInfo:isUnlock()

			if unlock then
				self._chapterIndex = self._chapterIndex + 1

				self:refreshChapterView()
			end
		end

		local chapterInfo = self:getStageSystem():getMapByIndex(self._chapterIndex, self._stageType)
		local chapterConfig = self:getStageSystem():getMapConfigByIndex(self._chapterIndex, self._stageType)
		local boxRewardList = self:getStageSystem():boxReardToTable(chapterConfig.StarBoxReward)
		local boxIndex = #boxRewardList
		local curStarNum = chapterInfo and chapterInfo:getCurrentStarCount() or 0
		local chapterId = self:getStageSystem():index2MapId(self._chapterIndex, self._stageType)

		local function receiveAward()
			local function requestRewardSuc(data)
				local stageSystem = self._stageSystem
				local curChapterId = stageSystem:index2MapId(self._chapterIndex, self._stageType)

				if chapterId == curChapterId then
					local parent = self._starBoxPanel:getChildByFullName("bar_schedule.box_panel_3")
					local redPoint = parent:getChildByName("red_point")

					redPoint:setVisible(false)
				end

				local view = self:getInjector():getInstance("getRewardView")

				stageSystem:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = data,
					callback = showNext
				}))
			end

			self:getStageSystem():requestStageStarsReward(chapterId, boxRewardList[boxIndex].starNum, function(data)
				requestRewardSuc(data)
			end)
		end

		if curStarNum >= boxRewardList[boxIndex].starNum and chapterInfo and chapterInfo:getMapBoxState(boxRewardList[boxIndex].starNum) == StageBoxState.kCanReceive then
			local data = {
				guide = true,
				type = StageRewardType.kStarBox,
				state = StageBoxState.kCanReceive,
				rewardId = boxRewardList[boxIndex].rewardId,
				callback = receiveAward,
				closeback = showNext,
				extra = {}
			}

			data.extra[1] = curStarNum
			data.extra[2] = boxRewardList[boxIndex].starNum

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("StageShowRewardView"), {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, self))
		else
			showNext()
		end
	end)
end

function CommonStageChapterDetailMediator:createPushBackBoxIcon(parentNode, pos, sceneId)
	local sceneId = KShopPushPackageScene.KSTAGE_FAIL

	IconFactory:createPushBackBoxIcon(self._main, {
		160,
		420
	}, sceneId)
end
