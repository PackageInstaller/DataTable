-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityZeroMapMediator.lua

ActivityZeroMapMediator = class("ActivityZeroMapMediator", DmAreaViewMediator, _M)

ActivityZeroMapMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
ActivityZeroMapMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ActivityZeroMapMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")
ActivityZeroMapMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")
ActivityZeroMapMediator:has("_bagSystem", {
	is = "rw"
}):injectWith("BagSystem")
ActivityZeroMapMediator:has("_curStepId", {
	is = "r"
})
ActivityZeroMapMediator:has("_endStepId", {
	is = "r"
})
ActivityZeroMapMediator:has("_activityId", {
	is = "r"
})
ActivityZeroMapMediator:has("_activity", {
	is = "r"
})
ActivityZeroMapMediator:has("_mapId", {
	is = "r"
})
ActivityZeroMapMediator:has("_map", {
	is = "r"
})

local scrollMoveTag = 1004
local moveTime = 1
local jumpTime = 4
local sizeView = cc.size((display.size.width - 400) / 2, (display.size.height - 400) / 2)
local scrollViewSize = display.size
local sizeStartPosMinX = display.center.x - sizeView.width
local sizeStartPosMaxX = display.center.x + sizeView.width
local sizeStartPosMinY = display.center.y - sizeView.height
local sizeStartPosMaxY = display.center.y + sizeView.height
local kBtnHandlers = {}

function ActivityZeroMapMediator:initialize()
	super.initialize(self)
end

function ActivityZeroMapMediator:dispose()
	super.dispose(self)
end

function ActivityZeroMapMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), "EVT_ACTIVITY_ZERO_EXPORTPOINT", self, self.changeExplorePoint)

	self._main = self:getView():getChildByName("main")
	self._bgScrollVIew = self._main:getChildByName("ScrollViewBg")
	self._tiledScrollVIew = self._main:getChildByName("ScrollViewTiled")
	self._lineScrollVIew = self._main:getChildByName("ScrollViewLine")
	self._roleScrollVIew = self._main:getChildByName("ScrollViewRole")
	self._panelTouch = self._main:getChildByName("Panel_touch")

	local view = self:getInjector():getInstance("ActivityZeroMapUIView")

	self._topUIMediator = self:getInjector():instantiate("ActivityZeroMapUIMediator", {
		view = view
	})

	self._main:addChild(view)
	self._bgScrollVIew:setTouchEnabled(true)
	self._tiledScrollVIew:setTouchEnabled(true)
	self._lineScrollVIew:setTouchEnabled(true)
	self._roleScrollVIew:setTouchEnabled(true)
end

function ActivityZeroMapMediator:enterWithData(data)
	self._activityId = data.activityId
	self._activity = self._activitySystem:getActivityById(self._activityId)

	self:setupView()
end

function ActivityZeroMapMediator:resumeWithData()
	local quit = self:doReset()

	if quit then
		return
	end

	self:refreshView("resume")
end

function ActivityZeroMapMediator:doReset()
	local model = self._activitySystem:getActivityById(self._activityId)

	if not model then
		self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, "homeView"))

		return true
	end

	return false
end

function ActivityZeroMapMediator:setupView()
	self._mapId = self._activity:getCurMapId()
	self._map = self._activity:getMapData(self._mapId)
	self._activityConfig = self._activity:getActivityConfig()
	self._event = self._activity:getEvent()
	self._lineImg = self._map:getMapLine()
	self._bgData = self._map:getScene()
	self._curStepId = self._map:getCurStep()
	self._tiledPos = self._map:getAllStepSize()
	self._stepList = self._map:getStepList()
	self._endStepId = self._curStepId

	self._topUIMediator:enterWithData({
		parent = self,
		activityId = self._activityId,
		activity = self._activity,
		mapId = self._mapId,
		map = self._map
	})
	self:setScrollView()
	self:getTiledInfo()
	self:getLineInfo()
	self._collectionViewTiled:reloadData()
	self._collectionViewLine:reloadData()
end

function ActivityZeroMapMediator:refreshView(status)
	self._tiledPos = self._map:getAllStepSize()
	self._stepList = self._map:getStepList()

	if status == "resume" then
		self._curStepId = self._map:getCurStep()
	elseif status == "refreshViewAndSetRoleStartPos" then
		self._curStepId = self._stepList[1]
	end

	self._endStepId = self._curStepId

	self:getTiledInfo()
	self:getLineInfo()
	self._collectionViewTiled:reloadData()
	self._collectionViewLine:reloadData()
	self:setRolePos()
	self:setInnerContainerOffset()
end

function ActivityZeroMapMediator:transRole()
	self._curStepId = self._map:getCurStep()
	self._endStepId = self._curStepId

	self:setRolePos()
	self:setInnerContainerOffset()
end

function ActivityZeroMapMediator:setScrollView()
	local row = #self._bgData
	local column = #self._bgData[1]
	local bgImg = ccui.ImageView:create(self._bgData[1][1])

	self._sizeCell = cc.size(bgImg:getContentSize().width, bgImg:getContentSize().height)
	self._numSize = cc.size(column, row)
	scrollViewSize = scrollViewSize
	self._viewAllSize = cc.size(self._numSize.width * self._sizeCell.width, self._numSize.height * self._sizeCell.height)

	self._bgScrollVIew:setContentSize(scrollViewSize)
	self._bgScrollVIew:center(self:getView():getContentSize())
	self._bgScrollVIew:setBackGroundColorType(1)
	self._bgScrollVIew:setBackGroundColor(cc.c3b(255, 255, 255))
	self._bgScrollVIew:setDirection(3)
	self._bgScrollVIew:setInertiaScrollEnabled(false)
	self._bgScrollVIew:setScrollBarEnabled(false)

	local info = {
		isReuse = true,
		extraOffset = 0,
		isSchedule = true,
		view = self._bgScrollVIew,
		delegate = self,
		cellNumSize = self._numSize,
		cellSize = self._sizeCell,
		cellData = {
			bgData = self._bgData
		}
	}

	self._collectionViewBg = CollectionViewUtils:new(info)

	self._collectionViewBg:reloadData()
	self._tiledScrollVIew:setContentSize(scrollViewSize)
	self._tiledScrollVIew:center(self:getView():getContentSize())
	self._tiledScrollVIew:setBackGroundColorType(0)
	self._tiledScrollVIew:setBackGroundColor(cc.c3b(0, 0, 0))
	self._tiledScrollVIew:setDirection(3)
	self._tiledScrollVIew:setInertiaScrollEnabled(false)
	self._tiledScrollVIew:setSwallowTouches(false)
	self._tiledScrollVIew:setScrollBarEnabled(false)

	local info = {
		isReuse = true,
		extraOffset = 0,
		isSchedule = true,
		view = self._tiledScrollVIew,
		delegate = self,
		cellNumSize = self._numSize,
		cellSize = self._sizeCell,
		cellData = {
			tiledInfo = {}
		}
	}

	self._collectionViewTiled = CollectionViewUtils:new(info)

	self._lineScrollVIew:setContentSize(scrollViewSize)
	self._lineScrollVIew:center(self:getView():getContentSize())
	self._lineScrollVIew:setBackGroundColorType(0)
	self._lineScrollVIew:setBackGroundColor(cc.c3b(0, 0, 0))
	self._lineScrollVIew:setDirection(3)
	self._lineScrollVIew:setInertiaScrollEnabled(false)
	self._lineScrollVIew:setSwallowTouches(false)
	self._lineScrollVIew:setScrollBarEnabled(false)

	local info = {
		isReuse = true,
		extraOffset = 0,
		isSchedule = true,
		view = self._lineScrollVIew,
		delegate = self,
		cellNumSize = self._numSize,
		cellSize = self._sizeCell,
		cellData = {
			lineInfo = {}
		}
	}

	self._collectionViewLine = CollectionViewUtils:new(info)

	self._roleScrollVIew:setContentSize(scrollViewSize)
	self._roleScrollVIew:center(self:getView():getContentSize())
	self._roleScrollVIew:setBackGroundColorType(0)
	self._roleScrollVIew:setBackGroundColor(cc.c3b(0, 0, 0))
	self._roleScrollVIew:setDirection(3)
	self._roleScrollVIew:setInertiaScrollEnabled(false)
	self._roleScrollVIew:setSwallowTouches(false)
	self._roleScrollVIew:setScrollBarEnabled(false)

	local info = {
		isReuse = true,
		extraOffset = 0,
		isSchedule = true,
		view = self._roleScrollVIew,
		delegate = self,
		cellNumSize = cc.size(1, 1),
		cellSize = self._viewAllSize,
		cellData = {
			roleData = {}
		}
	}

	self._collectionViewRole = CollectionViewUtils:new(info)

	self._collectionViewRole:reloadData()

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
	self._panelTouch:getEventDispatcher():addEventListenerWithSceneGraphPriority(self.listener, self._panelTouch)
	self:setRolePos()
	self:setInnerContainerOffset()
end

function ActivityZeroMapMediator:getTiledInfo()
	local tiledInfo = {}

	for stepId, v in pairs(self._tiledPos) do
		local infoPos = self:getPosForCell(v)
		local data = {}

		data.infoPos = infoPos
		data.step = self:getStepData(stepId)
		data.stepId = stepId
		tiledInfo[infoPos.row] = tiledInfo[infoPos.row] or {}
		tiledInfo[infoPos.row][infoPos.col] = tiledInfo[infoPos.row][infoPos.col] or {}

		table.insert(tiledInfo[infoPos.row][infoPos.col], data)
	end

	self._tiledInfo = tiledInfo
end

function ActivityZeroMapMediator:getLineInfo()
	self._lineInfo = self._tiledInfo or self:getTiledInfo()

	for row, rowd in pairs(self._lineInfo) do
		for col, cold in pairs(rowd) do
			for rowcol, value in ipairs(cold) do
				value.rotation = self:getLineRotation(value.stepId)
			end
		end
	end
end

function ActivityZeroMapMediator:getLineRotation(stepId)
	local idx = table.indexof(self._stepList, stepId)
	local nextId = self._stepList[idx + 1]

	if nextId and self._tiledPos[nextId] then
		local curPos = self._tiledPos[stepId]
		local nextPos = self._tiledPos[nextId]

		if nextPos.x > curPos.x then
			return 0
		elseif nextPos.x == curPos.x then
			if nextPos.y > curPos.y then
				return -90
			else
				return 90
			end
		else
			return 180
		end
	end

	return nil
end

function ActivityZeroMapMediator:getStepData(stepId)
	self._stepData = self._stepData or {}
	self._stepData[stepId] = self._stepData[stepId] or self._map:getStep(stepId)

	return self._stepData[stepId]
end

function ActivityZeroMapMediator:setRolePos(pos)
	assert(self._tiledPos[self._curStepId] ~= nil, "移动点id不存在" .. self._curStepId)

	local pos = pos or self._tiledPos[self._curStepId]

	self._roleModel:setPosition(pos)
	self:setRoleTurn(pos)
end

function ActivityZeroMapMediator:setRoleTurn(pos)
	local cur = self._tiledPos[self._curStepId]
	local next = self._tiledPos[self:getNextId()]

	self._roleModel:setScaleX(((cur and next and cur.x > next.x and (cur.x ~= pos.x or cur.y ~= pos.y) or nil) and -1) * math.abs(self._roleModel:getScaleX()))
end

function ActivityZeroMapMediator:getRolePosition()
	local rolePosX, rolePosY = self._roleModel:getPosition()

	return rolePosX, rolePosY
end

function ActivityZeroMapMediator:getNextId()
	local idx = table.indexof(self._stepList, self._curStepId)

	return self._stepList[idx + 1]
end

function ActivityZeroMapMediator:startMove(isJump)
	if isJump then
		if not self._endStepId then
			local nextId = self:getNextId()
			local nextPos = self._tiledPos[nextId]

			assert(nextPos ~= nil, "移动点id不存在" .. nextId)

			local time = moveTime
			local roleTargetPos = nextPos
			local mapTargetPos
			local rolePosX, rolePosY = self:getRolePosition()
			local wpCurPos = self._roleModel:getParent():convertToWorldSpace(cc.p(rolePosX, rolePosY))
			local wpNextPos = self._roleModel:getParent():convertToWorldSpace(nextPos)
			local curMapPos = self._collectionViewRole._view:getInnerContainerPosition()
			local isViewingAreaX = math.abs(wpNextPos.x - display.center.x) > math.abs(wpCurPos.x - display.center.x)
			local isViewingAreaY = math.abs(wpNextPos.y - display.center.y) > math.abs(wpCurPos.y - display.center.y)
			local mapTargetPos = curMapPos

			if isJump then
				time = 0

				if not self:checkIsInArea(wpNextPos) then
					mapTargetPos.x = curMapPos.x - (nextPos.x - rolePosX)
					mapTargetPos.y = curMapPos.y - (nextPos.y - rolePosY)
					time = jumpTime
				end
			else
				if isViewingAreaX and (wpNextPos.x > display.center.x + sizeView.width or wpNextPos.x < display.center.x - sizeView.width) then
					mapTargetPos.x = curMapPos.x - (nextPos.x - rolePosX)
				end

				if isViewingAreaY and (wpNextPos.y > display.center.y + sizeView.height or wpNextPos.y < display.center.y - sizeView.height) then
					mapTargetPos.y = curMapPos.y - (nextPos.y - rolePosY)
				end
			end

			local param = {
				time = time,
				mapTargetPos = mapTargetPos,
				roleTargetPos = roleTargetPos,
				nextId = nextId,
				isJump = isJump
			}

			if isJump then
				self:roleJump(param)
			else
				self:moveToPosByAction(param)
			end
		end
	end
end

function ActivityZeroMapMediator:checkIsInArea(checkPos)
	local stepSize = cc.size(30, 30)

	local function funPos(pos)
		if pos.x >= 10 and pos.x <= display.size.width - 10 and pos.y >= 10 and pos.y <= display.size.height then
			return true
		end

		return false
	end

	local pos1 = cc.p(checkPos.x + stepSize.width, checkPos.y + stepSize.height)
	local pos2 = cc.p(checkPos.x + stepSize.width, checkPos.y - stepSize.height)
	local pos3 = cc.p(checkPos.x - stepSize.width, checkPos.y - stepSize.height)
	local pos4 = cc.p(checkPos.x - stepSize.width, checkPos.y + stepSize.height)

	if funPos(pos1) and funPos(pos2) and funPos(pos3) and funPos(pos4) then
		return true
	end

	return false
end

function ActivityZeroMapMediator:roleJump(param)
	if not self:getIsMoving() then
		self:setIsMoving(true)
	end

	local function callBack()
		self:moveToPosByAction(param)
	end

	self:roleHide(param, callBack)
end

function ActivityZeroMapMediator:roleHide(param, callBack)
	local call2 = cc.CallFunc:create(function()
		self._roleModel:setVisible(false)
		self:setRolePos(param.roleTargetPos)
	end)
	local call = cc.CallFunc:create(function()
		if callBack then
			callBack()
		end
	end)
	local delay = cc.DelayTime:create(1)

	self._roleModel:runAction(cc.Sequence:create(delay, call2, call))
end

function ActivityZeroMapMediator:roleShow(callBack)
	local delay = cc.DelayTime:create(1)
	local call2 = cc.CallFunc:create(function()
		self._roleModel:setVisible(true)
	end)
	local call = cc.CallFunc:create(function()
		if callBack then
			callBack()
		end
	end)

	self._roleModel:runAction(cc.Sequence:create(delay, call2, call))
end

function ActivityZeroMapMediator:getNextMapPos(curMapStartPos, posMapOffset, startTime, time, timePercent)
	local targetPos = cc.pAdd(curMapStartPos, cc.pMul(posMapOffset, timePercent))
	local offsetMaxX = scrollViewSize.width - self._viewAllSize.width
	local offsetMaxY = scrollViewSize.height - self._viewAllSize.height

	targetPos.x = offsetMaxX > targetPos.x and offsetMaxX or targetPos.x
	targetPos.y = offsetMaxY > targetPos.y and offsetMaxY or targetPos.y
	targetPos.x = targetPos.x > 0 and 0 or targetPos.x
	targetPos.y = targetPos.y > 0 and 0 or targetPos.y

	return targetPos
end

function ActivityZeroMapMediator:getNextRolePos(curRoleStartPos, posRoleOffset, startTime, time, timePercent)
	return (cc.pAdd(curRoleStartPos, cc.pMul(posRoleOffset, timePercent)))
end

function ActivityZeroMapMediator:moveToPosByAction(param)
	local scrollView = self._collectionViewRole._view
	local curMapStartPos = scrollView:getInnerContainerPosition()
	local posMapOffset = param.mapTargetPos and cc.pSub(param.mapTargetPos, curMapStartPos) or nil
	local startTime = app.getTime()
	local curRoleStartPos = cc.p(self:getRolePosition())
	local posRoleOffset = param.roleTargetPos and cc.pSub(param.roleTargetPos, curRoleStartPos) or nil

	if not posMapOffset and not posRoleOffset then
		return
	end

	local action = schedule(scrollView, function()
		if not self:getIsMoving() then
			self:setIsMoving(true)
		end

		local timeOffset = app.getTime() - startTime
		local timePercent = timeOffset / param.time

		timePercent = timePercent > 1 and 1 or timePercent

		local targetMapPos, targetRolePos

		if posMapOffset then
			self:setInnerContainerOffset((self:getNextMapPos(curMapStartPos, posMapOffset, startTime, param.time, timePercent)))
		end

		if posRoleOffset then
			self:setRolePos((self:getNextRolePos(curRoleStartPos, posRoleOffset, startTime, param.time, timePercent)))
		end

		if param.isJump then
			local nextPos = self._roleModel:getParent():convertToWorldSpace(param.roleTargetPos)

			if self:checkIsInArea(nextPos) then
				scrollView:stopActionByTag(scrollMoveTag)

				local function callBack()
					self:setIsMoving(false)
				end

				self:roleShow(callBack)

				return
			end
		end

		if timePercent == 1 then
			scrollView:stopActionByTag(scrollMoveTag)

			self._curStepId = param.nextId

			if self:checkEvents() then
				self:startMove()
			end
		end
	end, 0)

	action:setTag(scrollMoveTag)
end

function ActivityZeroMapMediator:checkEvents()
	local endId, curId = self._endStepId, self._curStepId

	if curId == endId then
		performWithDelay(self:getView(), function()
			self:setIsMoving(false)
			dump(" @@@@@@@ 到达终点 ")
			self:moveEndCallback()
		end, 0.1)

		return false
	end

	return true
end

function ActivityZeroMapMediator:setIsMoving(isMoving)
	self._moveing = isMoving

	self._collectionViewRole._view:setTouchEnabled(not isMoving)
	self._collectionViewTiled._view:setTouchEnabled(not isMoving)
	self._collectionViewLine._view:setTouchEnabled(not isMoving)
	self._collectionViewBg._view:setTouchEnabled(not isMoving)
	self._collectionViewRole._view:setSwallowTouches(isMoving)
	self._collectionViewTiled._view:setSwallowTouches(isMoving)
	self._collectionViewLine._view:setSwallowTouches(isMoving)
	self._collectionViewBg._view:setSwallowTouches(isMoving)
	self._topUIMediator:setMovingStatus(isMoving)
	self:playAnimation(isMoving and "run" or "stand")
end

function ActivityZeroMapMediator:getIsMoving()
	return self._moveing
end

function ActivityZeroMapMediator:getNextRolePos(curRoleStartPos, posRoleOffset, startTime, time, timePercent)
	return (cc.pAdd(curRoleStartPos, cc.pMul(posRoleOffset, timePercent)))
end

function ActivityZeroMapMediator:setInnerContainerOffset(pos)
	pos = pos or self:getInnerContainerOffset()

	self._collectionViewRole._view:setInnerContainerPosition(pos)
	self._collectionViewTiled._view:setInnerContainerPosition(pos)
	self._collectionViewLine._view:setInnerContainerPosition(pos)
	self._collectionViewBg._view:setInnerContainerPosition(pos)
end

function ActivityZeroMapMediator:getInnerContainerOffset()
	local curMapPos = self._collectionViewRole._view:getInnerContainerPosition()
	local offsetX, offsetY = curMapPos.x, curMapPos.y
	local rolePosX, rolePosY = self:getRolePosition()
	local startPos1 = self._roleModel:getParent():convertToNodeSpace(cc.p(sizeStartPosMinX, sizeStartPosMinY))
	local startPos2 = self._roleModel:getParent():convertToNodeSpace(cc.p(sizeStartPosMaxX, sizeStartPosMaxY))

	if rolePosX < startPos1.x then
		offsetX = curMapPos.x + (startPos1.x - rolePosX)
	elseif rolePosX > startPos2.x then
		offsetX = curMapPos.x + (startPos2.x - rolePosX)
	end

	if rolePosY < startPos1.y then
		offsetY = curMapPos.y + (startPos1.y - rolePosY)
	elseif rolePosY > startPos2.y then
		offsetY = curMapPos.y + (startPos2.y - rolePosY)
	end

	offsetX = offsetX > 0 and 0 or offsetX
	offsetY = offsetY > 0 and 0 or offsetY

	return cc.p(offsetX, offsetY)
end

function ActivityZeroMapMediator:onTouchBegan(touch, event)
	if self._moveing then
		return false
	end

	self.mapOffset = self._collectionViewRole._view:getInnerContainerPosition()

	return true
end

function ActivityZeroMapMediator:onTouchMoved(touch, event)
	local mapOffset = self._collectionViewRole._view:getInnerContainerPosition()
end

function ActivityZeroMapMediator:onTouchCanceled(touch, event)
	return
end

function ActivityZeroMapMediator:onTouchEnded(touch, event)
	self:setInnerContainerOffset(self.mapOffset)
end

function ActivityZeroMapMediator:getPosForCell(pos)
	local row, col, diffX, diffY = 0, 0, 0, 0

	assert(self._viewAllSize.height >= pos.y, "节点设置高度" .. pos.y .. "～超过背景高度" .. self._viewAllSize.height)
	assert(self._viewAllSize.width >= pos.x, "节点设置宽度" .. pos.x .. "～超过背景宽度" .. self._viewAllSize.width)

	row = math.floor((self._viewAllSize.height - pos.y) / self._sizeCell.height)
	col = math.floor(pos.x / self._sizeCell.width)

	return {
		row = row + 1,
		col = col + 1,
		diffX = pos.x - col * self._sizeCell.width,
		diffY = (row + 1) * self._sizeCell.height - (self._viewAllSize.height - pos.y)
	}
end

function ActivityZeroMapMediator:cellAtIndex(view, row, col, viewUtils)
	row = viewUtils._cellNumSize.height - 1 - row
	col = col == -0 and 0 or col

	local cellInfo = viewUtils._cellData
	local cell = viewUtils:dequeueCellByKey()

	cell = cell or cc.Node:create()

	if cellInfo.bgData and cellInfo.bgData[row + 1] and cellInfo.bgData[row + 1][col + 1] then
		local bgPic = ccui.ImageView:create(cellInfo.bgData[row + 1][col + 1])

		bgPic:setAnchorPoint(cc.p(0, 0))
		bgPic:addTo(cell)
	elseif cellInfo.tiledInfo then
		if self._tiledInfo and self._tiledInfo[row + 1] and self._tiledInfo[row + 1][col + 1] then
			local data = self._tiledInfo[row + 1][col + 1]

			for k, v in pairs(data) do
				local tiledPic = ccui.ImageView:create(v.step:getImg(), 1)

				tiledPic:addTo(cell):posite(v.infoPos.diffX, v.infoPos.diffY)
			end
		end
	elseif cellInfo.lineInfo then
		if self._lineInfo and self._lineInfo[row + 1] and self._lineInfo[row + 1][col + 1] then
			local data = self._lineInfo[row + 1][col + 1]

			for k, v in pairs(data) do
				if v.rotation ~= nil then
					local line = ccui.ImageView:create(self._lineImg, 1)

					line:addTo(cell):setAnchorPoint(0, 0.5):posite(v.infoPos.diffX, v.infoPos.diffY + 5)
					line:setRotation(v.rotation)
				end
			end
		end
	elseif cellInfo.roleData and not self._roleModel then
		local masterSystem = self._developSystem:getMasterSystem()
		local masterId = self._activity:getTeam():getMasterId()
		local roleModel = IconFactory:getRoleModelByKey("MasterBase", masterId)
		local model = ConfigReader:getRecordById("RoleModel", roleModel).Model
		local node = RoleFactory:createRoleAnimation(model)

		node:addTo(cell):posite(0, 0)
		node:setScale(0.5)

		self._roleModel = node
	end

	return cell
end

function ActivityZeroMapMediator:cellWillHide(view, row, col, cell)
	cell:removeAllChildren()
end

function ActivityZeroMapMediator:cellWillShow(view, row, col, cell)
	return
end

function ActivityZeroMapMediator:onEventForCollectionView(...)
	return
end

function ActivityZeroMapMediator:handleEvent(callback)
	local eventData = self._activity:getMapStepEventData(self._mapId, self._curStepId)

	if eventData then
		local eventType = eventData:getConfig().Type
		local eventConfig = eventData:getConfig().Config

		local function request()
			self._activity:handleEvent(self._activityId, self._mapId, eventData:getId(), true, function(data)
				self:handleEventCallback(data)

				if callback then
					callback("event")
				end
			end)
		end

		self:showBubble(eventType, request)
	elseif callback then
		callback()
	end
end

function ActivityZeroMapMediator:handleEventCallback(data)
	if data.eventId then
		local event = self._event[data.eventId]
		local eventType = event:getConfig().Type
		local eventConfig = event:getConfig().Config

		self:dispatch(ShowTipEvent({
			duration = 1.35,
			tip = ActivityZeroEventName[eventType]
		}))

		if eventType == ActivityZeroEventType.KBattle or eventType == ActivityZeroEventType.KBoss then
			-- block empty
		elseif eventType == ActivityZeroEventType.KBonus or eventType == ActivityZeroEventType.KCoin then
			-- block empty
		elseif eventType == ActivityZeroEventType.KStory then
			local function endCallBack()
				self:dispatch(ShowTipEvent({
					tip = "剧情播放完毕，播放飞向剧情回顾按钮动画",
					duration = 1.35
				}))
			end

			local storyDirector = self:getInjector():getInstance(story.StoryDirector)
			local storyAgent = storyDirector:getStoryAgent()
			local storyLink = ConfigReader:getDataByNameIdAndKey("ActivityStoryPoint", eventConfig, "StoryLink")

			storyAgent:setSkipCheckSave(true)
			storyAgent:trigger(storyLink, nil, endCallBack)
		elseif eventType == ActivityZeroEventType.KTrans then
			if not data.isRefresh then
				self:transRole()
				self:handleEvent()
			end
		elseif eventType == ActivityZeroEventType.KMore then
			self:dispatch(ShowTipEvent({
				duration = 1.35,
				tip = Strings:get("Activity_Zero_UI14")
			}))
			self:requestDiceCallBackStartMove(data.isMoveRefresh)
		elseif eventType == ActivityZeroEventType.KEmpty then
			-- block empty
		end

		if data.isRefresh and not data.isMoveRefresh then
			self:refreshView("refreshViewAndSetRoleStartPos")
		end
	end
end

function ActivityZeroMapMediator:onClickDice(clickType)
	if self:showExplorePointFullView() then
		return
	end

	self:handleEvent(function(status)
		if status ~= "event" then
			self:showDiceView(clickType)
		end
	end)
end

local itemCost = 1

function ActivityZeroMapMediator:showDiceView(clickType)
	self._clickType = clickType

	if clickType == 1 then
		if not self._activityConfig.FixedItem then
			local item = self._activityConfig.RollItem

			if self._bagSystem:getItemCount(item) < itemCost then
				self:dispatch(ShowTipEvent({
					duration = 1.35,
					tip = Strings:get("Activity_Zero_title_5")
				}))

				return
			end

			local param = {}

			param.type = clickType

			function param.callback(response)
				self:requestDiceCallBackStartMove(response.isMoveRefresh)

				self._diceStepView = nil

				self:showBubble("explorePoint")
			end

			function param.request(point)
				self._activity:requestThrowDice(self._activityId, self._mapId, clickType, point, true, function(response)
					if self._clickType == ActivityZeroDiceType.KRandom then
						self:dispatch(Event:new(EVT_RESET_ZREO_RANDOM, {
							response = response
						}))
					else
						self:dispatch(Event:new(EVT_RESET_ZREO_FIXED, {
							response = response
						}))
					end
				end)
			end

			self._diceStepView = self:getInjector():getInstance("ActivityZeroDiceStepView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self._diceStepView, nil, param))
		end
	end
end

function ActivityZeroMapMediator:checkStartMove()
	if self._curStepId ~= self._endStepId then
		self:startMove()
	end
end

function ActivityZeroMapMediator:moveEndCallback()
	if self._isMoveRefresh then
		self._isMoveRefresh = false

		self:refreshView("refreshViewAndSetRoleStartPos")

		self._endStepId = self._map:getCurStep()

		self:checkStartMove()
	else
		self:handleEvent()
	end
end

function ActivityZeroMapMediator:requestDiceCallBackStartMove(isMoveRefresh)
	self._isMoveRefresh = isMoveRefresh

	if self._isMoveRefresh then
		self._endStepId = self._stepList[#self._stepList]

		if self._curStepId == self._endStepId then
			self:moveEndCallback()
		else
			self:checkStartMove()
		end
	else
		self._endStepId = self._map:getCurStep()

		self:checkStartMove()
	end
end

function ActivityZeroMapMediator:gotoLink()
	self:dismiss()
	self._activitySystem:enterSelecteZeroMap(self._activityId)
end

function ActivityZeroMapMediator:showExplorePointFullView()
	local point = self._map:getExplorePoint()
	local rate = self._map:getRate()
	local maxPoint = rate[#rate].point

	if point < maxPoint or self._showExplorePointFull then
		return false
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local function func()
		self:gotoLink()
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			func()
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("Activity_Zero_UI15"),
		title1 = Strings:get("Activity_Zero_UI16"),
		content = Strings:get("Activity_Zero_UI17"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))

	self._showExplorePointFull = true

	return true
end

function ActivityZeroMapMediator:playAnimation(name, times, endActionName)
	if not self._roleModel then
		return
	end

	times = times or -1

	CommonUtils.playSpineByTimes(self._roleModel, times, name, function()
		if endActionName then
			self._roleModel:playAnimation(0, endActionName, true)
		end
	end)
end

local res = {
	[ActivityZeroEventType.KBattle] = {
		img = "hd_cl_ysj_qp.png",
		tips = "KBattle"
	},
	[ActivityZeroEventType.KBoss] = {
		img = "hd_cl_ysj_qp.png",
		tips = "KBoss"
	},
	[ActivityZeroEventType.KBonus] = {
		img = "hd_cl_ysj_qp.png",
		tips = "KBonus"
	},
	[ActivityZeroEventType.KCoin] = {
		img = "hd_cl_ysj_qp.png",
		tips = "KCoin"
	},
	explorePoint = {
		img = "hd_cl_ysj_qp.png",
		tips = "水电费爽肤水放松放松的范德萨发"
	}
}

function ActivityZeroMapMediator:showBubble(type, callback)
	if self._diceStepView then
		return
	end

	local resName = res[type]

	if type == "explorePoint" then
		local bubble = self._map:getBubbleStatus()

		if bubble then
			resName = res.explorePoint
			resName.tips = bubble.tips
		else
			resName = nil
		end
	end

	if not resName then
		if callback then
			callback()
		end

		return
	end

	if self._roleModel and not self._bubbleNode then
		local node = cc.Node:create()
		local img = ccui.ImageView:create("hd_cl_ysj_qp.png", ccui.TextureResType.plistType)

		img:setAnchorPoint(cc.p(0, 0))
		img:setScale9Enabled(true)
		img:setName("img")

		local txt = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 25)

		txt:setColor(cc.c3b(52, 52, 52))
		txt:setAnchorPoint(cc.p(0, 0))
		txt:setName("txt")
		txt:setAlignment(cc.TEXT_ALIGNMENT_LEFT, cc.TEXT_ALIGNMENT_LEFT)
		txt:setLineSpacing(8)
		img:addTo(node):posite(40, 140)
		txt:addTo(node):posite(80, 200)
		node:addTo(self._roleModel):posite(0, 0)
		txt:setDimensions(220, 0)

		self._bubbleNode = node
	end

	local img = self._bubbleNode:getChildByName("img")

	img:loadTexture(resName.img, ccui.TextureResType.plistType)
	img:setCapInsets(cc.rect(70, 40, 10, 10))

	local txt = self._bubbleNode:getChildByName("txt")

	txt:setString(Strings:get(resName.tips))

	local h = txt:getContentSize().height

	img:setContentSize(cc.size(305, h + 95))

	local endCall = cc.CallFunc:create(function()
		self._bubbleNode:setVisible(false)

		if type == "explorePoint" then
			self._map:setBubbleShowEnd()
		end

		if callback then
			callback()
		end
	end)
	local preCall = cc.CallFunc:create(function()
		self._bubbleNode:setVisible(true)
	end)
	local delay = cc.DelayTime:create(1)

	self._bubbleNode:stopAction(self._bubbleAction)
	self._bubbleNode:setVisible(false)

	self._bubbleAction = self._bubbleNode:runAction(cc.Sequence:create(preCall, delay, endCall))
end

function ActivityZeroMapMediator:changeExplorePoint()
	self._topUIMediator:refreshExplorePoint()
	self:showBubble("explorePoint")
end
