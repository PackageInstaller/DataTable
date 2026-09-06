-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldPlayerMgr.lua

module("logic.extensions.uniqueworld.view.UniqueWorldPlayerMgr", package.seeall)

local UniqueWorldPlayerMgr = class("UniqueWorldPlayerMgr", ViewComponent)

function UniqueWorldPlayerMgr:ctor()
	self._gridId = 0
end

function UniqueWorldPlayerMgr:initParam(playerGo, gridId, gameview, tableview)
	self._playerGo = playerGo
	self._gridId = gridId
	self._siblingIdx = 0
	self._eventItemList = UniqueWorldMapMgr.instance:getEventItemList()
	self._mapLength = UniqueWorldMapMgr.instance:getMapLength()
	self._playerX = 0
	self._playerY = 0

	local width, height = UniqueWorldMapMgr.instance:getWidthNHeight()
	local mapScrollerRect = tableview:GetComponent(ComponentType.ScrollRect)
	local mapScrollerSize = {
		x = width,
		y = height
	}

	if self._uwPlayerMgr == nil then
		self._uwPlayerMgr = UWPlayerMgr.New()
	end

	self._uwPlayerMgr:onEnter(gameview, mapScrollerRect, mapScrollerSize, self._playerGo)
	self:_initUI()
end

function UniqueWorldPlayerMgr:_initUI()
	self._playerX = (self._gridId - 1) % self._mapLength + 1
	self._playerY = math.floor((self._gridId - 1) / self._mapLength) + 1

	local posX, posY = UniqueWorldMapMgr.instance:getMapPos(self._playerX, self._playerY)

	GameUtil.setLocalPos(self._playerGo, posX, posY, 0)
	self:checkNeedUpdateSiblingIdx(self._gridId, self._playerX, self._playerY)
end

function UniqueWorldPlayerMgr:_calcPos(xIndex, yIndex)
	local posX, posY = UniqueWorldMapMgr.instance:getMapPos(xIndex, yIndex)

	return posX, posY
end

function UniqueWorldPlayerMgr:setPlayerCurGridId(gridId)
	self._gridId = gridId
end

function UniqueWorldPlayerMgr:getPlayerCurGridId()
	return self._gridId
end

function UniqueWorldPlayerMgr:getPlayerCoord()
	return self._playerX, self._playerY
end

function UniqueWorldPlayerMgr:getPlayerGo()
	return self._playerGo
end

function UniqueWorldPlayerMgr:move(gridList, finishCallBack, diceValue)
	local gridPosList = {}

	self._gridCoordList = {}

	for i, gridId in ipairs(gridList) do
		local xIndex = (gridId - 1) % self._mapLength + 1
		local yIndex = math.floor((gridId - 1) / self._mapLength) + 1
		local posX, posY = self:_calcPos(xIndex, yIndex)
		local newPos = Vector3.New(posX, posY, 0)

		table.insert(gridPosList, newPos)
		table.insert(self._gridCoordList, {
			x = xIndex,
			y = yIndex
		})
	end

	local function stepStartHandle(stepIdx)
		local gridId = gridList[stepIdx]
		local coordPos = self._gridCoordList[stepIdx]

		self._playerX = coordPos.x
		self._playerY = coordPos.y

		self:checkNeedUpdateSiblingIdx(gridId, coordPos.x, coordPos.y)
	end

	self._uwPlayerMgr:playPathMove(self._playerGo, gridPosList, 0.3, nil, finishCallBack, stepStartHandle)
end

function UniqueWorldPlayerMgr:focusOnPlayer()
	self._uwPlayerMgr:focusOnPlayer(self._playerGo)
end

function UniqueWorldPlayerMgr:playDigMineAnim(param)
	self._uwPlayerMgr:playDigMineAnim(param)
end

function UniqueWorldPlayerMgr:clear()
	self._uwPlayerMgr:onExit()

	self._uwPlayerMgr = nil
end

function UniqueWorldPlayerMgr:destroy()
	goutil.destroy(self._playerGo)
end

function UniqueWorldPlayerMgr:hasNGetNewSibling(playerGridId, playerCoordX, playerCoordY)
	if self._eventItemList then
		local playerX = 0
		local playerY = 0

		if playerCoordX and playerCoordY then
			playerX = playerCoordX
			playerY = playerCoordY
		else
			playerX = (playerGridId - 1) % self._mapLength + 1
			playerY = math.floor((playerGridId - 1) / self._mapLength) + 1
		end

		local curSilblingIdx = 0

		for i, item in ipairs(self._eventItemList) do
			local gridX, gridY = item:getXYCoord()

			if gridX < playerX or playerX == gridX and gridY < playerY then
				curSilblingIdx = i
			end
		end

		return true, curSilblingIdx
	end

	return false, self._siblingIdx
end

function UniqueWorldPlayerMgr:checkNeedUpdateSiblingIdx(playerGridId, xIndex, yIndex)
	local hasNewSibling, siblingIdx = self:hasNGetNewSibling(playerGridId, xIndex, yIndex)

	if hasNewSibling then
		self._siblingIdx = siblingIdx

		GlobalDispatcher:dispatch(GlobalNotify.UniqueWorldPlayerSiblingIdxChange, siblingIdx)
	end
end

UniqueWorldPlayerMgr.instance = UniqueWorldPlayerMgr.New()

return UniqueWorldPlayerMgr
