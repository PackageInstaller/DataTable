-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/CommonStageMainViewMediator.lua

require("dm.gameplay.stage.view.component.ChapterCommonCell")

CommonStageMainViewMediator = class("CommonStageMainViewMediator", DmAreaViewMediator, _M)

CommonStageMainViewMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
CommonStageMainViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CommonStageMainViewMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
CommonStageMainViewMediator:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")
CommonStageMainViewMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kChapterMapSize = {
	1620,
	1800,
	1722,
	2055,
	1750,
	1650,
	1700,
	2185,
	2287,
	2300,
	2181,
	2589
}
local kChapterOffSetL = {
	1324,
	2584,
	3261,
	4240,
	4975,
	6133,
	6563,
	7910,
	8343,
	9962,
	10317,
	11400,
	12140,
	13290,
	14045,
	15500,
	16200,
	17900,
	18600,
	19900,
	20500,
	22600,
	24000
}
local kChapterOffSetR = {
	-10,
	863,
	1289,
	2481,
	2921,
	4102,
	4902,
	6322,
	6898,
	7950,
	8648,
	9531,
	10240,
	11711,
	12118,
	13618,
	14218,
	16000,
	16800,
	18000,
	18500,
	20700,
	21000
}
local isOnScroll = false
local isClose = false
local EVENT_REFRESH_COOPERATE_STATE = "EVENT_REFRESH_COOPERATE_STATE"
local kBtnHandlers = {
	leftBox = {
		func = "onGoLeft"
	},
	rightBox = {
		func = "onGoRight"
	}
}

StageMapUI = {
	chapter9 = "ChapterNightCell",
	chapter8 = "ChapterEightCell",
	chapter12 = "ChapterTwelveCell",
	chapter5 = "ChapterFiveCell",
	chapter6 = "ChapterSixCell",
	chapter3 = "ChapterThreeCell",
	chapter11 = "ChapterElevenCell",
	chapter4 = "ChapterFourCell",
	chapter1 = "ChapterOneCell",
	chapter2 = "ChapterTwoCell",
	chapter10 = "ChapterTenCell",
	chapter7 = "ChapterSevenCell"
}
EliteStageMapUI = {
	chapter9 = "EliteNightCell",
	chapter8 = "EliteEightCell",
	chapter12 = "EliteTwelveCell",
	chapter5 = "EliteFiveCell",
	chapter6 = "EliteSixCell",
	chapter3 = "EliteThreeCell",
	chapter11 = "EliteElevenCell",
	chapter4 = "EliteFourCell",
	chapter1 = "EliteOneCell",
	chapter2 = "EliteTwoCell",
	chapter10 = "EliteTenCell",
	chapter7 = "EliteSevenCell"
}

local clipNodePos = {
	[StageType.kNormal] = cc.p(0, 0),
	[StageType.kElite] = cc.p(30, 31)
}
local lightNodePos = {
	[StageType.kNormal] = cc.p(0, 0),
	[StageType.kElite] = cc.p(-33, -30)
}
local adjustLinePos = {
	[StageType.kNormal] = cc.p(58, 62),
	[StageType.kElite] = cc.p(66, 70)
}

function CommonStageMainViewMediator:initialize()
	super.initialize(self)
end

function CommonStageMainViewMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function CommonStageMainViewMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_REFRESH_INVITELIST, self, self.refreshInviteListView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_INVITE, self, self.refreshInviteListView)
	self.mapEventListener(self, self:getEventDispatcher(), EVENT_REFRESH_COOPERATE_STATE, self, self.setupCooperateBossShow)
end

function CommonStageMainViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	self._sharedInjector = self:getInjector()

	self:setupTopInfoWidget()
end

function CommonStageMainViewMediator:onRemove()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.onRemove(self)
end

function CommonStageMainViewMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(1299)

	local currencyInfo = {}
	local config = {
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}

	self._topInfoWidget = self:autoManageObject(self._sharedInjector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self._topInfoWidget:hideTitle()
end

function CommonStageMainViewMediator:enterWithData(data)
	isOnScroll = false
	isClose = false
	self._asyncLoadTexture = false
	self._data = data
	self._stageType = data and data.stageType and data.stageType or StageType.kNormal
	self._curChapter = 1
	self._stageCount = self:getStageSystem():getStageCount(self._stageType)
	self._winSize = cc.Director:getInstance():getWinSize()

	self:initWidget()
	self:enableRedPoint()
	self:refreshStageType()
	self:createTableView()
	self:getChapterIndex(false, true)
	self:initBottomSlider()
	self:refreshInviteListView()

	if data.chapterId then
		local chapterIndex = self:getStageSystem():mapId2Index(data.chapterId, data.stageType)

		self:enterChapterDetailView(chapterIndex, data.pointId, data.stageType)
	end

	self:setupClickEnvs()
end

function CommonStageMainViewMediator:refreshInviteListView()
	local state = self._cooperateBossSystem:getcooperateBossState()

	if kCooperateBossState.kStart == state then
		local function callback()
			self:dispatch(Event:new(EVENT_REFRESH_COOPERATE_STATE))
		end

		self._cooperateBossSystem:requestGetInviteInfo(callback)
	end
end

function CommonStageMainViewMediator:resumeWithData()
	isOnScroll = false
	isClose = false

	self:enableRedPoint()

	local contentData = self:getStageSystem():getContentData()

	if self._stageType == StageType.kNormal then
		self._lightBtn:getChildByName("redPoint"):setVisible(#self._tabElite > 0)
		self._darkBtn:getChildByName("redPoint"):setVisible(#self._tabNormal > 0)
	else
		self._lightBtn:getChildByName("redPoint"):setVisible(#self._tabNormal > 0)
		self._darkBtn:getChildByName("redPoint"):setVisible(#self._tabElite > 0)
	end

	local newMapChecker = self:getStageSystem():getNewMapUnlockIndex(self._stageType)

	self:getChapterIndex()

	if newMapChecker >= self._curChapter and contentData and contentData.tabOffX then
		self._tableView:setContentOffset(cc.p(contentData.tabOffX - 1, 0), false)
		self._tableView:setContentOffset(cc.p(contentData.tabOffX, 0), false)
	end

	self:refreshCanShow()

	local bgPanel = ccui.Layout:create()

	bgPanel:setTouchEnabled(true)
	bgPanel:setContentSize(self._winSize)
	bgPanel:setAnchorPoint(cc.p(0.5, 0.5))
	bgPanel:setPosition(cc.p(568, 320))
	bgPanel:setLocalZOrder(99999)
	bgPanel:addTo(self:getView())
	performWithDelay(self:getView(), function()
		bgPanel:removeFromParent(true)
	end, 0.3)
	self:setupCooperateBossShow()
	self:setupClickEnvs()
end

function CommonStageMainViewMediator:initWidget()
	self._main = self:getView():getChildByName("main")
	self._blockCloud = self:getView():getChildByName("Image_Cloud")

	self._blockCloud:setLocalZOrder(1000)
	AdjustUtils.ignorSafeAreaRectForNode(self._blockCloud, AdjustUtils.kAdjustType.Right)

	self._commonBg = self:getView():getChildByName("chapter_commonBg")
	self._eliteBg = self:getView():getChildByName("chapter_eliteBg")

	self._commonBg:getChildByFullName("Image_1"):loadTexture("asset/scene/main_img_zxxz02.jpg", ccui.TextureResType.localType)
	self._eliteBg:getChildByFullName("image"):loadTexture("asset/scene/zx_jy_bg.jpg", ccui.TextureResType.localType)

	self._eliteEffectPanel = self._main:getChildByName("eliteEffectPanel")

	self._eliteEffectPanel:setLocalZOrder(999)

	local btnImg = self._main:getChildByName("exStageBtn")

	btnImg:setLocalZOrder(1001)

	self._lightBtn = btnImg:getChildByName("type_light")
	self._darkBtn = btnImg:getChildByName("type_dark")
	self._leftBox = self:getView():getChildByName("leftBox")
	self._rightBox = self:getView():getChildByName("rightBox")
	self._coopreateBossPanel = self:getView():getChildByName("coopreateBossPanel")

	self._coopreateBossPanel:setSwallowTouches(false)
	self._coopreateBossPanel:setVisible(false)

	local image = self._eliteBg:getChildByName("image")

	image:setScaleX(self._winSize.width / 1228)
	image:setScaleY(self._winSize.height / 640)

	local function callFunc(sender, eventType)
		self:onClickImagedi()
	end

	mapButtonHandlerClick(nil, btnImg, {
		ignoreClickAudio = true,
		func = callFunc
	})
	self:refreshCanShow()

	local bottomSlider = self._main:getChildByName("bottomSlider")

	bottomSlider:setLocalZOrder(1000)

	self._bottomSlider = bottomSlider

	local hideBtn = bottomSlider:getChildByFullName("hideNode.hideBtn")

	hideBtn:setContentSize(cc.size(self._winSize.width, self._winSize.height))

	local rowPosX, rowPosY = hideBtn:getPosition()
	local offsetPos = bottomSlider:getChildByName("hideNode"):convertToWorldSpace(cc.p(rowPosX, rowPosY))
	local offX = 568 - offsetPos.x
	local offY = 320 - offsetPos.y

	hideBtn:setPosition(cc.p(rowPosX + offX, rowPosY + offY))
	hideBtn:setSwallowTouches(false)

	local function hideBtnFunc(sender)
		return
	end

	mapButtonHandlerClick(nil, hideBtn, {
		ignoreClickAudio = true,
		func = hideBtnFunc
	})

	self._mainSlider = bottomSlider:getChildByFullName("hideNode.mainSlider")

	self._mainSlider:setScale9Enabled(true)
	self._mainSlider:setCapInsets(cc.rect(43, 2, 32, 2))
	self._mainSlider:setCapInsetsBarRenderer(cc.rect(1, 1, 1, 1))

	local hideNode = self._bottomSlider:getChildByName("hideNode")
	local bg = self._bottomSlider:getChildByName("bg")

	self._mainSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			hideNode:setVisible(true)
			bg:setVisible(false)
			hideNode:setOpacity(255)
			self._mainSlider:stopAllActions()
			self._mainSlider:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
				hideNode:runAction(cc.Sequence:create(cc.FadeOut:create(0.5)))
				bg:setVisible(true)
				self._mainSlider:setTouchEnabled(true)
			end)))
			self:onSliderChanged()
		end
	end)
	self._mainSlider:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self._mainSlider:stopAllActions()
			hideNode:setOpacity(255)
			self._mainSlider:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
				hideNode:runAction(cc.Sequence:create(cc.FadeOut:create(0.5)))
				bg:setVisible(true)
				self._mainSlider:setTouchEnabled(true)
			end)))
		elseif eventType == ccui.TouchEventType.moved then
			self._mainSlider:stopAllActions()
			hideNode:setOpacity(255)
			self._mainSlider:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
				hideNode:runAction(cc.Sequence:create(cc.FadeOut:create(0.5)))
				bg:setVisible(true)
				self._mainSlider:setTouchEnabled(true)
			end)))
		elseif eventType == ccui.TouchEventType.ended then
			-- block empty
		end
	end)

	local function touchFunc()
		self:showOrHideSlider()
	end

	mapButtonHandlerClick(nil, bottomSlider:getChildByName("touchPanel"), {
		ignoreClickAudio = true,
		func = touchFunc
	})
	self:setTextOutline()
end

function CommonStageMainViewMediator:setTextOutline()
	local text1 = self._bottomSlider:getChildByName("precess")

	text1:enableOutline(cc.c4b(0, 0, 0, 142.8), 1)

	local text2 = self._bottomSlider:getChildByName("maxPrecess")

	text2:enableOutline(cc.c4b(0, 0, 0, 142.8), 1)

	local text3 = self._bottomSlider:getChildByFullName("hideNode.cur")

	text3:enableOutline(cc.c4b(0, 0, 0, 142.8), 1)

	local text4 = self._bottomSlider:getChildByFullName("hideNode.max")

	text4:enableOutline(cc.c4b(0, 0, 0, 142.8), 1)

	local text5 = self._bottomSlider:getChildByFullName("hideNode.Text_18")

	text5:enableOutline(cc.c4b(0, 0, 0, 142.8), 1)
end

function CommonStageMainViewMediator:onClickImagedi()
	local unlock, tips = self._systemKeeper:isUnlock("Elite_Block")

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tips
		}))

		return true
	end

	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

	if self._stageType == StageType.kElite then
		self._stageType = StageType.kNormal
	elseif self._stageType == StageType.kNormal then
		self._stageType = StageType.kElite
	end

	self._stageCount = self:getStageSystem():getStageCount(self._stageType)

	self:refreshStageType()
	self:getChapterIndex()
	self:initBottomSlider()
	self:setupClickEnvs()
end

function CommonStageMainViewMediator:refreshCanShow()
	local canShow = self._systemKeeper:canShow("Elite_Block")

	self._lightBtn:setVisible(canShow)

	local stageStarCountText = self._main:getChildByFullName("exStageBtn.stageStar.count")

	stageStarCountText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	self._main:getChildByFullName("exStageBtn.stageStar.Text_1"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local stageManager = self._stageSystem._stageManager

	stageStarCountText:setString(stageManager:getAllStageStar())
end

function CommonStageMainViewMediator:initClippedNode()
	local parentNode = self._main:getChildByName("exStageBtn")
	local myDrawNode = cc.DrawNode:create()
	local array = {
		cc.p(7, 64),
		cc.p(63, 13),
		cc.p(87, 32),
		cc.p(30, 89.5)
	}

	myDrawNode:drawPolygon(array, 4, cc.c4f(255, 0, 0, 1), 1, cc.c4f(0, 0, 0, 1))

	local clippingNode = cc.ClippingNode:create(myDrawNode)

	clippingNode:setPosition(cc.p(0, 0))
	clippingNode:setAnchorPoint(cc.p(0, 0))
	clippingNode:setLocalZOrder(1)
	clippingNode:addTo(parentNode)
	self._darkBtn:changeParent(clippingNode)

	self._clipNode = clippingNode
end

function CommonStageMainViewMediator:onSliderChanged()
	local mapViewWidth = self._tableView:minContainerOffset()
	local percent = self._mainSlider:getPercent() * 0.01

	self:setCurChapterIndex(percent)

	isOnScroll = true

	self._tableView:setContentOffset(cc.p(percent * mapViewWidth.x - 1, 0), false)
	self._tableView:setContentOffset(cc.p(percent * mapViewWidth.x, 0), false)

	isOnScroll = false
end

function CommonStageMainViewMediator:initBottomSlider()
	self._mainSlider:stopAllActions()
	self._mainSlider:setTouchEnabled(true)

	local chapterNumLabel1 = self._bottomSlider:getChildByName("maxPrecess")
	local chapterNumLabel2 = self._bottomSlider:getChildByFullName("hideNode.max")

	chapterNumLabel1:setString(self._stageCount)
	chapterNumLabel2:setString("/" .. self._stageCount)

	local chapterNode = self._bottomSlider:getChildByFullName("hideNode.chapterNode")
	local trip = 610 / (self._stageCount - 1)

	chapterNode:removeAllChildren()

	for i = 1, self._stageCount do
		local _node = ccui.ImageView:create("main_btn_page01.png", ccui.TextureResType.plistType)

		_node:addTo(chapterNode)
		_node:setPosition((i - 1) * trip, 0)
	end

	local percent = self._mainSlider:getPercent() * 0.01

	self:setCurChapterIndex(percent)
end

function CommonStageMainViewMediator:refreshStageType()
	local curStageType = self._stageType
	local lightText = {}
	local darkText = {}

	for i = 1, 2 do
		lightText[i] = self._lightBtn:getChildByName("text" .. i)

		lightText[i]:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

		darkText[i] = self._darkBtn:getChildByName("text" .. i)

		darkText[i]:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	end

	if curStageType == StageType.kNormal then
		self._lightBtn:getChildByName("redPoint"):setVisible(#self._tabElite > 0)
		self._darkBtn:getChildByName("redPoint"):setVisible(#self._tabNormal > 0)
		self._commonBg:setVisible(true)
		self._eliteBg:setVisible(false)
		self._eliteEffectPanel:setVisible(false)
		lightText[1]:setString(Strings:get("Stage_Text3"))
		lightText[2]:setString(Strings:get("Stage_Text4"))
		darkText[1]:setString(Strings:get("Stage_Text1"))
		darkText[2]:setString(Strings:get("Stage_Text2"))
	elseif curStageType == StageType.kElite then
		if self._asyncLoadTexture == false then
			local pos = {
				cc.p(100, 150),
				cc.p(90, 200),
				cc.p(211, 150),
				cc.p(340, 150),
				cc.p(500, 90),
				cc.p(750, 90),
				cc.p(1028, 100),
				cc.p(1258, 100),
				cc.p(1120, 319),
				cc.p(1261, 417),
				cc.p(1300, 150)
			}

			for i = 1, 11 do
				local yan = cc.MovieClip:create("heiza_zhuxianguanka")

				yan:addTo(self._eliteEffectPanel)
				yan:setPosition(pos[i])
				yan:setColorTransform(ColorTransform(1, 1, 1, 0.5))
			end

			self._asyncLoadTexture = true
		end

		self._lightBtn:getChildByName("redPoint"):setVisible(#self._tabNormal > 0)
		self._darkBtn:getChildByName("redPoint"):setVisible(#self._tabElite > 0)
		lightText[1]:setString(Strings:get("Stage_Text1"))
		lightText[2]:setString(Strings:get("Stage_Text2"))
		darkText[1]:setString(Strings:get("Stage_Text3"))
		darkText[2]:setString(Strings:get("Stage_Text4"))
		self._commonBg:setVisible(false)
		self._eliteBg:setVisible(true)
		self._eliteEffectPanel:setVisible(true)
	end
end

function CommonStageMainViewMediator:createTableView()
	local tableView = cc.TableView:create(cc.size(self._winSize.width, self._winSize.height))
	local hideNode = self._bottomSlider:getChildByName("hideNode")
	local bg = self._bottomSlider:getChildByName("bg")

	self._cellNumStageType = self._stageType
	self._mapCount = self:getChapterIndex(true)

	local function numberOfCells(view)
		if self._cellNumStageType ~= self._stageType then
			self._mapCount = self:getChapterIndex(true)
			self._cellNumStageType = self._stageType
		end

		return self._mapCount
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return kChapterMapSize[idx + 1], self._winSize.height
	end

	local function onScroll(table)
		local maxContainerOffX = table:minContainerOffset().x
		local offX = table:getContentOffset().x

		if offX < maxContainerOffX or offX > 0 then
			return
		end

		local chapterNum = numberOfCells()

		for i = 0, chapterNum - 1 do
			local cellInstance = table:cellAtIndex(i)

			if cellInstance then
				cellInstance.mediator:onScroll(offX)
			end
		end

		local tempTab = self._redPointTab[self._stageType]

		if #tempTab == 0 then
			self._leftBox:setVisible(false)
			self._rightBox:setVisible(false)
		else
			local prevTag = tempTab[1]
			local nextTag = tempTab[#tempTab]

			if -offX < kChapterOffSetL[prevTag] then
				self._leftBox:setVisible(false)
			else
				self._leftBox:setVisible(true)
			end

			if -offX > kChapterOffSetR[nextTag] then
				self._rightBox:setVisible(false)
			else
				self._rightBox:setVisible(true)
			end
		end

		if isOnScroll then
			return
		end

		local precess = offX / maxContainerOffX

		self._mainSlider:setPercent(precess * 100)
		self:setCurChapterIndex(precess)
		hideNode:setVisible(true)
		bg:setVisible(false)
		self._mainSlider:stopAllActions()
		hideNode:setOpacity(255)
		self._mainSlider:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.CallFunc:create(function()
			hideNode:runAction(cc.Sequence:create(cc.FadeOut:create(0.5)))
			bg:setVisible(true)
			self._mainSlider:setTouchEnabled(true)
		end)))
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCellByTag(idx)

		if not cell then
			cell = cc.TableViewCell:new()

			cell:setLocalZOrder(109 - index)
			cell:setTag(idx)
		elseif not ((cell.stageType ~= self._stageType or nil) and true) then
			cell.mediator:update(self._stageType, self._redPointTab[self._stageType])

			return cell
		else
			cell:removeAllChildren()
		end

		local chapterName = self._stageType == StageType.kNormal and StageMapUI["chapter" .. index] or EliteStageMapUI["chapter" .. index]
		local chapterView = self._sharedInjector:getInstance(chapterName)

		chapterView:setAnchorPoint(cc.p(0, 0.5))
		chapterView:setPosition(cc.p(0, self._winSize.height / 2))
		cell:addChild(chapterView)

		cell.mediator = self._sharedInjector:instantiate(chapterName, {
			view = chapterView,
			stageType = self._stageType,
			mediator = self
		})
		cell.stageType = self._stageType

		cell.mediator:update(self._stageType, self._redPointTab[self._stageType])

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0.5, 0.5))
	tableView:setPosition(cc.p(568, 320))
	tableView:setIgnoreAnchorPointForPosition(false)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:addTo(self._main)
	tableView:setBounceable(false)
	tableView:setDeaccelRate(0.85)

	self._tableView = tableView
end

function CommonStageMainViewMediator:setCurChapterIndex(precess)
	local curChapterIndex = 1

	for i = 1, self._stageCount do
		if precess >= (i - 1.5) / (self._stageCount - 1) and precess < (i - 0.5) / (self._stageCount - 1) then
			curChapterIndex = i

			break
		end
	end

	local curChapterNum = self._main:getChildByFullName("bottomSlider.precess")

	curChapterNum:setString(curChapterIndex)

	local curLabel = self._main:getChildByFullName("bottomSlider.hideNode.cur")

	curLabel:setString(curChapterIndex)
end

function CommonStageMainViewMediator:getChapterIndex(ignoreOffset, needDelay)
	local chapterList = self:getStageSystem():getChapterListInfo(self._stageType)
	local lastIndex = 1
	local curChapter = 1

	for i = 1, #chapterList do
		if chapterList[i]:isUnlock() then
			lastIndex = i
			curChapter = i
		else
			break
		end
	end

	if GameConfigs.closeGuide == false then
		local guideSystem = self:getInjector():getInstance(GuideSystem)

		if guideSystem:getChapterOneGetRewSta() then
			curChapter = 1
		end
	end

	local mapIndex = math.ceil((curChapter + 1) / 2)

	if not ignoreOffset then
		if mapIndex > 0 and mapIndex < 5 then
			AudioEngine:getInstance():setAisac(dmAudio.currentMusicPlaybackId, "AisacVolume", 0)
		elseif mapIndex < 8 then
			AudioEngine:getInstance():setAisac(dmAudio.currentMusicPlaybackId, "AisacVolume", 0.5)
		elseif mapIndex >= 8 then
			AudioEngine:getInstance():setAisac(dmAudio.currentMusicPlaybackId, "AisacVolume", 0.7)
		end

		local mapViewWidth = 0

		for i = 1, mapIndex - 1 do
			mapViewWidth = mapViewWidth + kChapterMapSize[i]
		end

		local function reloadTableView()
			self._tableView:reloadData()
			self._tableView:setContentOffset(cc.p(-mapViewWidth, 0), false)

			if math.mod(curChapter, 2) == 1 then
				local offX = self._tableView:getContentOffset().x

				self._tableView:setContentOffset(cc.p(offX - 600, 0), false)
			else
				self._tableView:setContentOffset(cc.p(-mapViewWidth - 1, 0), false)
			end
		end

		if needDelay then
			performWithDelay(self:getView(), function()
				reloadTableView()
			end, 0.1)
		else
			reloadTableView()
		end

		self._curChapter = curChapter
	end

	mapIndex = math.ceil((self._stageCount + 1) / 2)

	return mapIndex
end

function CommonStageMainViewMediator:enableRedPoint()
	self._tabNormal = self._stageSystem:queryRewardBox(StageType.kNormal)
	self._tabElite = self._stageSystem:queryRewardBox(StageType.kElite)
	self._redPointTab = {}
	self._redPointTab[StageType.kNormal] = self._tabNormal
	self._redPointTab[StageType.kElite] = self._tabElite
end

function CommonStageMainViewMediator:enterChapterDetailView(chapterIndex, pointId, stageType)
	local pointId = pointId or nil
	local var_40_0

	if chapterIndex then
		self._curChapter = chapterIndex
		var_40_0 = self:getInjector():getInstance("CommonStageChapterView")
	end

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, var_40_0, {}, {
		chapterIndex = self._curChapter,
		pointId = pointId,
		stageType = stageType
	}))
end

function CommonStageMainViewMediator:onGoLeft()
	local typeTab = self._redPointTab[self._stageType]
	local tableViewOff = self._tableView:getContentOffset().x
	local tag = #typeTab

	for i = 1, #typeTab do
		local k = typeTab[i]

		if -tableViewOff < kChapterOffSetL[k] then
			tag = i - 1

			break
		end
	end

	local newOff = (kChapterOffSetR[typeTab[tag]] + kChapterOffSetL[typeTab[tag]]) / 2

	self._tableView:stopScroll()
	self._tableView:setContentOffset(cc.p(-newOff, 0), false)
	self._tableView:setContentOffset(cc.p(-newOff - 1, 0), false)
end

function CommonStageMainViewMediator:onGoRight()
	local typeTab = self._redPointTab[self._stageType]
	local tableViewOff = self._tableView:getContentOffset().x
	local tag = #typeTab

	for i = #typeTab, 1, -1 do
		local k = typeTab[i]

		if -tableViewOff > kChapterOffSetR[k] then
			tag = i + 1

			break
		end
	end

	local newOff = (kChapterOffSetR[typeTab[tag]] + kChapterOffSetL[typeTab[tag]]) / 2

	self._tableView:stopScroll()
	self._tableView:setContentOffset(cc.p(-newOff, 0), false)
	self._tableView:setContentOffset(cc.p(-newOff - 1, 0), false)
end

function CommonStageMainViewMediator:showOrHideSlider()
	local hideNode = self._bottomSlider:getChildByName("hideNode")
	local bg = self._bottomSlider:getChildByName("bg")
	local visible = hideNode:isVisible()

	if visible then
		hideNode:setVisible(false)
		bg:setVisible(true)
	else
		hideNode:setVisible(true)
		bg:setVisible(false)
	end
end

function CommonStageMainViewMediator:onClickBack(sender, eventType)
	if isClose then
		self:dismissWithOptions({
			transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
		})
	end
end

function CommonStageMainViewMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		isClose = true

		return
	end

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		for i = 1, 6 do
			local cellBar = self._tableView:cellAtIndex(i - 1)

			if cellBar then
				local cell = cellBar.mediator._main

				if cell then
					storyDirector:setClickEnv("commonStageMain.cellChapter" .. i, cell, function(sender, eventType)
						AudioEngine:getInstance():playEffect("Se_Click_Charpter", false)
						self:enterChapterDetailView(i, nil, self._stageType)
					end)
				end
			end
		end

		local btnImg = self._main:getChildByName("exStageBtn")

		if btnImg then
			storyDirector:setClickEnv("commonStageMain.btnImg", btnImg, function(sender, eventType)
				self:onClickImagedi()
			end)
		end

		local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

		storyDirector:setClickEnv("commonStageMain.btnBack", btnBack, function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
				self:onClickBack(sender, eventType)
			end
		end)

		isClose = true

		storyDirector:notifyWaiting("enter_commonStageMain_view")
	end))

	self:getView():runAction(sequence)
end

function CommonStageMainViewMediator:setupCooperateBossShow()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	local inviteList = self._coopreateBossPanel:getChildByFullName("inviteList")
	local mineBoss = self._coopreateBossPanel:getChildByFullName("mineBoss")
	local leaveTimeLab = self._coopreateBossPanel:getChildByFullName("timePanel.times")
	local inviteBossShow = self._cooperateBossSystem:checkInviteBossShow()
	local mineBossShow = self._cooperateBossSystem:checkMineDefaultBossShow()

	self._coopreateBossPanel:setVisible(false)
	self._coopreateBossPanel:setLocalZOrder(20000)

	local curTimes = self._cooperateBossSystem:getCooperateBoss():getBossFightTimes()

	if curTimes then
		local resetData = DataReader:getDataByNameIdAndKey("Reset", "CooperateBoss", "ResetSystem")

		if curTimes.value <= 0 then
			leaveTimeLab:setTextColor(cc.c3b(255, 117, 117))
		else
			leaveTimeLab:setTextColor(cc.c3b(255, 255, 255))
		end

		leaveTimeLab:setString(tostring(curTimes.value) .. "/" .. tostring(resetData.max))
	end

	if inviteBossShow and mineBossShow then
		self._coopreateBossPanel:setVisible(true)
		inviteList:setVisible(true)
		mineBoss:setVisible(true)
		mineBoss:setPositionY(-10)
	elseif not inviteBossShow and mineBossShow then
		self._coopreateBossPanel:setVisible(true)
		mineBoss:setPositionY(340)
		inviteList:setVisible(false)
		mineBoss:setVisible(true)
	elseif inviteBossShow and not mineBossShow then
		self._coopreateBossPanel:setVisible(true)
		inviteList:setVisible(true)
		mineBoss:setVisible(false)
	end

	if mineBossShow then
		local bossIcon = mineBoss:getChildByFullName("IconPanel")
		local bossNameText = mineBoss:getChildByFullName("Name")
		local bossTimeText = mineBoss:getChildByFullName("Time")
		local cooperateBoss = self._cooperateBossSystem:getCooperateBoss()

		bossNameText:setString(Strings:get("CooperateBoss_Main_BossLevel", {
			bossName = cooperateBoss:getRoleModelName(),
			bossLevel = cooperateBoss:getBossLevel()
		}))

		local heroSprite = IconFactory:createRoleIconSpriteNew({
			id = cooperateBoss:getRoleModelId()
		})

		heroSprite:addTo(bossIcon):center(bossIcon:getContentSize())
		heroSprite:setScale(0.4)

		local endTime = cooperateBoss:getBossEndTime()

		local function checkTimeFunc()
			remoteTimestamp = self._gameServerAgent:remoteTimestamp()

			local remainTime = endTime - remoteTimestamp

			if remainTime < 0 then
				mineBoss:setVisible(false)

				if not inviteBossShow then
					self._coopreateBossPanel:setVisible(false)
				else
					self._coopreateBossPanel:setVisible(true)
				end

				self._timer:stop()

				self._timer = nil

				return
			end

			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])

			if timeTab.hour > 0 then
				bossTimeText:setString(string.format("%02d", timeTab.hour) .. ":" .. string.format("%02d", timeTab.min) .. ":" .. string.format("%02d", timeTab.sec))
			else
				bossTimeText:setString(string.format("%02d", timeTab.min) .. ":" .. string.format("%02d", timeTab.sec))
			end
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
		bossIcon:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._cooperateBossSystem:enterCooperateBossInviteFriendView(cooperateBoss:getMineBoss().bossId)
			end
		end)
	end

	if inviteBossShow then
		local cooperateBoss = self._cooperateBossSystem:getCooperateBoss()
		local inviteInfo = cooperateBoss:getSortInvitedBossIdMap()

		inviteList:removeAllChildren()
		inviteList:setScrollBarEnabled(false)

		local itemclone = self:getView():getChildByName("inviteBossCellClone")

		itemclone:setVisible(false)

		for i = 1, #inviteInfo do
			local item = itemclone:clone()

			item:setVisible(true)

			local info = inviteInfo[i]
			local bossIcon = item:getChildByFullName("invitePanel.role")
			local bossNameText = item:getChildByFullName("invitePanel.nameDi.name")
			local bossLvText = item:getChildByFullName("invitePanel.level.text")
			local playerNameText = item:getChildByFullName("invitePanel.inviteDi.invite")
			local bg = item:getChildByFullName("Bg")

			playerNameText:setString(info.name)
			bossNameText:setString(self._cooperateBossSystem:getBossName(info.confId))
			bossLvText:setString("Lv." .. info.lv)

			local pic, animName = self._cooperateBossSystem:getInviteBossTabImage(info.lv)

			bg:loadTexture(pic, ccui.TextureResType.localType)

			if animName and animName ~= "" then
				local animNode = item:getChildByFullName("invitePanel")

				animNode:removeChildByName("FrameFX")

				local anim = cc.MovieClip:create(animName)

				anim:addTo(animNode):center(animNode:getContentSize()):offset(0, 5)
				anim:setName("FrameFX")
			end

			item:getChildByFullName("invitePanel.info"):setVisible(false)

			local heroSprite = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe13_2",
				id = cooperateBoss:getRoleModelId(info.confId)
			})

			heroSprite:addTo(bossIcon):center(bossIcon:getContentSize())
			item:setTouchEnabled(true)

			local touch = item:getChildByFullName("invitePanel")

			touch:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					local bossLeaveTime = info.bossCreateTime + ConfigReader:getDataByNameIdAndKey("CooperateBossMain", info.confId, "Time")
					local currentTIme = self._gameServerAgent:remoteTimestamp()

					if bossLeaveTime - currentTIme <= 0 then
						self:dispatch(ShowTipEvent({
							duration = 0.35,
							tip = Strings:get("CooperateBoss_AfterBattle_UI05")
						}))
						self:refreshInviteListView()

						return
					end

					local data = {
						confId = info.confId,
						bossCreateTime = info.bossCreateTime,
						bossLevel = info.lv,
						name = info.name,
						bossId = info.bossId
					}

					self._cooperateBossSystem:enterCooperateBossInvite(data)
				end
			end)
			inviteList:pushBackCustomItem(item)
		end
	end
end
