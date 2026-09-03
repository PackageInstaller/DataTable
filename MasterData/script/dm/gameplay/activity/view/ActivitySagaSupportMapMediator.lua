-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivitySagaSupportMapMediator.lua

require("dm.gameplay.activity.model.stageModel.ActivityStageCommonCell")
require("dm.gameplay.stage.view.component.StoryStageCommonCell")
require("dm.gameplay.stage.view.component.BossStageCommonCell")

ActivitySagaSupportMapMediator = class("ActivitySagaSupportMapMediator", DmAreaViewMediator, _M)

ActivitySagaSupportMapMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivitySagaSupportMapMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local commonCellWidth = 420
local unSelectCellHeight = 69
local selectedCellHeight = 155
local onScrollState = false
local BaseChapterPath = "asset/scene/"
local choiceBtnPos = {
	{
		z = 10,
		x = -9,
		y = 19
	},
	{
		z = 20,
		x = 25,
		y = -40
	},
	{
		z = 30,
		x = 56,
		y = 1
	}
}
local lineGradiantVec = {
	{
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(161, 182, 238, 255)
		}
	},
	{
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(201, 161, 238, 255)
		}
	},
	{
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 153, 153, 255)
		}
	}
}
local stageType_index = {
	[StageType.kNormal] = 1,
	[StageType.kElite] = 2,
	[StageType.kHard] = 3
}
local stageType_name = {
	{
		"STAGE_DIFFICULTY_NORMAL",
		StageType.kNormal,
		"Change_Fire_Normal_Tips"
	},
	{
		"STAGE_DIFFICULTY_ELITE",
		StageType.kElite,
		"Change_Fire_Crazy_Tips"
	},
	{
		"STAGE_DIFFICULTY_HARD",
		StageType.kHard,
		"Change_Fire_Hard_Tips"
	}
}
local kBtnHandlers = {
	["main.actionNode.btn_heroSystem"] = {
		func = "onGotoHeroSystem"
	},
	["main.actionNode.btn_emBattle"] = {
		func = "onClickEmBattle"
	},
	["main.actionNode.btn_stage"] = {
		func = "onClickChangeStageStype"
	}
}
local stageBtnImg = {
	[ActivityType_UI.kActivityBlockZuoHe] = {
		[StageType.kNormal] = "zx_btn_fhj_ndqh.png",
		[StageType.kElite] = "zx_btn_fhj_ndqh.png"
	},
	[ActivityType_UI.kActivityBlockSummer] = {
		[StageType.kNormal] = "xh_btn_xigua_jd.png",
		[StageType.kElite] = "xh_btn_paobing_jd.png"
	},
	[ActivityType_UI.kActivityWxh] = {
		[StageType.kNormal] = "zx_btn_wxh_1.png",
		[StageType.kElite] = "zx_btn_wxh_1.png"
	},
	[ActivityType_UI.KActivityBlockDetetive] = {
		[StageType.kNormal] = "ywzjdzx_btn_jdnd.png",
		[StageType.kElite] = "ywzjdzx_btn_jdnd2.png"
	}
}

function ActivitySagaSupportMapMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ActivitySagaSupportMapMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(1001)

	local config = {
		style = 1,
		currencyInfo = self._model:getActivityConfig().ResourcesBanner,
		title = Strings:get(self._model:getTitle()),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.dismiss, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function ActivitySagaSupportMapMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	if not self._activity then
		return
	end

	self._blockActivityId = data.blockActivityId
	self._model = self._activity:getBlockMapActivity(self._blockActivityId)

	if not self._model then
		self:tryEnterSupport()

		return
	end

	self._data = data or {}
	self._stageType = self._data.stageType or StageType.kNormal
	self._useThreeChoice = self._data.useThreeChoice or false
	self._mapId = self._model:getMapIdByStageType(self._stageType)

	self:initWidget()
	self:setupTopInfoWidget()
	self:refreshStageType()
	self:setChapterTitle()
	self:initStage()
	self:initThreeChoiceLogic()
	self:createTableView()
	self:setScrollPoint()
	self:initRewardBox()
	self:setAdditionHero()
	self:refreshStarBoxPanel()
	self:playBackGroundMusic()
end

function ActivitySagaSupportMapMediator:tryEnterSupport()
	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = Strings:get("Activity_Saga_UI_2")
	}))
	self:dismiss()
end

function ActivitySagaSupportMapMediator:resumeWithData(data)
	self._model = self._activity:getBlockMapActivity(self._blockActivityId)

	if not self._model then
		self:tryEnterSupport()

		return
	end

	local pointIndex = table.indexof(self._pointList, self._selectPointId)

	if pointIndex then
		local map = self._model:getStageByStageType(self._stageType)
		local enterBattlePoint = map:getPointById(self._selectPointId)
		local nextPointId = self._pointList[pointIndex + 1]
		local nextPoint = map:getPointById(nextPointId)

		if enterBattlePoint:isPass() and nextPoint and nextPoint:isUnlock() and not nextPoint:isPass() then
			self._selectPointId = nextPointId
		end
	end

	self:initStage()
	self:initThreeChoiceLogic()
	self:initThreeChoiceLogic()
	self._tableView:reloadData()
	self:setScrollPoint()
	self:refreshStarBoxPanel()
	self:playBackGroundMusic()

	for k, v in pairs(self._bossPointView) do
		local point = chapterInfo:getPointById(k)

		v:refreshState(nil, point:isUnlock(), point:isPass())
		v:reloadBar()
	end
end

function ActivitySagaSupportMapMediator:playBackGroundMusic()
	local chapterInfo = self._model:getStageByStageType(self._stageType)
	local chapterConfig = chapterInfo:getConfig()

	AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)
end

function ActivitySagaSupportMapMediator:setAdditionHero()
	local btns = self._activity:getButtonConfig()

	if btns.blockParams and btns.blockParams.heroes then
		local length = #btns.blockParams.heroes

		for i = 1, length do
			local id = btns.blockParams.heroes[i]
			local icon = IconFactory:createHeroIconForReward({
				star = 0,
				id = id
			})

			icon:addTo(self._stageRewardsPanel):setScale(0.5)

			local x = (i - 1) * 65 + 5

			icon:setPositionX(x)

			local image = ccui.ImageView:create("jjc_bg_ts_new.png", 1)

			image:addTo(icon):posite(92, 20):setScale(1.2)
		end
	end

	self._stageAdditionPanel:setContentSize(cc.size(#btns.blockParams.heroes * 65 + 65, 70))
end

function ActivitySagaSupportMapMediator:setChapterTitle()
	local chapterInfo = self._model:getStageByStageType(self._stageType)
	local chapterConfig = chapterInfo:getConfig()

	if chapterConfig then
		self._textContent:setString(Strings:get(chapterConfig.MapName))

		local bgPanel = self:getView():getChildByFullName("main.bg")

		bgPanel:removeAllChildren()

		local test = ConfigReader:getRecordById("BackGroundPicture", chapterConfig.Background)
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

function ActivitySagaSupportMapMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._stagePanel = self:getView():getChildByFullName("main.stagePanel")

	self._stagePanel:setLocalZOrder(2)

	self._cloneCell = self:getView():getChildByName("clone_cell")
	self._storyCell = self:getView():getChildByFullName("storyPoint_cell")
	self._textContent = self:getView():getChildByFullName("main.titleContent")
	self._starBoxPanel = self:getView():getChildByName("star_panel")
	self._stageTypeView = self:getView():getChildByFullName("main.stageType")
	self._stageAdditionPanel = self:getView():getChildByFullName("main.stageAddition")
	self._starAdditionPanel = self:getView():getChildByFullName("main.starAddPanel")
	self._Image_2 = self:getView():getChildByFullName("main.Image_2")

	if self._Image_2 then
		self._Image_2:setVisible(false)
	end

	self._heroSystemBtn = self._main:getChildByFullName("actionNode.btn_heroSystem")
	self._emBattleBtn = self._main:getChildByFullName("actionNode.btn_emBattle")
	self._stageTypeBtn = self._main:getChildByFullName("actionNode.btn_stage")
	self._choicePanel = self._main:getChildByFullName("actionNode.choicePanel")
	self._heroSystemBtnX = self._heroSystemBtn:getPositionX()
	self._emBattleBtnX = self._emBattleBtn:getPositionX()
	self._stageTypeBtnX = self._stageTypeBtn:getPositionX()
	self._stageRewardsPanel = self:getView():getChildByFullName("main.stageAddition.stageRewards")

	for i = 1, 3 do
		self._stageTypeBtn:getChildByName("Text" .. i):enableOutline(cc.c4b(0, 0, 0, 204), 1)
	end

	self._pointSlider = self._main:getChildByName("Slider")

	self._pointSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			self:onSliderChanged()
		end
	end)
	self._stageAdditionPanel:addClickEventListener(function()
		self:onClickAditionButton()
	end)

	local emBattleText29 = self:getView():getChildByFullName("main.actionNode.btn_emBattle.Text_2")
	local emBattleText5 = self:getView():getChildByFullName("main.actionNode.btn_emBattle.Text_3")
	local emBattleText2 = self:getView():getChildByFullName("main.actionNode.btn_heroSystem.Text_29")
	local emBattleText3 = self:getView():getChildByFullName("main.actionNode.btn_heroSystem.Text_5")
	local stagetext1 = self:getView():getChildByFullName("main.actionNode.btn_stage.Text1")
	local stagetext3 = self:getView():getChildByFullName("main.actionNode.btn_stage.Text3")
	local stagetext2 = self:getView():getChildByFullName("main.actionNode.btn_stage.Text2")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		stagetext2:setVisible(false)
		emBattleText3:setVisible(false)
		emBattleText5:setVisible(false)
		emBattleText2:setPosition(cc.p(62, 37.71))
		emBattleText29:setPosition(cc.p(62, 37.71))
		stagetext1:setPosition(cc.p(62, 37.71))
		stagetext3:setPosition(cc.p(62, 16.71))
		stagetext1:setFontSize(22)
		stagetext3:setFontSize(22)
		emBattleText29:setFontSize(24)
		emBattleText2:setFontSize(24)
		self:getView():getChildByFullName("main.actionNode.btn_heroSystem.Text_6"):setVisible(false)
		self:getView():getChildByFullName("main.actionNode.btn_emBattle.Text_4"):setVisible(false)
		self:getView():getChildByFullName("main.actionNode.btn_stage.Text_En"):setVisible(false)
	end

	self._starAdditionPanel:addClickEventListener(function()
		self:onClickAditionButton()
	end)

	if self._useThreeChoice then
		for i = 1, 3 do
			local nameText = self._choicePanel:getChildByFullName("Panel_" .. i .. ".nameText")
			local map = self._model:getStageByStageType(stageType_name[i][2])

			nameText:setString(Strings:get(map:getConfig().MapName))
			nameText:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec[i], {
				x = 0,
				y = -1
			}))

			local touchPanel = self._choicePanel:getChildByFullName("Panel_" .. i .. ".touchPanel")

			touchPanel:setTouchEnabled(true)
			touchPanel:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.SliderEventType.percentChanged then
					self:onClickThreeChangeStage(sender)
				end
			end)
		end

		local selectPane = self._choicePanel:getChildByFullName("Panel_4")

		selectPane:setPosition(cc.p(choiceBtnPos[3].x, choiceBtnPos[3].y))
		selectPane:setLocalZOrder(choiceBtnPos[3].z)
	end
end

function ActivitySagaSupportMapMediator:updataStageBtnImg()
	if self._activity and self._useThreeChoice == false then
		local imgName

		if stageBtnImg[self._activity:getUI()] then
			imgName = stageBtnImg[self._activity:getUI()][self._stageType]
		elseif self._model:getActivityConfig().ChangeBtnImg then
			imgName = self._model:getActivityConfig().ChangeBtnImg[self._stageType]
		end

		if imgName then
			self._stageTypeBtn:loadTextures(imgName, imgName, imgName, ccui.TextureResType.plistType)
		end
	end

	self._stageTypeBtn:setVisible(self._model:getStageByStageType(StageType.kElite) and true or false)
	self._heroSystemBtn:setPositionX((self._stageTypeBtn:isVisible() or nil) and (self._heroSystemBtnX or self._heroSystemBtnX - 100))
	self._emBattleBtn:setPositionX((self._stageTypeBtn:isVisible() or nil) and (self._emBattleBtnX or self._emBattleBtnX - 100))
end

function ActivitySagaSupportMapMediator:refreshStageType()
	self._stageTypeView:setString(Strings:get(stageType_name[stageType_index[self._stageType]][1]))

	self._activitySystem.curStageType = self._stageType
end

function ActivitySagaSupportMapMediator:switchMainScene()
	self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "mainScene", nil, nil))
end

function ActivitySagaSupportMapMediator:onSliderChanged()
	local percent = self._pointSlider:getPercent()
	local maxOffset = self._tableView:minContainerOffset().y

	onScrollState = true

	self._tableView:setContentOffset(cc.p(0, maxOffset * (1 - percent * 0.01)), false)

	onScrollState = false
end

function ActivitySagaSupportMapMediator:initStage()
	local map = self._model:getActivityMapById(self._mapId)
	local mapConfig = map:getConfig()
	local storyPoints = map:getStoryPoints()

	self._pointList = {}
	self._storyPointView = {}
	self._bossPointView = {}

	for _, point in ipairs(map._index2Points) do
		self._pointList[#self._pointList + 1] = point:getId()
	end

	self._storyPointList = storyPoints

	self:storySort(self._storyPointList)

	for k, storyPoint in ipairs(self._storyPointList) do
		self:createStoryPointNode(k, storyPoint:getId())
	end

	local enterBattlePointId = self._data.enterBattlePointId

	if enterBattlePointId then
		local pointIndex = table.indexof(self._pointList, enterBattlePointId)

		if pointIndex then
			local enterBattlePoint = map:getPointById(enterBattlePointId)
			local nextPointId = self._pointList[pointIndex + 1]
			local nextPoint = map:getPointById(nextPointId)

			self._selectPointId = enterBattlePoint:isPass() and nextPoint and nextPoint:isUnlock() and not nextPoint:isPass() and nextPointId or enterBattlePointId
		else
			self._selectPointId = enterBattlePointId
		end

		self._data.enterBattlePointId = nil
	else
		for _, _pointId in ipairs(self._pointList) do
			local _point = map:getPointById(_pointId)

			if _point:isUnlock() and not _point:isPass() then
				self._selectPointId = _pointId
			end
		end
	end

	self:updataStageBtnImg()
	self._starAdditionPanel:setVisible(false)

	local isHeroAttrSatrExtra = self._model:isHeroAttrStarExtra()

	if isHeroAttrSatrExtra then
		-- block empty
	end
end

function ActivitySagaSupportMapMediator:storySort(tab)
	table.sort(tab, function(a, b)
		local storyPointA = a:isPass() and 1 or 0
		local storyPointB = b:isPass() and 1 or 0
		local storyPointConfigA = ConfigReader:getRecordById("ActivityStoryPoint", a:getId())
		local storyPointConfigB = ConfigReader:getRecordById("ActivityStoryPoint", b:getId())

		if storyPointA == storyPointB then
			if self._stageType == StageType.kNormal then
				return storyPointConfigA.Location[2] < storyPointConfigB.Location[2]
			else
				return storyPointConfigA.Location[2] > storyPointConfigB.Location[2]
			end
		end

		return storyPointB < storyPointA
	end)
end

local tempPos = {
	NORMAL = {
		cc.p(218, 320),
		cc.p(218, 370)
	},
	ELITE = {
		cc.p(190, 500),
		cc.p(470, 500)
	}
}

function ActivitySagaSupportMapMediator:createBossPointNode(index, pointData)
	local point = pointData
	local pointId = point:getId()

	if self._bossPointView[pointId] == nil then
		local view = cc.Node:create()
		local touchPanel = ccui.Layout:create()

		touchPanel:setContentSize(cc.size(130, 40))
		touchPanel:setTouchEnabled(true)
		touchPanel:setAnchorPoint(0.5, 0.5)
		touchPanel:setPosition(0, 0)
		touchPanel:addTo(view)

		local pointNode = BossStageCommonCell:new(view, {
			mediator = self,
			point = pointData,
			index = index
		})

		local function callFunc()
			self:enterCommonPoint(pointId)
		end

		mapButtonHandlerClick(nil, touchPanel, {
			func = callFunc
		})

		local posTab = tempPos[self._stageType]

		view:addTo(self._main):setPosition(posTab[index])

		self._bossPointView[pointId] = pointNode

		pointNode:refreshState(point:getState(), point:isUnlock(), point:isPass())
	else
		self._bossPointView[pointId]:refreshState(nil, point:isUnlock(), point:isPass())
	end
end

function ActivitySagaSupportMapMediator:createStoryPointNode(index, pointId)
	local map = self._model:getActivityMapById(self._mapId)
	local storyPointConfig = ConfigReader:getRecordById("ActivityStoryPoint", pointId)
	local storyPoint = map:getStoryPointById(pointId)

	if self._storyPointView[pointId] == nil then
		local pointIdCell = self._main:getChildByName(pointId)

		if pointIdCell then
			pointIdCell:removeFromParent()
		end

		local cell = self._storyCell:clone()
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

		if self._stageType == StageType.kNormal then
			cell:addTo(self:getView():getChildByName("main")):setPosition(568 + storyPointConfig.Location[1], 70 + (index - 1) * 50)
		else
			cell:addTo(self:getView():getChildByName("main")):setPosition(568 + storyPointConfig.Location[1], 350 - (index - 1) * 50)
		end

		if self._useThreeChoice then
			cell:setPositionX(600 + storyPointConfig.Location[1])
		end

		cell:setName(pointId)
		cell:setLocalZOrder(1)

		self._storyPointView[pointId] = pointNode

		pointNode:refreshViewWithState(storyPoint:getState(), storyPoint:isUnlock(), storyPoint:isPass())
	else
		self._storyPointView[pointId]:refreshViewWithState(nil, storyPoint:isUnlock(), storyPoint:isPass())
	end

	if not storyPoint:getIsHidden() and not storyPoint:isPass() and storyPointConfig.IsHide ~= 1 then
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

function ActivitySagaSupportMapMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(402, 419))

	local function numberOfCells(view)
		return #self._pointList
	end

	local function cellTouched(table, cell)
		local index = cell:getIdx() + 1

		self:onClickNextAction(index)
	end

	local function cellSize(table, idx)
		local pointId = self._pointList[idx + 1]

		if pointId == self._selectPointId then
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
		local cell
		local pointId = self._pointList[index]

		cell = pointId == self._selectPointId and table:dequeueCellByTag(843) or table:dequeueCellByTag(348)

		if not cell then
			cell = cc.TableViewCell:new()

			local cellView = self._cloneCell:clone()

			cellView:setVisible(true)
			cellView:setAnchorPoint(cc.p(0.5, 1))
			cellView:setName("cellView")

			if pointId == self._selectPointId then
				cell:setTag(843)
				cellView:setPosition(cc.p(210, 145))
				cellView:addTo(cell)
			else
				cell:setTag(348)
				cellView:setPosition(cc.p(210, 78))
				cellView:addTo(cell)
			end

			cell.mediator = ActivityStageCommonCell:new(cellView, {
				model = self._model
			})
		end

		cell.mediator:refreshData(pointId)
		cell.mediator:setCellState(self._selectPointId, pointId)
		cell.mediator:setHiddenStory(self:checkShowHiddenStory(pointId))

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

function ActivitySagaSupportMapMediator:checkShowHiddenStory(pointId)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()
	local pointInfo, pointType = self._model:getPointById(pointId)
	local map = self._model:getActivityMapById(self._mapId)

	if pointType == kStageTypeMap.point then
		local hiddenStory = pointInfo:getHiddenStory()

		for link, v in pairs(hiddenStory) do
			local storyPointConfig = ConfigReader:getRecordById("ActivityStoryPoint", link)
			local storyPoint = map:getStoryPointById(link)

			return storyPoint:isPass()
		end
	end

	return true
end

function ActivitySagaSupportMapMediator:initRewardBox()
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

function ActivitySagaSupportMapMediator:onClickRewardBox(sender)
	local chapterInfo = self._model:getStageByStageType(self._stageType)
	local chapterConfig = chapterInfo:getConfig()
	local boxRewardList = self:boxReardToTable(chapterConfig.StarBoxReward)
	local index = sender:getTag()
	local boxNum = #boxRewardList
	local boxIndex = index - (3 - boxNum)
	local curStarNum = chapterInfo and chapterInfo:getCurrentStarCount() or 0

	local function receiveAward()
		local function requestRewardSuc(data)
			if checkDependInstance(self) then
				local view = self:getInjector():getInstance("getRewardView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					maskOpacity = 0
				}, {
					rewards = data.reward
				}))
			end
		end

		self._activitySystem:requestDoChildActivity(self._activity:getId(), self._model:getId(), {
			doActivityType = 105,
			type = litTypeMap[self._stageType],
			mapId = self._mapId,
			star = boxRewardList[boxIndex].starNum
		}, function(data)
			sender:getParent():getChildByName("red_point"):setVisible(false)

			local map = self._model:getActivityMapById(self._mapId)
			local rsData = data.data

			map:setMapBoxReceived(rsData.star)
			requestRewardSuc(rsData)
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

function ActivitySagaSupportMapMediator:refreshStarBoxPanel()
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

	local chapterInfo = self._model:getStageByStageType(self._stageType)
	local chapterConfig = chapterInfo:getConfig()
	local boxPanel = {}
	local starBar = self._starBoxPanel:getChildByName("bar_schedule")

	for i = 1, 3 do
		boxPanel[i] = starBar:getChildByName("box_panel_" .. i)
	end

	if chapterConfig then
		local boxRewardList = self:boxReardToTable(chapterConfig.StarBoxReward)
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
	end
end

function ActivitySagaSupportMapMediator:boxReardToTable(boxReward)
	local tab = {}

	if not boxReward then
		return tab
	end

	for k, v in pairs(boxReward) do
		local item = {}

		item.starNum = tonumber(k)
		item.rewardId = v

		table.insert(tab, item)
	end

	table.sort(tab, function(t1, t2)
		if t1.starNum <= t2.starNum then
			return true
		else
			return false
		end
	end)

	return tab
end

function ActivitySagaSupportMapMediator:refreshStagePoint()
	if not self._tableView or onScrollState then
		return
	end

	local offY = self._tableView:getContentOffset().y
	local maxOffset = self._tableView:minContainerOffset().y
	local percent = math.abs(offY / maxOffset)

	self._pointSlider:setPercent(100 - percent * 100)
end

function ActivitySagaSupportMapMediator:onGotoHeroSystem()
	local view = self:getInjector():getInstance("HeroShowListView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view))
end

function ActivitySagaSupportMapMediator:onClickEmBattle()
	self._activitySystem:enterTeam(self._activityId, self._model)
end

function ActivitySagaSupportMapMediator:setScrollPoint()
	if #self._pointList < 5 then
		self._pointSlider:setVisible(false)

		return
	else
		self._pointSlider:setVisible(true)

		local curPointIndex = table.indexof(self._pointList, self._selectPointId) or 1

		if curPointIndex > 5 then
			local offset = unSelectCellHeight * (curPointIndex - 1)
			local minOffset = self._tableView:minContainerOffset().y

			self._tableView:setContentOffset(cc.p(0, offset + minOffset), false)
		end
	end
end

function ActivitySagaSupportMapMediator:onClickNextAction(index)
	local tag = index
	local pointId = self._pointList[tag]
	local pointInfo, pointType = self._model:getPointById(pointId)

	if not pointInfo:isUnlock() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:find("Lock2")
		}))

		return
	end

	if self._selectPointId ~= pointId then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		self._selectPointId = pointId

		self._tableView:reloadData()
		self:setScrollPoint()
	else
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if pointType == kStageTypeMap.point then
			local openTime = pointInfo:getConfig().PointTime
			local curTime = self._gameServerAgent:remoteTimestamp()

			if openTime and openTime.start then
				local startTime = TimeUtil:formatStrToRemoteTImestamp(openTime.start)

				if curTime < startTime then
					local date = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", startTime)

					self:dispatch(ShowTipEvent({
						duration = 0.2,
						tip = Strings:get("Newyear_ActivityStage_OpenTimeTip", {
							time = date
						})
					}))

					return
				end
			end

			self:enterCommonPoint(pointId)
		elseif pointType == kStageTypeMap.StoryPoint then
			self:onClickPlayStory(pointId)
		end
	end
end

function ActivitySagaSupportMapMediator:enterCommonPoint(pointId)
	local data = {
		parent = self,
		pointId = pointId,
		activityId = self._activityId
	}
	local view = self:getInjector():getInstance("ActivityPointDetailView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
end

function ActivitySagaSupportMapMediator:onClickPlayStory(pointId, isCheck)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local chapterInfo = self._model:getStageByStageType(self._stageType)
	local chapterConfig = chapterInfo:getConfig()
	local storyLink = ConfigReader:getDataByNameIdAndKey("ActivityStoryPoint", pointId, "StoryLink")
	local startTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
	local storyAgent = storyDirector:getStoryAgent()

	local function endCallBack()
		local storyPoint = chapterInfo:getStoryPointById(pointId)
		local isFirst = 0

		if not storyPoint:isPass() then
			isFirst = 1

			self._activitySystem:requestDoChildActivity(self._activity:getId(), self._model:getId(), {
				doActivityType = 106,
				pointId = pointId
			}, function(response)
				local delegate, outSelf = {}, self

				function delegate:willClose(popupMediator, data)
					storyDirector:notifyWaiting("story_play_end")
					outSelf:refreshStoryPoint(pointId)

					local chapterInfo = outSelf._model:getStageByStageType(outSelf._stageType)

					for k, v in pairs(outSelf._bossPointView) do
						local point = chapterInfo:getPointById(k)

						v:refreshState(nil, point:isUnlock(), point:isPass())
					end
				end

				local view = self:getInjector():getInstance("getRewardView")

				if not response.data.reward then
					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						maskOpacity = 0
					}, {
						rewards = response.data.reward
					}, delegate))
				end
			end)
		end

		AudioEngine:getInstance():playBackgroundMusic(chapterConfig.BGM)

		local endTs = self:getInjector():getInstance(GameServerAgent):remoteTimeMillis()
		local statisticsData = storyAgent:getStoryStatisticsData(storyLink)

		StatisticSystem:send({
			type = "plot_end",
			op_type = "plot_activity",
			point = "plot_end",
			activityid = self._activity:getTitle(),
			plot_id = storyLink,
			plot_name = storyPoint:getName(),
			id_first = isFirst,
			totaltime = endTs - startTs,
			detail = statisticsData.detail,
			amount = statisticsData.amount,
			misc = statisticsData.misc
		})
	end

	storyAgent:setSkipCheckSave(not isCheck)
	storyAgent:trigger(storyLink, function()
		AudioEngine:getInstance():stopBackgroundMusic()
	end, endCallBack)
end

function ActivitySagaSupportMapMediator:refreshStoryPoint(pointId)
	self:storySort(self._storyPointList)

	for pId, pNode in pairs(self._storyPointView) do
		local storyPointConfig = ConfigReader:getRecordById("ActivityStoryPoint", pId)

		for index, pointCell in pairs(self._storyPointList) do
			if pNode:getPoint() == pointCell then
				if self._stageType == StageType.kNormal then
					pNode:getView():setPosition(cc.p(568 + storyPointConfig.Location[1], 70 + (index - 1) * 50))
				else
					pNode:getView():setPosition(cc.p(568 + storyPointConfig.Location[1], 350 - (index - 1) * 50))
				end
			end
		end
	end

	for pId, pNode in pairs(self._storyPointView) do
		local storyPoint = self._model:getPointById(pId)

		pNode:refreshViewWithState(nil, storyPoint:isUnlock(), storyPoint:isPass())
	end

	local selectIndex = table.indexof(self._pointList, pointId)

	table.removebyvalue(self._pointList, pointId)

	self._selectPointId = self._pointList[selectIndex]

	self._tableView:reloadData()
	self:setScrollPoint()
end

function ActivitySagaSupportMapMediator:onClickChangeStageStype()
	local toStageType, tips

	if self._stageType == StageType.kNormal then
		toStageType = StageType.kElite
		tips = Strings:get("Change_Crazy_Tips")
	else
		toStageType = StageType.kNormal
		tips = Strings:get("Change_Normal_Tips")
	end

	local lockTip = Strings:get("Activity_Stage_Type_Switch_Tips")

	self:changeStagetype(toStageType, tips, lockTip)
end

function ActivitySagaSupportMapMediator:changeStagetype(toStageType, tips, lockTip)
	local map = self._model:getStageByStageType(toStageType)
	local mapPoints = map._index2Points
	local firstPoint = mapPoints[1]
	local startTime = firstPoint:getConfig().PointTime

	if startTime and startTime.start then
		local timeStr = startTime.start
		local timeStrTab = string.split(timeStr, " ")
		local _tab1 = TimeUtil:parseDate(nil, timeStrTab[1])
		local _tab2 = TimeUtil:parseTime(nil, timeStrTab[2])

		for k, v in pairs(_tab2) do
			_tab1[k] = v
		end

		local timeStemp = TimeUtil:getTimeByDateForTargetTime(_tab1)
		local curTimeStemp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

		if curTimeStemp < timeStemp then
			local remoteTime = TimeUtil:formatStrToRemoteTImestamp(startTime.start)
			local localDate = TimeUtil:localDate("%Y.%m.%d  %H:%M:%S", remoteTime)
			local tip = Strings:get("EMap_TimeLimit_Tips", {
				time = localDate
			})

			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = (toStageType == StageType.kHard or nil) and Strings:get("HMap_TimeLimit_Tips", {
					time = localDate
				})
			}))

			return
		end
	end

	if map:isUnlock() then
		self._mapId = map:getMapId()
		self._stageType = toStageType
		self._selectPointId = nil

		for _, v in pairs(self._storyPointView) do
			v:getView():removeFromParent()
		end

		for _, v in pairs(self._bossPointView) do
			v:getView():removeFromParent()
			v:dispose()
		end

		self:refreshStageType()
		self:setChapterTitle()
		self:initStage()
		self:initThreeChoiceLogic()
		self._tableView:reloadData()
		self:setScrollPoint()
		self:refreshStarBoxPanel()
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = lockTip
		}))
	end
end

function ActivitySagaSupportMapMediator:onClickAditionButton()
	if not self._model then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local rules = self._model:getActivityConfig().BonusHeroDesc

	self._activitySystem:showActivityRules(rules)
end

function ActivitySagaSupportMapMediator:initThreeChoiceLogic()
	if self._useThreeChoice == false then
		self._choicePanel:setVisible(false)

		return
	end

	self._heroSystemBtn:setPositionX(263)
	self._emBattleBtn:setPositionX(386)
	self._choicePanel:setVisible(true)
	self._stageTypeBtn:setVisible(false)

	local selectIndex = stageType_index[self._stageType]
	local pos_index = 1

	for i = 1, 3 do
		local basePane = self._choicePanel:getChildByFullName("Panel_" .. i)

		if selectIndex == i then
			basePane:setVisible(false)
		else
			basePane:setVisible(true)
			basePane:setPosition(cc.p(choiceBtnPos[pos_index].x, choiceBtnPos[pos_index].y))
			basePane:setLocalZOrder(choiceBtnPos[pos_index].z)

			pos_index = pos_index + 1
		end
	end

	local selectNameText = self._choicePanel:getChildByFullName("Panel_4.nameText")
	local map = self._model:getStageByStageType(self._stageType)

	selectNameText:setString(Strings:get(map:getConfig().MapName))
end

function ActivitySagaSupportMapMediator:onClickThreeChangeStage(sender)
	local tag = sender:getTag()
	local selectIndex = stageType_index[self._stageType]

	if selectIndex == tag then
		return
	end

	local toStageType = stageType_name[tag][2]
	local tips = Strings:get(stageType_name[tag][3])
	local lockTip = Strings:get("ActivityBlock_UI_26")

	self:changeStagetype(toStageType, tips, lockTip)
end
