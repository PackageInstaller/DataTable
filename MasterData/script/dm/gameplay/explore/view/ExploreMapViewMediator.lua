-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreMapViewMediator.lua

ExploreMapViewMediator = class("ExploreMapViewMediator", DmAreaViewMediator)

ExploreMapViewMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreMapViewMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
ExploreMapViewMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")
ExploreMapViewMediator:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")
ExploreMapViewMediator:has("_customDataSystem", {
	is = "r"
}):injectWith("CustomDataSystem")
ExploreMapViewMediator:has("_rankSystem", {
	is = "r"
}):injectWith("RankSystem")

local cjson = require("cjson.safe")
local kBtnHandlers = {
	["Panel_base.btnPanel.caseBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickCase"
	}
}
local blockGridSize = ExploreTypeCfgInfo.blockGridSize
local mapSize = ExploreTypeCfgInfo.mapSize
local blockGridNumSize = ExploreTypeCfgInfo.blockGridNumSize
local cellSize = cc.size(320, 320)
local extraOffset = 320
local blockCellNum = cc.size(cellSize.width / blockGridSize.width, cellSize.height / blockGridSize.height)
local cellNumSize = cc.size(mapSize.width / cellSize.width, mapSize.height / cellSize.height)
local roleDistance = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MapTeamSpacing", "content")
local mapTeamNum = 10
local moveTimeForPerGrid = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "MapMoveSpeed", "content")
local moveTimeScale = 1.414
local animationSpeedFactor = ConfigReader:getDataByNameIdAndKey("ConfigValue", "MapAnimationSpeedFactor", "content") or 0.5
local baseGlobalZOrder = 10
local topGlobalZOrder = 999999999
local baseFloorGlobalZOrder = -1000000000
local baseFloorDecorateGlobalZOrder1 = -900000000
local baseFloorDecorateGlobalZOrder2 = -800000000
local baseFloorDecorateGlobalZOrder3 = -700000000
local moveActionTag = 1001
local checkDirActionTag = 1002
local testCpuPerformanceTag = 1003
local scrollMoveTag = 1004
local lowPerformanceMode = true
local dirInfo = {
	{
		1,
		0
	},
	{
		1,
		1
	},
	{
		0,
		1
	},
	{
		-1,
		1
	},
	{
		-1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		-1
	}
}

function ExploreMapViewMediator:initialize()
	super.initialize(self)
end

function ExploreMapViewMediator:dispose()
	super.dispose(self)

	local director = cc.Director:getInstance()

	director:setAnimationInterval(1 / (GAME_MAX_FPS or 30))
	self._astar:cleanData()
	self._exploreSystem:popShowStack()

	self._mapHeads = {}
	self._mapCellDatas = {}
end

function ExploreMapViewMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	local view = self:getInjector():getInstance("ExploreMapUIView")

	self._topUIMediator = self:getInjector():instantiate("ExploreMapUIMediator", {
		view = view
	})

	self:getView():getChildByFullName("Panel_base"):addChild(view)
	self._exploreSystem:pushShowStack(true)
end

function ExploreMapViewMediator:initChat()
	local view = self:getInjector():getInstance("SmallChat")

	if view then
		view:setPosition(cc.p(-680, 280))
		self:getView():addChild(view)
		AdjustUtils.adjustLayoutByType(view, AdjustUtils.kAdjustType.Left)

		local mediator = self:getMediatorMap():retrieveMediator(view)

		if mediator then
			mediator:enterWithData(nil)

			self._chatMediator = mediator
		end
	end
end

function ExploreMapViewMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_FINISH, self, self.back)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_TASK_REWARD, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_SELL_ITEM_SUCC, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_RESET_MAPCOUNT, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_TASK_RESET, self, self.refreshView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_ADD_OBJ, self, self.addObjectByEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_REMOVE_OBJ, self, self.removeObjectByEvent)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_FIGHT_FINISH, self, self.tryDealFightFinish)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_END_SUCC, self, self.updateCaseBtnByEndTrigger)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EXPLORE_STATUR_REFRESH, self, self.updateCaseObj)
end

function ExploreMapViewMediator:tryDealFightFinish()
	local fightData = self._exploreSystem:getFightFinishData(true)

	if fightData then
		if self._autoPlay then
			self._autoPlayIsWin = fightData.isWin
		end

		self:dealExploreEvent(nil, nil, fightData)
	end
end

function ExploreMapViewMediator:refreshView(event, ignoreBuffRefresh)
	self._topUIMediator:refreshView(ignoreBuffRefresh)
	self:setMoveTimeForPerGrid()
end

function ExploreMapViewMediator:back(event)
	local data = event:getData()

	if data.curGroupId then
		self._exploreSystem:cleanExploreData()

		local function callback()
			local view = self:getInjector():getInstance("ExploreView")

			self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, {
				curGroupId = data.curGroupId
			}))
		end

		self._rankSystem:cleanUpRankListByType(RankType.kMap)

		local sendData = {
			rankStart = 1,
			type = RankType.kMap,
			rankEnd = self._rankSystem:getRequestRankCountPerTime()
		}

		self._rankSystem:requestRankData(sendData, callback)
	else
		self:dismiss()
	end
end

function ExploreMapViewMediator:initialize()
	super.initialize(self)
end

function ExploreMapViewMediator:enterWithData(data)
	self._mapHeads = {}
	self._mapCellDatas = {}
	self._pointId = data.pointId

	self._exploreSystem:initAutoPlayCfg()

	self._pointCfg = self._exploreSystem:getMapPointObjById(self._pointId)
	self._exploreData = self._developSystem:getPlayer():getExplore()
	self._currentMapInfo = self._exploreData:getPointMap()[self._exploreData:getCurPointId()]
	self._exploreObjects = self._currentMapInfo:getMapObjects()
	self._turnFace = self._currentMapInfo:isRoleTurn()
	self._mapResource = self._pointCfg:getMapResource()
	self._mapBgm = self._pointCfg:getBGM()[1]
	self._BGMAisac = self._pointCfg:getBGMAisac()
	self._mapBgmDefAction = self._pointCfg:getBGM()[2]
	self._mapBgmAction = self._pointCfg:getBGMAction() or {}
	self._autoClickEvent = false
	self._mapHeads = {}
	self._heroMovePath = {}
	self._objectsMap = {}
	self._objectsRenderMap = {}
	self._passiveEventState = {}
	self._blockCountMap = {}
	self._cpuPerformanceInfo = {
		testOver = false,
		maxTimeSum = 10,
		count = 0,
		timeSum = 0,
		fps = 20
	}
	self._caseData = nil

	self:initAStar()
	self:setupView()
	self:initCustomCamera()
	self._topUIMediator:initView(self._pointId, self)
	self:initExploreObjects()

	self._curGridIndex = self:getCurrentGridByServer()

	AudioEngine:getInstance():playBackgroundMusic(self._mapBgm)
	self:moveToPos(self:getPosByGrid(self._curGridIndex), nil, true)
	self:initRole()
	self._collectionView:reloadData()
	self:updateCaseBtnByEndTrigger()

	self._autoPlay = false

	if self._exploreSystem:getAutoBattleStatus() then
		self:autoPlay()
	elseif not self._exploreSystem:getFightFinishData() then
		local stateChangedObj = self:getPassiveEventStateChangedObj()

		if stateChangedObj then
			self:triggerEvent(stateChangedObj)
		end
	end

	if lowPerformanceMode or GameConfigs.battleSceneMode then
		lowPerformanceMode = true

		performWithDelay(self._view, function()
			self:dispatch(Event:new(EVT_RELEASE_VIEW_MEMORY, {
				keepOnlyOne = true
			}))
		end, 0)
	end

	self:setMoveTimeForPerGrid()

	local director = cc.Director:getInstance()

	director:setAnimationInterval(1 / (GAME_MAX_FPS or 30))
end

function ExploreMapViewMediator:setMoveTimeForPerGrid()
	local rate = self._exploreData:getSpeedRate() or 1
	local canSpeed = self._exploreSystem:canSpeed()

	if canSpeed then
		local speed = self._exploreSystem:getSpeedEffect()

		self._moveTimeForPerGrid = speed / rate
	else
		self._moveTimeForPerGrid = moveTimeForPerGrid / rate
	end
end

function ExploreMapViewMediator:initCustomCamera()
	local s = cc.Director:getInstance():getWinSize()

	_G.Explore_3D_degree = 0

	if self.is3D then
		self._camera = cc.Camera:create()

		self._camera:setCameraFlag(2)
		self._view:addChild(self._camera)

		local pos_Y = 0

		self._camera:setPositionY(pos_Y)
		self._camera:setDepth(-1)

		local lookAt_y = s.height * 0.4
		local eyeZ = 500

		self._camera:setPositionZ(eyeZ)
		self._camera:lookAt(cc.vec3(s.width / 2, lookAt_y, 0), cc.vec3(0, 1, 0))

		local degree = math.deg(math.atan((lookAt_y - pos_Y) / eyeZ))

		self._scrollView:setCameraMask(2)

		_G.Explore_3D_degree = degree
	end
end

function ExploreMapViewMediator:showStopAutoTip()
	local outSelf, delegate = self, {}

	local function callback()
		if DisposableObject:isDisposed(self) then
			return
		end

		self:resetAutoState()
	end

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			-- block empty
		elseif data.response == "cancel" then
			callback()
		elseif data.response == "close" then
			callback()
		end
	end

	self:showAlertView(Strings:get("EXPLORE_UI104"), delegate)
end

function ExploreMapViewMediator:resetAutoState()
	self._exploreSystem:setAutoBattleStatus(true)
	self._topUIMediator:setAutoAnim()
	self:autoPlay()
end

function ExploreMapViewMediator:showAlertView(content, delegate)
	local alertView = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, alertView, nil, {
		title = Strings:get("Tip_Remind"),
		content = content,
		sureBtn = {},
		cancelBtn = {}
	}, delegate))
end

function ExploreMapViewMediator:autoPlay()
	if self._autoPlay then
		return
	end

	self._exploreSystem:KeepAutoPlayTeamHpEnough(function()
		self._passiveEventState = {}
		self._autoPlay = true

		self:updateAutoPlayCfg()
		self:autoPlayVirtualTouch()
	end)
end

function ExploreMapViewMediator:updateAutoPlayCfg()
	self._curAutoPlayObj = nil
	self._autoPlayCfg = nil

	while not self._curAutoPlayObj do
		self._autoPlayCfg = self._exploreSystem:getCurrentAutoPlayCfg()

		if not self._autoPlayCfg then
			break
		end

		for i, v in pairs(self._exploreObjects) do
			if v:getConfigId() == self._autoPlayCfg.ObjectId then
				self._curAutoPlayObj = v
			end
		end

		if not self._curAutoPlayObj then
			self._exploreSystem:nextAutoPlayStep(true)
		end
	end
end

function ExploreMapViewMediator:autoPlayVirtualTouch()
	if self._curAutoPlayObj then
		if _G.isExploreDebug then
			self._text_debug_obj:setString(self._curAutoPlayObj:getConfigId())

			local var_23_0 = (self._exploreSystem:getAutoPlayCase() or {}).caseID

			self._text_debug_case:setString((not (self._exploreSystem:getAutoPlayCase() or {}).caseID or nil) and "no case")
		end

		local virtualTouchPos = self._scrollView:getInnerContainer():convertToWorldSpace(self:getPosByGrid(cc.p(self._curAutoPlayObj:getX(), self._curAutoPlayObj:getY())))

		self:dealTouch(virtualTouchPos)
	else
		self:showAlertView(Strings:get("EXPLORE_UI100"))
		self:stopAutoPlay()
	end
end

function ExploreMapViewMediator:nextAutoPlayStep()
	self._exploreSystem:KeepAutoPlayTeamHpEnough(function()
		if self._autoPlayIsWin == false then
			self:showAlertView(Strings:get("EXPLORE_UI102"))

			self._autoPlayIsWin = nil

			self:stopAutoPlay()

			return
		end

		self._exploreSystem:updateAutoId()
		self._exploreSystem:nextAutoPlayStep()

		if not self._autoPlay then
			return
		end

		self:updateAutoPlayCfg()
		self:autoPlayVirtualTouch()
	end)
end

function ExploreMapViewMediator:stopAutoPlay()
	if not self._autoPlay then
		return
	end

	self._autoPlay = false
	self._autoPlayFighting = false

	self._topUIMediator:resetAuto()
	self:stand()
end

function ExploreMapViewMediator:initAStar()
	self._astar = AStar:getInstance()

	local path = string.format("asset/exploreMap/%s.b", self._pointCfg:getMapBlock())

	self._astar:loadMapByPath(path)
end

function ExploreMapViewMediator:setBlockByObject(object)
	local blockRect = object:getBlockRect()
	local objBlockInfo = {}

	for y = blockRect.minY, blockRect.maxY do
		for x = blockRect.minX, blockRect.maxX do
			local key = y .. "#" .. x

			if not self._astar:isBlock(y, x) then
				table.insert(objBlockInfo, {
					y,
					x
				})

				self._blockCountMap[key] = 1
			elseif self._blockCountMap[key] then
				table.insert(objBlockInfo, {
					y,
					x
				})

				self._blockCountMap[key] = self._blockCountMap[key] + 1
			end

			self._astar:setBlock(y, x, true)
		end
	end

	object.objBlock = objBlockInfo
end

function ExploreMapViewMediator:initExploreObject(v)
	local cellIndex = v:createCellIndex(blockCellNum.width, blockCellNum.height)
	local cellKey = string.format("_%d_%d", cellIndex.y, cellIndex.x)

	self._objectsMap[cellKey] = self._objectsMap[cellKey] or {}

	local exploreObjects = self._objectsMap[cellKey]
	local triggerRect = v:getConfigByKey("Range")
	local blockRect = v:getConfigByKey("Size")

	assert(triggerRect, string.format("触发区域不能为空:%s", v:getConfigId()))
	assert(blockRect, string.format("阻挡区域不能为空:%s", v:getConfigId()))
	v:setTriggerRect(self:getRectByGrid({
		y = v:getY(),
		x = v:getX()
	}, triggerRect))
	v:setBlockRect(self:getRectByGrid({
		y = v:getY(),
		x = v:getX()
	}, blockRect))

	if v:block() then
		self:setBlockByObject(v)
	end

	table.insert(exploreObjects, v)
end

function ExploreMapViewMediator:initExploreObjects()
	for i, v in pairs(self._exploreObjects) do
		self:initExploreObject(v)
	end
end

function ExploreMapViewMediator:addObjectByEvent(event)
	local data = event:getData()

	data.showEffect = true

	self:addObject(data)
end

function ExploreMapViewMediator:addObject(data)
	local obj = data.object

	if data.mapKey == self._pointId then
		self:initExploreObject(obj)

		local cellIndex = obj:getCellIndex()
		local row, col = cellNumSize.height - 1 - cellIndex.y, cellIndex.x
		local cell = self._collectionView:getCellByRowAndCol(row, col)

		if cell and cell.decorateNode then
			local baseRow = blockCellNum.height * cellIndex.y
			local baseCol = blockCellNum.width * cellIndex.x
			local render = self:getObjectRenderByObj(obj, baseRow, baseCol)

			cell.decorateNode:addChild(render)

			if data.showEffect then
				render.mediator:playAddAction(self._roleNode)
			end
		end

		self:refreshView()
	end
end

function ExploreMapViewMediator:removeObjectByEvent(event)
	local data = event:getData()

	data.showEffect = true

	self:removeObject(data)
end

function ExploreMapViewMediator:removeObject(data)
	if data.mapKey == self._pointId then
		local v = data.object
		local cellIndex = v:getCellIndex()
		local cellKey = string.format("_%d_%d", cellIndex.y, cellIndex.x)
		local cellExploreObjects = self._objectsMap[cellKey]

		if cellExploreObjects then
			for i, obj in pairs(cellExploreObjects) do
				if v == obj then
					table.remove(cellExploreObjects, i)

					break
				end
			end
		end

		local objectMediator = self._objectsRenderMap[v]

		if objectMediator then
			self._objectsRenderMap[v] = nil

			local function tempfunc()
				local view = objectMediator:getView()

				if view and not tolua.isnull(view) then
					view:removeFromParent(true)
				end
			end

			if data.showEffect then
				objectMediator:playRemoveAction(self._roleNode, tempfunc)
			else
				tempfunc()
			end
		end

		if v:block() then
			for i = 1, #(v.objBlock or {}) do
				local key = v.objBlock[i][1] .. "#" .. v.objBlock[i][2]
				local count = self._blockCountMap[key]

				if count then
					self._blockCountMap[key] = count - 1
				end

				if self._blockCountMap[key] == 0 then
					self._astar:setBlock(v.objBlock[i][1], v.objBlock[i][2], false)

					self._blockCountMap[key] = nil
				end
			end
		end

		self:refreshView(nil, true)
	end
end

function ExploreMapViewMediator:setupView()
	self._quickView = self:getChildView("QuickBattle")
	self._animNode = self:getChildView("QuickBattle.QuickBattleAnim")
	self._panel_touch = self:getChildView("Panel_base.Panel_touch")
	self._btnPanel = self:getChildView("Panel_base.btnPanel")
	self._caseBtn = self._btnPanel:getChildByFullName("caseBtn")

	self._caseBtn:setVisible(false)

	self._scrollView = self:getChildView("Panel_base.ScrollView")

	self._scrollView:setScrollBarEnabled(false)

	self._scrollViewSize = self._scrollView:getContentSize()

	local info = {
		isReuse = true,
		isSchedule = true,
		view = self._scrollView,
		delegate = self,
		cellNumSize = cellNumSize,
		cellSize = cellSize,
		extraOffset = extraOffset
	}

	self._collectionView = CollectionViewUtils:new(info)
	self.containerSize = self._scrollView:getInnerContainerSize()

	local function onTouched(touch, event)
		local eventType = event:getEventCode()

		if eventType == ccui.TouchEventType.began then
			return self:onTouchBegan(touch, event)
		elseif eventType == ccui.TouchEventType.moved then
			self:onTouchMoved(touch, event)
		elseif eventType == ccui.TouchEventType.ended then
			self:onTouchEnded(touch, event)
		else
			self:onTouchCanceled(touch, event)
		end
	end

	self.listener = cc.EventListenerTouchOneByOne:create()

	self.listener:setSwallowTouches(false)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_BEGAN)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_MOVED)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_ENDED)
	self.listener:registerScriptHandler(onTouched, cc.Handler.EVENT_TOUCH_CANCELLED)
	self._panel_touch:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, self._panel_touch)

	self._roleNode = cc.Node:create()
	self._sceneEffectNode = cc.Node:create()

	self._roleNode:center(self._scrollView:getContentSize())
	self._scrollView:addProtectedChild(self._roleNode, 3, 3)
	self._scrollView:addChild(self._sceneEffectNode)
	self:initRocker()
	self:createDebugGrid()
	self:createQuickBattelAnim()
end

function ExploreMapViewMediator:createQuickBattelAnim()
	if not self._quickBattleAnim then
		local anim = cc.MovieClip:create("dajia_zhujuedajia")

		anim:addTo(self._animNode):posite(0, 0)

		self._quickBattleAnim = anim
	end

	self._quickBattleAnim:stop()
	self._quickView:setVisible(false)
end

function ExploreMapViewMediator:playQuickBattleAnim(callback)
	self._quickView:setVisible(true)
	self._quickBattleAnim:gotoAndPlay(0)
	delayCallByTime(1500, function()
		callback()
		self._quickBattleAnim:stop()
		self._quickView:setVisible(false)
	end)
end

function ExploreMapViewMediator:createDebugGrid()
	if not _G.isExploreDebug then
		return
	end

	self._text_debug_obj = self:getChildView("Text_debug_obj")
	self._text_debug_case = self:getChildView("Text_debug_case")

	self._text_debug_obj:setVisible(true)
	self._text_debug_case:setVisible(true)

	local debugNode = cc.DrawNode:create()

	self._scrollView:addChild(debugNode)

	for y = 0, blockGridNumSize.height - 1 do
		for x = 0, blockGridNumSize.width - 1 do
			if self._astar:isBlock(y, x) then
				local pos1_origin = cc.p(x * 10, blockGridNumSize.height * 10 - y * 10)
				local pos1_des = cc.p(pos1_origin.x + 10, pos1_origin.y - 10)

				debugNode:drawSolidRect(pos1_origin, pos1_des, cc.c4f(0, 0, 0, 0.5))
			end
		end
	end

	for i = 1, blockGridNumSize.width do
		local pos1_origin = cc.p(i * 10, 0)
		local pos1_des = cc.p(i * 10, 10000)

		debugNode:drawLine(pos1_origin, pos1_des, cc.c4f(1, 0, 0, 0.1))
	end

	for j = 1, blockGridNumSize.height do
		local pos1_origin = cc.p(0, j * 10)
		local pos1_des = cc.p(10000, j * 10)

		debugNode:drawLine(pos1_origin, pos1_des, cc.c4f(1, 0, 0, 0.1))
	end

	debugNode:setGlobalZOrder(999999999)

	local anchorPoint = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), 5, 5)

	anchorPoint:setAnchorPoint(0.5, 0.5)
	anchorPoint:setIgnoreAnchorPointForPosition(false)
	self._roleNode:addChild(anchorPoint)
	anchorPoint:setGlobalZOrder(999999999)
end

function ExploreMapViewMediator:getHeroPathStr()
	local data = {}

	data.path = self._heroMovePath
	data.heroPos = {}
	data.roleFace = self._turnFace

	for i = 1, #self._heroPlots do
		local node = self._heroPlots[i].node
		local pos = cc.p(node:getPosition())

		pos.x = math.floor(pos.x * 100) * 0.01
		pos.y = math.floor(pos.y * 100) * 0.01
		data.heroPos[i] = pos
	end

	return (cjson.encode(data))
end

function ExploreMapViewMediator:getHeroPath()
	local pathInfo = self._currentMapInfo:getHeroPath()

	return cjson.decode(pathInfo)
end

function ExploreMapViewMediator:getInnerContainerPosByViewPos(pos, fromCenter)
	local targetPos = self._scrollView:getInnerContainerPosition()

	targetPos.x = -1 * targetPos.x + pos.x
	targetPos.y = -1 * targetPos.y + pos.y

	if fromCenter then
		targetPos.x = targetPos.x + self._scrollViewSize.width * 0.5
		targetPos.y = targetPos.y + self._scrollViewSize.height * 0.5
	end

	return targetPos
end

function ExploreMapViewMediator:getViewPosByInnerContainerPos(pos)
	local targetPos = self._scrollView:getInnerContainerPosition()

	targetPos.x = targetPos.x + pos.x
	targetPos.y = targetPos.y + pos.y

	return targetPos
end

function ExploreMapViewMediator:getRectByGrid(grid, offsetRect)
	local x1 = grid.x + offsetRect[1][1]
	local x2 = grid.x + offsetRect[2][1]
	local y1 = grid.y + offsetRect[1][2]
	local y2 = grid.y + offsetRect[2][2]
	local minX, minY, maxX, maxY = x1, y1, x2, y2

	if maxX < minX then
		minX = x2
		maxX = x1
	end

	if maxY < minY then
		minY = y2
		maxY = y1
	end

	return {
		minX = minX,
		minY = minY,
		maxX = maxX,
		maxY = maxY
	}
end

function ExploreMapViewMediator:refreshHeroPositionAndZOrder(isCleanPath)
	local serverGrid = self:getCurrentGridByServer()
	local globalZOrder = self:getGlobalZOrderByGrid(serverGrid)

	self._roleSprite._baseNode:setGlobalZOrder(globalZOrder)

	local pathInfo = self:getHeroPath()
	local useServerData = not not (pathInfo and pathInfo.heroPos and #pathInfo.heroPos == #self._heroPlots and #pathInfo.path == #self._heroPlots * roleDistance - 1 and not isCleanPath)

	self._roleSprite.mediator:setRoleTurn(self._turnFace)

	local offset = self._currentMapInfo:getHeroOffset()

	for i = 1, #self._heroPlots do
		local pos = cc.p(i * offset[1] * 10, i * offset[2] * 10)

		if useServerData then
			pos = pathInfo.heroPos[i]
		end

		self._heroPlots[i].node:setPosition(pos)

		local hero = self._heros[i]

		if hero then
			local grid = self:getGridByPos(self:getInnerContainerPosByViewPos(pos, true))

			globalZOrder = self:getGlobalZOrderByGrid(grid)

			hero._baseNode:setGlobalZOrder(globalZOrder)
		end
	end

	self._heroMovePath = {}

	if useServerData then
		self._heroMovePath = pathInfo.path
	else
		local heroPath = self._currentMapInfo:getHeroDefaultPath()

		for i = 1, #self._heroPlots * roleDistance - 1 do
			heroPath.x = math.floor(heroPath.x * 100) * 0.01
			heroPath.y = math.floor(heroPath.y * 100) * 0.01

			table.insert(self._heroMovePath, heroPath)
		end
	end
end

function ExploreMapViewMediator:getFollowHeroes()
	local temp = {}
	local teamList = self._pointCfg:getTeams()

	for i = 1, #teamList do
		local team = teamList[i]
		local heroes = team:getHeroes()
		local effectHeroIds = self._exploreSystem:getMapPointObjById(self._pointId):getEffectHeroIds()

		for k, v in pairs(heroes) do
			if table.indexof(effectHeroIds, v) then
				temp[#temp + 1] = v
			end
		end
	end

	return temp
end

function ExploreMapViewMediator:initRole()
	local currentTeam = self._currentMapInfo:getTeams()[1]
	local masterId = currentTeam:getMasterId()
	local master = self._masterSystem:getMasterById(masterId)
	local roleModel = master:getModel()
	local roleMediator = self:getInjector():instantiate(ExploreRoleMediator, roleModel)

	self._roleSprite = roleMediator:getView()

	self._roleNode:addChild(self._roleSprite)

	self._skeletonAnimGroup = sp.SkeletonAnimationGroup:create()

	self._skeletonAnimGroup:start()
	roleMediator:setSkeletonAnimationGroup(self._skeletonAnimGroup)

	local heroes = self:getFollowHeroes()

	self._heros = {}
	self._heroPlots = {}

	for i = 1, mapTeamNum do
		local node = cc.Node:create()

		self._roleNode:addChild(node)

		local data = {
			hasChild = false,
			node = node
		}

		table.insert(self._heroPlots, data)
	end

	local pathInfo = self:getHeroPath()

	if pathInfo and pathInfo.roleFace ~= nil then
		self._turnFace = pathInfo.roleFace
	end

	local heroNum = #heroes

	for i = 1, heroNum do
		local heroData = self._heroSystem:getHeroById(heroes[i])
		local roleModel = heroData:getModel()
		local heroMediator = self:getInjector():instantiate(ExploreRoleMediator, roleModel)
		local hero = heroMediator:getView()

		heroMediator:setSkeletonAnimationGroup(self._skeletonAnimGroup)

		self._heroPlots[i].hasChild = true

		self._heroPlots[i].node:addChild(hero)
		heroMediator:setRoleTurn(self._turnFace)
		table.insert(self._heros, hero)
	end

	local joinObjects = self._currentMapInfo:getJoinObjects()

	for i, v in pairs(joinObjects) do
		local tempObject = self:getInjector():instantiate("ExploreObject", nil, nil, v)
		local objectMediator = self:getInjector():instantiate(ExploreObjectMediator, tempObject)
		local objectRender = objectMediator:getView()

		objectMediator:setSkeletonAnimationGroup(self._skeletonAnimGroup)

		heroNum = heroNum + 1
		self._heroPlots[heroNum].hasChild = true

		self._heroPlots[heroNum].node:addChild(objectRender)
		objectMediator:setRoleTurn(self._turnFace)
		table.insert(self._heros, objectRender)
	end

	self:refreshHeroPositionAndZOrder()
end

function ExploreMapViewMediator:onEventForCollectionView(sender, eventType)
	return
end

function ExploreMapViewMediator:getMapConfig(key)
	self._explormapConfig = self._explormapConfig or {}
	self._explormapConfig[key] = self._explormapConfig[key] or require("asset.exploreMap.ExploreMap")[key]

	return self._explormapConfig[key]
end

function ExploreMapViewMediator:getMapByIndex(key, row, col, isGlobalZOrder, isAlias, isFloor)
	local indexStr = string.format("_%d_%d", row, col)
	local path = string.format("asset/exploreMap/%s%s.lua", key, indexStr)
	local headPath = string.format("asset/exploreMap/%s_head.lua", key)

	self._mapHeads[key] = self._mapHeads[key] or self:getMapConfig(key .. "_head")()

	if self._mapHeads[key].cells[indexStr] then
		local layerData = self._mapCellDatas[path]

		if not layerData then
			layerData = self:getMapConfig(key .. indexStr)()
			self._mapCellDatas[path] = self:getMapConfig(key .. indexStr)()
		end

		local mapMediator = CustomMap:new()

		return (mapMediator:getMapByHeadAandLayersData(self._mapHeads[key], layerData, isGlobalZOrder, function(tiledRow, tiledCol, tiled, index)
			local baseOrder = baseGlobalZOrder
			local tempOrder = 0

			if not isFloor then
				if index == 0 then
					baseOrder = baseFloorDecorateGlobalZOrder1
				end

				if index == 1 then
					baseOrder = baseFloorDecorateGlobalZOrder2
				end

				if index == 2 then
					baseOrder = baseFloorDecorateGlobalZOrder3
				end

				if index == 4 then
					baseOrder = topGlobalZOrder
				end
			end

			if not isFloor then
				local realRow = blockCellNum.height * row + tiledRow
				local realCol = blockCellNum.width * col + tiledCol

				tempOrder = baseOrder + realRow * blockGridNumSize.width + realCol

				if index == 3 then
					tiled:setRotation3D(cc.vec3(_G.Explore_3D_degree, 0, 0))
				end
			else
				local realY = row * cellSize.height + cellSize.height - tiled:getPositionY()
				local realX = col * cellSize.width + tiled:getPositionX()

				tempOrder = baseFloorGlobalZOrder + realY * cellSize.width * cellNumSize.width + realX
			end

			return tempOrder
		end, isAlias))
	end

	return nil
end

function ExploreMapViewMediator:cellWillShow(view, row, col, cell)
	row = cellNumSize.height - 1 - row
end

function ExploreMapViewMediator:cellWillHide(view, row, col, cell)
	local children = cell.decorateNode:getChildren()

	for i = 1, #children do
		local mediator = children[i].mediator

		self._objectsRenderMap[mediator:getExploreObject()] = nil
	end

	cell:removeAllChildren()

	cell.decorateNode = nil
end

function ExploreMapViewMediator:getObjectRenderByObj(v, baseRow, baseCol)
	local localRow = v:getCellIndex().localRow
	local localCol = v:getCellIndex().localCol
	local realRow = baseRow + localRow
	local realCol = baseCol + localCol
	local objectMediator = self:getInjector():instantiate(ExploreObjectMediator, v)

	self._objectsRenderMap[v] = objectMediator

	local objectRender = objectMediator:getView()
	local pos = cc.p(localCol * blockGridSize.width, cellSize.height - (localRow + 1) * blockGridSize.height)

	objectRender:setPosition(pos)
	objectMediator:initWalk()

	if v:getResConfigByKey("ZorderType") == 3 then
		objectMediator:getBaseNode():setGlobalZOrder(topGlobalZOrder)
	elseif v:getResConfigByKey("ZorderType") == 2 then
		objectMediator:getBaseNode():setGlobalZOrder(self:getGlobalZOrderByGrid({
			y = realRow,
			x = realCol
		}))
	else
		objectMediator:getBaseNode():setGlobalZOrder(1)
	end

	return objectRender
end

function ExploreMapViewMediator:getDecorateNodeByIndex(row, col)
	local decorateNode = cc.Node:create()
	local cellKey = string.format("_%d_%d", row, col)
	local objects = self._objectsMap[cellKey]
	local baseRow = blockCellNum.height * row
	local baseCol = blockCellNum.width * col

	if objects then
		for i, v in pairs(objects) do
			local objectRender = self:getObjectRenderByObj(v, baseRow, baseCol)

			decorateNode:addChild(objectRender)
		end
	end

	return decorateNode
end

function ExploreMapViewMediator:cellAtIndex(view, row, col)
	row = cellNumSize.height - 1 - row

	local cell = self._collectionView:dequeueCellByKey()

	cell = cell or cc.Node:create()

	local map = self:getMapByIndex(self._mapResource[1], row, col, true, true, true)

	if map then
		cell:addChild(map)
	end

	map = self:getMapByIndex(self._mapResource[2], row, col, true)

	if map then
		cell:addChild(map)
	end

	local decorateNode = self:getDecorateNodeByIndex(row, col)

	cell:addChild(decorateNode)

	cell.decorateNode = decorateNode

	return cell
end

function ExploreMapViewMediator:getObjectOnClick(pos)
	local clickObjects = {}

	for k, v in pairs(self._objectsRenderMap) do
		local render = v:getView()

		if render then
			local endPos = render:convertToNodeSpace(pos)
			local boundBox = render.realNode:getBoundingBox()

			if cc.rectContainsPoint(boundBox, endPos) and not v.endTriggering then
				table.insert(clickObjects, v)
			end
		end
	end

	table.sort(clickObjects, function(a, b)
		return a:getView():getGlobalZOrder() > b:getView():getGlobalZOrder()
	end)

	return clickObjects[1]
end

function ExploreMapViewMediator:getAutoPlayObject()
	for k, v in pairs(self._objectsRenderMap) do
		local render = v:getView()

		if render then
			if self._curAutoPlayObj:getConfigId() == v:getExploreObject():getConfigId() then
				return v
			end
		end
	end

	return nil
end

function ExploreMapViewMediator:checkObjectInTriggerRect(v)
	local triggerRect = v:getExploreObject():getTriggerRect()

	return self._exploreSystem:checkPointInTargetRectByGrid(self._curGridIndex, triggerRect)
end

function ExploreMapViewMediator:resumeWithData()
	local director = cc.Director:getInstance()

	director:setAnimationInterval(0.016666666666666666)
	AudioEngine:getInstance():playBackgroundMusic(self._mapBgm)

	if self._mapBgmCurAction then
		local aisac = self._BGMAisac[self._mapBgmCurAction]

		if aisac then
			AudioEngine:getInstance():setAisacByID(aisac)
		else
			AudioEngine:getInstance():playAction(self._mapBgmCurAction)
		end
	end

	self._topUIMediator:refreshSpeed()
	self:setMoveTimeForPerGrid()
end

function ExploreMapViewMediator:findTalker(info)
	if type(info.Talker) == "string" then
		for k, v in pairs(self._objectsRenderMap) do
			local objcfgId = v:getExploreObject():getConfigByKey("Id")

			if info.Talker == objcfgId then
				return v:getView()
			end
		end
	elseif info.Talker == 1 then
		return self._roleSprite
	else
		return self._heros[info.Talker]
	end
end

function ExploreMapViewMediator:dealDialogueEvent(dialogue, callback)
	local index = 1
	local showDialogue

	function showDialogue()
		if index > #dialogue then
			callback()

			return
		end

		local info = dialogue[index]
		local talker = self:findTalker(info)

		if talker then
			talker.mediator:showDialogue(info, function()
				index = index + 1

				showDialogue()
			end)
		else
			index = index + 1

			showDialogue()
		end
	end

	showDialogue()
end

function ExploreMapViewMediator:dealActionMain(info)
	self._roleSprite.mediator:playAnimation(info.Action, info.Num, info.EndAction)
end

function ExploreMapViewMediator:dealActionObject(info)
	for k, v in pairs(self._objectsRenderMap) do
		if k:getConfigId() == info.ObjectID then
			v:playAnimation(info.Action, info.Num, info.EndAction)
		end
	end
end

function ExploreMapViewMediator:dealEffectMain(info)
	self._roleSprite.mediator:addEffect(info)
end

function ExploreMapViewMediator:dealEffectObject(info)
	for k, v in pairs(self._objectsRenderMap) do
		if k:getConfigId() == info.ObjectID then
			v:addEffect(info)
		end
	end
end

function ExploreMapViewMediator:dealEfectMap(info)
	local pos = self:getPosByGrid(cc.p(info.Position[1], info.Position[2]))
	local anim = cc.MovieClip:create(info.NameID)

	anim:setPosition(pos)
	anim:setGlobalZOrder(topGlobalZOrder)
	anim:addTo(self._sceneEffectNode)

	if info.Num > 0 then
		if not info.Num then
			local number = math.huge

			CommonUtils.playMovieClipByTimes(anim, number, nil, true)
		end
	end
end

function ExploreMapViewMediator:dealCaseEndActionEffect(actionIds)
	for i = 1, #(actionIds or {}) do
		local caseEndAction = ExploreCaseEndAction:new(actionIds[i])
		local action = caseEndAction:getAction()
		local actionInfo = caseEndAction:getFactorType2()

		if action == "effectmap" then
			self:dealEfectMap(actionInfo)
		end

		if action == "effectobject" then
			self:dealEffectObject(actionInfo)
		end

		if action == "effectmain" then
			self:dealEffectMain(actionInfo)
		end

		if action == "actionobject" then
			self:dealActionObject(actionInfo)
		end

		if action == "actionmain" then
			self:dealActionMain(actionInfo)
		end
	end
end

function ExploreMapViewMediator:endTriggerCallBack(response, case, dealEndDialogue)
	local data = response.data
	local endStory = case:getEndStory()
	local autoExecute = not not (data.autoexecute and data.autoexecute == "1")
	local tipstxt = ""

	if data.tipstxt and data.tipstxt ~= "" then
		tipstxt = data.tipstxt
	end

	local objectwalk

	if data.objectwalk then
		objectwalk = data.objectwalk
	end

	self:dealCaseEndActionEffect(data.actionIds)

	if data.mastermove then
		self:moveToPos(self:getPosByGrid({
			y = data.mastermove[2],
			x = data.mastermove[1]
		}), nil, true)
		self._collectionView:checkUpdateCell(true)

		self._passiveEventState = {}

		self:refreshHeroPositionAndZOrder(true)
		self:checkPosition(cc.p(data.mastermove[1], data.mastermove[2]))
		self:dispatch(Event:new(EVT_TINY_MAP_REFRESH))
		self._topUIMediator:updateTinyMap()
	end

	if data.objectmove then
		for i, v in pairs(self._exploreObjects) do
			if v:getConfigByKey("Id") == data.objectmove.configId then
				self:removeObject({
					mapKey = self._pointId,
					object = v
				})
				self:addObject({
					mapKey = self._pointId,
					object = v
				})
			end
		end
	end

	if data.objectjointeam then
		self:addRole(data.objectjointeam)
	end

	if data.objectleaveteam then
		self:removeRole(data.objectleaveteam)
	end

	if not self._autoPlay and endStory and #endStory > 0 then
		self:showUi(false)

		local function endCallBack()
			self:showUi(true)
			dealEndDialogue(autoExecute, tipstxt, objectwalk)
		end

		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local storyAgent = storyDirector:getStoryAgent()

		storyAgent:setSkipCheckSave(true)
		storyAgent:trigger(endStory, nil, endCallBack)
	else
		dealEndDialogue(autoExecute, tipstxt, objectwalk)
	end
end

function ExploreMapViewMediator:addRole(objectjointeam)
	local tempObject = self:getInjector():instantiate("ExploreObject", nil, nil, objectjointeam)
	local objectMediator = self:getInjector():instantiate(ExploreObjectMediator, tempObject)
	local objectRender = objectMediator:getView()

	objectMediator:setSkeletonAnimationGroup(self._skeletonAnimGroup)

	local hasHeroPlot = false
	local length = #self._heroPlots

	for i = 1, length do
		if not self._heroPlots[i].hasChild then
			self._heroPlots[i].hasChild = true

			self._heroPlots[i].node:addChild(objectRender)

			hasHeroPlot = true

			break
		end
	end

	if not hasHeroPlot then
		local index = length + 1

		self._heroPlots[index].hasChild = true

		self._heroPlots[index].node:addChild(objectRender)
	end

	table.insert(self._heros, objectRender)
	self:refreshHeroPositionAndZOrder()
end

function ExploreMapViewMediator:removeRole(objectleaveteam)
	local removeIndex

	for i = 1, #self._heros do
		local heroRender = self._heros[i]

		if heroRender.mediator.getExploreObject then
			if heroRender.mediator:getExploreObject():getResConfigByKey("Id") == objectleaveteam then
				heroRender:removeFromParent()
				table.remove(self._heros, i)

				removeIndex = i

				break
			end
		end
	end

	if removeIndex then
		for i = removeIndex, #self._heroPlots do
			local heroRender = self._heros[i]

			if heroRender then
				heroRender:changeParent(self._heroPlots[i].node)

				self._heroPlots[i].hasChild = true
			else
				self._heroPlots[i].hasChild = false
			end
		end

		self:refreshHeroPositionAndZOrder()
	end
end

function ExploreMapViewMediator:dealEventByType(obj, case, dealEndDialogue)
	local objId = obj:getExploreObject():getId()
	local caseId = case:getId()
	local caseFactor = case:getCaseFactor()
	local caseType = case:getCaseType()

	if caseType == "REWARD" then
		obj:showProgressBar(caseFactor, function()
			obj.endTriggering = true

			self._exploreSystem:endTrigger(function(response)
				obj.endTriggering = false

				self:endTriggerCallBack(response, case, dealEndDialogue)
			end, {
				objectId = objId,
				params = {}
			}, true, self)
		end)
	elseif caseType == "BATTLE" then
		local isAuto = false

		local function enterBattle()
			local function tempFunc(isAutoPlay)
				self._autoPlayFighting = false

				self._exploreSystem:requestGetBattleData(function(response)
					if not response.data.data then
						local str = string.format("isAuto:%s / caseId:%s / caseType:%s / objId:%s", tostring(isAuto), caseId, caseType, objId)

						CommonUtils.uploadDataToBugly("ExploreCaseDebug", str)
					end

					self._exploreSystem:enterBattle(caseFactor.mapbattlepoint, response.data.data, {
						caseId = caseId,
						objData = obj:getExploreObject()
					}, isAutoPlay)
				end, {
					objectId = objId
				})
			end

			if self._autoPlay then
				local info = self._exploreSystem:getAutoPlayCase().attackInfo

				if not info then
					tempFunc(true)

					return
				end

				self._autoPlayFighting = true

				self._roleSprite.mediator:playAnimation(info.Action, info.Num, info.EndAction, function()
					tempFunc(true)
				end)

				return
			end

			tempFunc()
		end

		local function enterQuickBattle()
			local function tempFunc()
				self._exploreSystem:requestGetBattleData(function(response)
					if not response.data.data then
						local str = string.format("isAuto:%s / caseId:%s / caseType:%s / objId:%s", tostring(isAuto), caseId, caseType, objId)

						CommonUtils.uploadDataToBugly("ExploreCaseDebug", str)
					end

					self._exploreSystem:enterQuickBattle(caseFactor.mapbattlepoint, response.data.data, {
						caseId = caseId,
						objData = obj:getExploreObject()
					})
				end, {
					objectId = objId
				})
			end

			self:playQuickBattleAnim(tempFunc)
		end

		if not caseFactor.casefactor or self._autoPlay then
			isAuto = true

			enterBattle()
		else
			isAuto = false

			local view = self:getInjector():getInstance("ExploreCaseAlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				caseType = "BATTLE",
				battleId = caseFactor.mapbattlepoint,
				caseFactor = caseFactor.casefactor,
				callback = function(chooseId)
					if caseFactor.casefactor:getBattleOption() == chooseId then
						enterBattle()
					elseif caseFactor.casefactor:getQuickBattleOption() == chooseId then
						enterQuickBattle()
					elseif ExploreCloseChooseId == chooseId then
						obj.endTriggering = true

						self._exploreSystem:endTrigger(function(response)
							obj.endTriggering = false

							self:endTriggerCallBack(response, case, dealEndDialogue)
						end, {
							objectId = objId,
							params = {
								type = "1"
							}
						}, true, self)
					else
						obj.endTriggering = true

						self._exploreSystem:endTrigger(function(response)
							obj.endTriggering = false

							self:endTriggerCallBack(response, case, dealEndDialogue)
						end, {
							objectId = objId,
							params = {
								type = chooseId
							}
						}, true, self)
					end
				end
			}))
		end
	elseif caseType == "SHOP" then
		local view = self:getInjector():getInstance("ExploreShopView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			objectId = objId,
			id = caseId,
			shopId = caseFactor.shopId
		}))
	elseif caseType == "CHOICE" then
		local function tempFunc(chooseId)
			obj.endTriggering = true

			self._exploreSystem:endTrigger(function(response)
				obj.endTriggering = false

				self:endTriggerCallBack(response, case, dealEndDialogue)
			end, {
				objectId = objId,
				params = {
					type = chooseId
				}
			}, true, self)
		end

		if self._autoPlay then
			tempFunc(self._exploreSystem:getAutoPlayCase().order)

			return
		end

		local view = self:getInjector():getInstance("ExploreCaseAlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			caseType = "CHOICE",
			caseFactor = caseFactor.casefactor,
			callback = tempFunc
		}))
	elseif caseType == "EMPTY" then
		obj.endTriggering = true

		self._exploreSystem:endTrigger(function(response)
			obj.endTriggering = false

			self:endTriggerCallBack(response, case, dealEndDialogue)
		end, {
			objectId = objId,
			params = {}
		}, true, self)
	end
end

function ExploreMapViewMediator:showFinishView()
	local taskData = self._pointCfg:getMainTask()
	local taskStatus = taskData:getStatus()
	local customKey = CustomDataKey.kExploreFinish
	local customData = self._customDataSystem:getValue(PrefixType.kGlobal, customKey)

	if (not customData or customData == "0") and taskStatus ~= 0 then
		local view = self:getInjector():getInstance("ExploreVictoryView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			pointData = self._pointCfg,
			callback = function()
				self:triggerPassiveEvent()
			end
		}))
		self._customDataSystem:setValue(PrefixType.kGlobal, customKey, "1")

		return true
	end
end

function ExploreMapViewMediator:triggerPassiveEvent()
	if self._autoPlay then
		return
	end

	local stateChangedObj = self:getPassiveEventStateChangedObj()

	if stateChangedObj then
		self:triggerEvent(stateChangedObj)
	end

	return stateChangedObj
end

function ExploreMapViewMediator:dealExploreEvent(caseId, obj, fightData)
	self._eventDirty = true

	if fightData then
		obj = self._objectsRenderMap[fightData.extraData.objData]
		caseId = fightData.extraData.caseId
	end

	local case = ExploreCase:new(caseId)
	local beginDialogue = case:getBeginDialogue()
	local endDialogue = case:getEndDialogue()
	local beginStory = case:getBeginStory()
	local beginJournalDes = case:getBeginJournalDes()
	local endJournalDes = case:getEndJournalDes()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()

	if obj then
		obj:setDoing(true)
	end

	local function dealEndDialogue(autoExecute, tipstxt, objectwalk)
		if obj then
			obj:setDoing(false)
			obj:resumeWalkAction()
		end

		if endJournalDes ~= "" then
			self:dispatch(Event:new(EVT_EXPLORE_SAVE_LOG, {
				caseId = caseId,
				logId = endJournalDes
			}))
		end

		local function endDialogueCallBack()
			if tipstxt ~= "" then
				self:dispatch(ShowTipEvent({
					tip = Strings:get(tipstxt)
				}))
			end

			if objectwalk then
				self:createWalkSprite(objectwalk)
			end

			if autoExecute and obj then
				if not self._autoPlay then
					self:triggerEvent(obj)
				end
			elseif not self:showFinishView() then
				self:triggerPassiveEvent()
			end

			if self._autoPlay then
				self:nextAutoPlayStep()
			end
		end

		if endDialogue and not self._autoPlay then
			self:dealDialogueEvent(endDialogue, endDialogueCallBack)
		else
			endDialogueCallBack()
		end
	end

	if fightData then
		self:endTriggerCallBack(fightData.response, case, dealEndDialogue)

		return
	end

	local function dealBeginDialogue()
		if beginJournalDes ~= "" then
			self:dispatch(Event:new(EVT_EXPLORE_SAVE_LOG, {
				caseId = caseId,
				logId = beginJournalDes
			}))
		end

		if beginDialogue and not self._autoPlay then
			self:dealDialogueEvent(beginDialogue, function()
				self:dealEventByType(obj, case, dealEndDialogue)
			end)
		else
			self:dealEventByType(obj, case, dealEndDialogue)
		end
	end

	if not self._autoPlay and beginStory and #beginStory > 0 then
		self:showUi(false)

		local function endCallBack()
			self:showUi(true)
			dealBeginDialogue()
		end

		storyAgent:setSkipCheckSave(true)
		storyAgent:trigger(beginStory, nil, endCallBack)
	else
		dealBeginDialogue()
	end
end

function ExploreMapViewMediator:createWalkSprite(objectwalk)
	self._scrollView:removeChildByName("WalkSprite")

	if objectwalk.ObjectID then
		local grid = {
			x = objectwalk.Walk.Position[1],
			y = objectwalk.Walk.Position[2]
		}
		local pos = self:getPosByGrid(grid)
		local object = self:getInjector():instantiate("ExploreObject", objectwalk.ObjectID)
		local objectMediator = self:getInjector():instantiate(ExploreObjectMediator, object)
		local render = objectMediator:getView()

		render:setName("WalkSprite")
		self._scrollView:addChild(render)
		render:setPosition(pos)
		render.mediator:runWalkAction3(objectwalk, function()
			local grid = self:getGridByPos({
				x = render:getPositionX(),
				y = render:getPositionY()
			})
			local zOrder = self:getGlobalZOrderByGrid(grid)

			render.mediator:getBaseNode():setGlobalZOrder(zOrder)
		end)
	end
end

function ExploreMapViewMediator:showUi(isShow)
	self._topUIMediator:getView():setVisible(isShow)
	self._rockerPan:setVisible(isShow)

	if self._chatMediator then
		self._chatMediator:getView():setVisible(isShow)
	end

	self._btnPanel:setVisible(isShow)
end

function ExploreMapViewMediator:cleanEvent()
	if not self._eventDirty then
		return
	end

	self._roleSprite.mediator:cleanEvent()

	for i = 1, #self._heros do
		local hero = self._heros[i]

		hero.mediator:cleanEvent()
	end

	for k, v in pairs(self._objectsRenderMap) do
		v:cleanEvent()
	end

	self._eventDirty = false
end

function ExploreMapViewMediator:triggerEvent(v)
	self:cleanEvent()

	local var_107_0 = {}

	var_107_0.objectId = v:getExploreObject():getId()

	self._exploreSystem:startTrigger(function(response)
		local caseId = response.data.caseId

		if caseId and #caseId > 0 then
			if self._autoPlay then
				local autoCaseID = (self._exploreSystem:getAutoPlayCase() or {}).caseID

				while autoCaseID do
					if autoCaseID == caseId then
						break
					else
						autoCaseID = (self._exploreSystem:nextAutoPlayCase() or {}).caseID
					end
				end

				if not autoCaseID then
					self:nextAutoPlayStep()

					return
				end
			end

			v:getExploreObject():setLastCase(caseId)
			v:setLastCase(caseId)
			self:dealExploreEvent(response.data.caseId, v)
		elseif self._autoPlay then
			self:nextAutoPlayStep()
		end
	end, var_107_0, true, self)
end

function ExploreMapViewMediator:getDirByDiff(diffPos)
	local degree = math.deg(math.atan(diffPos.y / diffPos.x))
	local dir = dirInfo[1]
	local realDegree = 0

	if diffPos.x >= 0 and diffPos.y >= 0 then
		dir = degree <= 22.5 and dirInfo[1] or degree <= 67.5 and dirInfo[2] or dirInfo[3]
		realDegree = degree
	elseif diffPos.x < 0 and diffPos.y >= 0 then
		dir = degree <= -67.5 and dirInfo[3] or degree <= -22.5 and dirInfo[4] or dirInfo[5]
		realDegree = 180 - degree
	elseif diffPos.x < 0 and diffPos.y < 0 then
		dir = degree <= 22.5 and dirInfo[5] or degree <= 67.5 and dirInfo[6] or dirInfo[7]
		realDegree = 180 + degree
	elseif diffPos.x > 0 and diffPos.y <= 0 then
		dir = degree <= -67.5 and dirInfo[7] or degree <= -22.5 and dirInfo[8] or dirInfo[1]
		realDegree = 360 - degree
	end

	return dir, realDegree
end

function ExploreMapViewMediator:getValidDir(targetDir, diffPos)
	local tempDir = cc.p(targetDir[1], -1 * targetDir[2])
	local curIndex = self._curGridIndex
	local targetIndexIsBlock = self._astar:isBlock(curIndex.y + tempDir.y, curIndex.x + tempDir.x)

	if math.abs(diffPos.x) > 1 and math.abs(diffPos.y) > 1 and targetIndexIsBlock then
		local tryDirArray = {
			cc.p(diffPos.x / math.abs(diffPos.x), 0),
			cc.p(diffPos.x / math.abs(diffPos.x), -1 * diffPos.y / math.abs(diffPos.y)),
			cc.p(0, -1 * diffPos.y / math.abs(diffPos.y))
		}
		local x, y = curIndex.x, curIndex.y
		local validDir = tempDir

		for i = 1, 3 do
			local dir = tryDirArray[((math.abs(diffPos.x) < math.abs(diffPos.y) or nil) and {
				3,
				2,
				1
			})[i]]

			targetIndexIsBlock = self._astar:isBlock(y + dir.y, x + dir.x)

			if not targetIndexIsBlock then
				validDir = dir

				break
			end
		end

		targetDir = {
			validDir.x,
			-1 * validDir.y
		}
	end

	return targetDir
end

function ExploreMapViewMediator:stopStepMove()
	self._dirPos = nil
	self._touchPanValid = false

	self:getView():stopActionByTag(checkDirActionTag)
	self:stand()
end

function ExploreMapViewMediator:StartTestCpuPerformance()
	if lowPerformanceMode or self._cpuPerformanceInfo.testOver then
		return
	end

	self:getView():stopActionByTag(testCpuPerformanceTag)

	self._cpuPerformanceInfo.Start = app.getTime()

	local action = schedule(self:getView(), function()
		self._cpuPerformanceInfo.count = self._cpuPerformanceInfo.count + 1
	end, 0)

	action:setTag(testCpuPerformanceTag)
end

function ExploreMapViewMediator:StopTestCpuPerformance()
	if lowPerformanceMode or self._cpuPerformanceInfo.testOver or not self._cpuPerformanceInfo.Start then
		return
	end

	self:getView():stopActionByTag(testCpuPerformanceTag)

	self._cpuPerformanceInfo.timeSum = self._cpuPerformanceInfo.timeSum + app.getTime() - self._cpuPerformanceInfo.Start
	self._cpuPerformanceInfo.Start = nil

	if self._cpuPerformanceInfo.timeSum >= self._cpuPerformanceInfo.maxTimeSum then
		local curFps = self._cpuPerformanceInfo.count / self._cpuPerformanceInfo.timeSum

		self._cpuPerformanceInfo.testOver = true

		if curFps < self._cpuPerformanceInfo.fps then
			lowPerformanceMode = true
			extraOffset = 100

			self._collectionView:setExtraOffset(extraOffset)
			self:dispatch(Event:new(EVT_RELEASE_VIEW_MEMORY, {
				keepOnlyOne = true
			}))

			if DEBUG == 2 or app.pkgConfig.showLuaError == 1 then
				self:dispatch(ShowTipEvent({
					duration = 2,
					tip = self._cpuPerformanceInfo.timeSum .. " 开启低性能模式:" .. curFps
				}))
			end
		end
	end
end

function ExploreMapViewMediator:initRocker()
	self._panel_rocker = self:getChildView("Panel_base.Panel_rocker")
	self._rockerPan = self:getChildView("Panel_base.Panel_rocker.Image_touchPan")

	self._rockerPan:setOpacity(153)

	self._rockerPoint = self:getChildView("Panel_base.Panel_rocker.Image_touchPan.Image_point")

	local originPosX, originPosY = self._rockerPoint:getPosition()
	local MaxDistance = 90
	local originPos = cc.p(self._rockerPan:getPosition())
	local touchBeginPos, moveStepFunc
	local timeScale = 1

	local function moveStep()
		local tickTime = app.getTime()
		local action = schedule(self:getView(), function()
			if not self._dirPos then
				return
			end

			while app.getTime() - tickTime >= self._moveTimeForPerGrid * timeScale do
				if not self._dirPos then
					return
				end

				tickTime = tickTime + self._moveTimeForPerGrid * timeScale

				local currentPos = self._scrollView:getInnerContainer():convertToWorldSpace(self:getPosByGrid(self._curGridIndex))
				local diffPos = cc.pSub(cc.p(self._rockerPoint:getPosition()), cc.p(originPosX, originPosY))
				local absX = math.abs(diffPos.x)
				local absY = math.abs(diffPos.y)

				if absX < 10 and absY < 10 then
					timeScale = 1

					return
				end

				local dir = self:getValidDir(self:getDirByDiff(diffPos), diffPos)

				timeScale = dir[1] ~= 0 and dir[2] ~= 0 and moveTimeScale or 1

				local targetPos = cc.pAdd(currentPos, cc.p(dir[1] * 10, dir[2] * 10))

				self:dealTouch(targetPos, true)
			end
		end, 0)

		action:setTag(checkDirActionTag)
	end

	self._panel_rocker:addTouchEventListener(function(sender, eventType)
		if self._autoPlay then
			self:stopAutoPlay()
			self:showStopAutoTip()

			return false
		end

		if eventType == ccui.TouchEventType.began then
			self._autoClickEvent = false
			self._touchPanValid = true

			self._rockerPan:setOpacity(255)
			self:getView():stopActionByTag(moveActionTag)

			touchBeginPos = sender:getTouchBeganPosition()

			local localPos = self._panel_rocker:convertToNodeSpace(touchBeginPos)
			local boundingBox = self._rockerPan:getBoundingBox()

			if not cc.rectContainsPoint(boundingBox, localPos) then
				self._rockerPan:setPosition(localPos)
			end

			self._rockerPan:setOpacity(255)
			self:getView():stopActionByTag(moveActionTag)
		elseif eventType == ccui.TouchEventType.moved then
			local curp = sender:getTouchMovePosition()

			if not self._dirPos and self._touchPanValid then
				self._dirPos = curp

				moveStep()
				self:StartTestCpuPerformance()
			end

			self._dirPos = curp

			local localPos = self._rockerPan:convertToNodeSpace(curp)
			local beginp = cc.p(originPosX, originPosY)
			local disttance = cc.pGetDistance(beginp, localPos)
			local diffPos = cc.pSub(localPos, beginp)

			if disttance > MaxDistance then
				localPos.x = beginp.x + diffPos.x * MaxDistance / disttance
				localPos.y = beginp.y + diffPos.y * MaxDistance / disttance
			end

			self._rockerPoint:setPosition(localPos)
		else
			if self._touchPanValid then
				self:checkPosition(self._curGridIndex)
				self:moveToPos(self:getPosByGrid(self._curGridIndex), nil, true)
			end

			self:StopTestCpuPerformance()
			self:stopStepMove()
			self._rockerPoint:moveTo({
				time = 0.1,
				x = originPosX,
				y = originPosY
			})
			self._rockerPan:setOpacity(191.25)
			self._rockerPan:setPosition(originPos)
		end
	end)
end

function ExploreMapViewMediator:onTouchBegan(touch, event)
	if self._autoPlay then
		self:stopAutoPlay()
		self:showStopAutoTip()

		return false
	end

	return true
end

function ExploreMapViewMediator:onTouchMoved(touch, event)
	return
end

function ExploreMapViewMediator:onTouchCanceled(touch, event)
	return
end

function ExploreMapViewMediator:onTouchEnded(touch, event)
	local scene = self:getInjector():getInstance("BaseSceneMediator", "activeScene")
	local viewStack = scene._areaViewStack
	local viewInfo = viewStack[#viewStack]
	local popViewSize = 0

	if viewInfo.popupGroup then
		popViewSize = #(viewInfo.popupGroup._popupViewStack or {})
	end

	if popViewSize > 0 then
		return
	end

	self._autoClickEvent = true

	local curp = touch:getLocation()

	self._astar:setLimitNum(999999999)
	self:dealTouch(curp)
end

function ExploreMapViewMediator:dealTouch(curp, isStep)
	local pos = self._scrollView:getInnerContainer():convertToNodeSpace(curp)

	if pos.x < self._scrollViewSize.width / 2 then
		pos.x = self._scrollViewSize.width / 2
	end

	if pos.x > self.containerSize.width - self._scrollViewSize.width / 2 then
		pos.x = self.containerSize.width - self._scrollViewSize.width / 2
	end

	if pos.y < self._scrollViewSize.height / 2 then
		pos.y = self._scrollViewSize.height / 2
	end

	if pos.y > self.containerSize.height - self._scrollViewSize.height / 2 then
		pos.y = self.containerSize.height - self._scrollViewSize.height / 2
	end

	if isStep then
		self:walkToPosByStep(pos)
	else
		local clickObj = self._autoPlay and self:getAutoPlayObject() or self:getObjectOnClick(curp)
		local endPosIndex = self:getGridByPos(pos)

		if clickObj and not self:checkObjectInTriggerRect(clickObj) then
			pos = self._astar:isBlock(endPosIndex.y, endPosIndex.x) and self:tryGetValidWalkPosByObj(clickObj) or pos

			self:stopStepMove()
			self:walkToPos(pos, clickObj)
		elseif clickObj then
			if self._autoPlay then
				self._passiveEventState[clickObj:getExploreObject():getId()] = true

				if self._isWalk then
					self:stand()
					self:checkPosition(self._curGridIndex, function(adjust)
						if not adjust then
							self:triggerEvent(clickObj)
						else
							self:stopStepMove()
							self:walkToPos(pos)
						end
					end)
				else
					self:triggerEvent(clickObj)
				end

				return
			end

			for k, v in pairs(self._objectsRenderMap) do
				v:setSelectStatus(false)
			end

			local clickIcon = clickObj:getExploreObject():getClickPics()

			if clickIcon and clickIcon ~= "" then
				clickObj:setSelectStatus(true)
				self:setCaseBtnStatus(clickObj)

				if not self._isWalk then
					self:autoClickCaseEvent()
				end
			end
		else
			pos = self._autoPlay and self._astar:isBlock(endPosIndex.y, endPosIndex.x) and self:tryGetValidWalkPosByObj() or pos

			self:stopStepMove()
			self:walkToPos(pos)
		end
	end
end

function ExploreMapViewMediator:getValidPosByGrid(tryPos)
	local validWalkPos = self:getPosByGrid(tryPos)

	if self:getPathByestination(validWalkPos, true) then
		return validWalkPos
	end
end

function ExploreMapViewMediator:tryGetValidWalkPosByObj(obj)
	local validWalkPos
	local currentPosIndex = self._curGridIndex
	local tempPos = {}
	local triggerRect

	if self._autoPlay then
		triggerRect = self._curAutoPlayObj:getTriggerRect()
	else
		local objdata = obj:getExploreObject()

		triggerRect = objdata:getTriggerRect()
	end

	for i = 1, 1 do
		local dir = -1
		local tryPos = cc.p(triggerRect.minX - i * dir, triggerRect.minY - i * dir)

		table.insert(tempPos, tryPos)

		tryPos = cc.p(triggerRect.minX - i * dir, triggerRect.maxY + i * dir)

		table.insert(tempPos, tryPos)

		tryPos = cc.p(triggerRect.maxX + i * dir, triggerRect.minY - i * dir)

		table.insert(tempPos, tryPos)

		tryPos = cc.p(triggerRect.maxX + i * dir, triggerRect.maxY + i * dir)

		table.insert(tempPos, tryPos)

		local midX = math.ceil((triggerRect.maxX + triggerRect.minX) / 2)
		local midY = math.ceil((triggerRect.maxY + triggerRect.minY) / 2)

		tryPos = cc.p(triggerRect.maxX + i * dir, midY)

		table.insert(tempPos, tryPos)

		tryPos = cc.p(triggerRect.minX - i * dir, midY)

		table.insert(tempPos, tryPos)

		tryPos = cc.p(midX, triggerRect.maxY + i * dir)

		table.insert(tempPos, tryPos)

		tryPos = cc.p(midX, triggerRect.minY - i * dir)

		table.insert(tempPos, tryPos)
	end

	table.sort(tempPos, function(pos1, pos2)
		return cc.pGetDistance(pos1, currentPosIndex) < cc.pGetDistance(pos2, currentPosIndex)
	end)

	local firstNoBlockPos

	self._astar:setLimitNum(2000)

	for i = 1, #tempPos do
		local tryPos = tempPos[i]

		if not self._astar:isBlock(tryPos.y, tryPos.x) then
			firstNoBlockPos = firstNoBlockPos or self:getPosByGrid(tryPos)
			validWalkPos = self:getValidPosByGrid(tryPos)

			if validWalkPos then
				break
			end
		end
	end

	self._astar:setLimitNum(999999999)

	validWalkPos = validWalkPos or firstNoBlockPos

	return validWalkPos
end

function ExploreMapViewMediator:stand()
	if not self._isWalk then
		return
	end

	self._skeletonAnimGroup:setSpeedFactor(1)

	self._isWalk = false

	self._scrollView:stopAutoScroll()
	self:getView():stopActionByTag(moveActionTag)

	if not self._moveing then
		self:standAction()
	end
end

function ExploreMapViewMediator:standAction()
	self._roleSprite.mediator:playAnimation("stand")

	for i = 1, #self._heros do
		local hero = self._heros[i]

		hero.mediator:playAnimation("stand")
	end
end

function ExploreMapViewMediator:run()
	if self._isWalk then
		return
	end

	self._skeletonAnimGroup:setSpeedFactor(animationSpeedFactor)

	self._isWalk = true

	self._roleSprite.mediator:playAnimation("run")

	for i = 1, #self._heros do
		local hero = self._heros[i]

		hero.mediator:playAnimation("run")
	end
end

function ExploreMapViewMediator:updateRolesPos(nextMoveBy, time)
	local num = #self._heroPlots
	local pathNum = #self._heroMovePath

	for i = 1, num do
		local node = self._heroPlots[i].node
		local nextPos = self._heroMovePath[pathNum - i * roleDistance + 1]
		local diffPos = cc.p(nextPos.x - nextMoveBy.x, nextPos.y - nextMoveBy.y)

		if diffPos.x ~= 0 or diffPos.y ~= 0 then
			node:offset(diffPos.x, diffPos.y)
		end

		local hero = self._heros[i]

		if hero then
			local currentpos = cc.p(node:getPosition())

			self:setRoleTurn(hero, nextPos)

			local nextPosInPoint = cc.p(currentpos.x + diffPos.x, currentpos.y + diffPos.y)
			local gird = self:getGridByPos(self:getInnerContainerPosByViewPos(nextPosInPoint, true))

			hero._baseNode:setGlobalZOrder(self:getGlobalZOrderByGrid(gird))
		end
	end

	if #self._heroMovePath > 0 then
		table.remove(self._heroMovePath, 1)
	end
end

function ExploreMapViewMediator:getCurrentGridByServer()
	return {
		y = self._currentMapInfo:getY(),
		x = self._currentMapInfo:getX()
	}
end

function ExploreMapViewMediator:getPassiveEventStateChangedObj()
	local stateChangedObj

	for k, v in pairs(self._objectsRenderMap) do
		local inRect = self:checkObjectInTriggerRect(v)
		local id = v:getExploreObject():getId()

		if self._autoPlay then
			if self._autoPlayCfg.ObjectId == v:getExploreObject():getConfigId() and inRect and not self._passiveEventState[id] and not stateChangedObj then
				stateChangedObj = v
				self._passiveEventState[id] = true
			end
		elseif inRect then
			if v:getExploreObject():getConfigByKey("TriggerType") > 1 and not self._passiveEventState[id] and not stateChangedObj then
				stateChangedObj = v
				self._passiveEventState[id] = true
			end
		end

		if not inRect then
			self._passiveEventState[id] = nil
		end
	end

	return stateChangedObj
end

function ExploreMapViewMediator:getActiveEventObjByTriggerRect()
	local obj

	for k, v in pairs(self._objectsRenderMap) do
		v:setSelectStatus(false)

		local inRect = self:checkObjectInTriggerRect(v)

		if inRect and not obj then
			local clickIcon = v:getExploreObject():getClickPics()

			if clickIcon and clickIcon ~= "" then
				v:setSelectStatus(true)

				obj = v
			end
		end
	end

	return obj
end

function ExploreMapViewMediator:checkPosition(pos, callback)
	self.listener:setEnabled(false)
	self._exploreSystem:move(function()
		local serverGrid = self:getCurrentGridByServer()
		local adjust = false

		if pos.y ~= serverGrid.y or pos.x ~= serverGrid.x then
			print("与后端位置不一致，进行校准")
			self:moveToPos(self:getPosByGrid(serverGrid), nil, true)

			adjust = true
			self._passiveEventState = {}

			self:refreshHeroPositionAndZOrder(true)
		end

		if callback then
			callback(adjust)
		end

		self.listener:setEnabled(true)
	end, {
		x = pos.x,
		y = pos.y,
		heroPath = self:getHeroPathStr()
	}, false, self)
end

function ExploreMapViewMediator:walkToPos(pos, onClickObj)
	local function doRun()
		local path = self:getPathByestination(pos)

		self:stand()
		self:cleanEvent()

		if path then
			self:run()
			self:moveToByPath(path, function(index)
				self:updateCaseBtnByEndTrigger()

				if not self._autoPlay and onClickObj and self:checkObjectInTriggerRect(onClickObj) and not self._dirPos and (onClickObj or nil) and onClickObj:getExploreObject():getConfigByKey("TriggerType") == 1 then
					self:checkPosition(path[index], function(adjust)
						if not adjust then
							self:autoClickCaseEvent(onClickObj)
						elseif self:checkObjectInTriggerRect(onClickObj) then
							self:autoClickCaseEvent()
						end
					end)

					return true
				end

				local stateChangedObj = self:getPassiveEventStateChangedObj()

				if stateChangedObj then
					self:checkPosition(path[index], function(adjust)
						if not adjust then
							self:triggerEvent(stateChangedObj)
						else
							stateChangedObj = self:getPassiveEventStateChangedObj()

							if stateChangedObj then
								self:triggerEvent(stateChangedObj)
							end
						end
					end)

					if stateChangedObj:getExploreObject():getConfigByKey("NoStop") then
						return false
					end

					return true
				end

				if #path == index then
					self:checkPosition(path[index])
				end
			end, pos)
		end
	end

	if self._isWalk then
		self._nextRun = doRun
	else
		doRun()
	end
end

function ExploreMapViewMediator:walkToPosByStep(pos)
	local endPosIndex = self:getGridByPos(pos)

	if self._astar:isBlock(endPosIndex.y, endPosIndex.x) then
		return
	end

	self:cleanEvent()
	self:run()

	local curIndex = self._curGridIndex

	self:moveToPos(pos, (curIndex.x ~= endPosIndex.x and curIndex.y ~= endPosIndex.y or nil) and self._moveTimeForPerGrid * moveTimeScale)
	self._roleSprite._baseNode:setGlobalZOrder(self:getGlobalZOrderByGrid(self._curGridIndex))
	self:updateCaseBtnByEndTrigger()

	local stateChangedObj = self:getPassiveEventStateChangedObj()

	if stateChangedObj then
		if not stateChangedObj:getExploreObject():getConfigByKey("NoStop") then
			self:stopStepMove()
		end

		self:checkPosition(endPosIndex, function(adjust)
			if not adjust then
				self:triggerEvent(stateChangedObj)
			else
				stateChangedObj = self:getPassiveEventStateChangedObj()

				if stateChangedObj then
					self:triggerEvent(stateChangedObj)
				end
			end
		end)
	end
end

function ExploreMapViewMediator:getCurrentPos()
	return self:getInnerContainerPosByViewPos(cc.p(self._scrollViewSize.width * 0.5, self._scrollViewSize.height * 0.5))
end

function ExploreMapViewMediator:getPathByestination(pos, isTry)
	local currentPosIndex = self._curGridIndex
	local endPosIndex = self:getGridByPos(pos)

	if endPosIndex.y == currentPosIndex.y and endPosIndex.x == currentPosIndex.x then
		return
	end

	self._astar:setStartPoint(endPosIndex.y, endPosIndex.x)
	self._astar:setEndPoint(currentPosIndex.y, currentPosIndex.x)

	local time = os.clock()

	self._astar:setAntiAlias(true)

	local path, tryNum = self._astar:getSearchPath()

	if #path == 0 then
		if self._autoPlay and not isTry then
			self:showAlertView(Strings:get("EXPLORE_UI101"))
			self:stopAutoPlay()
		end

		if isTry then
			return
		end

		self._astar:setStartPoint(currentPosIndex.y, currentPosIndex.x)
		self._astar:setEndPoint(endPosIndex.y, endPosIndex.x)
		self._astar:setAntiAlias(false)

		path = self._astar:getMaxValidPath()

		if #path > 1 then
			table.reverse(path)
		end
	end

	if #path < 2 then
		path = nil
	end

	if path then
		local temp = {}

		for i = 1, #path do
			path[i].pos = self:getPosByGrid(cc.p(path[i].col, path[i].row))

			if path[i - 1] then
				local distance = cc.pGetDistance(path[i].pos, path[i - 1].pos)

				if distance > 18 then
					local segmentNum = math.ceil(distance / 10)
					local vector = cc.pSub(path[i].pos, path[i - 1].pos)
					local nomalVector = cc.pMul(vector, 1 / segmentNum)

					for j = 1, segmentNum - 1 do
						local tempPathPoint = {}

						tempPathPoint.pos = cc.pAdd(path[i - 1].pos, cc.pMul(nomalVector, j))

						local grid = self:getGridByPos(tempPathPoint.pos)

						tempPathPoint.col = grid.x
						tempPathPoint.row = grid.y

						table.insert(temp, tempPathPoint)
					end
				end
			end

			table.insert(temp, path[i])
		end

		path = temp

		for i = 1, #temp do
			path[i].x = path[i].col
			path[i].y = path[i].row
		end
	end

	return path
end

function ExploreMapViewMediator:getPosByGrid(grid, noCenter)
	local offsetScale = noCenter and 0 or 0.5

	return cc.p(grid.x * blockGridSize.width + blockGridSize.width * offsetScale, (blockGridNumSize.height - 1 - grid.y) * blockGridSize.height + blockGridSize.height * offsetScale)
end

function ExploreMapViewMediator:getGridByPos(pos)
	local grid = {}

	grid.y = blockGridNumSize.height - 1 - math.floor(pos.y / blockGridSize.height)
	grid.x = math.floor(pos.x / blockGridSize.width)

	return grid
end

function ExploreMapViewMediator:setRoleTurn(role, diffMove, isMaster)
	if diffMove.x < 0 then
		role.mediator:setRoleTurn(true)

		if isMaster then
			self._turnFace = true
		end
	elseif diffMove.x > 0 then
		role.mediator:setRoleTurn(false)

		if isMaster then
			self._turnFace = false
		end
	end
end

function ExploreMapViewMediator:updateBGM()
	local curGrid = self._curGridIndex

	for k, v in pairs(self._mapBgmAction) do
		for i = 1, #v do
			local points = v[i]

			if curGrid.y <= points[1][2] and curGrid.y >= points[2][2] and curGrid.x <= points[2][1] and curGrid.x >= points[1][1] then
				if self._mapBgmCurAction ~= k then
					if self._mapBgmCurAction then
						AudioEngine:getInstance():playAction(k)
					else
						local aisac = self._BGMAisac[k]

						if aisac then
							AudioEngine:getInstance():setAisacByID(aisac)
						else
							AudioEngine:getInstance():playAction(k)
						end
					end

					self._mapBgmCurAction = k
				end

				return
			end
		end
	end

	if self._mapBgmCurAction ~= self._mapBgmDefAction then
		if self._mapBgmCurAction then
			AudioEngine:getInstance():playAction(self._mapBgmDefAction)
		else
			local aisac = self._BGMAisac[self._mapBgmDefAction]

			if aisac then
				AudioEngine:getInstance():setAisacByID(aisac)
			else
				AudioEngine:getInstance():playAction(self._mapBgmDefAction)
			end
		end

		self._mapBgmCurAction = self._mapBgmDefAction
	end
end

function ExploreMapViewMediator:moveToPosByAction(pos, time)
	local curPos = self._scrollView:getInnerContainerPosition()
	local posOffset = cc.pSub(pos, curPos)
	local startTime = app.getTime()

	self._scrollView:stopActionByTag(scrollMoveTag)

	local action = schedule(self._scrollView, function()
		local timeOffset = app.getTime() - startTime
		local timePercent = timeOffset / time

		timePercent = timePercent > 1 and 1 or timePercent

		local targetPos = cc.pAdd(curPos, cc.pMul(posOffset, timePercent))

		self._scrollView:setInnerContainerPosition(targetPos)

		if timePercent == 1 then
			self._scrollView:stopActionByTag(scrollMoveTag)

			self._moveing = false

			if not self._isWalk and not self._autoPlayFighting then
				self:standAction()
			end
		end
	end, 0)

	self._moveing = true

	action:setTag(scrollMoveTag)
end

function ExploreMapViewMediator:moveToPos(pos, time, init)
	if pos.x < self._scrollViewSize.width / 2 then
		pos.x = self._scrollViewSize.width / 2
	end

	if pos.x > self.containerSize.width - self._scrollViewSize.width / 2 then
		pos.x = self.containerSize.width - self._scrollViewSize.width / 2
	end

	if pos.y < self._scrollViewSize.height / 2 then
		pos.y = self._scrollViewSize.height / 2
	end

	if pos.y > self.containerSize.height - self._scrollViewSize.height / 2 then
		pos.y = self.containerSize.height - self._scrollViewSize.height / 2
	end

	if self._scrollView.targetPos then
		self._scrollView:setInnerContainerPosition(self._scrollView.targetPos)
	end

	if not init then
		local currentPos = self:getCurrentPos()
		local diffPos = cc.p(pos.x - currentPos.x, pos.y - currentPos.y)

		self:setRoleTurn(self._roleSprite, diffPos)

		diffPos.x = math.floor(diffPos.x * 100) * 0.01
		diffPos.y = math.floor(diffPos.y * 100) * 0.01

		table.insert(self._heroMovePath, diffPos)
		self:updateRolesPos(diffPos, time)
	end

	if time then
		self:moveToPosByAction(cc.p(self._scrollViewSize.width / 2 - pos.x, self._scrollViewSize.height / 2 - pos.y), time)
	else
		self._scrollView:setInnerContainerPosition(cc.p(self._scrollViewSize.width / 2 - pos.x, self._scrollViewSize.height / 2 - pos.y))
	end

	self._scrollView.targetPos = cc.p(self._scrollViewSize.width / 2 - pos.x, self._scrollViewSize.height / 2 - pos.y)
	self._curGridIndex = self:getGridByPos(pos)

	self._topUIMediator:refreshTinyMap(self._curGridIndex)
	self:updateBGM()
end

function ExploreMapViewMediator:getGlobalZOrderByGrid(grid)
	return baseGlobalZOrder + grid.y * blockGridNumSize.width + grid.x
end

function ExploreMapViewMediator:moveToByPath(path, callback, endPos)
	local index = 2
	local num = #path
	local timeScale = 1
	local tickTime = app.getTime()
	local action = schedule(self:getView(), function()
		while app.getTime() - tickTime >= self._moveTimeForPerGrid * timeScale do
			if index == num + 1 then
				return
			end

			if not self._isWalk then
				self:getView():stopActionByTag(moveActionTag)

				break
			end

			tickTime = tickTime + self._moveTimeForPerGrid * timeScale

			local pathIndexInfo = path[index]
			local curPos = self:getCurrentPos()
			local pos = path[index].pos

			timeScale = cc.pGetDistance(curPos, pos) / 10 * 0.5

			if endPos and index == num and math.abs(pos.x - endPos.x) < blockGridSize.width * 0.5 and math.abs(pos.y - endPos.y) < blockGridSize.height * 0.5 then
				pos = endPos
			end

			self:moveToPos(pos, self._moveTimeForPerGrid * timeScale)
			self._roleSprite._baseNode:setGlobalZOrder(self:getGlobalZOrderByGrid(pathIndexInfo))

			local isStop = callback(index)

			if isStop then
				index = num
			end

			index = index + 1

			if index == num + 1 then
				self:stand()
			end

			if self._nextRun then
				index = num + 1

				self:stand()
				self._nextRun()

				self._nextRun = nil
			end
		end
	end, 0)

	action:setTag(moveActionTag)
end

function ExploreMapViewMediator:setCaseBtnStatus(obj)
	self._caseBtn:setVisible(false)

	if not obj and self._caseData and self._objectsRenderMap[self._caseData._exploreObject] then
		self._caseData:setSelectStatus(false)
		self._caseData:resumeWalkAction()
	end

	self._caseData = nil

	if obj then
		self._caseBtn:setVisible(true)

		self._caseData = obj

		self._caseData:stopWalkActions()

		local image = self._caseData:getExploreObject():getClickPics()

		self._caseBtn:getChildByFullName("image"):loadTexture(string.format("asset/exploreTipsIcon/%s.png", image))
	end
end

function ExploreMapViewMediator:autoClickCaseEvent()
	if self._autoClickEvent and self._caseBtn:isVisible() then
		self._autoClickEvent = false

		self:onClickCase()
	end
end

function ExploreMapViewMediator:onClickCase()
	if self._autoPlay then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("EXPLORE_UI99")
		}))

		return
	end

	if self._caseData and self._objectsRenderMap[self._caseData._exploreObject] and not self._caseData:getDoing() then
		local soundId = self._caseData:getExploreObject():getConfigByKey("ClickSound")

		if soundId ~= "" then
			AudioEngine:getInstance():playEffect(soundId, false)
		end

		if self._isWalk then
			self:stand()
			self:checkPosition(self._curGridIndex, function(adjust)
				if self._caseData and not adjust then
					self._caseData:setDoing(true)
					self:triggerEvent(self._caseData)
				end
			end)
		else
			self._caseData:setDoing(true)
			self:triggerEvent(self._caseData)
		end
	end
end

function ExploreMapViewMediator:updateCaseBtnByEndTrigger()
	local selectObj = self:getActiveEventObjByTriggerRect()

	self:setCaseBtnStatus(selectObj)
end

function ExploreMapViewMediator:updateCaseObj()
	if self._caseData and self._objectsRenderMap[self._caseData._exploreObject] then
		self._caseData:setDoing(false)
	end
end

function ExploreMapViewMediator:leaveWithData()
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))
end
