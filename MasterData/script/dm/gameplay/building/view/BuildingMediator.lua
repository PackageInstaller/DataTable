-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingMediator.lua

local showDrwaState = false

BuildingMediator = class("BuildingMediator", DmAreaViewMediator)

BuildingMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")
BuildingMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local clickEventMap = {}

function BuildingMediator:initialize()
	super.initialize(self)
end

function BuildingMediator:dispose()
	if self._enterHeroAudio then
		AudioEngine:getInstance():stopEffect(self._enterHeroAudio)

		self._enterHeroAudio = nil
	end

	if self._schedule_cd then
		LuaScheduler:getInstance():unschedule(self._schedule_cd)

		self._schedule_cd = nil
	end

	self._buildingSystem:switchSelfBuild()
	super.dispose(self)
end

function BuildingMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function BuildingMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_UNLOCK_ROOM_SUCCESS, self, self.updateLock)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_ROOM_MOVE, self, self.onRoomMove)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_BUY_PUT_TO_MAP, self, self.onBuyBuilding)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_BUY_BUILDING_SUC, self, self.onBuyBuildingSuc)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_MOVE_BUILDING_SUC, self, self.onSendMoveBuildingSuc)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_ACTIVATE_BUILDING_SUC, self, self.onActiveBuildingSuc)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_BUILDING_SUC, self, self.onBuildingStaChanged)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_CANEL_BUILDING_SUC, self, self.onBuildingStaChanged)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_FINISH_BUILDING_SUC, self, self.onBuildingStaChanged)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_LVUP_BUILDING_SUC, self, self.updateLockComponent)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_COMFORT_REFRESH, self, self.onComfortRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_RECYCLE_SUC, self, self.onRecycleSuc)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_WAREHOUSE_TO_MAP, self, self.onWarehouseToMap)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_WAREHOUSE_TO_MAP_SUC, self, self.onWarehouseToMapSuc)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_PUTHEROS_SUCCESS, self, self.onPutHeroSuc)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_COLLECT_RESOUSE_SUC, self, self.onCollectResouseSuc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.onResetDone)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_EVT_OPERATE_BUILD_REVERT_REFRESH, self, self.onOperateRevertRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_EVT_ENTER_ROOM, self, self.onMoveToRoom)
	self.mapEventListener(self, self:getEventDispatcher(), BUILDING_EVT_GETRES_SUCCESS, self, self.onEventGetResAnim)
end

function BuildingMediator:enterWithData(enterData)
	self.__enterData = enterData
	self._buildingSystem._mapShowType = KBuildingMapShowType.kAll
	self._minCollectionViewScale = 0
	self._collectionViewScale = 0

	self._buildingSystem:setOperateInfo(nil)
	self._buildingSystem:setShowRoomId("")
	self._buildingSystem:clearAllHeroPutInfo()

	self._buildingSystem._buildingLvUpFinishShowSta = false
	self._addComponentNum = 0

	self:setupView()
	self:createCollectionView()
	self:initCollectionViewScale()
	AudioEngine:getInstance():playBackgroundMusic("Mus_Main_House")

	local enterLoadingView = self:getInjector():getInstance("enterLoadingView")

	enterLoadingView:addTo(self:getView(), 10000)
	AdjustUtils.adjustLayoutUIByRootNode(enterLoadingView)

	local mediator = self:getMediatorMap():retrieveMediator(enterLoadingView)

	local function onCompleted()
		enterLoadingView:removeFromParent()
		self:showAfterLoading()
		self:addShare()
		self:playEnterViewVoice()
	end

	if mediator then
		local var_5_0 = {
			loadingTask = self:buildLoadingTask()
		}

		var_5_0.loadingWidget = self:getInjector():injectInto(BuildLoadingWidget:new())
		var_5_0.onCompleted = onCompleted

		mediator:enterWithData(var_5_0)
	end

	self._buildingSystem:sendRefreshAfkEvent()
end

function BuildingMediator:addShare()
	local data = {
		enterType = ShareEnterType.KBuilding,
		node = self:getView(),
		preConfig = function()
			self._mainComponentView:setVisible(false)
			self._decorateComponent:refreshHeroList(true)
			self._decorateComponent:showRoomHeroList()
			self._decorateComponent:hideOtherRoomHeroList()
			self._lockComponent:showRoomLockImage(false)
		end,
		endConfig = function()
			self._mainComponentView:setVisible(true)
			self._decorateComponent:hideRoomHeroList()
			self._lockComponent:showRoomLockImage(true)
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)
end

function BuildingMediator:buildLoadingTask()
	local taskBuilder = timesharding.TaskBuilder:new()
	local timeBuild = self._gameServerAgent:remoteTimestamp()
	local task = taskBuilder:buildParalelTask(function()
		SEQUENCE(30)
		ADD_TASK(1, timesharding.CustomTask:new(function(task)
			self:addTiledComponent()
			self:addMapComponent()
			self._collectionView:reloadData()
			self:addLockComponent()
			self:addMainComponent()
			self:addTouchComponent()
			self:addDecorateComponent()
			self:addBuildingLootComponent()
			self._decorateComponent:initRankBtn()

			local waitTime = 3

			performWithDelay(self:getView(), function()
				self._buildingSystem:sendGetHeroLove(true)
				self:mapEventListeners()
				self:startMainLoop()
				self:setupClickEnvs()
				task:finish()
			end, waitTime)
		end))
		END()
	end)

	task:setTimeLimitation(30)

	return task
end

function BuildingMediator:scheduleAddComponent()
	self._addComponentNum = self._addComponentNum + 1

	if self._addComponentNum == 1 then
		self:addTiledComponent()
	elseif self._addComponentNum == 2 then
		self:addMapComponent()
	elseif self._addComponentNum == 3 then
		self._collectionView:reloadData()
	elseif self._addComponentNum == 4 then
		self:addLockComponent()
	elseif self._addComponentNum == 5 then
		self:addDecorateComponent()
	elseif self._addComponentNum == 6 then
		self:addMainComponent()
		self:addTouchComponent()
	elseif self._addComponentNum == 7 then
		self:startMainLoop()
		self:mapEventListeners()
	elseif self._addComponentNum == 8 then
		self:setupClickEnvs()
	elseif self._addComponentNum == 9 then
		self._decorateComponent:initRankBtn()
	else
		return false
	end

	return true
end

function BuildingMediator:addMapComponent()
	local mapComponent = cc.Node:create():addTo(self._scrollView, KBuildingComponentZOrder.kMap)

	self._mapComponent = self:getInjector():instantiate("BuildingMapComponent", {
		view = mapComponent
	})

	self._mapComponent:setBuildingMediator(self)
	self._mapComponent:enterWithData()
	self._mapComponent:getView():setVisible(false)
end

function BuildingMediator:addTiledComponent()
	local tiledMapComponent = cc.Node:create():addTo(self._scrollView, KBuildingComponentZOrder.kTiledMap)

	self._tiledMapComponent = self:getInjector():instantiate("BuildingTiledMapComponent", {
		view = tiledMapComponent
	})

	self._tiledMapComponent:setBuildingMediator(self)
	self._tiledMapComponent:enterWithData()
end

function BuildingMediator:addDecorateComponent(endCallback)
	local decorateComponent = cc.Node:create():addTo(self._scrollView, KBuildingComponentZOrder.kDecorate)

	self._decorateComponent = self:getInjector():instantiate("BuildingDecorateComponent", {
		view = decorateComponent
	})

	self._decorateComponent:setBuildingMediator(self)
	self._decorateComponent:enterWithData(endCallback)
	self._decorateComponent:refreshHeroList()
end

function BuildingMediator:addBuildingLootComponent(endCallback)
	local lootComponent = cc.Node:create():addTo(self:getView(), 99999)

	self._lootComponent = self:getInjector():instantiate("BuildingLootWidget", {
		view = lootComponent
	})

	self._lootComponent:setBuildingMediator(self)
end

function BuildingMediator:addLockComponent()
	local lockComponent = cc.Node:create():addTo(self._scrollView, KBuildingComponentZOrder.kLock)

	self._lockComponent = self:getInjector():instantiate("BuildingLockComponent", {
		view = lockComponent
	})

	self._lockComponent:setBuildingMediator(self)
	self._lockComponent:enterWithData()
end

function BuildingMediator:addMainComponent()
	local buildingMain = self:getInjector():getInstance("BuildingMain")

	self._mainComponent = self:getInjector():instantiate("BuildingMainComponent", {
		view = buildingMain
	})

	buildingMain:addTo(self._panel_base, 3):center(self._panel_base:getContentSize())
	self._mainComponent:setBuildingMediator(self)
	self._mainComponent:setupTopInfoWidget()
	self._mainComponent:enterWithData()

	self._mainComponentView = self._mainComponent:getView()
end

function BuildingMediator:addTouchComponent()
	local touchComponent = cc.Layer:create():addTo(self._panel_base, 1):center(self._panel_base:getContentSize())

	self._touchComponent = self:getInjector():instantiate("BuildingTouchComponent", {
		view = touchComponent
	})

	self._touchComponent:setBuildingMediator(self)
	self._touchComponent:enterWithData()
end

function BuildingMediator:setupView()
	self._panel_base = self:getView():getChildByFullName("Panel_base")
	self._scrollView = self._panel_base:getChildByFullName("ScrollView")

	local mapBg = self._scrollView:getChildByFullName("Image_map")

	self._scrollView:setLocalZOrder(3)
	mapBg:setPosition(cc.p(0, 0))
end

function BuildingMediator:startMainLoop()
	if self._schedule_cd then
		return
	end

	self._schedule_cd = LuaScheduler:getInstance():schedule(function()
		self:tick()
	end, 1, false)

	self:tick()
end

function BuildingMediator:tick()
	self._decorateComponent:refreshBuildingCd()
	self._decorateComponent:refreshHeroCd()
	self._buildingSystem:showLvUpSucView()
	self._mainComponent:refreshQueueNum()
	self._mainComponent:refreshRedPoint()
end

function BuildingMediator:createCollectionView()
	self._scrollView:setScrollBarEnabled(false)

	self._scrollViewSize = self._scrollView:getContentSize()

	local info = {
		isCreateAll = false,
		extraOffset = 0,
		isSchedule = true,
		isReuse = true,
		reloadDataSchedule = true,
		view = self._scrollView,
		delegate = self,
		cellNumSize = KBUILDING_MAP_CELL_NUM,
		cellSize = KBUILDING_MAP_CELL_SIZE
	}

	self._collectionView = CollectionViewUtils:new(info)
	self._containerSize = self._scrollView:getInnerContainerSize()
end

function BuildingMediator:setScrollViewTouchEnable(enabled)
	self._scrollView:setTouchEnabled(enabled)
end

function BuildingMediator:cellAtIndex(view, row, col)
	local key = row .. "_" .. col
	local cell = self._collectionView:dequeueCellByKey(key)

	if not cell then
		cell = self._mapComponent:getMapCell(row, col):getView()

		cell:setName(key)
	end

	return cell
end

function BuildingMediator:cellWillHide(view, row, col, cell)
	self._mapComponent:hideMapCell(row, col)
end

function BuildingMediator:cellWillShow(view, row, col, cell)
	self._mapComponent:showMapCell(row, col)
	self._mapComponent:refreshMapCell(row, col)
end

function BuildingMediator:onEventForCollectionView(...)
	return
end

function BuildingMediator:initCollectionViewScale()
	local mapSize = cc.size(KBUILDING_MAP_CELL_SIZE.width * KBUILDING_MAP_CELL_NUM.width, KBUILDING_MAP_CELL_SIZE.height * KBUILDING_MAP_CELL_NUM.height)
	local winSize = cc.Director:getInstance():getWinSize()
	local sacaleX = winSize.width / mapSize.width
	local sacaleY = winSize.height / mapSize.height

	if sacaleX < sacaleY then
		sacaleX = sacaleY
	end

	self._minCollectionViewScale = sacaleX
	self._collectionViewScale = self._minCollectionViewScale

	self._buildingSystem:resetBuildResouseMaxScale(self._collectionViewScale)
	self._collectionView:setZoomScale(self._minCollectionViewScale)
	self:setScrollViewTouchEnable(false)
end

function BuildingMediator:enterRoomByPos(worldPos, firstRoomId)
	local roomId = self._tiledMapComponent:getEnterRoomIdByPos(worldPos)
	local winSize = cc.Director:getInstance():getWinSize()

	if roomId then
		local openState, str = self._buildingSystem:getRoomOpenSta(roomId)

		if not openState and firstRoomId then
			openState = true
			roomId = firstRoomId
		end

		if openState then
			self:enterRoom(roomId)

			return
		elseif self._buildingSystem:canUnlockRoom(roomId) then
			if not self._buildingSystem:isSelfBuilding() then
				return
			end

			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:showUnlockRoom(roomId)
		elseif str and str ~= "" then
			self:dispatch(ShowTipEvent({
				duration = 0.5,
				tip = str
			}))
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		end
	elseif firstRoomId then
		self:enterRoom(firstRoomId)

		return
	end

	if self._collectionViewScale ~= self._minCollectionViewScale then
		local centerWorldPos = worldPos

		self._collectionViewScale = self._minCollectionViewScale

		self._collectionView:zoomScaleToCenterByTime(self._minCollectionViewScale, centerWorldPos, cc.p(winSize.width / 2, winSize.height / 2), 0.15)
	end
end

function BuildingMediator:showUnlockRoom(roomId)
	local view = self:getInjector():getInstance("BuildingUnlockRoomView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		roomId = roomId
	})

	self:dispatch(event)
end

function BuildingMediator:onMoveToRoom(event)
	local roomId = event:getData().roomId
	local time = event:getData().time

	if roomId then
		self:moveToRoom(roomId, time)
	end
end

function BuildingMediator:enterRoom(roomId, time)
	DmGame:getInstance()._injector:getInstance(ShareSystem):setShareVisible({
		status = false,
		enterType = ShareEnterType.KBuilding,
		node = self:getView()
	})

	local function timeCallfun()
		self._buildingSystem._mapShowType = KBuildingMapShowType.kInRoom

		self._decorateComponent:refreshBuildingList()
		self._decorateComponent:refreshHeroList()
		self._decorateComponent:showRoomHeroList()
		self._decorateComponent:hideOtherRoomHeroList(true)
		self._decorateComponent:hideOtherRoomBuilding(true)
		self._collectionView:reFreshCurCells()
		self._mainComponent:showCornerMask()
	end

	local function endCallfun()
		self._decorateComponent:refreshBuildResourceSacle()
		self._lockComponent:refreshRoomLock()
	end

	local centerWorldPos = self._tiledMapComponent:getRoomCenterWorldPos(roomId)
	local winSize = cc.Director:getInstance():getWinSize()

	self._buildingSystem:setShowRoomId(roomId)

	self._collectionViewScale = KBUILDING_MAP_INROOM_SCALE

	local scaleTime = time or KBUILDING_CHANGE_SCALE_TIME

	self._collectionView:zoomScaleToCenterByTime(self._collectionViewScale, centerWorldPos, cc.p(winSize.width / 2, winSize.height / 2), scaleTime, timeCallfun, scaleTime / 1.5, endCallfun)
	self._decorateComponent:hideBuildResource()
	self._lockComponent:hideRoomLockDes()
	self._mapComponent:getView():setVisible(true)
end

function BuildingMediator:enterShowAll()
	DmGame:getInstance()._injector:getInstance(ShareSystem):setShareVisible({
		status = true,
		enterType = ShareEnterType.KBuilding,
		node = self:getView()
	})

	local function timeCallfun()
		self._decorateComponent:refreshBuildingList(true)
	end

	local function endCallfun()
		self._decorateComponent:refreshBuildResourceSacle()
		self._lockComponent:refreshRoomLock()
		self._mapComponent:getView():setVisible(false)

		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		storyDirector:notifyWaiting("enter_building_main_view")
		self._mainComponent:hideCornerMask()
	end

	local roomId = self._buildingSystem:getShowRoomId()

	self._buildingSystem:setShowRoomId("")

	self._collectionViewScale = self._minCollectionViewScale

	local winSize = cc.Director:getInstance():getWinSize()
	local centerWorldPos = self._tiledMapComponent:getRoomCenterWorldPos("Room6")
	local scaleTime = KBUILDING_CHANGE_SCALE_TIME

	self._buildingSystem._mapShowType = KBuildingMapShowType.kAll

	self._collectionView:zoomScaleToCenterByTime(self._minCollectionViewScale, centerWorldPos, cc.p(winSize.width / 2, winSize.height / 2), scaleTime, timeCallfun, scaleTime / 3, endCallfun)
	self._decorateComponent:hideBuildResource()
	self._lockComponent:hideRoomLockDes()
	self._decorateComponent:showRoomHeroList()
end

function BuildingMediator:moveToRoom(roomId, time)
	self._buildingSystem:setShowRoomId(roomId)

	local centerWorldPos = self._tiledMapComponent:getRoomCenterWorldPos(roomId)

	self._collectionViewScale = KBUILDING_MAP_INROOM_SCALE

	local winSize = cc.Director:getInstance():getWinSize()

	self._collectionView:zoomScaleToCenterByTime(nil, centerWorldPos, cc.p(winSize.width / 2, winSize.height / 2), time or KBUILDING_CHANGE_SCALE_TIME)
	self._decorateComponent:showRoomHeroList()
	self._decorateComponent:hideOtherRoomHeroList(true)
	self._decorateComponent:refreshBuildingList()
	self._decorateComponent:hideOtherRoomBuilding(true)
end

function BuildingMediator:changeCollectionViewSacleInAll(diffLen, centerWorldPos)
	local mapWidth = KBUILDING_MAP_CELL_SIZE.width * KBUILDING_MAP_CELL_NUM.width
	local widthAgo = self._collectionViewScale * mapWidth
	local scaleNow = (widthAgo + diffLen) / mapWidth
	local changeScale = 0

	if scaleNow < self._minCollectionViewScale then
		scaleNow = self._minCollectionViewScale
	end

	local maxScale = self._minCollectionViewScale + KBUILDING_MAP_INALL_SCALE_DIFF

	if maxScale < scaleNow then
		scaleNow = maxScale
	end

	changeScale = scaleNow - self._collectionViewScale

	if self._collectionViewScale ~= scaleNow then
		self._collectionViewScale = scaleNow

		self._collectionView:setZoomScale(self._collectionViewScale, centerWorldPos)
	end

	return changeScale
end

function BuildingMediator:changeCollectionViewSacleInRoom(diffLen, centerWorldPos)
	local mapWidth = KBUILDING_MAP_CELL_SIZE.width * KBUILDING_MAP_CELL_NUM.width
	local widthAgo = self._collectionViewScale * mapWidth
	local scaleNow = (widthAgo + diffLen) / mapWidth
	local changeScale = 0

	if scaleNow > KBUILDING_MAP_INROOM_SCALE then
		scaleNow = KBUILDING_MAP_INROOM_SCALE
	end

	local minScale = KBUILDING_MAP_INROOM_SCALE - KBUILDING_MAP_INALL_SCALE_DIFF

	if scaleNow < minScale then
		scaleNow = minScale
	end

	changeScale = scaleNow - self._collectionViewScale

	if self._collectionViewScale ~= scaleNow then
		self._collectionViewScale = scaleNow

		self._collectionView:setZoomScale(self._collectionViewScale, centerWorldPos)
	end

	return changeScale
end

function BuildingMediator:setScrollViewPosition(pos)
	local targetPos = cc.p(pos.x, pos.y)

	targetPos.x = targetPos.x > 0 and 0 or targetPos.x
	targetPos.y = targetPos.y > 0 and 0 or targetPos.y

	local viewSize = self._scrollView:getContentSize()
	local curSize = self._scrollView:getInnerContainerSize()
	local minX = viewSize.width - curSize.width
	local minY = viewSize.height - curSize.height

	targetPos.x = minX > targetPos.x and minX or targetPos.x
	targetPos.y = minY > targetPos.y and minY or targetPos.y

	self._scrollView:setInnerContainerPosition(targetPos)
end

function BuildingMediator:getScrollViewPosition()
	return self._scrollView:getInnerContainerPosition()
end

function BuildingMediator:getActionRuning()
	if self._scrollView:getActionByTag(1001) then
		return true
	end

	return false
end

function BuildingMediator:updateLock(event)
	local roomId = event:getData().roomId

	if self._tiledMapComponent then
		self._tiledMapComponent:refreshTiledMapList()
	end

	if self._lockComponent then
		self._lockComponent:refreshView()
	end

	if self._decorateComponent and roomId then
		self._decorateComponent:refreshRoom(roomId)
	end
end

function BuildingMediator:updateLockComponent(event)
	if self._lockComponent then
		self._lockComponent:refreshView()
	end
end

function BuildingMediator:onRoomMove(event)
	local roomId = event:getData().roomId
	local time = event:getData().time

	self:moveToRoom(roomId, time)
end

function BuildingMediator:createDebugGrid()
	if not showDrwaState then
		return
	end

	local debugNode = cc.DrawNode:create()
	local cellSize = cc.size(200, 200)
	local widthNum = 100

	for i = 1, widthNum do
		local pos1_origin = cc.p(i * cellSize.width, 0)
		local pos1_des = cc.p(i * cellSize.width, 10000)

		debugNode:drawLine(pos1_origin, pos1_des, cc.c4f(1, 0, 0, 1))
	end

	local heightNum = 100

	for j = 1, heightNum do
		local pos1_origin = cc.p(0, j * cellSize.height)
		local pos1_des = cc.p(10000, j * cellSize.height)

		debugNode:drawLine(pos1_origin, pos1_des, cc.c4f(1, 0, 0, 1))
	end

	debugNode:setGlobalZOrder(999999999)
	debugNode:setScale(0.19)
	self._panel_base:addChild(debugNode)
end

function BuildingMediator:onBuyBuilding(event)
	local buildingId = event:getData().buildingId
	local pos = event:getData().pos
	local roomId = event:getData().roomId
	local another = event:getData().another

	if not buildingId or not pos or not roomId then
		return
	end

	if self:getActionRuning() then
		return
	end

	if self._decorateComponent:getBuyingBuilding() then
		return
	end

	if roomId ~= self._buildingSystem:getShowRoomId() then
		return
	end

	local info = {
		buildingId = buildingId,
		pos = cc.p(pos.x, pos.y),
		roomId = roomId,
		another = another
	}

	info.revert = false
	info.operateType = KBuildingOperateType.kBuy

	self._buildingSystem:setOperateInfo(info)
	self._decorateComponent:showBuyingBuilding()
	self._mainComponent:refreshLayerBtn()
	self._decorateComponent:hideRoomHeroList()

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("guide_buy_building")
end

function BuildingMediator:removeBuyBuilding()
	self._buildingSystem:setOperateInfo(nil)
	self._decorateComponent:removeBuyingBuilding()
	self._mainComponent:refreshLayerBtn()
	self._decorateComponent:showRoomHeroList()
	self._decorateComponent:hideOtherRoomHeroList()
end

function BuildingMediator:onBuyBuildingSuc(event)
	self._mainComponent:refreshBuildOutPut()

	local roomId = event:getData().roomId

	if roomId then
		self._decorateComponent:refreshRoom(roomId)
	end

	self:removeBuyBuilding()
	self:tick()
end

function BuildingMediator:onMoveBuilding(roomId, id)
	if self:getActionRuning() then
		return
	end

	if not roomId or not id then
		return
	end

	if self._decorateComponent:getOperationBuilding() then
		return
	end

	if roomId ~= self._buildingSystem:getShowRoomId() then
		return
	end

	local buildingData = self._buildingSystem:getBuildingData(roomId, id)

	if not buildingData then
		return
	end

	local info = {
		buildingId = buildingData._configId,
		pos = cc.p(buildingData._pos.x, buildingData._pos.y),
		id = id,
		type = buildingData._type,
		roomId = roomId
	}

	info.revert = buildingData._revert
	info.operateType = KBuildingOperateType.kMove

	self._buildingSystem:setOperateInfo(info)
	self._decorateComponent:showOperationBuilding()

	if buildingData._type == KBuildingType.kDecorate then
		self._mainComponent:refreshLayerBtn()
	else
		self._mainComponent:refreshLayerBtn()
	end

	self._decorateComponent:hideRoomHeroList()
end

function BuildingMediator:onSendMoveBuildingSuc(event)
	if event and event:getData() then
		local roomId = event:getData().roomId

		if roomId then
			self._decorateComponent:refreshRoom(roomId)
		end
	end

	self._buildingSystem:setOperateInfo(nil)
	self._decorateComponent:removeOperationBuilding()
	self._mainComponent:refreshLayerBtn()
	self._decorateComponent:showRoomHeroList()
	self._decorateComponent:hideOtherRoomHeroList()
end

function BuildingMediator:onMoveBuildingFinsh()
	local info = self._buildingSystem:getOperateInfo()

	if self._buildingSystem:getBuildCanTouchMove(info.buildingId) or self._buildingSystem:getBuildCanTurn(info.buildingId) then
		local outPos = self._buildingSystem:getMapBuildingPosList(info.roomId, info.id)

		if self._buildingSystem:getBuildingCanChangeToPos(info.roomId, info.buildingId, info.pos, outPos, info.revert) then
			local params = {}

			params.roomId = info.roomId
			params.buildId = info.id
			params.posX = info.pos.x
			params.posY = info.pos.y
			params.turn = info.revert and 1 or 0

			self._buildingSystem:sendMoveBuilding(params, true)
		else
			self:dispatch(ShowTipEvent({
				duration = 0.5,
				tip = Strings:get("Building_Tips_Cover")
			}))
		end
	else
		self:dispatch(Event:new(BUILDING_MOVE_BUILDING_SUC, {
			roomId = info.roomId
		}))
	end
end

function BuildingMediator:onActiveBuilding(roomId, id)
	if not roomId or not id then
		return
	end

	local params = {}

	params.roomId = roomId
	params.buildId = id

	self._buildingSystem:sendActivateBuilding(params, true)
end

function BuildingMediator:onActiveBuildingSuc(event)
	local roomId = event:getData().roomId
	local id = event:getData().id

	if roomId and id then
		self._decorateComponent:refreshRoomActivate(roomId)

		local buildingData = self._buildingSystem:getBuildingData(roomId, id)

		if buildingData then
			local config = self._buildingSystem:getBuildingConfig(buildingData._configId)

			self:dispatch(ShowTipEvent({
				duration = 0.5,
				tip = Strings:get("Building_Tips_Activate", {
					name = Strings:get(config.Name)
				})
			}))
		end
	end
end

function BuildingMediator:onBuildingStaChanged(event)
	self._mainComponent:refreshLayerBtn()
	self._mainComponent:refreshBuildOutPut()

	local roomId = event:getData().roomId
	local id = event:getData().id

	if roomId and id then
		self._decorateComponent:refreshBuildingLvInfo(roomId, id)
	end

	self:tick()
end

function BuildingMediator:onComfortRefresh(event)
	self._mainComponent:refreshComfort()
end

function BuildingMediator:onRecycleSuc(event)
	local roomId = event:getData().roomId
	local id = event:getData().id

	if roomId and id then
		self._decorateComponent:removeBuilding(roomId, id)
	end

	self._buildingSystem:setOperateInfo(nil)
	self._mainComponent:refreshLayerBtn()
	self._decorateComponent:showRoomHeroList()
	self._decorateComponent:hideOtherRoomHeroList()
	self:dispatch(ShowTipEvent({
		duration = 0.5,
		tip = Strings:get("Building_Tips_Recovery")
	}))
end

function BuildingMediator:onWarehouseToMap(event)
	local buildingId = event:getData().buildingId
	local pos = event:getData().pos
	local roomId = event:getData().roomId
	local id = event:getData().id

	if not buildingId or not pos or not roomId and not id then
		return
	end

	if self:getActionRuning() then
		return
	end

	if self._decorateComponent:getWarehouseBuilding() then
		return
	end

	if roomId ~= self._buildingSystem:getShowRoomId() then
		return
	end

	local info = {
		buildingId = buildingId,
		pos = cc.p(pos.x, pos.y),
		roomId = roomId,
		id = id
	}

	info.revert = event:getData().revert
	info.operateType = KBuildingOperateType.kRecycle

	self._buildingSystem:setOperateInfo(info)
	self._decorateComponent:showWarehouseBuilding()
	self._mainComponent:refreshLayerBtn()
	self._decorateComponent:hideRoomHeroList()
end

function BuildingMediator:removeWarehouseBuilding()
	self._buildingSystem:setOperateInfo(nil)
	self._decorateComponent:removeWarehouseBuilding()
	self._mainComponent:refreshLayerBtn()
end

function BuildingMediator:onWarehouseToMapSuc(event)
	local roomId = event:getData().roomId

	if roomId then
		self._decorateComponent:refreshRoom(roomId)
	end

	self:removeWarehouseBuilding()
	self._decorateComponent:showRoomHeroList()
	self._decorateComponent:hideOtherRoomHeroList()
end

function BuildingMediator:onPutHeroSuc(event)
	local roomId = event:getData().roomId

	if roomId then
		self._decorateComponent:refreshRoomHeroList(roomId)
	end

	self._mainComponent:refreshBuildOutPut()
end

function BuildingMediator:onCollectResouseSuc(event)
	local roomResList = event:getData().roomResList
	local place = event:getData().place

	if place == "main" then
		self._decorateComponent:refreshBuildingCd(roomResList)
	end
end

function BuildingMediator:initChat()
	local view = self:getInjector():getInstance("SmallChat")

	if view then
		view:setPosition(cc.p(-680, 140))
		self:getView():addChild(view)
		AdjustUtils.adjustLayoutByType(view, AdjustUtils.kAdjustType.Left)

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			mediator:enterWithData(nil)

			self._chatMediator = mediator
		end
	end
end

function BuildingMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("enter_building_view_init")

	local sequence = cc.Sequence:create(cc.DelayTime:create(0.2), cc.CallFunc:create(function()
		local roomId = "Room5"
		local roomNode = self._tiledMapComponent:getRoomNode(roomId)

		if roomNode then
			storyDirector:setClickEnv("BuildingView.UnlockRoom5", roomNode, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
				self:showUnlockRoom(roomId)
			end)
		end

		local button_put = self._mainComponent:getView():getChildByFullName("main.Layer_normal.Button_put")

		if button_put then
			storyDirector:setClickEnv("BuildingView.button_put", button_put, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)
				self._mainComponent:onClickPutHero(sender, eventType)
			end)
		end

		local button_ok = self._mainComponent:getView():getChildByFullName("main.Layer_buy.createcheck")

		if button_ok then
			storyDirector:setClickEnv("BuildingView.button_ok", button_ok, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)
				self._mainComponent:onClickOk(sender, eventType)
			end)
		end

		local button_overview = self._mainComponent:getView():getChildByFullName("main.Layer_normal.Button_overview")

		if button_overview then
			storyDirector:setClickEnv("BuildingView.button_overview", button_overview, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)
				self._mainComponent:onClickOverview(sender, eventType)
			end)
		end

		local button_back = self._mainComponent:getView():getChildByFullName("main.topinfo_node.back_btn")

		if button_back then
			storyDirector:setClickEnv("BuildingView.button_back", button_back, function(sender, eventType)
				self._mainComponent:onClickBack(sender, eventType)
			end)
		end

		storyDirector:notifyWaiting("enter_building_view")
	end))

	self:getView():runAction(sequence)
end

function BuildingMediator:onClickRankBtn()
	if self._buildingSystem._mapShowType == KBuildingMapShowType.kInRoom and self._buildingSystem:getShowRoomId() == "Room2" then
		local rankSystem = self:getInjector():getInstance(RankSystem)

		rankSystem:tryEnter()
	end
end

function BuildingMediator:onResetDone(event)
	local sendSta = self._buildingSystem:getHeroLoveSendSta()

	if not sendSta then
		return
	end

	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local topViewName = scene:getTopViewName()

	if topViewName == "BuildingView" then
		self._buildingSystem:sendGetHeroLove(true)
	end
end

function BuildingMediator:resumeWithData()
	self._buildingSystem:sendGetHeroLove(true)
end

function BuildingMediator:onOperateRevertRefresh(event)
	self._decorateComponent:refreshOperateBuildingRevert()
	self._mainComponent:refreshLayerBtn()
end

function BuildingMediator:playEnterHeroAudio()
	if not self._playEnterAudio then
		self._playEnterAudio = true

		local roomList = self._buildingSystem:getRoomList()
		local heroListOwn = {}

		for k, v in pairs(roomList) do
			local heroList = v:getHeroList() or {}

			for __, id in pairs(heroList) do
				heroListOwn[#heroListOwn + 1] = id
			end
		end

		if #heroListOwn > 0 then
			local randomNum = math.random(1, #heroListOwn)
			local heroId = heroListOwn[randomNum]
			local audioName = "Voice_" .. heroId .. "_63"

			self._enterHeroAudio = AudioEngine:getInstance():playEffect(audioName, false)
		end
	end
end

function BuildingMediator:getLoopWordPos(loopType)
	local topInfoWidget = self._mainComponent._topInfoWidget

	if topInfoWidget then
		if loopType == KBuildingType.kGoldOre then
			local node = topInfoWidget:getView():getChildByFullName("currency_bar_4")
			local worldPos = node:convertToWorldSpace(cc.p(0, 0))

			return cc.p(worldPos.x - 163, worldPos.y - 24)
		elseif loopType == KBuildingType.kCrystalOre then
			local node = topInfoWidget:getView():getChildByFullName("currency_bar_3")
			local worldPos = node:convertToWorldSpace(cc.p(0, 0))

			return cc.p(worldPos.x - 163, worldPos.y - 24)
		elseif loopType == KBuildingType.kExpOre then
			local worldPos = self._buildingSystem:getBagWorldPos() or cc.p(0, 0)

			return cc.p(worldPos.x, worldPos.y)
		end
	end
end

function BuildingMediator:onEventGetResAnim(event)
	local loopType = event:getData().loopType

	if not loopType then
		return
	end

	local ___scale = 1.8
	local ___time = 0.03
	local topInfoWidget = self._mainComponent._topInfoWidget

	if loopType == KBuildingType.kGoldOre then
		local node = topInfoWidget:getView():getChildByFullName("currency_bar_4.icon_node")

		self.__kGoldOreNodeScale = self.__kGoldOreNodeScale or node:getScale()

		node:stopActionByTag(909090)
		node:setScale(self.__kGoldOreNodeScale)

		local action = cc.Sequence:create(cc.ScaleTo:create(___time, self.__kGoldOreNodeScale * ___scale), cc.ScaleTo:create(___time, self.__kGoldOreNodeScale))

		node:runAction(action)
		action:setTag(909090)
	elseif loopType == KBuildingType.kCrystalOre then
		local node = topInfoWidget:getView():getChildByFullName("currency_bar_3.icon_node")

		self.__kCrystalOreScale = self.__kCrystalOreScale or node:getScale()

		node:stopActionByTag(909090)
		node:setScale(self.__kCrystalOreScale)

		local action = cc.Sequence:create(cc.ScaleTo:create(___time, self.__kCrystalOreScale * ___scale), cc.ScaleTo:create(___time, self.__kCrystalOreScale))

		node:runAction(action)
		action:setTag(909090)
	end
end

function BuildingMediator:_showSubView(viewName, param)
	local view = self:getInjector():getInstance(viewName)
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param)

	self:dispatch(event)
end

function BuildingMediator:showAfterLoading()
	if not self.__enterData then
		return
	end

	local t = self.__enterData.t
	local roomId = self.__enterData.roomId

	if not t or not roomId then
		return
	end

	if t == "buyDecorate" or t == "overview" then
		local openState, str = self._buildingSystem:getRoomOpenSta(roomId)

		if openState then
			self:enterRoom(roomId, 0.2)

			if t == "buyDecorate" then
				self:_showSubView("BuildingBuildView", {
					roomId = roomId
				})
			elseif t == "overview" then
				self:_showSubView("BuildingOverviewView", {
					roomId = roomId
				})
			end
		elseif self._buildingSystem:canUnlockRoom(roomId) then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:showUnlockRoom(roomId)
		end
	end
end

function BuildingMediator:playEnterViewVoice()
	local roomList = self._buildingSystem:getRoomList()
	local heroListOwn = {}

	for k, v in pairs(roomList) do
		local heroList = v:getHeroList() or {}

		for __, id in pairs(heroList) do
			heroListOwn[#heroListOwn + 1] = id
		end
	end

	if #heroListOwn > 0 then
		local randomNum = math.random(1, #heroListOwn)
		local heroId = heroListOwn[randomNum]
		local audioName = "Voice_" .. heroId .. "_63"

		self._enterHeroAudio = AudioEngine:getInstance():playEffect(audioName, false)
	end
end
