-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/view/MazeGameView.lua

module("logic.extensions.mazegame.view.MazeGameView", package.seeall)

local MazeGameView = class("MazeGameView", ViewComponent)
local speed = 20
local RIGHT = 3
local UP = -1
local LEFT = 1
local DOWN = -3
local STATE_INIT = "STATE_INIT"
local STATE_READY = "STATE_READY"
local STATE_RUNING = "STATE_RUNING"
local STATE_PAUSE = "STATE_PAUSE"
local STATE_GAME_END = "STATE_GAME_END"

function MazeGameView:ctor()
	MazeGameView.super.ctor(self)
end

function MazeGameView:unbindEvents()
	MazeGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
	PointerUpHandler.Get(self._btnLeft):RemoveLuaHandler(self._pointerUpBtnLeftHandler)
	PointerUpHandler.Get(self._btnLeft):RemoveLuaHandler(self._pointerDownBtnLeftHandler)
	PointerUpHandler.Get(self._btnRight):RemoveLuaHandler(self._pointerUpBtnRightHandler)
	PointerUpHandler.Get(self._btnRight):RemoveLuaHandler(self._pointerDownBtnRightHandler)
	PointerUpHandler.Get(self._btnUp):RemoveLuaHandler(self._pointerUpBtnUpHandler)
	PointerUpHandler.Get(self._btnUp):RemoveLuaHandler(self._pointerDownBtnUpHandler)
	PointerUpHandler.Get(self._btnDown):RemoveLuaHandler(self._pointerUpBtnDownHandler)
	PointerUpHandler.Get(self._btnDown):RemoveLuaHandler(self._pointerDownBtnDownHandler)
end

function MazeGameView:bindEvents()
	MazeGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)

	self._pointerDownBtnLeftHandler = PointerDownHandler.Get(self._btnLeft):AddLuaHandler(function(_go, eventData)
		self:_onPointerDown(eventData, LEFT)
	end)
	self._pointerDownBtnRightHandler = PointerDownHandler.Get(self._btnRight):AddLuaHandler(function(_go, eventData)
		self:_onPointerDown(eventData, RIGHT)
	end)
	self._pointerDownBtnUpHandler = PointerDownHandler.Get(self._btnUp):AddLuaHandler(function(_go, eventData)
		self:_onPointerDown(eventData, UP)
	end)
	self._pointerDownBtnDownHandler = PointerDownHandler.Get(self._btnDown):AddLuaHandler(function(_go, eventData)
		self:_onPointerDown(eventData, DOWN)
	end)
	self._pointerUpBtnLeftHandler = PointerUpHandler.Get(self._btnLeft):AddLuaHandler(function(_go, eventData)
		self:_onPointerUp(eventData, LEFT)
	end)
	self._pointerUpBtnRightHandler = PointerUpHandler.Get(self._btnRight):AddLuaHandler(function(_go, eventData)
		self:_onPointerUp(eventData, RIGHT)
	end)
	self._pointerUpBtnUpHandler = PointerUpHandler.Get(self._btnUp):AddLuaHandler(function(_go, eventData)
		self:_onPointerUp(eventData, UP)
	end)
	self._pointerUpBtnDownHandler = PointerUpHandler.Get(self._btnDown):AddLuaHandler(function(_go, eventData)
		self:_onPointerUp(eventData, DOWN)
	end)
end

function MazeGameView:buildUI()
	MazeGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnStart = self:getGo("btnStart")
	self._btnDown = self:getGo("direct/btnDown")
	self._btnRight = self:getGo("direct/btnRight")
	self._btnLeft = self:getGo("direct/btnLeft")
	self._btnUp = self:getGo("direct/btnUp")
	self._cell = self:getGo("cell")
	self._container = self:getGo("container")
	self._container2 = self:getGo("container2")
	self._imgPoint = self:getGo("imgPoint")
	self._txtRule = self:getTxt("rule/ScrollView/Viewport/Content")

	self:_initFSM()
end

function MazeGameView:onExit()
	MazeGameView.super.onExit(self)

	if self._joystickCtrl then
		self._joystickCtrl:StopJoystickMove()
	end

	self._stateMachine:stopTimer()
end

function MazeGameView:onEnter()
	MazeGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MazeGameEndGameRes, self.close, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 523001
	end

	self._stageId = checknumber(params[2])
	self._actCfg = MazeGameConfig.instance:getActCfg(self._activityId)
	self._stageCfg = MazeGameConfig.instance:getStageCfgById(self._activityId, self._stageId)
	self._mapCfg = MazeGameConfig.instance:getStageMapCfgById(self._activityId, self._stageId)

	self._stateMachine:startTimer()
	self._stateMachine:gotoState(STATE_INIT)
	self:_onSetUI()
end

function MazeGameView:_initFSM()
	self._stateMachine = SimpleFSM.New()

	self._stateMachine:addState(STATE_INIT, GameUtil.handler(self._onEnterInit, self), nil, nil)
	self._stateMachine:addState(STATE_READY, nil, nil, nil)
	self._stateMachine:addState(STATE_RUNING, nil, nil, GameUtil.handler(self._onRunning, self))
	self._stateMachine:addState(STATE_PAUSE, nil, nil, nil)
	self._stateMachine:addState(STATE_GAME_END, GameUtil.handler(self._onEnterGameEnd, self))

	local linkedList = {
		[STATE_INIT] = {
			STATE_READY
		},
		[STATE_READY] = {
			STATE_RUNING
		},
		[STATE_RUNING] = {
			STATE_PAUSE,
			STATE_GAME_END
		},
		[STATE_PAUSE] = {
			STATE_RUNING,
			STATE_GAME_END
		},
		[STATE_GAME_END] = {
			STATE_INIT
		}
	}

	self._stateMachine:addLinkByLinkedList(linkedList)
end

function MazeGameView:_initGamePram()
	local startPointStr = self._mapCfg.startPointStr
	local startIdxArr = string.split(startPointStr, "_")
	local startIdxX = checknumber(startIdxArr[1])
	local startIdxY = checknumber(startIdxArr[2])
	local cellSize = self._mapCfg.cellSize

	self._playerCoord = {
		startIdxX,
		startIdxY
	}
	self._playerAnchorPos = {
		startIdxX * cellSize,
		startIdxY * cellSize
	}
	self._directX = 0
	self._directY = 0
	self._direct = 0
	self._catchPointNum = 0
end

function MazeGameView:_onSetUI()
	self._countDownTime = self._mapCfg.gameTime
	self._txtTime.text = string.format("倒计时：%d", self._countDownTime)
	self._txtRule.text = self._actCfg.gameRuleDesc

	GameUtil.SetActive(self._btnStart, true)
end

function MazeGameView:_changePos()
	local moveDistance = speed * 0.2
	local cellSize = self._mapCfg.cellSize

	if cellSize < moveDistance then
		moveDistance = cellSize
	end

	local playerPosX = self._playerAnchorPos[1]
	local playerPosY = self._playerAnchorPos[2]

	if self._direct == LEFT then
		local curCoordX = math.floor((playerPosX - cellSize / 2) / cellSize) + 1
		local curCoordY = math.floor((playerPosY - cellSize / 2) / cellSize) + 1
		local curUpCoordY = math.floor((playerPosY + 8 - cellSize / 2) / cellSize) + 1
		local curDownCoordY = math.floor((playerPosY - 8 - cellSize / 2) / cellSize) + 1
		local afterMovePosX = playerPosX - moveDistance
		local afterMoveCoordX = math.floor((afterMovePosX - cellSize / 2) / cellSize) + 1
		local finalPosX = playerPosX
		local finalCoordX = curCoordX

		if curUpCoordY ~= curDownCoordY then
			return
		end

		if afterMoveCoordX == curCoordX then
			if self._map[curCoordX - 1] then
				local wallType = self._map[curCoordX - 1][curCoordY]

				finalPosX = curCoordX > 1 and ((wallType == 0 or wallType == 2) and math.max(curCoordX * cellSize, afterMovePosX) or afterMovePosX) or math.max(curCoordX * cellSize, afterMovePosX)
			end
		elseif self._map[curCoordX - 1] then
			local wallType = self._map[curCoordX - 1][curCoordY]

			if wallType ~= nil then
				if wallType ~= 1 and wallType ~= 3 then
					finalPosX = playerPosX
				else
					finalPosX = afterMovePosX
					finalCoordX = finalCoordX - 1
				end
			end
		end

		GameUtil.setAnchoredPos(self._player, finalPosX, playerPosY)

		self._playerAnchorPos[1] = finalPosX
		self._playerAnchorPos[2] = playerPosY
		self._playerCoord[1] = finalCoordX
		self._playerCoord[2] = curCoordY
	end

	if self._direct == RIGHT then
		local curCoordX = math.floor((playerPosX - cellSize / 2) / cellSize) + 1
		local curCoordY = math.floor((playerPosY - cellSize / 2) / cellSize) + 1
		local curUpCoordY = math.floor((playerPosY + 8 - cellSize / 2) / cellSize) + 1
		local curDownCoordY = math.floor((playerPosY - 8 - cellSize / 2) / cellSize) + 1
		local afterMovePosX = playerPosX + moveDistance
		local afterMoveCoordX = math.floor((afterMovePosX - cellSize / 2) / cellSize) + 1
		local finalPosX = playerPosX
		local finalCoordX = curCoordX

		if curUpCoordY ~= curDownCoordY then
			return
		end

		if afterMoveCoordX == curCoordX then
			if self._map[curCoordX] then
				local wallType = self._map[curCoordX][curCoordY]

				finalPosX = wallType ~= 1 and wallType ~= 3 and math.min(curCoordX * cellSize, afterMovePosX) or afterMovePosX
			end
		elseif self._map[curCoordX] then
			local wallType = self._map[curCoordX][curCoordY]

			if wallType ~= nil then
				if wallType == 1 or wallType == 3 then
					finalPosX = afterMovePosX
					finalCoordX = finalCoordX + 1
				else
					finalPosX = playerPosX
				end
			end
		end

		GameUtil.setAnchoredPos(self._player, finalPosX, playerPosY)

		self._playerAnchorPos[1] = finalPosX
		self._playerAnchorPos[2] = playerPosY
		self._playerCoord[1] = finalCoordX
		self._playerCoord[2] = curCoordY
	end

	if self._direct == DOWN then
		local curCoordX = math.floor((playerPosX - cellSize / 2) / cellSize) + 1
		local curLeftCoordX = math.floor((playerPosX - 10 - cellSize / 2) / cellSize) + 1
		local curRightCoordX = math.floor((playerPosX + 10 - cellSize / 2) / cellSize) + 1
		local curCoordY = math.floor((playerPosY - cellSize / 2) / cellSize) + 1
		local afterMovePosY = playerPosY - moveDistance
		local afterMoveCoordY = math.floor((afterMovePosY - cellSize / 2) / cellSize) + 1
		local finalPosY = playerPosY
		local finalCoordY = curCoordY

		if curLeftCoordX ~= curRightCoordX then
			return
		end

		if afterMoveCoordY == curCoordY then
			if curCoordY == 1 then
				finalPosY = math.max(curCoordY * cellSize, afterMovePosY)
			elseif self._map[curCoordX] then
				local wallType = self._map[curCoordX][curCoordY - 1]

				finalPosY = (wallType == 0 or wallType == 1) and math.max(curCoordY * cellSize, afterMovePosY) or afterMovePosY
			end
		elseif self._map[curCoordX] then
			local wallType = self._map[curCoordX][curCoordY - 1]

			if wallType ~= nil and (wallType == 2 or wallType == 3) then
				finalPosY = afterMovePosY
				finalCoordY = finalCoordY - 1
			end
		end

		GameUtil.setAnchoredPos(self._player, playerPosX, finalPosY)

		self._playerAnchorPos[1] = playerPosX
		self._playerAnchorPos[2] = finalPosY
		self._playerCoord[1] = curCoordX
		self._playerCoord[2] = finalCoordY
	end

	if self._direct == UP then
		local curCoordX = math.floor((playerPosX - cellSize / 2) / cellSize) + 1
		local curLeftCoordX = math.floor((playerPosX - 10 - cellSize / 2) / cellSize) + 1
		local curRightCoordX = math.floor((playerPosX + 10 - cellSize / 2) / cellSize) + 1
		local curCoordY = math.floor((playerPosY - cellSize / 2) / cellSize) + 1
		local afterMovePosY = playerPosY + moveDistance
		local afterMoveCoordY = math.floor((afterMovePosY - cellSize / 2) / cellSize) + 1
		local finalPosY = playerPosY
		local finalCoordY = curCoordY

		if curLeftCoordX ~= curRightCoordX then
			return
		end

		if afterMoveCoordY == curCoordY then
			if self._map[curCoordX] then
				local wallType = self._map[curCoordX][curCoordY]

				finalPosY = (curCoordY == self._mapCfg.height or wallType == 0 or wallType == 1) and math.min(curCoordY * cellSize, afterMovePosY) or afterMovePosY
			end
		elseif self._map[curCoordX] then
			local wallType = self._map[curCoordX][curCoordY]

			if wallType ~= nil and (wallType == 2 or wallType == 3) then
				finalPosY = afterMovePosY
				finalCoordY = finalCoordY + 1
			end
		end

		GameUtil.setAnchoredPos(self._player, playerPosX, finalPosY)

		self._playerAnchorPos[1] = playerPosX
		self._playerAnchorPos[2] = finalPosY
		self._playerCoord[1] = curCoordX
		self._playerCoord[2] = finalCoordY
	end
end

function MazeGameView:_checkCurPos()
	local curCoordX = self._playerCoord[1]
	local curCoordY = self._playerCoord[2]

	for i, coord in ipairs(self._pointCoordList) do
		if coord.x == curCoordX and coord.y == curCoordY then
			local point = self._point[i]

			GameUtil.SetActive(point, false)

			if self._catchPointMap[i] == false then
				self._catchPointNum = self._catchPointNum + 1
				self._catchPointMap[i] = true
			end
		end
	end
end

function MazeGameView:_checkGameFinish()
	local endPointNum = #self._point

	if self._catchPointNum == endPointNum then
		self._stateMachine:gotoState(STATE_GAME_END)
	end
end

function MazeGameView:_createGameMap()
	GameUtil.SetActive(self._cell, true)
	GameUtil.SetActive(self._imgPoint, true)
	self:_setMapData()
	self:_readConfigAndCreateMap()
	self:_createPoint()
	self:_createPlayer()
	GameUtil.SetActive(self._cell, false)
	GameUtil.SetActive(self._imgPoint, false)
end

function MazeGameView:_onPointerDown(eventData, direct)
	self._direct = direct

	if direct == UP then
		self._directX = 0
		self._directY = 1
	elseif direct == DOWN then
		self._directX = 0
		self._directY = -1
	elseif direct == RIGHT then
		self._directX = 1
		self._directY = 0
	elseif direct == LEFT then
		self._directX = -1
		self._directY = 0
	end
end

function MazeGameView:_onPointerUp(eventData, direct)
	self._directX = 0
	self._directY = 0
	self._direct = 0
end

function MazeGameView:_onClickBtnResetPlayer()
	local cellSize = self._mapCfg.cellSize

	self._playerCoord = {
		1,
		1
	}
	self._playerAnchorPos = {
		cellSize,
		cellSize
	}

	if self._player then
		GameUtil.setAnchoredPos(self._player, cellSize, cellSize)
	end
end

function MazeGameView:_setMapData()
	local mapData = self._mapCfg.mapData

	self._map = {}

	for i = 1, self._mapCfg.width do
		self._map[i] = self._map[i] or {}

		for j = 1, self._mapCfg.height do
			self._map[j] = self._map[j] or {}

			local curIdx = (i - 1) * self._mapCfg.height + j

			self._map[i][j] = mapData[curIdx]
		end
	end
end

function MazeGameView:_createPlayer()
	self._player = goutil.cloneAndSetParent(self._imgPoint, self._container.transform, "player")

	local cellSize = self._mapCfg.cellSize
	local playerIdxArr = string.split(self._mapCfg.startPointStr, "_")
	local playerIdxX = playerIdxArr[1]
	local playerIdxY = playerIdxArr[2]
	local changeSpriteComp = self._player:GetComponent("UIImageSpriteChange")

	changeSpriteComp:SetState(0)
	self._player:GetComponent(goutil.Type_UIImage):SetNativeSize()
	GameUtil.setAnchoredPos(self._player, playerIdxX * cellSize, playerIdxY * cellSize)
end

function MazeGameView:_createPoint()
	self._point = {}
	self._pointCoordList = {}
	self._catchPointMap = {}

	local cellSize = self._mapCfg.cellSize
	local endPointStr = self._mapCfg.endPointStr
	local endPointArr = string.split(endPointStr, "#")

	for i, point in ipairs(endPointArr) do
		local coord = {}
		local pointIdxArr = string.split(point, "_")
		local pointIdxX = checknumber(pointIdxArr[1])
		local pointIdxY = checknumber(pointIdxArr[2])
		local colorType = checknumber(pointIdxArr[3])
		local point = goutil.cloneAndSetParent(self._imgPoint, self._container.transform, "point_" .. pointIdxX .. "_" .. pointIdxY .. "_" .. colorType)
		local changeSpriteComp = point:GetComponent("UIImageSpriteChange")

		coord.x = pointIdxX
		coord.y = pointIdxY

		changeSpriteComp:SetState(colorType - 1)
		point:GetComponent(goutil.Type_UIImage):SetNativeSize()
		GameUtil.setAnchoredPos(point, pointIdxX * cellSize, pointIdxY * cellSize)
		table.insert(self._point, point)
		table.insert(self._pointCoordList, coord)

		self._catchPointMap[i] = false
	end
end

function MazeGameView:_readConfigAndCreateMap()
	goutil.clearChildren(self._container)

	local cellSize = self._mapCfg.cellSize

	for i = 1, self._mapCfg.width do
		for j = 1, self._mapCfg.height do
			local v = self._map[i][j]
			local cell = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell_" .. i .. "_" .. j)

			GameUtil.setAnchoredPos(cell, i * cellSize, j * cellSize)
			GameUtil.SetActive(cell, true)

			if i == 1 then
				local line = goutil.findChild(cell, "line_3")

				GameUtil.SetActive(line, true)
			end

			if j == 1 then
				local line = goutil.findChild(cell, "line_4")

				GameUtil.SetActive(line, true)
			end

			if v == 1 then
				local line = goutil.findChild(cell, "line_1")

				GameUtil.SetActive(line, false)
			elseif v == 2 then
				local line = goutil.findChild(cell, "line_2")

				GameUtil.SetActive(line, false)
			elseif v == 3 then
				local line = goutil.findChild(cell, "line_1")

				GameUtil.SetActive(line, false)

				local line = goutil.findChild(cell, "line_2")

				GameUtil.SetActive(line, false)
			end
		end
	end
end

function MazeGameView:_createData(i, j)
	local obj = {}

	obj.i = i
	obj.j = j
	obj.dirArr = {
		{
			1,
			0
		},
		{
			0,
			1
		},
		{
			-1,
			0
		},
		{
			0,
			-1
		}
	}

	GameUtil.permuteArray(obj.dirArr)

	return obj
end

function MazeGameView:buildTree(obj)
	self._openMap[obj.i][obj.j] = true

	table.insert(self._list, obj)

	for i, v in ipairs(obj.dirArr) do
		local newX = obj.i + v[1]
		local newY = obj.j + v[2]

		if newX >= 1 and newX <= self._mapCfg.width and newY >= 1 and newY <= self._mapCfg.height and self._openMap[newX][newY] == false then
			if v[1] == 1 then
				local cell = self._cellMap[obj.i][obj.j]
				local line = goutil.findChild(cell, "line_1")

				goutil.setActive(line, false)

				self._map[obj.i][obj.j] = self._map[obj.i][obj.j] + 1
			end

			if v[1] == -1 then
				local cell = self._cellMap[newX][newY]
				local line = goutil.findChild(cell, "line_1")

				goutil.setActive(line, false)

				self._map[newX][newY] = self._map[newX][newY] + 1
			end

			if v[2] == 1 then
				local cell = self._cellMap[obj.i][obj.j]
				local line = goutil.findChild(cell, "line_2")

				goutil.setActive(line, false)

				self._map[obj.i][obj.j] = self._map[obj.i][obj.j] + 2
			end

			if v[2] == -1 then
				local cell = self._cellMap[newX][newY]
				local line = goutil.findChild(cell, "line_2")

				goutil.setActive(line, false)

				self._map[newX][newY] = self._map[newX][newY] + 2
			end

			local tem = self:_createData(newX, newY)

			self:buildTree(tem)
		end
	end
end

function MazeGameView:_createMap()
	goutil.clearChildren(self._container)

	self._map = {}
	self._cellMap = {}
	self._openMap = {}

	local cellSize = self._mapCfg.cellSize

	for i = 1, self._mapCfg.width do
		self._cellMap[i] = {}
		self._map[i] = {}
		self._openMap[i] = {}

		for j = 1, self._mapCfg.height do
			self._openMap[i][j] = false
			self._map[i][j] = 0

			local cell = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell_" .. i .. "_" .. j)

			GameUtil.setAnchoredPos(cell, i * cellSize, j * cellSize)
			GameUtil.SetActive(cell, true)

			self._cellMap[i][j] = cell

			if i == 1 then
				local line = goutil.findChild(cell, "line_3")

				GameUtil.SetActive(line, true)
			end

			if j == 1 then
				local line = goutil.findChild(cell, "line_4")

				GameUtil.SetActive(line, true)
			end
		end
	end
end

function MazeGameView:_onClickBtnClose()
	self._stateMachine:gotoState(STATE_PAUSE)

	local tipsContent = "确定要退出迷宫游戏吗？"

	local function okFunc()
		self._stateMachine:gotoState(STATE_GAME_END)
	end

	local function cencelFunc()
		self._stateMachine:gotoState(STATE_RUNING)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

function MazeGameView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MazeGameView:_onClickBtnStart()
	GameUtil.SetActive(self._btnStart, false)
	self._stateMachine:gotoState(STATE_RUNING)
end

function MazeGameView:_onEnterInit()
	self:_initGamePram()
	self:_createGameMap()
	self._stateMachine:gotoState(STATE_READY)
end

function MazeGameView:_onRunning()
	if self._isPauseGame then
		return
	end

	self._countDownTime = math.max(0, self._countDownTime - 0.01)
	self._txtTime.text = string.format("倒计时：%.2f", self._countDownTime)

	if self._countDownTime <= 0 then
		local tipsContent = "游戏结束，请退出后重新开始"

		local function okFunc()
			self:close()
		end

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定")

		self._direct = 0

		self._stateMachine:gotoState(STATE_GAME_END)

		return
	end

	self:_changePos()
	self:_checkCurPos()
	self:_checkGameFinish()
end

function MazeGameView:_onEnterGameEnd()
	local endPointNum = #self._point
	local passOrNotNum = 0

	if self._catchPointNum == endPointNum then
		passOrNotNum = 1
		self._direct = 0

		local rewardStr = MazeGameController.instance:getRewardTiTanStr(self._activityId, self._stageId)
		local tipsContent = string.format("恭喜你，成功收集泰坦残骸%s", rewardStr)

		local function okFunc()
			MazeGameController.instance:sendPM_MazeGameEndGameReq(self._activityId, self._stageId, passOrNotNum)
		end

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定")
	elseif self._countDownTime <= 0 then
		local tipsContent = "游戏结束，请退出后重新开始"

		local function okFunc()
			MazeGameController.instance:sendPM_MazeGameEndGameReq(self._activityId, self._stageId, passOrNotNum)
			self:close()
		end

		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定")

		self._direct = 0
	else
		MazeGameController.instance:sendPM_MazeGameEndGameReq(self._activityId, self._stageId, passOrNotNum)
	end
end

return MazeGameView
