-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/view/PinBallBrickMapMgr.lua

module("logic.extensions.pinball.view.PinBallBrickMapMgr", package.seeall)

local PinBallBrickMapMgr = class("PinBallBrickMapMgr")

function PinBallBrickMapMgr:ctor()
	self._healthMap = {}
	self._cellGoMap = {}
	self._propMap = {}
	self._addParamMap = {}
	self._mapGo = nil
	self._complateInstanceMap = {}
	self._brickPoolMap = {}
	self._brickItemMap = {}
	self._brickPosMap = {}
	self._brickLineMap = {}
	self._brickLineUIMap = {}
end

function PinBallBrickMapMgr:initParam(cfg, mapGo)
	self._mapGo = mapGo
	self._stageCfg = cfg
	self._mapWidth = cfg.mapWidth
	self._mapHeight = cfg.mapHeight
	self._brickWidth = cfg.brickWidth
	self._brickHeight = cfg.brickHeight
	self._mapInterval = cfg.mapInterval
	self._brickNum = 0

	local mapLocalPos = GameUtil.getLocalPos(mapGo)

	self._mapInitX = mapLocalPos.x
	self._mapInitY = mapLocalPos.y

	self:_getAddParamMap(cfg.addParam)
	self:_getPropMap(cfg.propParam)

	local healthMapList = cfg.mapHealthData

	for i = 1, self._mapWidth do
		self._healthMap[i] = {}
		self._brickItemMap[i] = {}

		for j = 1, self._mapHeight do
			local curIndex = (i - 1) * self._mapHeight + j

			self._healthMap[i][j] = healthMapList[curIndex]
		end
	end
end

function PinBallBrickMapMgr:setComplateInstance(brickTag, brickInstance)
	if not brickInstance then
		printError("无对象实例，请检查是否有正确设置模板实例。 brickTag: ", brickTag)
	else
		GameUtil.SetActive(brickInstance, true)

		self._complateInstanceMap[brickTag] = brickInstance

		GameUtil.SetActive(brickInstance, false)
	end
end

function PinBallBrickMapMgr:createMap()
	local mapTypeList = self._stageCfg.mapTypeData

	for i = 1, self._mapWidth do
		for j = 1, self._mapHeight do
			local index = (i - 1) * self._mapHeight + j
			local health = self._healthMap[i][j]
			local mapType = mapTypeList[index]
			local propData = self._propMap[index]
			local addParam = self._addParamMap[index]
			local propType = PinBallEnum.PropType.None
			local propExtParam

			if propData then
				propType = propData.propType
				propExtParam = propData.param
			end

			local item = self:createBrick(mapType, addParam)
			local posX = (i - 1) * (self._brickWidth + self._mapInterval)
			local posY = (j - 1) * (self._brickHeight + self._mapInterval)

			item:initParam(j, health, posX, posY, mapType, propType, propExtParam)
			item:updateUI()

			self._brickItemMap[i][j] = item
			self._brickPosMap[item] = {
				x = i,
				y = j
			}
			self._healthMap[i][j] = health
		end
	end

	self:setLineUIList()
end

function PinBallBrickMapMgr:clear()
	for i = 1, self._mapWidth do
		for j = 1, self._mapHeight do
			local item = self._brickItemMap[i][j]

			if item then
				self._brickPoolMap[item._brickType]:returnObject(item)
			end
		end
	end

	for k, pool in pairs(self._brickPoolMap) do
		pool:clear()
	end

	self._mapGo = nil
	self._healthMap = {}
	self._cellGoMap = {}
	self._propMap = {}
	self._addParamMap = {}
	self._mapGo = nil
	self._complateInstanceMap = {}
	self._brickPoolMap = {}
	self._brickItemMap = {}
	self._brickPosMap = {}
	self._brickLineMap = {}
	self._brickLineUIMap = {}
end

function PinBallBrickMapMgr:createBrick(type, param)
	if not self._brickPoolMap[type] then
		local createFunc = self:_getBrickCreatFunc(type)

		local function disposeFunc(item)
			item:destroy()
		end

		local function resetFunc(item)
			item:reset()
		end

		if self._brickPoolMap[type] == nil then
			self._brickPoolMap[type] = ObjectPool.New(100, createFunc, disposeFunc, resetFunc)
		end
	end

	local obj = self._brickPoolMap[type]:fetchObject()

	if obj.initExtParam then
		local key = "init"

		if param then
			local params = string.split(param, "#")

			key = params and params[1] or "init"
		end

		obj:initExtParam(param)

		if type == PinBallEnum.BrickType.Line then
			if self._brickLineMap[key] == nil then
				self._brickNum = self._brickNum + 1
			end

			self._brickLineMap[key] = self._brickLineMap[key] or {}

			table.insert(self._brickLineMap[key], obj)
		end
	end

	return obj
end

function PinBallBrickMapMgr:_getBrickCreatFunc(type)
	local createFunc
	local brickInstance = self._complateInstanceMap[type]

	if brickInstance then
		function createFunc()
			local item

			if type == PinBallEnum.BrickType.Default then
				local go = goutil.cloneAndSetParent(brickInstance, self._mapGo.transform)

				GameUtil.setWidth(go, self._brickWidth)
				GameUtil.setHeight(go, self._brickHeight)

				item = PinBallBrickBase.New(go)
				self._brickNum = self._brickNum + 1
			elseif type == PinBallEnum.BrickType.Line then
				local go = goutil.cloneAndSetParent(brickInstance, self._mapGo.transform)

				GameUtil.setWidth(go, self._brickWidth)
				GameUtil.setHeight(go, self._brickHeight)

				item = PinBallBrickLine.New(go)
			elseif type == PinBallEnum.BrickType.Wall then
				local go = goutil.cloneAndSetParent(brickInstance, self._mapGo.transform)

				item = PinBallBrickWall.New(go)
			else
				printError("创建了未知类型的砖块，未设置, brickType: ", type)
			end

			return item
		end
	else
		printError("没用该类型的砖块实例， brickType: ", type)
	end

	return createFunc
end

function PinBallBrickMapMgr:_getAddParamMap(addParam)
	if addParam then
		for i, addDataStr in ipairs(addParam) do
			local addArr = string.split(addDataStr, "#")
			local brickId = checknumber(addArr[1])

			self._addParamMap[brickId] = addArr[2]
		end
	end
end

function PinBallBrickMapMgr:_getPropMap(propParam)
	if propParam then
		for i, propDataStr in ipairs(propParam) do
			local propData = {}
			local propArr = string.split(propDataStr, "#")
			local brickId = checknumber(propArr[1])
			local propType = checknumber(propArr[2])
			local param = propArr[3]

			propData.propType = propType
			propData.param = param
			self._propMap[brickId] = propData

			if propType == PinBallEnum.PropType.GetPrize then
				local paramArr = string.split(param, "_")
				local prizeId = checknumber(paramArr[1])
				local num = checknumber(paramArr[2])

				PinBallPropMgr.instance:addCollectPrizeMap(prizeId, num)
			end
		end
	end
end

function PinBallBrickMapMgr:clearAllLineBrickByKey(brickKey)
	local brickLineList = self._brickLineMap[brickKey]
	local lineUIItem = self._brickLineUIMap[brickKey]

	lineUIItem:reduceHealth()

	if brickLineList then
		for _, item in ipairs(brickLineList) do
			local pos = self._brickPosMap[item]

			item:reduceAllHealth()
			item:updateUI()

			self._healthMap[pos.x][pos.y] = 0
		end
	end
end

function PinBallBrickMapMgr:getBrickNum()
	return self._brickNum
end

function PinBallBrickMapMgr:releaseBrickNum()
	self._brickNum = self._brickNum - 1
end

function PinBallBrickMapMgr:_updateBrickNum()
	local brickNum = 0

	for i = 1, self._mapWidth do
		for j = 1, self._mapHeight do
			local item = self._brickItemMap[i][j]

			if item and item:getHealth() > 0 and item:getBrickType() ~= PinBallEnum.BrickType.Wall then
				brickNum = brickNum + 1
			end
		end
	end

	self._brickNum = brickNum
end

function PinBallBrickMapMgr:getBrickId(x, y)
	return (x - 1) * self._mapHeight + y
end

function PinBallBrickMapMgr:getReflectDirect(ballData, direct)
	local ballPosX = ballData.posX - self._mapInitX
	local ballPosY = ballData.posY - self._mapInitY

	self._ballRadiusSquare = ballData.radius * ballData.radius

	local curCoordX = math.ceil(ballPosX / (self._brickWidth + self._mapInterval))
	local curCoordY = math.ceil(ballPosY / (self._brickHeight + self._mapInterval))

	self._rushDirect = nil
	self._curReboundDistance = math.huge
	self._reflectCoordX = 0
	self._reflectCoordY = 0

	if curCoordX < -1 or curCoordX > self._mapWidth + 1 or curCoordY < -1 or curCoordY > self._mapHeight + 1 then
		return self._rushDirect
	end

	if direct.x < 0 then
		local upCoordY = curCoordY + 1

		if upCoordY >= 1 and upCoordY <= self._mapHeight then
			self:_calcDirect(curCoordX, upCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.Up)
		end

		local leftCoordX = curCoordX - 1

		if leftCoordX >= 1 and leftCoordX <= self._mapWidth and upCoordY >= 1 and upCoordY <= self._mapHeight then
			self:_calcDirect(leftCoordX, upCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.UpLeft)
		end

		if leftCoordX >= 1 and leftCoordX <= self._mapWidth then
			self:_calcDirect(leftCoordX, curCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.Left)
		end

		local downCoordY = curCoordY - 1

		if downCoordY >= 1 and downCoordY <= self._mapHeight and leftCoordX >= 1 and leftCoordX <= self._mapWidth then
			self:_calcDirect(leftCoordX, downCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.DownLeft)
		end

		if downCoordY >= 1 and downCoordY <= self._mapHeight then
			self:_calcDirect(curCoordX, downCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.Down)
		end
	else
		local upCoordY = curCoordY + 1

		if upCoordY >= 0 and upCoordY <= self._mapHeight then
			self:_calcDirect(curCoordX, upCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.Up)
		end

		local rightCoordX = curCoordX + 1

		if rightCoordX >= 1 and rightCoordX <= self._mapWidth and upCoordY >= 1 and upCoordY <= self._mapHeight then
			self:_calcDirect(rightCoordX, upCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.UpRight)
		end

		if rightCoordX >= 1 and rightCoordX <= self._mapWidth then
			self:_calcDirect(rightCoordX, curCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.Right)
		end

		local downCoordY = curCoordY - 1

		if downCoordY >= 1 and downCoordY <= self._mapHeight and rightCoordX >= 1 and rightCoordX <= self._mapWidth then
			self:_calcDirect(rightCoordX, downCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.DownRight)
		end

		if downCoordY >= 1 and downCoordY <= self._mapHeight then
			self:_calcDirect(curCoordX, downCoordY, ballPosX, ballPosY, direct, PinBallEnum.BrickSide.Down)
		end
	end

	if self._rushDirect then
		local item = self._brickItemMap[self._reflectCoordX][self._reflectCoordY]
		local brickType = item:getBrickType()

		if brickType ~= PinBallEnum.BrickType.Wall then
			self._healthMap[self._reflectCoordX][self._reflectCoordY] = self._healthMap[self._reflectCoordX][self._reflectCoordY] - 1
		end

		item:reduceHealth()
		item:updateUI()
		self:_updateBrickNum()
	end

	return self._rushDirect
end

function PinBallBrickMapMgr:_getBrickSidePos(ballPosX, ballPosY, x, y, wallSide)
	local posX = 0
	local posY = 0

	if wallSide == PinBallEnum.BrickSide.Right then
		posX = (x - 1) * (self._brickWidth + self._mapInterval)
		posY = ballPosY
	elseif wallSide == PinBallEnum.BrickSide.Left then
		posX = x * (self._brickWidth + self._mapInterval)
		posY = ballPosY
	elseif wallSide == PinBallEnum.BrickSide.Up then
		posX = ballPosX
		posY = (y - 1) * (self._brickHeight + self._mapInterval)
	elseif wallSide == PinBallEnum.BrickSide.Down then
		posX = ballPosX
		posY = y * (self._brickHeight + self._mapInterval)
	elseif wallSide == PinBallEnum.BrickSide.DownLeft then
		posX = x * (self._brickWidth + self._mapInterval)
		posY = y * (self._brickHeight + self._mapInterval)
	elseif wallSide == PinBallEnum.BrickSide.DownRight then
		posX = (x - 1) * (self._brickWidth + self._mapInterval)
		posY = y * (self._brickHeight + self._mapInterval)
	elseif wallSide == PinBallEnum.BrickSide.UpLeft then
		posX = x * (self._brickWidth + self._mapInterval)
		posY = (y - 1) * (self._brickHeight + self._mapInterval)
	elseif wallSide == PinBallEnum.BrickSide.UpRight then
		posX = (x - 1) * (self._brickWidth + self._mapInterval)
		posY = (y - 1) * (self._brickHeight + self._mapInterval)
	end

	return posX, posY
end

function PinBallBrickMapMgr:_getReboundDirect(brickSidePosX, brickSidePosY, ballPosX, ballPosY, direct)
	local normallize = Vector2.New(ballPosX - brickSidePosX, ballPosY - brickSidePosY)

	normallize = normallize:Normalize()

	local dot = normallize.x * direct.x + normallize.y * direct.y
	local reboundDirect = direct - 2 * dot * normallize

	reboundDirect = reboundDirect:Normalize()

	return reboundDirect
end

function PinBallBrickMapMgr:_calcDirect(coordX, coordY, ballPosX, ballPosY, direct, BrickSide)
	if self._healthMap[coordX] then
		if checknumber(self._healthMap[coordX]) > 0 then
			local posX, posY = self:_getBrickSidePos(ballPosX, ballPosY, coordX, coordY, BrickSide)
			local distance = (posX - ballPosX) * (posX - ballPosX) + (posY - ballPosY) * (posY - ballPosY)
			local rebound = distance <= checknumber(self._ballRadiusSquare)
			local isMinDistance = distance < self._curReboundDistance

			if rebound and isMinDistance then
				self._curReboundDistance = distance
				self._rushDirect = self:_getReboundDirect(posX, posY, ballPosX, ballPosY, direct)
				self._reflectCoordX = coordX
				self._reflectCoordY = coordY
			end
		end
	end
end

function PinBallBrickMapMgr:setLineUIList()
	local leftX = 0
	local rightX = 0
	local upY = 0
	local downY = 0
	local maxHealth = 0
	local lineKey = "init"

	for key, list in pairs(self._brickLineMap) do
		leftX = -1
		rightX = -1
		upY = -1
		downY = -1
		lineKey = "init"

		for i, item in ipairs(list) do
			local health = item:getHealth()
			local posX, posY = item:getPos()

			if maxHealth < health then
				maxHealth = health
			end

			if leftX < 0 then
				leftX = posX
			end

			if rightX < 0 then
				rightX = posX
			end

			if upY < 0 then
				upY = posY
			end

			if downY < 0 then
				downY = posY
			end

			leftX = math.min(leftX, posX)
			rightX = math.max(rightX, posX)
			upY = math.max(upY, posY)
			downY = math.min(downY, posY)
			lineKey = item:getBrickKey()
		end

		if rightX - leftX > 0 then
			if not (rightX - leftX + self._brickWidth) then
				local uiTotalWidth = self._brickWidth

				if upY - downY > 0 then
					if not (upY - downY + self._brickHeight) then
						local uiTotalHeight = self._brickHeight
						local paramTable = {
							health = 1,
							key = lineKey,
							posX = leftX + uiTotalWidth / 2,
							posY = downY + uiTotalHeight / 2,
							width = uiTotalWidth + 10,
							height = uiTotalHeight + 10
						}

						self._brickLineUIMap[lineKey] = PinBallBrickUIMgr.instance:createBrickUI(PinBallEnum.BrickType.Line, paramTable)
					end
				end
			end
		end
	end
end

PinBallBrickMapMgr.instance = PinBallBrickMapMgr.New()

return PinBallBrickMapMgr
