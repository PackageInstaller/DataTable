-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/HeroStoryChapterDetailMediator.lua

require("dm.gameplay.stage.view.component.HeroStoryCell")

HeroStoryChapterDetailMediator = class("HeroStoryChapterDetailMediator", DmAreaViewMediator)

HeroStoryChapterDetailMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
HeroStoryChapterDetailMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.enforce"] = {
		func = "onGoHeroUp"
	}
}
local onScrollState = false
local rareityMap = {
	"n",
	"r",
	"sr",
	"ssr",
	"ur"
}

function HeroStoryChapterDetailMediator:initialize()
	super.initialize(self)
end

function HeroStoryChapterDetailMediator:dispose()
	super.dispose(self)
end

function HeroStoryChapterDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROEVOLUTIONLUP_SUCC, self, self.initBottomHeroPanelAndReload)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROSTARUP_SUCC, self, self.initBottomHeroPanelAndReload)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REQUSET_HEROSTORY, self, self.flushDataReload)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROSTAGE_RESETTIMES, self, self.refreshTotalTimes)

	self._heroSystem = self._developSystem:getHeroSystem()
end

function HeroStoryChapterDetailMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")

	topInfoNode:setLocalZOrder(1001)

	local config = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		title = Strings:get("HeroStory_Title"),
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function HeroStoryChapterDetailMediator:enterWithData(data)
	onScrollState = false
	self._heroId = data.heroId
	self._heroStoryMapId = ConfigReader:getDataByNameIdAndKey("HeroBase", self._heroId, "HeroStoryMap")
	self._mapInfo = ConfigReader:getRecordById("HeroStoryMap", self._heroStoryMapId)

	self:initWeight()
	self:setupTopInfoWidget()
	self:initStageProgress()

	if data.index then
		self._selectTag = data.index
	end

	self:initRewardBox()
	self:refreshStarBoxPanel()
	self:setHeroName()
	self:initBottomHeroPanel()
	self:createTableView()
	self:initAnim()

	data.index = nil
end

function HeroStoryChapterDetailMediator:initWeight()
	self._stagePanel = self:getView():getChildByFullName("main.stagePanel")
	self._pointSlider = self:getView():getChildByFullName("main.Slider")

	self._pointSlider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			self:onSliderChanged()
		end
	end)

	self._starBoxPanel = self:getView():getChildByName("star_panel")
	self._heroFrag = self:getView():getChildByFullName("main.fragment")
	self._heroNameLabel = self:getView():getChildByFullName("main.heroName")
	self._lastNameLabel = self:getView():getChildByFullName("main.lastName")
	self._heroQuality = self:getView():getChildByFullName("main.Quality")

	self._heroQuality:ignoreContentAdaptWithSize(true)

	self._heroStarsPanel = self:getView():getChildByFullName("main.heroStarsPanel")
	self._totalTimes = self:getView():getChildByFullName("main.todayTotalTime")

	local text = self:getView():getChildByFullName("main.enforce.Text_99")

	text:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	self._safeTouchPanel = self:getView():getChildByName("touchPanel")

	local heroPanel = self:getView():getChildByFullName("main.heroPanel")
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", self._heroId)
	local hero = self._heroSystem:getHeroById(self._heroId)
	local heroSprite = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = (hero or nil) and hero:getModel()
	})

	heroSprite:addTo(heroPanel)
	heroSprite:setPosition(cc.p(390, 210))

	local bgPanel = self:getView():getChildByFullName("main.bg")
	local backgroundId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", self._mapInfo.Background, "Picture")

	if backgroundId and backgroundId ~= "" then
		local background = cc.Sprite:create("asset/scene/" .. backgroundId .. ".jpg")

		background:setAnchorPoint(cc.p(0.5, 0.5))
		background:setPosition(cc.p(568, 320))
		background:addTo(bgPanel)
	end

	local flashId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", self._mapInfo.Background, "Flash1")

	if flashId and flashId ~= "" then
		local mc = cc.MovieClip:create(flashId)

		mc:setPosition(cc.p(568, 320))
		mc:addTo(bgPanel)
	end

	local flashId2 = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", self._mapInfo.Background, "Flash2")

	if flashId2 and flashId2 ~= "" then
		local mc = cc.MovieClip:create(flashId2)

		mc:setPosition(cc.p(568, 320))
		mc:addTo(bgPanel)
	end

	local winSize = cc.Director:getInstance():getWinSize()

	if winSize.height < 641 then
		bgPanel:setScale(winSize.width / 1386)
	end

	local plistViewId = ConfigReader:getDataByNameIdAndKey("BackGroundPicture", self._mapInfo.Background, "Extra")

	if plistViewId and plistViewId ~= "" then
		local plistView = cc.CSLoader:createNode("asset/ui/" .. plistViewId .. ".csb")

		plistView:addTo(bgPanel):center(cc.size(1136, 640))
	end
end

function HeroStoryChapterDetailMediator:initAnim()
	self._starBoxPanel:setOpacity(0)
	self._safeTouchPanel:setVisible(true)

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
		self._starBoxPanel:runAction(cc.FadeIn:create(0.25))
	end, 0.31)
end

function HeroStoryChapterDetailMediator:initStageProgress()
	self:refreshTotalTimes()

	self._pointList = {}

	local _hero = self._heroSystem:getHeroById(self._heroId)
	local heroInfo = {}

	heroInfo.heroId = _hero:getId()
	heroInfo.heroLove = _hero:getLoveLevel()
	heroInfo.heroQuality = _hero:getQuality()
	heroInfo.heroStar = _hero:getStar()

	local heroName = ConfigReader:getDataByNameIdAndKey("HeroBase", heroInfo.heroId, "Name")

	heroInfo.heroName = Strings:get(heroName)
	self._heroInfo = heroInfo
	self._heroInstance = _hero

	local _map = self._stageSystem:getHeroStoryMapById(self._heroStoryMapId)

	if _map then
		self._pointList = _map._indexToPoints
		self._selectTag = 0
		self._useModelInfo = true

		local activeInfo = self._stageSystem:getActivityHeroStoryId()
		local activePointId = activeInfo and activeInfo.pointId

		if activePointId then
			self._stageSystem:setActivityHeroStoryId({})

			local _point = _map:getHeroStoryPointById(activePointId)

			if _point then
				local nextIndex = _point:getIndex() + 1
				local nextPoint = self._pointList[nextIndex]

				if nextPoint and nextPoint:isPass() then
					self._selectTag = nextIndex - 1

					return
				end
			end
		end

		for k, v in ipairs(self._pointList) do
			if not v:isPass() then
				if v:isUnlock(heroInfo) then
					self._selectTag = k
				end

				break
			end
		end
	else
		self._pointList = self._mapInfo.SubPoint
		self._selectTag = 0

		local firstPointInfo = ConfigReader:getRecordById("HeroStoryPoint", self._pointList[1])
		local condition = true
		local conditionNum = 0

		for k, v in pairs(firstPointInfo.Condition) do
			if k == "HeroLove" and heroInfo.heroLove < tonumber(v) then
				condition = false
				conditionNum = tonumber(v)

				break
			end

			if k == "Quality" and heroInfo.heroQuality < tonumber(v) then
				condition = false
				conditionNum = Strings:get("QualityDesc_" .. tonumber(v))

				break
			end

			if k == "HeroStar" and heroInfo.heroStar < tonumber(v) then
				condition = false
				conditionNum = tonumber(v)

				break
			end
		end

		if condition then
			self._selectTag = 1
		else
			self._unlockTips = Strings:get(firstPointInfo.UnlockTip, {
				Hero = heroInfo.heroName,
				HeroLove = conditionNum,
				HeroQuality = conditionNum
			})
		end

		self._useModelInfo = false
	end
end

function HeroStoryChapterDetailMediator:initRewardBox()
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

function HeroStoryChapterDetailMediator:setHeroName()
	local _hero = self._heroInstance
	local heroId = _hero:getId()
	local firstName = self._heroInfo.heroName
	local lastName = Strings:get(ConfigReader:getDataByNameIdAndKey("GalleryHeroInfo", heroId, "HistoryHero"))

	self._heroNameLabel:setString(firstName)
	self._lastNameLabel:setString(Strings:get("GALLERY_UI52", {
		name = lastName
	}))

	local length = utf8.len(lastName)

	if length > 6 then
		self._lastNameLabel:setFontSize(18)
	else
		self._lastNameLabel:setFontSize(22)
	end
end

function HeroStoryChapterDetailMediator:initBottomHeroPanel()
	local _hero = self._heroInstance
	local _rarity = _hero:getRarity()

	self._heroQuality:loadTexture("yh_bg_" .. rareityMap[_rarity - 10] .. ".png", ccui.TextureResType.plistType)

	local heroPrototype = _hero:getHeroPrototype()
	local heroStar = _hero:getStar()
	local littleStar = _hero:getLittleStar()
	local maxStar = _hero:getMaxStar()

	for i = 1, HeroStarCountMax do
		local _star = self._heroStarsPanel:getChildByName("star" .. i)

		_star:setVisible(i <= maxStar)
		_star:ignoreContentAdaptWithSize(true)
		_star:loadTexture((_hero:getAwakenStar() > 0 or nil) and "jx_img_star.png", 1)
	end

	self:refresHeroPieceNum()
end

function HeroStoryChapterDetailMediator:initBottomHeroPanelAndReload()
	self:initBottomHeroPanel()

	local heroInfo = {}

	heroInfo.heroId = self._heroInstance:getId()
	heroInfo.heroLove = self._heroInstance:getLoveLevel()
	heroInfo.heroQuality = self._heroInstance:getQuality()
	heroInfo.heroStar = self._heroInstance:getStar()

	local heroName = ConfigReader:getDataByNameIdAndKey("HeroBase", heroInfo.heroId, "Name")

	heroInfo.heroName = Strings:get(heroName)
	self._heroInfo = heroInfo

	self._tableView:reloadData()
end

function HeroStoryChapterDetailMediator:refresHeroPieceNum()
	local _hero = self._heroInstance
	local heroPrototype = _hero:getHeroPrototype()
	local hasNum = self._heroSystem:getHeroDebrisCount(self._heroId)
	local needNum = heroPrototype:getStarCostFragByStar(_hero:getNextStarId())
	local fragText = self._heroFrag:getChildByName("number")
	local numberBg = self._heroFrag:getChildByName("numBg")

	fragText:setString(hasNum .. "/" .. needNum)

	local rawSize = numberBg:getContentSize()

	numberBg:setContentSize(cc.size(fragText:getContentSize().width + 95, rawSize.height))
end

function HeroStoryChapterDetailMediator:createTableView()
	local tableView = cc.TableView:create(self._stagePanel:getContentSize())

	local function numberOfCells(view)
		return #self._pointList
	end

	local function cellTouched(table, cell)
		local index = cell:getIdx() + 1

		self:onClickStoryCell(ccui.TouchEventType.ended, index)
	end

	local function cellSize(table, idx)
		if idx + 1 == self._selectTag then
			return 420, 145
		else
			return 420, 69
		end
	end

	local function onScroll(table)
		self:refreshStagePoint()
	end

	local function cellAtIndex(table, idx)
		local index = idx + 1
		local cell = index == self._selectTag and table:dequeueCellByTag(843) or table:dequeueCellByTag(348)

		if not cell then
			cell = cc.TableViewCell:new()

			local clone_cell = self:getView():getChildByFullName("clone_cell")

			clone_cell:setVisible(false)

			local cellView = clone_cell:clone()

			cellView:setVisible(true)
			cellView:setAnchorPoint(cc.p(0.5, 1))
			cellView:setName("cellView")

			if index == self._selectTag then
				cell:setTag(843)
				cellView:setPosition(cc.p(210, 138))
				cellView:addTo(cell)
			else
				cell:setTag(348)
				cellView:setPosition(cc.p(210, 78))
				cellView:addTo(cell)
			end

			cell.mediator = HeroStoryCell:new(cellView, {
				mediator = self
			})
		end

		cell.mediator:refreshData(self._pointList[index], self._useModelInfo, self._selectTag, index)
		cell.mediator:setCellState(self._selectTag, index)

		return cell
	end

	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setDelegate()
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(0, 0))
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:addTo(self._stagePanel)
	tableView:reloadData()
	tableView:setBounceable(false)

	self._tableView = tableView
end

function HeroStoryChapterDetailMediator:resumeWithData()
	local activeInfo = self._stageSystem:getActivityHeroStoryId()

	if activeInfo and activeInfo.pointId then
		local pointId = activeInfo.pointId

		self._stageSystem:setActivityHeroStoryId({})
		self:initStageProgress()

		local _map = self._stageSystem:getHeroStoryMapById(self._heroStoryMapId)
		local pointIndex = _map:getHeroStoryPointById(pointId):getIndex()

		if self._selectTag - pointIndex ~= 1 then
			self._selectTag = pointIndex
		end

		self._tableView:reloadData()
		self:refreshStarBoxPanel()
		self:refresHeroPieceNum()
	end
end

function HeroStoryChapterDetailMediator:onClickStoryCell(eventType, index)
	if eventType == ccui.TouchEventType.ended then
		local tag = index
		local isUnlock = false
		local tips = ""

		if self._useModelInfo then
			isUnlock, tips = self._pointList[tag]:isUnlock(self._heroInfo)
		elseif tag == 1 then
			if self._selectTag == 1 then
				isUnlock = true
			else
				tips = self._unlockTips
			end
		else
			local PointInfo = ConfigReader:getRecordById("HeroStoryPoint", self._pointList[tag])
			local condition = true
			local conditionNum = 0

			for k, v in pairs(PointInfo.Condition) do
				if k == "HeroLove" and self._heroInfo.heroLove < tonumber(v) then
					condition = false
					conditionNum = tonumber(v)

					break
				end

				if k == "Quality" and self._heroInfo.heroQuality < tonumber(v) then
					condition = false
					conditionNum = Strings:get("QualityDesc_" .. tonumber(v))

					break
				end

				if k == "HeroStar" and self._heroInfo.heroStar < tonumber(v) then
					condition = false
					conditionNum = tonumber(v)

					break
				end
			end

			tips = not condition and Strings:get(PointInfo.UnlockTip, {
				Hero = self._heroInfo.heroName,
				HeroLove = conditionNum,
				HeroQuality = conditionNum
			}) or Strings:get("Lock2")
		end

		if not isUnlock then
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = tips
			}))

			return
		end

		if self._selectTag ~= tag then
			self._selectTag = tag

			self._tableView:reloadData()
		else
			local data = {}

			data.point = self._pointList[tag]
			data.isModel = self._useModelInfo
			data.index = tag

			local view = self:getInjector():getInstance("HeroStoryPointDetailView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		end
	end
end

function HeroStoryChapterDetailMediator:onSliderChanged()
	local percent = self._pointSlider:getPercent()
	local maxOffset = self._tableView:minContainerOffset().y

	onScrollState = true

	self._tableView:setContentOffset(cc.p(0, maxOffset * (1 - percent * 0.01)), false)

	onScrollState = false
end

function HeroStoryChapterDetailMediator:refreshStagePoint()
	if not self._tableView or onScrollState then
		return
	end

	local offY = self._tableView:getContentOffset().y
	local maxOffset = self._tableView:minContainerOffset().y
	local percent = math.abs(offY / maxOffset)

	self._pointSlider:setPercent(100 - percent * 100)
end

function HeroStoryChapterDetailMediator:refreshTotalTimes()
	local bagSystem = self._developSystem:getBagSystem()
	local times = bagSystem:getTimeRecordById(TimeRecordType.kHeroStoryTotalNum)._time

	self._totalTimes:setString(Strings:get("HeroStory_Today_Times") .. times)
end

function HeroStoryChapterDetailMediator:onClickRewardBox(sender)
	local mapInfo = self:getStageSystem():getHeroStoryMapById(self._heroStoryMapId)
	local starBoxReward = ConfigReader:getDataByNameIdAndKey("HeroStoryMap", self._heroStoryMapId, "StarBoxReward")
	local boxRewardList = self:getStageSystem():boxReardToTable(starBoxReward)
	local index = sender:getTag()
	local boxNum = #boxRewardList
	local boxIndex = index - (3 - boxNum)
	local curStarNum = mapInfo and mapInfo:getCurrentStarCount() or 0

	local function receiveAward()
		local function requestRewardSuc(data)
			local parent = sender:getParent()
			local redPoint = parent:getChildByName("red_point")

			redPoint:setVisible(false)
			self:refresHeroPieceNum()

			local view = self:getInjector():getInstance("getRewardView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				rewards = data
			}))
		end

		self:getStageSystem():requestHeroStoryStarsReward(self._heroStoryMapId, boxRewardList[boxIndex].starNum, function(data)
			requestRewardSuc(data)
		end)
	end

	local data = {
		type = StageRewardType.kStarBox,
		rewardId = boxRewardList[boxIndex].rewardId,
		extra = {}
	}

	if curStarNum >= boxRewardList[boxIndex].starNum then
		if mapInfo and mapInfo:getMapBoxState(boxRewardList[boxIndex].starNum) ~= StageBoxState.kCanReceive then
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

function HeroStoryChapterDetailMediator:refreshStarBoxPanel()
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

	local mapInfo = self:getStageSystem():getHeroStoryMapById(self._heroStoryMapId)
	local starBoxReward = ConfigReader:getDataByNameIdAndKey("HeroStoryMap", self._heroStoryMapId, "StarBoxReward")
	local boxPanel = {}
	local starBar = self._starBoxPanel:getChildByName("bar_schedule")

	for i = 1, 3 do
		boxPanel[i] = starBar:getChildByName("box_panel_" .. i)
	end

	if starBoxReward then
		local boxRewardList = self:getStageSystem():boxReardToTable(starBoxReward)
		local totalStarNum = tonumber(boxRewardList[#boxRewardList].starNum)
		local curStarNum = mapInfo and mapInfo:getCurrentStarCount() or 0
		local boxNum = #boxRewardList

		boxPanel[1]:setVisible(boxNum >= 3)
		boxPanel[2]:setVisible(boxNum >= 2)

		for index, reward in pairs(boxRewardList) do
			local boxIndex = 3 - boxNum + index

			setBoxStar(boxPanel[boxIndex], reward.starNum)
			setBoxPosition(boxPanel[boxIndex], reward.starNum, totalStarNum)

			local isOpen, showRed

			if curStarNum >= reward.starNum then
				if mapInfo and mapInfo:getMapBoxState(reward.starNum) ~= StageBoxState.kCanReceive then
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

function HeroStoryChapterDetailMediator:onClickBack()
	self._stageSystem:setActivityHeroStoryId({})
	self:dismiss()
end

function HeroStoryChapterDetailMediator:onGoHeroUp()
	local view = self:getInjector():getInstance("HeroShowMainView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		id = self._heroId
	}))
end

function HeroStoryChapterDetailMediator:flushDataReload()
	self._tableView:reloadData()
	self:refreshTotalTimes()
end
