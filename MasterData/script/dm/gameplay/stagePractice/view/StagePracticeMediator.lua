-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeMediator.lua

StagePracticeMediator = class("StagePracticeMediator", DmAreaViewMediator, _M)

StagePracticeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
StagePracticeMediator:has("_stagePracticeSystem", {
	is = "r"
}):injectWith("StagePracticeSystem")

local HeroSpriteConfig = {
	{
		scale = 0.9,
		name = "MKLJLuo",
		pos = cc.p(35, 0)
	},
	{
		scale = 0.8,
		name = "DNTLuo",
		pos = cc.p(50, -20)
	},
	{
		scale = 0.85,
		name = "DFQi",
		pos = cc.p(40, -35)
	}
}
local cellRedPointTag = 143
local movieClipTag1 = 1001
local movieClipTag2 = 2001
local rewardActionTag = 99999

function StagePracticeMediator:initialize()
	super.initialize(self)

	self._newMessages = {}
end

function StagePracticeMediator:dispose()
	super.dispose(self)
end

function StagePracticeMediator:userInject()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
end

function StagePracticeMediator:onRegister()
	super.onRegister(self)
end

function StagePracticeMediator:enterWithData(data)
	self._data = data

	self:createMapListener()
	self:initData()
	self:initNode()
	self:initAnim()
	self:refreshData(data, true)
	self:createTabPanel()
	self:setCurPassStage(true)

	self._tableViewNodeList = {}

	self._tabController:selectTabByTag(self._curMapIndex)
	self:refreshPointPanel()

	if data and data.reward then
		self:refreshViewByBattleWinClose(data.reward)
	end

	if data and data.enterTeam then
		self:pushTeamView()
	end

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshViewByResChange)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGEPRACTICE_BATTLEOVER_SUCC, self, self.refreshViewByBattleOver)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGEPRACTICE_BATTLEWINCLOSE_SUCC, self, self.refreshViewByBattleWinClose)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGEPRACTICE_GETREWARD_SUCC, self, self.refreshViewByGetReward)
	self:runUIAction()
	self:refreshTableView()
end

function StagePracticeMediator:runUIAction()
	self:getView():stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/StagePractice.csb")

	self:getView():runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 100, false)
	action:setTimeSpeed(2)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end
	end

	action:clearFrameEventCallFunc()
	action:setFrameEventCallFunc(onFrameEvent)
end

function StagePracticeMediator:runTableViewEffeft()
	local cellWidth = self._clonePanel:getChildByFullName("pointpanel"):getContentSize().width
	local tableViewWidth = self._listBg:getContentSize().width
	local offset = 0

	if tableViewWidth < self._curPointIndex * cellWidth then
		offset = self._curPointIndex * cellWidth - tableViewWidth
	end

	local seq = cc.Sequence:create(cc.CallFunc:create(function()
		self._tableView:setContentOffsetInDuration(cc.p(-90 - offset, 0), 0.15)
	end), cc.DelayTime:create(0.15), cc.CallFunc:create(function()
		self._tableView:setContentOffsetInDuration(cc.p(-offset, 0), 0.15)
	end), cc.DelayTime:create(0.15), cc.CallFunc:create(function()
		self:clearSelectState()
		self:switchStageEffect(true)
	end))

	self._tableView:runAction(seq)
end

function StagePracticeMediator:runCellAction(cellview)
	local seq = cc.Sequence:create(cc.FadeIn:create(0.5))

	cellview:runAction(seq)
end

function StagePracticeMediator:pushTeamView(pointData)
	local mapId = self._curMapData:getId()
	local curPointId = self._curPointData:getId()
	local pointData = self._stagePracticeSystem:getPointById(mapId, curPointId)

	if pointData:getConfig().SkipMatrix == 1 then
		self._stagePracticeSystem:requestBattleBefore(mapId, curPointId, nil, nil)

		return
	end

	local view = self:getInjector():getInstance("StagePracticeTeamView")

	local function battleCallback()
		return
	end

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		stagePoint = pointData ~= nil and pointData or self._curPointData,
		battleCallback = battleCallback
	}))
end

function StagePracticeMediator:refreshCostPanel()
	local costData = self._curPointData:getCost()
	local costIcon = IconFactory:createPic({
		id = costData.id
	})

	costIcon:setScale(0.7)

	local width = costIcon:getContentSize().width
	local parent = self._costNode:getChildByFullName("iconpanel")

	costIcon:addTo(parent):center(parent:getContentSize())

	local costLabel = self._costNode:getChildByFullName("numlabel")

	self._goldEngouh = self._bagSystem:getItemCount(CurrencyIdKind.kGold) >= costData.amount
	self._goldCost = costData.amount

	local colorNum = self._goldEngouh and 1 or 6

	costLabel:setTextColor(GameStyle:getColor(colorNum))
	costLabel:setString(costData.amount)

	width = width + costLabel:getContentSize().width

	self._costNode:setPositionX(960 - width / 2)
end

function StagePracticeMediator:refreshViewByGetReward(event)
	local data = event:getData()
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = data.rewards
	}))
	self:refreshData()
	self:refreshPointPanel()
	self._tableView:updateCellAtIndex(self._curPointIndex - 1)
end

function StagePracticeMediator:refreshViewByBattleWinClose(data)
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = data
	}))
	self:refreshData()
	self:refreshPointPanel()
	self._tableView:updateCellAtIndex(self._curPointIndex - 1)
end

function StagePracticeMediator:refreshViewByResChange(event)
	self:refreshCostPanel()
end

function StagePracticeMediator:refreshViewByBattleOver(event)
	self:refreshData()
	self:refreshPointPanel()
	self._tableView:updateCellAtIndex(self._curPointIndex - 1)
	self._tableView:updateCellAtIndex(self._curPointIndex)
end

function StagePracticeMediator:setupTopInfoWidget()
	local topInfoNode = self._mainPanel:getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Stage_Practice")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("StagePractice_Btn_Title")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function StagePracticeMediator:createMapListener()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_STAGEPRACTICE_CHALLAGE_SUCC, self, self.challageCallBack)
end

function StagePracticeMediator:challageCallBack(event)
	return
end

function StagePracticeMediator:initNode()
	self._mainPanel = self:getView():getChildByFullName("main")
	self._clonePanel = self._mainPanel:getChildByFullName("clonenode")

	self._clonePanel:setVisible(false)

	self._mapNode = self._mainPanel:getChildByFullName("mapnode")
	self._listBg = self._mainPanel:getChildByFullName("listBg")
	self._infoNode = self._mainPanel:getChildByFullName("infonode")
	self._costNode = self._infoNode:getChildByFullName("costnode")
	self._playerNode = self._infoNode:getChildByFullName("playernode")

	self._mainPanel:getChildByFullName("infonode"):setVisible(true)

	self._challageBtn = self._mainPanel:getChildByFullName("infonode.challagenbtns")
	self._challageBtnWidget = self._mainPanel:getChildByFullName("infonode.challagebtns")
	self._tiaozhan = self._mainPanel:getChildByFullName("bg_right.tiaozhan")
	self._tiaozhanbg = self._mainPanel:getChildByFullName("infonode.Image_188")
	self._challBtnRedPoint = self._mainPanel:getChildByFullName("infonode.challagebtns.redPoint")

	self._challBtnRedPoint:setVisible(false)

	self._masterImg = self._mainPanel:getChildByFullName("masterImg")
	self._coinPanle = self._mainPanel:getChildByFullName("bg_right.coinpanel")
	self._rewardNode = self._mainPanel:getChildByFullName("reward")
	self._pinglunBtn = self._mainPanel:getChildByFullName("pinglunBtn")

	self._challageBtnWidget:addTouchEventListener(function(sender, type)
		self:onClickChallage(sender, type)
	end)
	self._challageBtn:addTouchEventListener(function(sender, type)
		self:onClickChallage(sender, type)
	end)
	self._pinglunBtn:addTouchEventListener(function(sender, type)
		self:onClickComment(sender, type)
	end)

	local topInfoNode = self._mainPanel:getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Stage_Practice")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function StagePracticeMediator:initAnim()
	local mc = cc.MovieClip:create("xiangqingxunhuan_zhuxianguanka_UIjiaohudongxiao")

	mc:setPosition(cc.p(100, 100))
	self._tiaozhan:addChild(mc)
	self._tiaozhan:setOpacity(0)

	local act = cc.Sequence:create(cc.DelayTime:create(0.4375), cc.FadeIn:create(0.3125))

	self._tiaozhan:runAction(act:clone())
end

function StagePracticeMediator:initData()
	self._bagSystem = self._developSystem:getBagSystem()
	self._stagePractice = self._stagePracticeSystem:getStagePractice()
	self._curMapIndex = self._data.mapIndex or self._curMapIndex or 1
	self._curPointIndex = self._stagePracticeSystem:getCurPointIndex(self._curMapIndex) or 1
	self._curMapRankFirstData = {}
end

function StagePracticeMediator:checkCurMap()
	local curmapid = 1

	for k, v in pairs(self._stagePracticeSystem._stagePractice._array) do
		if v._fullStarReward ~= 1 then
			curmapid = k

			break
		end
	end

	return curmapid
end

function StagePracticeMediator:refreshData(data, isInit)
	self._mapIds = self._stagePracticeSystem:getShowMapIds()

	if data then
		for i = 1, #self._mapIds do
			if self._mapIds[i] == data.mapId then
				self._curMapIndex = i

				break
			end
		end
	elseif isInit then
		local list = {}

		for i = #self._mapIds, 1, -1 do
			local mapId = self._mapIds[i]
			local mapData = self._stagePractice:getMapById(mapId)

			if not mapData:isLock() then
				list[#list + 1] = {
					sortIndex = #list + 1,
					location = mapData:getLocation(),
					index = i,
					redPoint = mapData:hasRedPoint()
				}
			end
		end

		table.sort(list, function(a, b)
			if a.location ~= b.location then
				return a.location > b.location
			end

			if a.sortIndex ~= b.sortIndex then
				return a.sortIndex < b.sortIndex
			end
		end)

		self._curMapIndex = list[1].index

		for i = 1, #self._mapIds do
			local mapId = self._mapIds[i]
			local mapData = self._stagePractice:getMapById(mapId)

			if mapData:hasRedPoint() then
				self._curMapIndex = i

				break
			end
		end
	end

	self._curMapId = self._mapIds[self._curMapIndex]
	self._curMapData = self._stagePractice:getMapById(self._curMapId)
	self._pointList = self._curMapData:getPointArray()

	if data then
		for i = 1, #self._pointList do
			if self._pointList[i]:getId() == data.pointId then
				self._curPointIndex = i

				break
			end
		end
	elseif isInit then
		for i = 1, #self._pointList do
			local pointData = self._pointList[i]

			if not pointData:isLock() then
				self._curPointIndex = i

				break
			end
		end

		for i = 1, #self._pointList do
			if self._pointList[i]:hasRedPoint() then
				self._curPointIndex = i

				break
			end
		end

		local lastPoint = self._pointList[#self._pointList]

		if not lastPoint:isLock() and lastPoint:getFirstPassState() == SPracticeRewardState.kHasGet then
			self._curPointIndex = 1
		end
	end

	self._curPointData = self._curMapData:getPointByIndex(self._curPointIndex)

	self:showReward(self._curPointData:getId())
end

function StagePracticeMediator:resumeWithData(viewData)
	if self._tableView then
		self:refreshCurCell()
	end

	if viewData then
		self:resertcurPointIndex(viewData.userdata)
	end

	self:setCurPassStage(false)
	self:refreshPointPanel()
	self:switchStageEffect()

	if self._tableView then
		self:refreshCurCell()
	end

	self:showReward(self._curPointData:getId())
end

function StagePracticeMediator:resertcurPointIndex(userdata)
	local targetPointId = userdata.pointId
	local curMapData = self._stagePractice:getMapById(self._curMapId)
	local pointList = self._curMapData:getPointArray()

	for j, pointData in ipairs(self._pointList) do
		local pointId = pointData:getId()

		if targetPointId == pointId then
			self._curPointIndex = j
		end
	end
end

function StagePracticeMediator:refreshCurCell()
	local cell = self._tableView:cellAtIndex(self._curPointIndex - 1)

	if cell then
		cell = cell:getChildByTag(123)

		if cell then
			self:setOnePointPanelInfo(self._curPointData, cell, self._curPointIndex)
		end
	end
end

function StagePracticeMediator:refreshRankPanel(hasAnim)
	local playerInfo = self._curPointData:getPlayerInfo()
	local showrankplayinfo = playerInfo:hasInfo() and self._curPointData:getType() ~= SPracticePointType.kTEACH

	self._playerNode:setVisible(showrankplayinfo)

	if self._playerNode:isVisible() then
		local nameLabel = self._playerNode:getChildByFullName("namelabel")

		nameLabel:setString(playerInfo:getName())

		local iconPanel = self._playerNode:getChildByFullName("iconpanel")

		iconPanel:removeAllChildren()

		local headIcon = IconFactory:createPlayerIcon({
			id = playerInfo:getHeadImg()
		}, {
			shape = IconShape.kParallelogram
		})

		headIcon:addTo(iconPanel):center(iconPanel:getContentSize()):offset(0, 0)
		headIcon:setScale(0.64)
		self._playerNode:setLocalZOrder(100)
		self._playerNode:removeChildByTag(123)

		local descLabel = ccui.RichText:createWithXML(Strings:get("StagePractice_Text3", {
			fontName = TTF_FONT_FZYH_M,
			time = string.format("%0.2f", playerInfo:getTime() / 1000)
		}), {})

		descLabel:ignoreContentAdaptWithSize(true)
		descLabel:rebuildElements()
		descLabel:formatText()
		descLabel:setAnchorPoint(cc.p(0, 0))
		descLabel:renderContent()
		descLabel:addTo(self._playerNode):posite(570, 168)
		descLabel:setTag(123)
	end

	for k, node in pairs(self._playerNode:getChildren()) do
		node:stopAllActionsByTag(123)
		node:setScale(1)
	end

	if hasAnim then
		for k, node in pairs(self._playerNode:getChildren()) do
			node:setScale(0.2)
			node:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1)))
		end
	end
end

function StagePracticeMediator:refreshPointPanel()
	local descLabel = self._infoNode:getChildByFullName("desclabel")

	descLabel:setString(self._curPointData:getStageDesc())

	local strId = "StagePractice_Text5"
	local canget = false

	if self._curPointData:getFirstPassState() == SPracticeRewardState.kCanGet then
		strId = "StagePracticeGetReward_Text"

		self._challBtnRedPoint:setVisible(true)

		canget = true
	else
		self._challBtnRedPoint:setVisible(false)
	end

	self._tiaozhan:setVisible(not canget)
	self._tiaozhanbg:setVisible(false)
	self._challageBtn:setVisible(not canget)
	self._challageBtnWidget:setVisible(canget)
	self._challageBtnWidget:getChildByName("name"):setString(Strings:get(strId))
	self._challageBtnWidget:getChildByName("name1"):setString(Strings:get("UITitle_EN_Lingqu"))

	if not canget then
		self._coinPanle:runAction(cc.FadeIn:create(1))
	else
		self._coinPanle:runAction(cc.FadeOut:create(0.1))
	end

	self._costNode:setVisible(false)
	self:refreshCostPanel()

	local pointName = self._mainPanel:getChildByFullName("bg_right.name")
	local hardLevel = self._mainPanel:getChildByFullName("bg_right.star")
	local stars = hardLevel:getChildren()

	for k, v in pairs(stars) do
		local index = string.split(v:getName(), "_")[2]

		v:setVisible(tonumber(index) <= self._curPointData:getStageHardLevel())
	end

	pointName:setString(self._curPointData:getName())

	local peopleNum = self._mainPanel:getChildByFullName("bg_right.peopleNum")

	peopleNum:setString(self._curPointData:getStageHeroNum())

	local winCondition = self._mainPanel:getChildByFullName("bg_right.title_5_desc")

	winCondition:setString(self._curPointData:getStageWinCondition())

	local havePass = self._mainPanel:getChildByFullName("bg_right.havepass")

	havePass:setVisible(self._curPointData:getFirstPassState() == SPracticeRewardState.kCanGet)

	self._pointindex = self._mainPanel:getChildByFullName("bg_right.point")

	self._pointindex:setString(self._curPointData:getPointIndex(self._curMapIndex, self._curPointIndex))

	local occupations = self._curPointData:getEnemysOccupation()
	local occupationIds = self:removeRepetion(occupations)

	for i = 1, 5 do
		self._mainPanel:getChildByFullName("bg_right.occupations.oc_" .. i):setVisible(false)
	end
end

function StagePracticeMediator:removeRepetion(cbCardData)
	assert(type(cbCardData) == "table")

	local bExist = {}

	for v, k in pairs(cbCardData) do
		bExist[k] = true
	end

	local result = {}

	for v, k in pairs(bExist) do
		table.insert(result, v)
	end

	return result
end

function StagePracticeMediator:createTabPanel()
	self._tabBtns = {}
	self._invalidButtons = {}

	for i = 1, #self._mapIds do
		local btn = self._mapNode:getChildByFullName("tabbtn_" .. i)

		btn.index = i

		btn:setVisible(true)

		local mapData = self._stagePractice:getMapByIndex(i)
		local nameStr = mapData:getName()
		local lightNode = btn:getChildByFullName("light_1")
		local lightLabel = lightNode:getChildByFullName("titlelabel")

		lightLabel:setString(nameStr)

		local darkNode = btn:getChildByFullName("dark_1")
		local darkLabel = darkNode:getChildByFullName("titlelabel")

		darkLabel:setString(nameStr)

		self._tabBtns[#self._tabBtns + 1] = btn

		btn:setTag(i)

		local showPanel = btn:getChildByFullName("showpanel")

		showPanel:setLocalZOrder(9999)

		function btn:refrshPassCount(index, stagePractice)
			local mapData = stagePractice:getMapByIndex(index)
			local showpanel = self:getChildByFullName("showpanel")

			showpanel:setVisible(mapData:getAllStar() > 0)

			local countLabel = self:getChildByFullName("showpanel.countlabel")
			local allconut = self:getChildByFullName("showpanel.countalllabel")

			countLabel:setString(mapData:getStar())
			allconut:setString("/" .. mapData:getAllStar())

			local img = self:getChildByFullName("showpanel.backimg")

			img:setGray(mapData:getStar() == 0)
		end

		function btn:refrshRedPoint(isVisible)
			btn.redPoint:setVisible(isVisible)
		end

		if mapData:isLock() then
			self._invalidButtons[#self._invalidButtons + 1] = btn
		end
	end

	self._tabController = TabController:new(self._tabBtns, function(name, tag)
		self:onClickTab(name, tag)
	end)
end

function StagePracticeMediator:refreshTabBtns()
	self._invalidButtons = {}

	for i = 1, #self._tabBtns do
		local btn = self._tabBtns[i]
		local mapData = self._stagePractice:getMapByIndex(i)

		btn:refrshPassCount(i, self._stagePractice)

		if mapData:isLock() then
			self._invalidButtons[#self._invalidButtons + 1] = btn
		end
	end

	self._tabController:setInvalidButtons(self._invalidButtons)
end

function StagePracticeMediator:refreshTableView(rankdata)
	if self._tableView then
		self._tableView:removeFromParent(true)
	end

	local clonePanel = self._clonePanel:getChildByFullName("pointpanel")
	local size = clonePanel:getContentSize()

	local function tableCellTouch(table, cell)
		local data = self._pointList[cell:getIdx() + 1]

		if not data then
			return
		end

		if data:isLock() then
			local condition = data:getUnlockCondition()

			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = condition.LEVEL .. "级解锁"
			}))

			return
		end

		local newIndex = cell:getIdx() + 1

		if newIndex == self._curPointIndex then
			return
		end

		self._curPointIndex = newIndex

		self._stagePracticeSystem:setCurPointIndex(self._curMapIndex, self._curPointIndex)
		self._stagePracticeSystem:setCurPoint(self._curMapIndex, self._pointList[self._curPointIndex])
		self:showReward(self._curPointData:getId())
		self:refreshData()
		self:clearSelectState()
		self:refreshPointPanel()
		self:switchStageEffect()
	end

	local function cellSizeForTable(table, idx)
		return size.width, size.height
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = clonePanel:clone()

			sprite:setPosition(cc.p(0, 4))
			sprite:setAnchorPoint(cc.p(0, 0))
			sprite:setVisible(true)
			cell:addChild(sprite, 11, 123)
			self:createCell(sprite, idx + 1)
		else
			local cell_Old = cell:getChildByTag(123)

			self:createCell(cell_Old, idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._pointList
	end

	local tableView = cc.TableView:create(self._listBg:getContentSize())

	tableView:setTag(1234)
	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setPosition(-10, -20)
	self._listBg:removeAllChildren()
	self._listBg:addChild(tableView, 0)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()

	self._tableView = tableView

	self:clearSelectState()
	self:runTableViewEffeft()
end

function StagePracticeMediator:showCurPointIdex()
	self._stagePracticeSystem:setCurPointIndex(self._curMapIndex, self._curPointIndex)
	self:showReward(self._curPointData:getId())
	self:refreshData()
	self:refreshPointPanel()
end

function StagePracticeMediator:setOnePointPanelInfo(data, cell, idx)
	local passData

	if data:getPassed() == 1 then
		local id = data:getId()

		passData = self._curMapRankFirstData[id]
	end

	self:clearCellproperties(cell)
	cell:getChildByFullName("redPoint"):setVisible(data:getFirstPassState() == SPracticeRewardState.kCanGet)

	local sucText = cell:getChildByFullName("sucLab")

	sucText:setTextColor(cc.c4b(0, 0, 0, 0))
	sucText:setVisible(data:getPassed() == 1)
	cell:getChildByFullName("bg.unselect"):setVisible(data:getPassed() ~= 1 and self._curPointIndex ~= idx)
	cell:getChildByFullName("bg.sucselect"):setVisible(data:getPassed() == 1 and self._curPointIndex ~= idx)
	cell:getChildByFullName("bg.select"):setVisible(self._curPointIndex == idx)
	cell:getChildByFullName("numberBg_2"):setVisible(self._curPointIndex == idx)
	cell:getChildByFullName("lingxing2"):setVisible(self._curPointIndex == idx)
	cell:getChildByFullName("selecttitle"):setVisible(false)
	cell:getChildByFullName("t_bg_1"):setVisible(self._curPointIndex ~= idx)

	local iconView = cc.MovieClip:create("baoshi_lingxingbaoshi")

	iconView:setScale(0.6)
	cell:getChildByFullName("lingxing2"):removeAllChildren()
	cell:getChildByFullName("lingxing2"):addChild(iconView)
	cell:getChildByFullName("Text_165"):setVisible(self._curPointIndex == idx)
	cell:getChildByFullName("cellpointindex"):setVisible(self._curPointIndex ~= idx)

	local titleLabel = cell:getChildByFullName("titlelabel")

	titleLabel:setVisible(self._curPointIndex ~= idx)
	titleLabel:setString(data:getName())

	local selectTitleLabel = cell:getChildByFullName("titlelabel_select")

	selectTitleLabel:setVisible(self._curPointIndex == idx)
	selectTitleLabel:setString(data:getName())
	cell:getChildByFullName("Text_165"):setString(data:getPointIndex(self._curMapIndex, idx))
	cell:getChildByFullName("cellpointindex"):setString(data:getPointIndex(self._curMapIndex, idx))
	cell:getChildByFullName("suo"):setVisible(self._pointList[idx]:isLock())

	local name = cell:getChildByFullName("playername")

	name:setVisible(data:getPassed() == 1)

	if data:getPassed() == 1 and passData then
		name:setString(passData.nickname)
	end

	local time = cell:getChildByFullName("time")

	time:setVisible(data:getPassed() == 1)

	if data:getPassed() == 1 and passData then
		time:setString(passData.value / 1000 .. "秒")
	end

	name:setVisible(false)
	time:setVisible(false)

	local iconPanel = cell:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()

	local hasPass = data:getPassed()
	local passImg = cell:getChildByTag(9999)

	if passImg then
		passImg:removeFromParent(true)
	end
end

function StagePracticeMediator:createCell(cell, idx)
	local oldcell = cell:getChildByTag(123)

	if oldcell then
		oldcell:removeFromParent(false)
	end

	cell:setTouchEnabled(true)
	cell:setSwallowTouches(false)
	cell:addTouchEventListener(function(sender, eventType)
		self:onCellClicked(sender, eventType, idx)
	end)

	local data = self._pointList[idx]
	local stageType = data:getType()

	self:setOnePointPanelInfo(data, cell, idx)
end

function StagePracticeMediator:refreshCellRedPoint(cell, idx)
	local data = self._pointList[idx]

	if not cell:getChildByTag(cellRedPointTag) then
		cell.redPoint = RedPoint:createDefaultNode()

		cell.redPoint:addTo(cell):posite(306, 64)
		cell.redPoint:setTag(cellRedPointTag)
	end

	cell.redPoint:setVisible(data:hasRedPoint())
end

function StagePracticeMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:dismiss()
	end
end

function StagePracticeMediator:onClickChallage(sender, eventType, pointId)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local pos = self._tableView:getContentOffset().y

		self._stagePracticeSystem:setOffsetX(pos)

		local mapId = self._curMapData:getId()

		if not pointId then
			::label_55_0::

			local curPointId = self._curPointData:getId()
			local pointData = self._stagePracticeSystem:getPointById(mapId, curPointId)

			if not pointId and pointData:getFirstPassState() == SPracticeRewardState.kCanGet then
				self._stagePracticeSystem:getPointReward(mapId, curPointId)

				return
			end

			self:pushTeamView(pointData)
		end
	end
end

function StagePracticeMediator:setCurPassStage(_isFist)
	if self._tableView then
		self:clearSelectState()
	end

	local passAll = true

	if _isFist == true then
		for k, v in pairs(self._pointList) do
			if v._passed == 0 then
				self._curPointIndex = k
				passAll = false

				break
			end
		end
	elseif self._curPointIndex + 1 <= #self._pointList and self._pointList[self._curPointIndex + 1]._passed == 1 or self._curPointIndex == #self._pointList then
		passAll = true
	else
		for k, v in pairs(self._pointList) do
			if v._passed == 0 then
				self._curPointIndex = k
				passAll = false

				break
			end
		end
	end

	if passAll then
		self._curPointIndex = self._curPointIndex or 1
	end

	self._curPointData = self._curMapData:getPointByIndex(self._curPointIndex)

	self._stagePracticeSystem:setCurPoint(self._curMapIndex, self._pointList[self._curPointIndex])
end

local ismove = false

function StagePracticeMediator:onCellClicked(sender, eventType, idx)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Select_1", false)

		ismove = false

		if self._pointList[idx]:isLock() then
			return
		end

		if not ismove then
			sender:setVisible(true)
		end

		ismove = false
		self._beganPos = sender:getTouchBeganPosition()
	elseif eventType == ccui.TouchEventType.moved then
		local beganPos = sender:getTouchBeganPosition()
		local movedPos = sender:getTouchMovePosition()

		ismove = true
	elseif eventType == ccui.TouchEventType.ended then
		-- block empty
	end
end

function StagePracticeMediator:onCellClickRank(sender, eventType, idx)
	if self._pointList[idx]:getPassed() == 1 then
		self:showRank(self._curMapRankFirstData[idx])
	end
end

function StagePracticeMediator:clearSelectState(defaultIndex)
	for i = 0, #self._pointList - 1 do
		local cell = self._tableView:cellAtIndex(i)

		if cell then
			if self._pointList[i + 1]:getPassed() == 1 then
				cell:getChildByTag(123):getChildByFullName("cellpointindex"):setVisible(true)
				cell:getChildByTag(123):getChildByFullName("Text_165"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("selecttitle"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("t_bg_1"):setVisible(true)
				cell:getChildByTag(123):getChildByFullName("bg.select"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("bg.sucselect"):setVisible(true)
				cell:getChildByTag(123):getChildByFullName("bg.unselect"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("selecttitle"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("numberBg_2"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("lingxing2"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("Text_165"):setVisible(false)
			else
				cell:getChildByTag(123):getChildByFullName("t_bg_2"):setVisible(true)
				cell:getChildByTag(123):getChildByFullName("bg.select"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("bg.sucselect"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("bg.unselect"):setVisible(true)
				cell:getChildByTag(123):getChildByFullName("selecttitle"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("numberBg_2"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("lingxing2"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("Text_165"):setVisible(false)
				cell:getChildByTag(123):getChildByFullName("cellpointindex"):setVisible(true)
			end

			cell:getChildByTag(123):getChildByFullName("titlelabel_select"):setVisible(false)
			cell:getChildByTag(123):getChildByFullName("lingxing2"):setVisible(false)
			cell:getChildByTag(123):getChildByFullName("titlelabel"):setVisible(true)
			cell:getChildByTag(123):getChildByFullName("titlelabel_select"):setVisible(false)
			self:clearCellproperties(cell:getChildByTag(123))

			if defaultIndex then
				cell:getChildByTag(123):getChildByFullName("bg.select"):setVisible(defaultIndex == i)
				cell:getChildByTag(123):getChildByFullName("Text_165"):setVisible(defaultIndex == i)
				cell:getChildByTag(123):getChildByFullName("selecttitle"):setVisible(defaultIndex == i)
				cell:getChildByTag(123):getChildByFullName("numberBg_2"):setVisible(defaultIndex == i)
				cell:getChildByTag(123):getChildByFullName("cellpointindex"):setVisible(defaultIndex ~= i)
				cell:getChildByTag(123):getChildByFullName("t_bg_2"):setVisible(defaultIndex ~= i)
			end
		end
	end
end

function StagePracticeMediator:onRankClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		local delegate, outSelf = {}, self

		function delegate:willClose(md, data)
			if data and data.enterTeam then
				outSelf:onClickChallage(nil, ccui.TouchEventType.ended, data.pointId)
			end
		end

		local view = self:getInjector():getInstance("StagePracticeRankView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			index = self._curPointIndex,
			mapId = self._curMapId
		}, delegate))
	end
end

function StagePracticeMediator:showRank()
	local delegate, outSelf = {}
	local view = self:getInjector():getInstance("StagePracticeRankView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		index = self._curPointIndex,
		mapId = self._curMapId
	}))
end

function StagePracticeMediator:onClickComment(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self._stagePracticeSystem:requestPointComment(self._curPointData:getId(), self._curMapId, function(response)
			local view = self:getInjector():getInstance("StagePracticeCommentView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				serverdata = response.data,
				poindid = self._curPointData:getId(),
				mapid = self._curMapId
			}))
		end)
	end
end

function StagePracticeMediator:onClickTab(name, tag)
	local mapData = self._stagePractice:getMapByIndex(tag)

	if mapData:isLock() then
		local condition = mapData:getStarCondition()
		local pointpass = mapData:getPreMapPass()
		local levelpass = self._developSystem:getLevel() >= mapData:getShowCondition().LEVEL

		if not levelpass then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = mapData:getShowCondition().LEVEL .. "级解锁"
			}))
		else
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = "请先通关" .. mapData:getPreMapName()
			}))
		end

		dump(mapData:getStarCondition(), "地图解锁条件")

		return
	end

	self._curMapIndex = tag

	self:updateBg(self._curMapIndex)

	if self._initPointIndex then
		self._curPointIndex = 1
	end

	self._initPointIndex = true

	self._stagePracticeSystem:requestEnterPracticeMain(mapData:getId(), function(response)
		self._curMapRankFirstData = response.data

		self:setupClickEnvs()
	end)
	self:refreshData()
	self:refreshPointPanel()
end

function StagePracticeMediator:updateBg(selectindex)
	local settingMdl = self:getInjector():getInstance(SettingSystem):getSettingModel()
	local isUseAnim = settingMdl:getRoleDynamic()

	if isUseAnim then
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", HeroSpriteConfig[selectindex].name)
		local heroSprite = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe9",
			id = roleModel,
			useAnim = isUseAnim
		})

		self._masterImg:removeChildByTag(690)
		heroSprite:addTo(self._masterImg):setTag(690)
		heroSprite:setScale(HeroSpriteConfig[selectindex].scale)
		heroSprite:setPosition(HeroSpriteConfig[selectindex].pos)
		heroSprite:setTouchEnabled(false)
	end

	for i = 1, 3 do
		self:getView():getChildByFullName("bg_" .. i):setVisible(selectindex == i)
		self._masterImg:getChildByFullName("lh_" .. i):setVisible(not isUseAnim and selectindex == i)
	end
end

function StagePracticeMediator:showReward(pointid)
	local rewards = self._stagePracticeSystem:getPointRewardConfig(pointid)

	for k, v in pairs(rewards) do
		local nodep = self._rewardNode:getChildByFullName("reward_" .. k)

		nodep:removeAllChildren()

		local info = {
			code = v.code,
			amount = v.amount,
			type = v.type
		}
		local reward = IconFactory:createRewardIcon(info, {
			showAmount = true,
			isWidget = true
		})

		reward:setScale(0.8)
		IconFactory:bindTouchHander(reward, IconTouchHandler:new(self), v, {
			needDelay = true
		})
		nodep:setVisible(true)
		nodep:addChild(reward)
	end

	self._rewardNode:getChildByFullName("haveGet"):setVisible((self._curPointData:getFirstPassState() == SPracticeRewardState.kHasGet or nil) and true)
end

function StagePracticeMediator:getTime(time)
	local h = math.floor(time / 3600)
	local m = math.floor((time - h * 3600) / 60)
	local s = math.floor(time - h * 3600 - m * 60)

	return (string.format("%02d:%02d:%02d", h, m, s))
end

function StagePracticeMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local listBg = self._mainPanel:getChildByFullName("listBg")

	if listBg then
		storyDirector:setClickEnv("StagePracticeMediator.missionList", listBg, function(sender, eventType)
			return
		end)
	end

	local rewardInfoBg = self._mainPanel:getChildByFullName("bg_right.rewardInfoBg")

	if rewardInfoBg then
		storyDirector:setClickEnv("StagePracticeMediator.rewardInfo", rewardInfoBg, function(sender, eventType)
			return
		end)
	end

	if self._challageBtnWidget then
		storyDirector:setClickEnv("StagePractice.challengeBtn", self._challageBtnWidget, function(sender, eventType)
			self:onClickChallage(sender, ccui.TouchEventType.began)
		end)
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_StagePractice_view")
	end))

	self:getView():runAction(sequence)
end

function StagePracticeMediator:switchStageEffect(isEnter)
	if self._stopSwitchCell then
		self._stopSwitchCell()
	end

	if self._stopSwitchPanel then
		self._stopSwitchPanel()
	end

	self:switchStageCellEffect()
	self:switchStagePointPanelEffect(isEnter)
end

function StagePracticeMediator:switchStageCellEffect()
	local cell = self._tableView:cellAtIndex(self._curPointIndex - 1)

	if cell then
		cell = cell:getChildByTag(123)

		local bg = cell:getChildByFullName("bg")
		local node1 = cell:getChildByFullName("numberBg_2")
		local node2 = cell:getChildByFullName("t_bg_1")
		local node3 = bg:getChildByFullName("select")
		local node4 = bg:getChildByFullName("sucselect"):isVisible() and bg:getChildByFullName("sucselect") or bg:getChildByFullName("unselect")
		local node5 = cell:getChildByFullName("cellpointindex")
		local node6 = cell:getChildByFullName("Text_165")
		local node7 = cell:getChildByFullName("lingxing2")
		local node8 = cell:getChildByFullName("titlelabel")
		local node9 = cell:getChildByFullName("titlelabel_select")

		node1:setVisible(true)
		node2:setVisible(true)
		node3:setVisible(true)
		node4:setVisible(true)
		node5:setVisible(true)
		node6:setVisible(true)
		node7:setVisible(true)
		node8:setVisible(true)
		node9:setVisible(true)

		local anim = cc.MovieClip:create("guanqia_z_d_yanjiusuo")

		cell:removeChildByTag(movieClipTag1, true)
		anim:addTo(cell, 0, movieClipTag1)

		local animNode1 = anim:getChildByName("numberBg2")
		local animNode2 = anim:getChildByName("numberBg1")
		local animNode3 = anim:getChildByName("bg2")
		local animNode4 = anim:getChildByName("bg1")
		local animNode5 = anim:getChildByName("index1")
		local animNode6 = anim:getChildByName("index2")
		local animNode7 = anim:getChildByName("lingxing2")
		local nodeToActionMap = {}

		nodeToActionMap[node1] = animNode1
		nodeToActionMap[node2] = animNode2
		nodeToActionMap[node3] = animNode3
		nodeToActionMap[node4] = animNode4
		nodeToActionMap[node5] = animNode5
		nodeToActionMap[node6] = animNode6
		nodeToActionMap[node7] = animNode7
		nodeToActionMap[node8] = anim:getChildByName("name1")
		nodeToActionMap[node9] = anim:getChildByName("name2")

		local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, cell, false)

		startFunc()

		local action = performWithDelay(cell, function()
			stopFunc()
			anim:removeFromParent()

			self._stopSwitchCell = nil
		end, 1)

		function self._stopSwitchCell()
			cell:stopAction(action)
			stopFunc()
			anim:removeFromParent()

			self._stopSwitchCell = nil
		end
	end
end

function StagePracticeMediator:switchStagePointPanelEffect(isEnter)
	if not isEnter then
		self:switchStageRewardEffect()
	end

	local mainPanel = self._mainPanel
	local node1 = mainPanel:getChildByFullName("bg_right_0")
	local node2 = mainPanel:getChildByFullName("bg_right.point")
	local node3 = mainPanel:getChildByFullName("bg_right.name")
	local node4 = mainPanel:getChildByFullName("bg_right.Image_6")
	local node5 = mainPanel:getChildByFullName("bg_right.title_5")
	local node6 = mainPanel:getChildByFullName("bg_right.title_5_desc")
	local node7 = mainPanel:getChildByFullName("pinglunBtn")

	node1:setVisible(true)
	node2:setVisible(true)
	node3:setVisible(true)
	node4:setVisible(true)
	node5:setVisible(true)
	node6:setVisible(true)
	node7:setVisible(true)

	local anim = cc.MovieClip:create("yanjiusuo_yanjiusuo")

	anim:gotoAndPlay(24)
	mainPanel:removeChildByTag(movieClipTag2, true)
	anim:addTo(mainPanel, 0, movieClipTag2)

	local animNode1 = anim:getChildByName("bg_right_0")
	local animNode2 = anim:getChildByName("name")
	local animNode3 = anim:getChildByName("Image_6")
	local animNode4 = anim:getChildByName("title_5")
	local nodeToActionMap = {}

	nodeToActionMap[node1] = animNode1
	nodeToActionMap[node2] = animNode2
	nodeToActionMap[node3] = animNode2
	nodeToActionMap[node4] = animNode3
	nodeToActionMap[node5] = animNode4
	nodeToActionMap[node6] = animNode4
	nodeToActionMap[node7] = anim:getChildByName("comment")

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, mainPanel, false)

	startFunc()

	local action = performWithDelay(mainPanel, function()
		stopFunc()
		anim:removeFromParent()

		self._stopSwitchPanel = nil
	end, 2)

	function self._stopSwitchPanel()
		mainPanel:stopAction(action)
		stopFunc(true)
		anim:removeFromParent()

		self._stopSwitchPanel = nil
	end

	self._tiaozhan:setOpacity(0)

	local act = cc.Sequence:create(cc.DelayTime:create(0.4375), cc.FadeIn:create(0.3125))

	self._tiaozhan:runAction(act:clone())
end

function StagePracticeMediator:switchStageRewardEffect()
	local action = cc.CSLoader:createTimeline("asset/ui/StagePractice.csb")

	action:setTag(rewardActionTag)
	self:getView():stopActionByTag(rewardActionTag)
	self:getView():runAction(action)
	action:play("reward", false)
end

function StagePracticeMediator:clearCellproperties(cell)
	cell:getChildByFullName("bg.select"):setScaleY(1)
	cell:getChildByFullName("bg.select"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("bg.sucselect"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("bg.sucselect"):setScaleY(1)
	cell:getChildByFullName("bg.unselect"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("bg.unselect"):setScaleY(1)
	cell:getChildByFullName("numberBg_2"):setScale(1)
	cell:getChildByFullName("numberBg_2"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("t_bg_1"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("cellpointindex"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("Text_165"):setScale(1)
	cell:getChildByFullName("Text_165"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("lingxing2"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("titlelabel"):setColorTransform(ColorTransform(1, 1, 1, 1))
	cell:getChildByFullName("titlelabel_select"):setColorTransform(ColorTransform(1, 1, 1, 1))
end
