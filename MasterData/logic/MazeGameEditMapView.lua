-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mazegame/view/MazeGameEditMapView.lua

module("logic.extensions.mazegame.view.MazeGameEditMapView", package.seeall)

local MazeGameEditMapView = class("MazeGameEditMapView", ViewComponent)
local RIGHT = 1
local UP = 2
local LEFT = 3
local DOWN = 4

function MazeGameEditMapView:ctor()
	MazeGameEditMapView.super.ctor(self)
end

function MazeGameEditMapView:unbindEvents()
	MazeGameEditMapView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnFun2)
	GameUtil.rmClickHandler(self._btn)
	GameUtil.rmClickHandler(self._btnCopy)
	GameUtil.rmClickHandler(self._btnCopyEndPoint)
	GameUtil.rmClickHandler(self._btnCopyPlayer)
	GameUtil.rmClickHandler(self._btnCreateRoom)
	GameUtil.rmClickHandler(self._btnNext)
	self._inputFieldDestNum:RemoveOnValueChanged()
	self._inputFieldCellSize:RemoveOnValueChanged()
	self._inputFieldWidth:RemoveOnValueChanged()
	self._inputFieldHeight:RemoveOnValueChanged()
end

function MazeGameEditMapView:bindEvents()
	MazeGameEditMapView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnFun2, self._onClickBtnFunc2, self)
	GameUtil.addClickHandler(self._btn, self._onClickBtn, self)
	GameUtil.addClickHandler(self._btnCopy, self._onClickBtnCopy, self)
	GameUtil.addClickHandler(self._btnCopyEndPoint, self._onClickBtnCopyEndPoint, self)
	GameUtil.addClickHandler(self._btnCopyPlayer, self._onClickBtnCopyPlayer, self)
	GameUtil.addClickHandler(self._btnCreateRoom, self._createDungeonMap, self)
	GameUtil.addClickHandler(self._btnNext, self._digNext, self)
	self._inputFieldDestNum:AddOnValueChanged(self._onValueChangedDestNum, self)
	self._inputFieldCellSize:AddOnValueChanged(self._onValueChangedCellSize, self)
	self._inputFieldWidth:AddOnValueChanged(self._onValueChangedWidth, self)
	self._inputFieldHeight:AddOnValueChanged(self._onValueChangedHeight, self)
end

function MazeGameEditMapView:buildUI()
	MazeGameEditMapView.super.buildUI(self)

	self._cell = self:getGo("cell")
	self._imgPoint = self:getGo("imgPoint")
	self._container = self:getGo("container")
	self._btn = self:getGo("btn")
	self._btnCopy = self:getGo("btnCopy")
	self._btnCopyEndPoint = self:getGo("btnCopyEndPoint")
	self._btnCopyPlayer = self:getGo("btnCopyPlayer")
	self._inputFieldDestNum = self:getInput("destNum/inputFieldDestNum")
	self._inputFieldCellSize = self:getInput("cellSize/inputFieldCellSize")
	self._inputFieldWidth = self:getInput("width/inputFieldWidth")
	self._inputFieldHeight = self:getInput("height/inputFieldHeight")
	self._btnFun2 = self:getGo("btnFunc2")
	self._cellDungeon = self:getGo("cellDungeon")
	self._btnCreateRoom = self:getGo("btnCreateRoom")
	self._btnNext = self:getGo("btnNext")
end

function MazeGameEditMapView:onExit()
	MazeGameEditMapView.super.onExit(self)
	removetimer(self._tick, self)

	if self._joystickCtrl then
		self._joystickCtrl:StopJoystickMove()
	end
end

function MazeGameEditMapView:onEnter()
	MazeGameEditMapView.super.onEnter(self)

	self._width = 40
	self._height = 40
	self._cellSize = 15
	self._roomWidthList = {
		2,
		6
	}
	self._roomHeightList = {
		2,
		6
	}
	self._maxWidth = 10
	self._maxHeight = 10
	self._density = 0.5

	self:_createDungeonMap()
end

function MazeGameEditMapView:_createDungeonMap()
	self._cellGoMap = {}
	self._map = {}
	self._roomMap = {}
	self._roomList = {}
	self._openMap = {}
	self._RoomUFSet = {}
	self._doorList = {}

	for i = 1, self._width do
		self._map[i] = {}
		self._roomMap[i] = {}
		self._cellGoMap[i] = {}
		self._openMap[i] = {}

		for j = 1, self._height do
			local idx = (i - 1) * self._height + j

			self._map[i][j] = 0
			self._roomMap[i][j] = 0
			self._openMap[i][j] = false
			self._RoomUFSet[idx] = idx

			local cellGo = goutil.cloneAndSetParent(self._cellDungeon, self._container.transform, "cell_" .. i .. "_" .. j)

			GameUtil.setAnchoredPos(cellGo, i * self._cellSize, j * self._cellSize)

			self._cellGoMap[i][j] = cellGo
		end
	end

	for i = 1, 10 do
		self:_digNext()
	end

	self:_fillRemainPath()
end

function MazeGameEditMapView:_fillRemainPath()
	local i = math.random(1, self._width)
	local j = math.random(1, self._height)

	self._list = {}

	local tem = self:_createData(i, j)

	self:buildTreeDungeon(tem)

	for i, v in ipairs(self._doorList) do
		local doorX, doorY, doorSide = unpack(v)
		local cell = self._cellGoMap[doorX][doorY]

		if doorSide == LEFT then
			local line = goutil.findChild(cell, "line_1")

			goutil.setActive(line, false)

			self._map[doorX][doorY] = self._map[doorX][doorY] + 1
		else
			local line = goutil.findChild(cell, "line_2")

			goutil.setActive(line, false)

			self._map[doorX][doorY] = self._map[doorX][doorY] + 2
		end
	end
end

function MazeGameEditMapView:buildTreeDungeon(obj)
	self._openMap[obj.i][obj.j] = true

	table.insert(self._list, obj)

	for i, v in ipairs(obj.dirArr) do
		local newX = obj.i + v[1]
		local newY = obj.j + v[2]

		if newX >= 1 and newX <= self._width and newY >= 1 and newY <= self._height and self._openMap[newX][newY] == false then
			if v[1] == 1 then
				local cell = self._cellGoMap[obj.i][obj.j]
				local line = goutil.findChild(cell, "line_1")

				goutil.setActive(line, false)

				self._map[obj.i][obj.j] = self._map[obj.i][obj.j] + 1
			end

			if v[1] == -1 then
				local cell = self._cellGoMap[newX][newY]
				local line = goutil.findChild(cell, "line_1")

				goutil.setActive(line, false)

				self._map[newX][newY] = self._map[newX][newY] + 1
			end

			if v[2] == 1 then
				local cell = self._cellGoMap[obj.i][obj.j]
				local line = goutil.findChild(cell, "line_2")

				goutil.setActive(line, false)

				self._map[obj.i][obj.j] = self._map[obj.i][obj.j] + 2
			end

			if v[2] == -1 then
				local cell = self._cellGoMap[newX][newY]
				local line = goutil.findChild(cell, "line_2")

				goutil.setActive(line, false)

				self._map[newX][newY] = self._map[newX][newY] + 2
			end

			local tem = self:_createData(newX, newY)

			self:buildTreeDungeon(tem)
		end
	end
end

function MazeGameEditMapView:_digNext()
	local randomRoomIdxX = math.random(1, self._width - 1)
	local randomRoomIdxY = math.random(1, self._height - 1)
	local width = math.random(2, 10)
	local height = math.random(2, 10)
	local randomFlag = false

	for i = randomRoomIdxX, randomRoomIdxX + width do
		for j = randomRoomIdxY, randomRoomIdxY + height do
			if randomRoomIdxX + width > self._width or randomRoomIdxY + height > self._height or self._roomMap[i][j] == 1 then
				randomFlag = true

				break
			end
		end
	end

	while randomFlag do
		randomFlag = false
		randomRoomIdxX = math.random(1, self._width - 1)
		randomRoomIdxY = math.random(1, self._height - 1)

		for i = randomRoomIdxX, randomRoomIdxX + width do
			for j = randomRoomIdxY, randomRoomIdxY + height do
				if randomRoomIdxX + width > self._width or randomRoomIdxY + height > self._height or self._roomMap[i][j] == 1 then
					randomFlag = true

					break
				end
			end
		end
	end

	for i = randomRoomIdxX, randomRoomIdxX + width do
		for j = randomRoomIdxY, randomRoomIdxY + height do
			self._map[i][j] = 3

			if i == randomRoomIdxX + width then
				self._map[i][j] = 2
			end

			if j == randomRoomIdxY + height then
				self._map[i][j] = 1
			end

			if j == randomRoomIdxY + height and i == randomRoomIdxX + width then
				self._map[i][j] = 0
			end

			self._roomMap[i][j] = 1
			self._openMap[i][j] = true

			local changeComp = self._cellGoMap[i][j]:GetComponent(ComponentType.UIImageColorChange)
			local line_1 = goutil.findChild(self._cellGoMap[i][j], "line_1")
			local line_2 = goutil.findChild(self._cellGoMap[i][j], "line_2")

			changeComp:SetState(self._roomMap[i][j])

			if self._map[i][j] == 0 then
				GameUtil.SetActive(line_1, true)
				GameUtil.SetActive(line_2, true)
			elseif self._map[i][j] == 1 then
				GameUtil.SetActive(line_1, false)
				GameUtil.SetActive(line_2, true)
			elseif self._map[i][j] == 2 then
				GameUtil.SetActive(line_1, true)
				GameUtil.SetActive(line_2, false)
			else
				GameUtil.SetActive(line_1, false)
				GameUtil.SetActive(line_2, false)
			end
		end
	end

	local doorX, doorY, doorSide = self:_getDoorPos(randomRoomIdxX, randomRoomIdxY, width, height)

	if doorSide == RIGHT or doorSide == UP then
		self._map[doorX][doorY] = 3
	elseif doorSide == LEFT then
		table.insert(self._doorList, {
			doorX - 1,
			doorY,
			doorSide
		})
	else
		table.insert(self._doorList, {
			doorX,
			doorY - 1,
			doorSide
		})
	end
end

function MazeGameEditMapView:_getDoorPos(randomRoomIdxX, randomRoomIdxY, width, height)
	local doorSide = math.random(1, 4)
	local doorX = randomRoomIdxX
	local doorY = randomRoomIdxY

	if doorSide == RIGHT and randomRoomIdxX + width == self._width then
		doorSide = LEFT
	end

	if doorSide == LEFT and randomRoomIdxX == 1 then
		doorSide = RIGHT
	end

	if doorSide == UP and randomRoomIdxY + height == self._height then
		doorSide = DOWN
	end

	if doorSide == DOWN and randomRoomIdxY == 1 then
		doorSide = UP
	end

	if doorSide == RIGHT then
		doorY = math.random(randomRoomIdxY, randomRoomIdxY + height)
		doorX = randomRoomIdxX + width
	elseif doorSide == UP then
		doorX = math.random(randomRoomIdxX, randomRoomIdxX + width)
		doorY = randomRoomIdxY + height
	elseif doorSide == LEFT then
		doorY = math.random(randomRoomIdxY, randomRoomIdxY + height)
	elseif doorSide == DOWN then
		doorX = math.random(randomRoomIdxX, randomRoomIdxX + width)
	end

	return doorX, doorY, doorSide
end

function MazeGameEditMapView:_createRoomData(x, y, width, height)
	local room = {}

	room.width = width
	room.height = height
	room.left = x - math.ceil(width / 2)
	room.bottom = y + math.ceil(height / 2)

	table.insert(self._roomList, room)

	return room
end

function MazeGameEditMapView:_isInRoom(x, y, width, height)
	for _, room in ipairs(self._roomList) do
		if x >= room.left and x <= room.left + room.width and y >= room.bottom and y <= room.bottom + room.height then
			return true
		end
	end

	return false
end

function MazeGameEditMapView:UFSetRootRoom(num)
	while num ~= self._RoomUFSet[num] do
		num = self._RoomUFSet[num]
	end

	return num
end

function MazeGameEditMapView:UFSetUnionRoom(a, b)
	if self:UFSetRootRoom(a) == self:UFSetRootRoom(b) then
		return false
	else
		self._RoomUFSet[self:UFSetRootRoom(b)] = self:UFSetRootRoom(a)

		return true
	end
end

function MazeGameEditMapView:_onClickBtn()
	if self._width == 0 or self._height == 0 or self._cellSize == 0 then
		FloatWordMgr.instance:show("无效地图数据")

		return
	end

	self:_createMap()
	self:_tryCreateMazeMap()
	self:_createPlayer()
	self:_createPoint()
	GameUtil.setLocalScale(self._container, self._cellSize / 30, self._cellSize / 30, self._cellSize / 30)
end

function MazeGameEditMapView:_onClickBtnCopy()
	self._dataStr = "["

	for i = 1, self._width do
		for j = 1, self._height do
			self._dataStr = i == self._width and j == self._height and self._dataStr .. self._map[i][j] or self._dataStr .. self._map[i][j] .. ","
		end
	end

	self._dataStr = self._dataStr .. "]"

	printError(self._dataStr)
	Game.TextUtil.CopyToClipBoard(self._dataStr)
end

function MazeGameEditMapView:_onClickBtnCopyEndPoint()
	printError(self._pointStr)
	Game.TextUtil.CopyToClipBoard(self._pointStr)
end

function MazeGameEditMapView:_onClickBtnCopyPlayer()
	local playerStr = self._playerPos[1] .. "_" .. self._playerPos[2]

	printError(playerStr)
	Game.TextUtil.CopyToClipBoard(playerStr)
end

function MazeGameEditMapView:_tryCreateMazeMap()
	local i = math.random(1, self._width)
	local j = math.random(1, self._height)

	self._list = {}

	local tem = self:_createData(i, j)

	self:buildTree(tem)
end

function MazeGameEditMapView:_createPlayer()
	local randomSide = math.random(1, 4)

	self._playerSide = randomSide

	local point = goutil.cloneAndSetParent(self._imgPoint, self._container.transform, "player")
	local changeColorComp = point:GetComponent(ComponentType.UIImageColorChange)

	changeColorComp:SetState(0)

	if randomSide == RIGHT then
		local y = math.random(1, self._height)

		self._playerPos = {
			self._width,
			y
		}

		local cellGo = self._cellMap[self._width][y]
		local line = goutil.findChild(cellGo, "line_1")

		GameUtil.SetActive(line, false)
		GameUtil.setAnchoredPos(point, self._width * 30, y * 30)
	elseif randomSide == UP then
		local x = math.random(1, self._width)

		self._playerPos = {
			x,
			self._height
		}

		local cellGo = self._cellMap[x][self._height]
		local line = goutil.findChild(cellGo, "line_2")

		GameUtil.SetActive(line, false)
		GameUtil.setAnchoredPos(point, x * 30, self._height * 30)
	elseif randomSide == LEFT then
		local y = math.random(1, self._height)

		self._playerPos = {
			1,
			y
		}

		local cellGo = self._cellMap[1][y]
		local line = goutil.findChild(cellGo, "line_3")

		GameUtil.SetActive(line, false)
		GameUtil.setAnchoredPos(point, 30, y * 30)
	elseif randomSide == DOWN then
		local x = math.random(1, self._width)

		self._playerPos = {
			x,
			1
		}

		local cellGo = self._cellMap[x][1]
		local line = goutil.findChild(cellGo, "line_4")

		GameUtil.SetActive(line, false)
		GameUtil.setAnchoredPos(point, x * 30, 30)
	end
end

function MazeGameEditMapView:_createPoint()
	self._directList = {
		RIGHT,
		UP,
		LEFT,
		DOWN
	}

	table.remove(self._directList, self._playerSide)

	self._pointStr = ""

	for num = 1, self._destNum do
		local sideIdx = num % 3 + 1
		local side = self._directList[sideIdx]
		local i = 0
		local j = 0

		if side == RIGHT then
			i = self._width
			j = math.random(1, self._height)
		elseif side == UP then
			i = math.random(1, self._width)
			j = self._height
		elseif side == LEFT then
			i = 1
			j = math.random(1, self._height)
		elseif side == DOWN then
			i = math.random(1, self._width)
			j = 1
		end

		local colorType = math.random(0, 6)
		local point = goutil.cloneAndSetParent(self._imgPoint, self._container.transform, "point_" .. i .. "_" .. j .. "_" .. colorType)
		local changeColorComp = point:GetComponent(ComponentType.UIImageColorChange)
		local str = i .. "_" .. j

		changeColorComp:SetState(colorType)
		GameUtil.setAnchoredPos(point, i * 30, j * 30)

		self._pointStr = num == self._destNum and self._pointStr .. str or self._pointStr .. str .. "#"
	end
end

function MazeGameEditMapView:_createData(i, j)
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

function MazeGameEditMapView:buildTree(obj)
	self._openMap[obj.i][obj.j] = true

	table.insert(self._list, obj)

	for i, v in ipairs(obj.dirArr) do
		local newX = obj.i + v[1]
		local newY = obj.j + v[2]

		if newX >= 1 and newX <= self._width and newY >= 1 and newY <= self._height and self._openMap[newX][newY] == false then
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

function MazeGameEditMapView:_createMap()
	goutil.clearChildren(self._container)

	self._map = {}
	self._cellMap = {}
	self._openMap = {}

	for i = 1, self._width do
		self._cellMap[i] = {}
		self._map[i] = {}
		self._openMap[i] = {}

		for j = 1, self._height do
			self._openMap[i][j] = false
			self._map[i][j] = 0

			local cell = goutil.cloneAndSetParent(self._cell, self._container.transform, "cell_" .. i .. "_" .. j)

			GameUtil.setAnchoredPos(cell, i * 30, j * 30)
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

function MazeGameEditMapView:_onValueChangedDestNum(numStr)
	self._destNum = checkint(numStr)
end

function MazeGameEditMapView:_onValueChangedCellSize(numStr)
	self._cellSize = checkint(numStr)
end

function MazeGameEditMapView:_onValueChangedWidth(numStr)
	self._width = checkint(numStr)
end

function MazeGameEditMapView:_onValueChangedHeight(numStr)
	self._height = checkint(numStr)
end

function MazeGameEditMapView:_initMapByKruskal()
	self._UFSet = {}

	for i = 0, self._width * self._height - 1 do
		self._UFSet[i] = i
	end

	self._map = {}
	self._cellGo = {}
	self._edgeList = {}

	for i = 1, self._width do
		self._map[i] = self._map[i] or {}
		self._cellGo[i] = self._cellGo[i] or {}

		for j = 1, self._height do
			local name = string.format("cell_%d_%d", i, j)
			local cellGo = goutil.cloneAndSetParent(self._cell, self._container.transform, name)

			self._map[i][j] = 0
			self._cellGo[i][j] = cellGo

			GameUtil.setAnchoredPos(cellGo, i * self._cellSize, j * self._cellSize)

			if i == 1 then
				local line3 = goutil.findChild(cellGo, "line_3")

				GameUtil.SetActive(line3, true)
				self:createEdge(i, j, i + 1, j)

				if j ~= self._height then
					self:createEdge(i, j, i, j + 1)
				end

				if j == 1 then
					local line4 = goutil.findChild(cellGo, "line_4")

					GameUtil.SetActive(line4, true)
				end
			elseif j == 1 then
				local line4 = goutil.findChild(cellGo, "line_4")

				GameUtil.SetActive(line4, true)
				self:createEdge(i, j, i, j + 1)

				if i ~= self._width then
					self:createEdge(i, j, i + 1, j)
				end
			elseif i == self._width then
				local line1 = goutil.findChild(cellGo, "line_1")

				GameUtil.SetActive(line1, true)

				if j ~= self._height then
					self:createEdge(i, j, i, j + 1)
				end
			elseif j == self._height then
				local line2 = goutil.findChild(cellGo, "line_2")

				GameUtil.SetActive(line2, true)

				if i ~= self._width then
					self:createEdge(i, j, i + 1, j)
				end
			else
				self:createEdge(i, j, i + 1, j)
				self:createEdge(i, j, i, j + 1)
			end
		end
	end
end

function MazeGameEditMapView:_tryCreateMapByKruskal()
	MathUtil.randArray(self._edgeList)

	for _, edge in ipairs(self._edgeList) do
		local x1 = edge.x1
		local y1 = edge.y1
		local x2 = edge.x2
		local y2 = edge.y2
		local randomNum = math.random(1, 2)

		if self:UFSetUnion((x1 - 1) * self._height + (y1 - 1), (x2 - 1) * self._height + (y2 - 1)) then
			if math.abs(x1 - x2) == 1 then
				local line1 = goutil.findChild(self._cellGo[x1][y1], "line_1")

				GameUtil.SetActive(line1, false)

				self._map[x1][y1] = self._map[x1][y1] + 1
			else
				local line2 = goutil.findChild(self._cellGo[x1][y1], "line_2")

				GameUtil.SetActive(line2, false)

				self._map[x1][y1] = self._map[x1][y1] + 2
			end
		end
	end

	TableUtil.printTable(self._map)
end

function MazeGameEditMapView:createEdge(x1, y1, x2, y2)
	local edge = {}

	edge.x1 = x1
	edge.y1 = y1
	edge.x2 = x2
	edge.y2 = y2

	table.insert(self._edgeList, edge)
end

function MazeGameEditMapView:UFSetRoot(num)
	while num ~= self._UFSet[num] do
		num = self._UFSet[num]
	end

	return num
end

function MazeGameEditMapView:UFSetUnion(a, b)
	if self:UFSetRoot(a) == self:UFSetRoot(b) then
		return false
	else
		self._UFSet[self:UFSetRoot(b)] = self:UFSetRoot(a)

		return true
	end
end

function MazeGameEditMapView:_onClickBtnFunc2()
	goutil.clearChildren(self._container)
	self:_initMapByKruskal()
	self:_tryCreateMapByKruskal()
end

return MazeGameEditMapView
