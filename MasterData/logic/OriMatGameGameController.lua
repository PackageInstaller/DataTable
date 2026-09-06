-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/controller/OriMatGameGameController.lua

module("logic.extensions.orimatgame.controller.OriMatGameGameController", package.seeall)

local OriMatGameGameController = class("OriMatGameGameController", BaseController)

function OriMatGameGameController:onInit()
	self:onReset()
end

function OriMatGameGameController:onReset()
	self._unitNum = 0
	self._curUnitMapsByType = {}
	self._finalTargetId = 0
	self._selectedWeaponIds = {}
	self._activeTalents = {}
	self._exBuffIdsTalent = {}
	self._exBuffIdsBlessing = {}
	self._gameSpeedRate = 1
end

function OriMatGameGameController:initQuadtree(width, height)
	self._mapCellWidth = 100
	self._mapWidth = width
	self._mapHeight = height
	self._bigbullets = {}
	self._collisionQuadtree = SimpleQuadTree.New(-width / 2, -height / 2, width, height, 4)
	self._collisionFoundList = {}
	self._attackQuadtree = SimpleQuadTree.New(-width / 2, -height / 2, width, height, 4)
	self._attackFoundList = {}
	self._internalFinder = LuaAStarPathfinder.New()
end

function OriMatGameGameController:setMapCellWidth(width)
	self._mapCellWidth = width
end

function OriMatGameGameController:updateMapCellParams()
	self._halfMapCellWidth = self._mapCellWidth / 2
	self._startPosX = -self._gridColNum * 0.5 * self._mapCellWidth + self._halfMapCellWidth
	self._startPosY = -self._gridRowNum * 0.5 * self._mapCellWidth + self._halfMapCellWidth
end

function OriMatGameGameController:getMapCellWidth()
	return self._mapCellWidth
end

function OriMatGameGameController:pos2RowCol(posX, posY)
	local col = 1 + math.floor((posX - self._startPosX) / self._mapCellWidth)
	local row = 1 + math.floor((posY - self._startPosY) / self._mapCellWidth)

	return row, col
end

function OriMatGameGameController:rowCol2Pos(row, col)
	local posX = self._startPosX + (col - 1) * self._mapCellWidth
	local posY = self._startPosY + (row - 1) * self._mapCellWidth

	return posX, posY
end

function OriMatGameGameController:setGameConfig(cfg)
	self._gameConfig = cfg

	if not self._gameConfig then
		return
	end

	self._carrotHpMax = self._gameConfig.carrotHP
	self._isLoopState = self._gameConfig.isLoop
	self._totalTimer = self._gameConfig.totalTimer

	self:_resetMap()
	self:_setMonsterWaveParams()
end

function OriMatGameGameController:_setMonsterWaveParams()
	OriMatGameWaveMgr.instance:initFunc(GameUtil.handler(self._checkAliveFunc, self), GameUtil.handler(self._createWaveMonsterFunc, self), GameUtil.handler(self._newWaveFunc, self))

	self._waveList = OriMatGameWaveMgr.instance:initWave(self._gameConfig.monsterPlanIds, self._isLoopState)
end

function OriMatGameGameController:_resetMap()
	local mapData = self._gameConfig.mapData

	self._gridRowNum = mapData.rowNum
	self._gridColNum = mapData.colNum

	self:updateMapCellParams()

	self._gridDataMap = {}

	for i = 1, self._gridRowNum do
		self._gridDataMap[i] = self._gridDataMap[i] or {}

		for j = 1, self._gridColNum do
			if not self._gridDataMap[i][j] then
				local gridData = OriMatGameGridData.New()

				gridData:reset()
				gridData:setRowCol(i, j)

				self._gridDataMap[i][j] = gridData
			end
		end
	end

	self._startPosList = {}
	self._monsterPathMap = {}
	self._endPos = nil

	for _, gridCfg in ipairs(mapData.list) do
		local index = gridCfg.index + 1
		local i = math.floor((index - 1) / self._gridColNum) + 1
		local j = (index - 1) % self._gridColNum + 1
		local data = self._gridDataMap[i][j]

		if data then
			data:setCellCfg(gridCfg)

			if data:getGridState() == OriMatGameEnum.GridState.RoadFirst then
				table.insert(self._startPosList, data)
			elseif data:getGridState() == OriMatGameEnum.GridState.RoadEnd then
				self._endPos = data
			end
		end
	end

	local blockType, array, index
	local data = {}

	for i = 1, self._gridRowNum do
		array = {}
		data[i - 1] = array

		for j = 1, self._gridColNum do
			index = (i - 1) * self._gridColNum + j

			local gridData = self:getGridDataByRowCol(i, j)

			blockType = gridData and (gridData:isWalkable() and LuaPathfinder_Const.BlockType_None or LuaPathfinder_Const.BlockType_Wall) or LuaPathfinder_Const.BlockType_Wall
			array[j - 1] = {
				weight = 20,
				x = i - 1,
				y = j - 1,
				blockType = blockType
			}
		end
	end

	self._internalFinder:reload(data, self._gridRowNum, self._gridColNum, LuaPathfinder_Const.CostFlag_Dir_4, LuaPathfinder_Const.HeuristicFlag_Manhattan)

	local endRow, endColumn = self._endPos:getRowCol()
	local endNode = self._internalFinder:getNode(endRow - 1, endColumn - 1)

	for idx, gridData in ipairs(self._startPosList) do
		local oldRow, oldColumn = gridData:getRowCol()
		local startNode = self._internalFinder:getNode(oldRow - 1, oldColumn - 1)

		self:createMonsterPath(gridData, endNode)
	end
end

function OriMatGameGameController:createMonsterPath(gridData, endNode)
	if endNode == nil then
		local endRow, endColumn = self._endPos:getRowCol()

		endNode = self._internalFinder:getNode(endRow - 1, endColumn - 1)
	end

	local oldRow, oldColumn = gridData:getRowCol()
	local startNode = self._internalFinder:getNode(oldRow - 1, oldColumn - 1)

	if startNode and endNode then
		local pathList = self._internalFinder:search(startNode, endNode)

		if pathList then
			local length = #pathList
			local pathNodePath = {}

			for j = 1, length, 2 do
				local row = pathList[j] + 1
				local col = pathList[j + 1] + 1
				local posX, posY = self:rowCol2Pos(row, col)

				table.insert(pathNodePath, {
					x = posX,
					y = posY
				})
			end

			self._monsterPathMap[gridData] = pathNodePath

			return pathNodePath
		end
	end
end

function OriMatGameGameController:getMonsterPath(gridData)
	if not self._monsterPathMap then
		return self:createMonsterPath(gridData, nil)
	end

	return self._monsterPathMap[gridData]
end

function OriMatGameGameController:removeAllGridUnit()
	for i = 1, self._gridRowNum do
		for j = 1, self._gridColNum do
			local gridData = self._gridDataMap[i][j]

			if gridData then
				gridData:clearUnit()
			end
		end
	end
end

function OriMatGameGameController:buildObstacleByMap()
	for i = 1, self._gridRowNum do
		for j = 1, self._gridColNum do
			local gridData = self._gridDataMap[i][j]

			if gridData and gridData:isObstaclePos() then
				self:createObstacle(i, j, gridData:getCellTypeCfg())
			end
		end
	end
end

function OriMatGameGameController:getAllGridDataMap()
	return self._gridDataMap
end

function OriMatGameGameController:getCurRowNumAndColNum()
	return self._gridRowNum, self._gridColNum
end

function OriMatGameGameController:getGridDataByRowCol(row, col)
	if self._gridDataMap[row] then
		return self._gridDataMap[row][col]
	end
end

function OriMatGameGameController:getGridStateByRowCol(row, col)
	local gridData = self:getGridDataByRowCol(row, col)

	if gridData then
		return gridData:getGridState()
	end

	return nil
end

function OriMatGameGameController:getUnitByRowCol(row, col)
	local gridData = self:getGridDataByRowCol(row, col)

	if gridData then
		return gridData:getUnit()
	end

	return nil
end

function OriMatGameGameController:setUnitToGrid(row, col, unit)
	local gridData = self:getGridDataByRowCol(row, col)

	if gridData and gridData:getGridState() == OriMatGameEnum.GridState.Empty then
		gridData:setUnit(unit)
	end
end

function OriMatGameGameController:removeUnitFromGrid(row, col)
	local gridData = self:getGridDataByRowCol(row, col)

	if gridData then
		gridData:clearUnit()
	end
end

function OriMatGameGameController:initGame()
	self._curUnitMap = {}
	self._curUnitMapsByType = {}

	self:initQuadtree(UnityEngine.Screen.width + 200, UnityEngine.Screen.height + 200)
end

function OriMatGameGameController:resetGame()
	self:resetGameData()
	self:resetGameUnits()
end

function OriMatGameGameController:resetGameData()
	if self._gameConfig == nil then
		printError("游戏配置为空，无法重置游戏数据")

		return
	end

	self:removeAllGridUnit()

	self._waveList = OriMatGameWaveMgr.instance:initWave(self._gameConfig.monsterPlanIds, self._isLoopState)
	self._curCoin = self._gameConfig.initCoinNum
	self._carrotHp = self._gameConfig.carrotHP
	self._updateSiblingCD = 1
	self._killCountByWeapon = {}
	self._buildCountByWeapon = {}
	self._recycleCountByWeapon = {}
	self._gameSpeedRate = 1
	self._blessingPool = {}
	self._blessingPoolTotalWeight = 0

	for _, weaponId in ipairs(self._selectedWeaponIds) do
		local blessingDataList = OriMatGameConfig.instance:getBlessingDataList(weaponId)

		if blessingDataList then
			for _, data in ipairs(blessingDataList) do
				local item = {
					blessingId = data.blessingId,
					weight = checknumber(data.weight)
				}

				table.insert(self._blessingPool, item)

				self._blessingPoolTotalWeight = self._blessingPoolTotalWeight + item.weight
			end
		end
	end

	self._activeBlessings = {}
	self._exBuffIdsBlessing = {}
	self._maxBlessingEnergy = OriMatGameConfig.instance:getCommonValue("MAX_BLESSING_ENERGY", true)
	self._blessingEnergy = 0
	self._maxBlessingCount = OriMatGameConfig.instance:getCommonValue("MAX_BLESSING_COUNT", true)
end

function OriMatGameGameController:getMapData()
	return self._curPosMap
end

function OriMatGameGameController:startGame()
	return
end

function OriMatGameGameController:beforeUpdate()
	if not self._curUnitMap then
		return
	end

	for _, unit in pairs(self._curUnitMap) do
		unit:beforeUpdate()
	end
end

function OriMatGameGameController:getCurDeltaTime()
	return UnityEngine.Time.deltaTime * self._gameSpeedRate
end

function OriMatGameGameController:setGameSpeedRate(rate)
	rate = checknumber(rate)

	if rate <= 0 then
		rate = 1
	end

	self._gameSpeedRate = rate

	local monsterMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Monster)

	if monsterMap then
		for _, monster in pairs(monsterMap) do
			monster:setTimeScale(rate)
		end
	end
end

function OriMatGameGameController:getGameSpeedRate()
	return self._gameSpeedRate
end

function OriMatGameGameController:updateGame()
	if not self._curUnitMap then
		return
	end

	self:beforeUpdate()
	self:_checkBornMonster()

	for _, unit in pairs(self._curUnitMap) do
		unit:update(self:getCurDeltaTime())
	end

	self:_updateMonsterSibling()
	self:afterUpdate()
end

function OriMatGameGameController:afterUpdate()
	if not self._curUnitMap then
		return
	end

	self:checkMonsterArriveEnd()
	self:checkCollision()
	self:updateTowerTargets()

	for _, unit in pairs(self._curUnitMap) do
		unit:afterUpdate()

		if self:checkIsOutOfBounds(unit) then
			unit:beOutOfBounds()
		end
	end

	self:recycleDeadUnits()
end

function OriMatGameGameController:isGameOver()
	if self._waveList == nil or #self._waveList == 0 then
		return false
	end

	if self._carrotHp <= 0 then
		return true
	end

	return (OriMatGameWaveMgr.instance:checkIsGameOver(self._waveList))
end

function OriMatGameGameController:endGame()
	return
end

function OriMatGameGameController:destroyGame()
	self:resetGameUnits()
	self:clearObjectPool()
end

function OriMatGameGameController:resetGameUnits()
	if self._curUnitMap then
		for _, unit in pairs(self._curUnitMap) do
			self:destroyUnit(unit)
		end

		table.clear(self._curUnitMap)
	end

	if self._curUnitMapsByType then
		for k, v in pairs(self._curUnitMapsByType) do
			table.clear(v)

			self._curUnitMapsByType[k] = nil
		end

		table.clear(self._curUnitMapsByType)
	end

	self._finalTargetId = 0
end

function OriMatGameGameController:getUnit(unitId)
	return self._curUnitMap[unitId]
end

function OriMatGameGameController:getUnitByTypeAndId(unitType, unitId)
	if self._curUnitMapsByType[unitType] then
		return self._curUnitMapsByType[unitType][unitId]
	end

	return nil
end

function OriMatGameGameController:getUnitMapByType(unitType)
	return self._curUnitMapsByType[unitType]
end

function OriMatGameGameController:clearObjectPool()
	if self._unitPoolMap then
		for k, pool in pairs(self._unitPoolMap) do
			pool:clear()

			self._unitPoolMap[k] = nil
		end
	end

	self._unitPoolMap = {}

	if self._unitPoolComMap then
		for k, pool in pairs(self._unitPoolComMap) do
			pool:clear()

			self._unitPoolComMap[k] = nil
		end
	end

	self._unitPoolComMap = {}
end

function OriMatGameGameController:createUnit(unitType)
	self._unitNum = self._unitNum + 1
	self._unitPoolMap = self._unitPoolMap or {}

	if self._unitPoolMap[unitType] == nil then
		self:_createUnitPool(unitType)
	end

	if self._curUnitMapsByType[unitType] == nil then
		self._curUnitMapsByType[unitType] = {}
	end

	local unit = self._unitPoolMap[unitType]:fetchObject()

	unit:setUnitId(self._unitNum)

	self._curUnitMap[self._unitNum] = unit
	self._curUnitMapsByType[unitType][self._unitNum] = unit

	return unit
end

function OriMatGameGameController:preReCycle(unit)
	if unit then
		unit:preReCycle()
	end
end

function OriMatGameGameController:destroyUnit(unit)
	local utype, uid = unit:getType(), unit:getUnitId()

	self._curUnitMap[uid] = nil

	if self._curUnitMapsByType[utype] then
		self._curUnitMapsByType[utype][uid] = nil
	end

	if self._unitPoolMap[utype] then
		self._unitPoolMap[utype]:returnObject(unit)
	end
end

function OriMatGameGameController:_createUnitPool(unitTag)
	local function createFunc()
		if unitTag == OriMatGameEnum.UnitType.Monster then
			return OriMatGameMonster.New()
		elseif unitTag == OriMatGameEnum.UnitType.Weapon then
			return OriMatGameWeapon.New()
		elseif unitTag == OriMatGameEnum.UnitType.Bullet then
			return OriMatGameBullet.New()
		elseif unitTag == OriMatGameEnum.UnitType.Obstacle then
			return OriMatGameObstacle.New()
		end
	end

	local function disposeFunc(obj)
		obj:destroy()
	end

	local function resetFunc(obj)
		obj:reset()
	end

	self._unitPoolMap[unitTag] = ObjectPool.New(25, createFunc, disposeFunc, resetFunc)
end

function OriMatGameGameController:setUnitComTemplate(unitTag, copyInstance)
	self._unitComInstanceMap = self._unitComInstanceMap or {}
	self._unitComInstanceMap[unitTag] = copyInstance

	if not copyInstance then
		printError("没有找到对应的UnitCom实例，无法设置UnitCom模板，unitTag: " .. tostring(unitTag))
	else
		goutil.setActive(copyInstance, false)
	end
end

function OriMatGameGameController:createUnitCom(unitTag)
	local template = self._unitComInstanceMap[unitTag]

	if not template then
		printError("没有找到对应的UnitCom模板，无法创建UnitCom实例，unitTag: " .. tostring(unitTag))

		return nil
	end

	self._unitPoolComMap = self._unitPoolComMap or {}

	if not self._unitPoolComMap[unitTag] then
		self:_createUnitComPool(unitTag)
	end

	return (self._unitPoolComMap[unitTag]:fetchObject())
end

function OriMatGameGameController:_createUnitComPool(unitTag)
	local function createFunc()
		local template = self._unitComInstanceMap[unitTag]

		if not template then
			printError("没有找到对应的UnitCom模板，无法创建UnitCom实例，unitTag: " .. tostring(unitTag))

			return nil
		end

		local newInstance = goutil.cloneAndSetParent(template, template.transform.parent)

		if unitTag == OriMatGameEnum.UnitType.Monster then
			return OriMatGameMonsterCon.New(newInstance)
		elseif unitTag == OriMatGameEnum.UnitType.Weapon then
			return OriMatGameWeaponCon.New(newInstance)
		elseif unitTag == OriMatGameEnum.UnitType.Bullet then
			return OriMatGameBulletCon.New(newInstance)
		elseif unitTag == OriMatGameEnum.UnitType.Obstacle then
			return OriMatGameObstacleCon.New(newInstance)
		end
	end

	local function disposeFunc(obj)
		obj:destroy()
	end

	local function resetFunc(obj)
		obj:reset()
	end

	self._unitPoolComMap[unitTag] = ObjectPool.New(50, createFunc, disposeFunc, resetFunc)
end

function OriMatGameGameController:destroyUnitCom(unitCom)
	if not unitCom then
		return
	end

	local utype = unitCom:getType()

	if self._unitPoolComMap[utype] then
		self._unitPoolComMap[utype]:returnObject(unitCom)
	end
end

function OriMatGameGameController:checkCollision()
	if not self._curUnitMap then
		return
	end

	table.clear(self._bigbullets)
	self._collisionQuadtree:clear()

	local bulletMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Bullet)

	if bulletMap then
		for _, bullet in pairs(bulletMap) do
			if bullet:getRadius() > self._halfMapCellWidth then
				table.insert(self._bigbullets, bullet)
			else
				self._collisionQuadtree:insert(bullet)
			end
		end
	end

	local monsterMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Monster)

	if monsterMap then
		for _, monster in pairs(monsterMap) do
			if monster:getRadius() > 0 and monster:isActive() then
				table.clear(self._collisionFoundList)

				self._collisionFoundList = self._collisionQuadtree:query(monster.rect, self._collisionFoundList)

				for _, bullet in pairs(self._collisionFoundList) do
					if bullet:isActive() and self:checkIsRangeBetween(bullet, monster, monster:getRadius() + bullet:getRadius()) then
						self:onBulletHitTarget(bullet, monster)
					end
				end
			end
		end
	end

	local obstacleMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Obstacle)

	if obstacleMap then
		for _, obstacle in pairs(obstacleMap) do
			if obstacle:getRadius() > 0 and obstacle:isActive() then
				table.clear(self._collisionFoundList)

				self._collisionFoundList = self._collisionQuadtree:query(obstacle.rect, self._collisionFoundList)

				for _, bullet in pairs(self._collisionFoundList) do
					if bullet:isActive() and self:checkIsRangeBetween(bullet, obstacle, obstacle:getRadius() + bullet:getRadius()) then
						self:onBulletHitTarget(bullet, obstacle)
					end
				end
			end
		end
	end

	if #self._bigbullets == 0 then
		return
	end

	self._collisionQuadtree:clear()

	if monsterMap then
		for _, monster in pairs(monsterMap) do
			self._collisionQuadtree:insert(monster)
		end
	end

	if obstacleMap then
		for _, obstacle in pairs(obstacleMap) do
			self._collisionQuadtree:insert(obstacle)
		end
	end

	for _, bullet in pairs(self._bigbullets) do
		table.clear(self._collisionFoundList)

		self._collisionFoundList = self._collisionQuadtree:query(bullet.rect, self._collisionFoundList)

		for _, target in pairs(self._collisionFoundList) do
			if bullet:isActive() and target:isActive() and self:checkIsRangeBetween(bullet, target, target:getRadius() + bullet:getRadius()) then
				self:onBulletHitTarget(bullet, target)
			end
		end
	end
end

function OriMatGameGameController:checkMonsterArriveEnd()
	if not self._curUnitMap then
		return
	end

	local monsterMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Monster)

	if monsterMap then
		for _, monster in pairs(monsterMap) do
			if monster:isArriveEnd() then
				monster:preReCycle()
				self:_updateCurHP(-1)
				GlobalDispatcher:dispatch(GlobalNotify.OriMatGamePlayXiaoShiEffect, monster.position.x, monster.position.y)
			end
		end
	end
end

function OriMatGameGameController:recycleDeadUnits()
	if not self._curUnitMap then
		return
	end

	for _, unit in pairs(self._curUnitMap) do
		if not unit:isActive() then
			self:destroyUnit(unit)
		end
	end
end

function OriMatGameGameController:updateTowerTargets()
	if not self._curUnitMap then
		return
	end

	local weaponMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Weapon)

	if not weaponMap then
		return
	end

	self._attackQuadtree:clear()

	local monsterMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Monster)

	if monsterMap then
		for _, monster in pairs(monsterMap) do
			if monster._isActive then
				self._attackQuadtree:insert(monster)
			end
		end
	end

	local obstacleMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Obstacle)

	if obstacleMap then
		for _, obstacle in pairs(obstacleMap) do
			if obstacle._isActive then
				self._attackQuadtree:insert(obstacle)
			end
		end
	end

	local unit = self:getUnit(self._finalTargetId)

	if unit and unit:isActive() == false then
		unit = nil
	end

	local minMonsterDist, minObstacleDist = math.huge, math.huge
	local nearestMonster, nearestObstacle
	local attackRangePow = 0
	local distPow = 0

	for _, weapon in pairs(weaponMap) do
		weapon:resetTargets()

		attackRangePow = checknumber(weapon:getRadiusPow())

		if unit and attackRangePow >= weapon:getDistancePowTo(unit) then
			weapon:addTarget(unit)
		else
			minMonsterDist = math.huge
			nearestObstacle = nil
			nearestMonster = nil

			table.clear(self._attackFoundList)

			self._attackFoundList = self._attackQuadtree:query(weapon.rect, self._attackFoundList)

			for _, target in pairs(self._attackFoundList) do
				distPow = weapon:getDistancePowTo(target)

				if distPow <= attackRangePow then
					if target:getType() == OriMatGameEnum.UnitType.Monster then
						if distPow < minMonsterDist then
							minMonsterDist = distPow
							nearestMonster = target
						end
					elseif target:getType() == OriMatGameEnum.UnitType.Obstacle and distPow < math.huge then
						minObstacleDist = distPow
						nearestObstacle = target
					end
				end

				if nearestMonster then
					weapon:addTarget(nearestMonster)
				elseif nearestObstacle then
					weapon:addTarget(nearestObstacle)
				end
			end
		end
	end
end

function OriMatGameGameController:getNearestTarget(x, y, radius)
	local rect = SimpleQuadTree.createRect(x - radius, y - radius, radius + radius, radius + radius)

	self._attackQuadtree:clear()

	local monsterMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Monster)

	if monsterMap then
		for _, monster in pairs(monsterMap) do
			self._attackQuadtree:insert(monster)
		end
	end

	local obstacleMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Obstacle)

	if obstacleMap then
		for _, obstacle in pairs(obstacleMap) do
			self._attackQuadtree:insert(obstacle)
		end
	end

	table.clear(self._attackFoundList)

	self._attackFoundList = self._attackQuadtree:query(rect, self._attackFoundList)

	local minMonsterDist, minObstacleDist = math.huge, math.huge
	local attackRangePow = checknumber(radius * radius)
	local finalTarget

	for _, target in pairs(self._attackFoundList) do
		local dx = x - target.position.x
		local dy = y - target.position.y
		local distPow = dx * dx + dy * dy

		if distPow <= attackRangePow and distPow < minMonsterDist then
			minMonsterDist = distPow
			finalTarget = target
		end
	end

	if finalTarget then
		local unit = self:getUnit(self._finalTargetId)

		self._finalTargetId = finalTarget:getUnitId()

		if unit and unit:isActive() then
			unit:updateFireUI(self._finalTargetId)
		end

		finalTarget:updateFireUI(self._finalTargetId)
	end
end

function OriMatGameGameController:findTargetsInRange(posx, posy, range, ignoreTarget)
	if not posx or not posy or not range then
		printError("寻找范围内的目标，参数错误")

		return
	end

	local rangePow = checknumber(range) * checknumber(range)
	local target
	local minTargetDist = math.huge
	local monsterMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Monster)

	if monsterMap then
		for _, monster in pairs(monsterMap) do
			if monster and monster ~= ignoreTarget and monster:isActive() then
				local disX = monster.position.x - posx
				local disY = monster.position.y - posy
				local distPow = disX * disX + disY * disY

				if distPow <= rangePow and distPow < minTargetDist then
					minTargetDist = distPow
					target = monster
				end
			end
		end
	end

	local obstacleMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Obstacle)

	if obstacleMap then
		for _, obstacle in pairs(obstacleMap) do
			if obstacle and obstacle ~= ignoreTarget and obstacle:isActive() then
				local disX = obstacle.position.x - posx
				local disY = obstacle.position.y - posy
				local distPow = disX * disX + disY * disY

				if distPow <= rangePow and distPow < minTargetDist then
					minTargetDist = distPow
					target = obstacle
				end
			end
		end
	end

	return target
end

function OriMatGameGameController:checkIsRangeBetween(unitA, unitB, dis)
	if unitA and unitB then
		local disX = unitA.position.x - unitB.position.x
		local disY = unitA.position.y - unitB.position.y
		local range = checknumber(dis)

		return range * range >= disX * disX + disY * disY
	end
end

function OriMatGameGameController:onBulletHitTarget(bullet, target)
	if not bullet or not target then
		return
	end

	if not bullet:canHitTarget(target) then
		return
	end

	target:beHit(bullet)
	bullet:hit(target)
	bullet:beforeDoDamage(target)

	local damage = checknumber(bullet:getCurAttrValue(OriMatGameEnum.UnitAttrName.Attack))

	target:beDamage(bullet, damage)
	bullet:afterDoDamage(target, damage)
end

function OriMatGameGameController:onBuildWeapon(unit)
	if unit and unit:getType() == OriMatGameEnum.UnitType.Weapon then
		local weapon = unit

		self._buildCountByWeapon[weapon:getWeaponId()] = (self._buildCountByWeapon[weapon:getWeaponId()] or 0) + 1
	end
end

function OriMatGameGameController:onRecycleWeapon(unit)
	if unit and unit:getType() == OriMatGameEnum.UnitType.Weapon then
		local weapon = unit

		self._recycleCountByWeapon[weapon:getWeaponId()] = (self._recycleCountByWeapon[weapon:getWeaponId()] or 0) + 1
	end
end

function OriMatGameGameController:onMonsterKillByBullet(monster, bullet)
	if monster and bullet and bullet:getType() == OriMatGameEnum.UnitType.Bullet then
		GlobalDispatcher:dispatch(GlobalNotify.OriMatGamePlayXiaoShiEffect, monster.position.x, monster.position.y)

		self._killCountByWeapon[bullet:getWeaponId()] = (self._killCountByWeapon[bullet:getWeaponId()] or 0) + 1

		self:_updateCurCoin(monster:getKillCoin())
		self:_updateBlessingEnergy(monster:getBlessingEnergy(), monster.position.x, monster.position.y)
	end
end

function OriMatGameGameController:onObstacleKillByBullet(obstacle, bullet)
	if obstacle and bullet and bullet:getType() == OriMatGameEnum.UnitType.Bullet then
		self:_updateCurCoin(obstacle:getKillCoin())

		local row, col = obstacle:getCurRowCol()

		self:removeUnitFromGrid(row, col)
	end
end

function OriMatGameGameController:buildWeaponAtRowCol(row, col, weaponType)
	local girdData = self:getGridDataByRowCol(row, col)

	if not girdData then
		return
	end

	if girdData:getGridState() ~= OriMatGameEnum.GridState.Empty then
		TipsFacade.instance:openCommonTips("当前位置不可放置武器")

		return
	end

	local weaponLv = 1
	local weaponCfg = OriMatGameConfig.instance:getWeaponLevelCfgByWeapon(weaponType, weaponLv)

	if weaponCfg == nil then
		printError("没有找到对应的武器配置，无法建造武器，weaponType: " .. tostring(weaponType) .. " weaponLv: " .. tostring(weaponLv))

		return
	end

	local buildCost = weaponCfg.setCost

	if buildCost > self._curCoin then
		TipsFacade.instance:openCommonTips("代币不足，无法建造武器")

		return false
	end

	local weapon = self:createWeapon(row, col, weaponCfg)

	self:updateTowerTargets()
	self:onBuildWeapon(weapon)
	self:_updateCurCoin(-buildCost)
	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameUpdateWeaponBuildInfo, row, col, weaponType)
end

function OriMatGameGameController:recycleWeaponAt(row, col)
	local grid = self:getGridDataByRowCol(row, col)

	if not grid then
		return
	end

	local unit = grid:getUnit()

	if not unit then
		return
	end

	self:removeUnitFromGrid(row, col)

	if unit:getType() == OriMatGameEnum.UnitType.Weapon then
		self:_updateCurCoin(unit:getResetReturn())
		GlobalDispatcher:dispatch(GlobalNotify.OriMatGameUpdateWeaponBuildInfo, row, col, -1)
		self:onRecycleWeapon(unit)
	end

	self:preReCycle(unit)
	self:destroyUnit(unit)
end

function OriMatGameGameController:upgradeWeaponAt(row, col)
	row = checknumber(row)
	col = checknumber(col)

	local unit = self:getUnitByRowCol(row, col)

	if not unit or unit:getType() ~= OriMatGameEnum.UnitType.Weapon then
		TipsFacade.instance:openCommonTips("当前位置没有武器")

		return false
	end

	local weapon = unit
	local curLevel = weapon:getLevel()
	local weaponId = weapon:getWeaponId()

	if weapon:isMaxLevel() then
		TipsFacade.instance:openCommonTips("武器已达到最高等级")

		return false
	end

	local upgradeCost = weapon:getUpgradeCost()

	if upgradeCost > self._curCoin then
		TipsFacade.instance:openCommonTips("代币不足，无法升级武器")

		return false
	end

	local nextLevel = curLevel + 1
	local nextCfg = OriMatGameConfig.instance:getWeaponLevelCfgByWeapon(weaponId, nextLevel)

	if not nextCfg then
		printError(string.format("没有找到对应的武器升级配置，无法升级武器，weaponId: %s, nextLevel: %s", weaponId, nextLevel))

		return false
	end

	weapon:setWeaponCfg(nextCfg)
	weapon:updateUI()
	self:updateTowerTargets()
	self:_updateCurCoin(-upgradeCost)
	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameUpgradeWeapon, row, col, weaponId)

	return true
end

function OriMatGameGameController:createWeapon(row, col, weaponcfg)
	local girdData = self:getGridDataByRowCol(row, col)

	if not girdData or girdData:getGridState() ~= OriMatGameEnum.GridState.Empty then
		printError("当前格子不可放置武器，x: " .. tostring(col) .. " y: " .. tostring(row))

		return nil
	end

	local weapon = self:createUnit(OriMatGameEnum.UnitType.Weapon)
	local posX, posY = self:rowCol2Pos(row, col)

	weapon:setWeaponCfg(weaponcfg)
	weapon:updatePosition(posX, posY)
	weapon:setSpecialGridId(girdData:getAddParam())

	local weaponId = weapon:getWeaponId()
	local exBuffIds = {}

	if self._exBuffIdsTalent[OriMatGameEnum.UnitType.Weapon] then
		for _, id in ipairs({
			weaponId,
			0
		}) do
			local exBuffIdsTalent = self._exBuffIdsTalent[OriMatGameEnum.UnitType.Weapon][id]

			if exBuffIdsTalent then
				for _, buffId in ipairs(exBuffIdsTalent) do
					table.insert(exBuffIds, buffId)
				end
			end
		end
	end

	if self._exBuffIdsBlessing[OriMatGameEnum.UnitType.Weapon] then
		for _, id in ipairs({
			weaponId,
			0
		}) do
			local exBuffIdsBlessing = self._exBuffIdsBlessing[OriMatGameEnum.UnitType.Weapon][id]

			if exBuffIdsBlessing then
				for _, buffId in ipairs(exBuffIdsBlessing) do
					table.insert(exBuffIds, buffId)
				end
			end
		end
	end

	for _, buffId in ipairs(exBuffIds) do
		weapon.addBuffByBuffId(weapon, buffId, weapon)
	end

	weapon:onEnable()

	local weaponCon = self:createUnitCom(weapon:getType())

	weapon:setCom(weaponCon)
	self:setUnitToGrid(row, col, weapon)

	return weapon
end

function OriMatGameGameController:_checkBornMonster()
	if self._waveList then
		local isRunning = OriMatGameWaveMgr.instance:updateWaveList(self._waveList, self:getCurDeltaTime())
	end
end

function OriMatGameGameController:_checkAliveFunc(unitType, unitIdList)
	local isHasActive = false

	if unitIdList ~= nil then
		for i, unitId in ipairs(unitIdList) do
			local unit = self:getUnitByTypeAndId(unitType, unitId)

			if unit and unit:isActive() then
				isHasActive = true
			end
		end
	end

	return isHasActive
end

function OriMatGameGameController:_createWaveMonsterFunc(idx, cfg)
	local grid = self._startPosList[idx]

	if grid then
		local monsterCfg = OriMatGameConfig.instance:getMonsterCfg(cfg.monsterId)
		local unit = self:createMonster(grid.row, grid.col, monsterCfg, grid)

		GlobalDispatcher:dispatch(GlobalNotify.OriMatGamePlayEffect, unit.position.x, unit.position.y)

		return unit
	end

	return nil
end

function OriMatGameGameController:_newWaveFunc()
	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameUpdateWave)
end

function OriMatGameGameController:getCurWave()
	local cur, total = OriMatGameWaveMgr.instance:getCurrMaxWaveCount(self._waveList)

	return cur, total
end

function OriMatGameGameController:createMonster(row, col, cfg, grid)
	local monster = self:createUnit(OriMatGameEnum.UnitType.Monster)
	local posX, posY = self:rowCol2Pos(row, col)

	monster:updatePosition(posX, posY)

	local movePath = self:getMonsterPath(grid) or {}

	monster:initParam(cfg, grid, movePath)

	local monsterCon = self:createUnitCom(monster:getType())

	monster:setCom(monsterCon)

	return monster
end

function OriMatGameGameController:createBullet(posX, posY, bulletId, weaponTypeId, ownerId, dirX, dirY, baseDamValue)
	local bullet = self:createUnit(OriMatGameEnum.UnitType.Bullet)

	bullet:setDefineId(bulletId)
	bullet:setWeaponId(weaponTypeId)
	bullet:setOwnerId(ownerId)
	bullet:setDirection(dirX, dirY)
	bullet:setBaseDamage(baseDamValue)
	bullet:updatePosition(posX, posY)

	local exBuffIds = {}

	if self._exBuffIdsTalent[OriMatGameEnum.UnitType.Bullet] then
		for _, id in ipairs({
			weaponTypeId,
			0
		}) do
			local exBuffIdsTalent = self._exBuffIdsTalent[OriMatGameEnum.UnitType.Bullet][id]

			if exBuffIdsTalent then
				for _, buffId in ipairs(exBuffIdsTalent) do
					table.insert(exBuffIds, buffId)
				end
			end
		end
	end

	if self._exBuffIdsBlessing[OriMatGameEnum.UnitType.Bullet] then
		for _, id in ipairs({
			weaponTypeId,
			0
		}) do
			local exBuffIdsBlessing = self._exBuffIdsBlessing[OriMatGameEnum.UnitType.Bullet][id]

			if exBuffIdsBlessing then
				for _, buffId in ipairs(exBuffIdsBlessing) do
					table.insert(exBuffIds, buffId)
				end
			end
		end
	end

	for _, buffId in ipairs(exBuffIds) do
		bullet.addBuffByBuffId(bullet, buffId, bullet)
	end

	bullet:onEnable()

	local bulletCon = self:createUnitCom(bullet:getType())

	bullet:setCom(bulletCon)

	return bullet
end

function OriMatGameGameController:createObstacle(row, col, mapCellCfg)
	if self:getGridStateByRowCol(row, col) == OriMatGameEnum.GridState.Empty then
		local obstacle = self:createUnit(OriMatGameEnum.UnitType.Obstacle)
		local posX, posY = self:rowCol2Pos(row, col)

		obstacle:setCurRowCol(row, col)
		obstacle:setObstacleCfg(mapCellCfg)
		obstacle:updatePosition(posX, posY)
		obstacle:onEnable()

		local obstacleCon = self:createUnitCom(obstacle:getType())

		obstacle:setCom(obstacleCon)
		self:setUnitToGrid(row, col, obstacle)

		return obstacle
	end
end

function OriMatGameGameController:checkIsOutOfBounds(unit)
	if unit then
		local posX, posY = unit.position.x, unit.position.y

		return posX < -self._mapWidth / 2 or posX > self._mapWidth / 2 or posY < -self._mapHeight / 2 or posY > self._mapHeight / 2
	end

	return false
end

function OriMatGameGameController:_updateCurCoin(changeValue)
	local changeValue = checknumber(changeValue)

	self._curCoin = self._curCoin + checknumber(changeValue)
	self._curCoin = math.max(0, self._curCoin)

	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameChangeCoin, changeValue)
end

function OriMatGameGameController:getCurCoin()
	return self._curCoin
end

function OriMatGameGameController:_updateBlessingEnergy(changeValue, posX, posY)
	if #self._activeBlessings >= self._maxBlessingCount then
		return
	end

	if self._blessingEnergy >= self._maxBlessingEnergy then
		return
	end

	local changeValue = checknumber(changeValue)
	local newValue = self._blessingEnergy + changeValue

	if changeValue > 0 and posX and posY then
		local flyText = string.format("祝福+%s", changeValue)

		GlobalDispatcher:dispatch(GlobalNotify.OriMatGameShowAlertTxt, flyText, posX, posY + 80, AQAFSimpleFloatTipsMgr.TYPE_ENERGY_TEXT)
	end

	if newValue >= self._maxBlessingEnergy and #self._blessingPool > 0 then
		self._blessingEnergy = Mathf.Clamp(newValue - self._maxBlessingEnergy, 0, self._maxBlessingEnergy)

		GlobalDispatcher:dispatch(GlobalNotify.OriMatGameBlessingSelect)
	else
		self._blessingEnergy = Mathf.Clamp(newValue, 0, self._maxBlessingEnergy)
	end

	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameChangeBlessingEnergy)
end

function OriMatGameGameController:getCurBlessingEnergy()
	return self._blessingEnergy
end

function OriMatGameGameController:getMaxBlessingEnergy()
	return self._maxBlessingEnergy
end

function OriMatGameGameController:_updateCurHP(changeValue)
	local changeValue = checknumber(changeValue)

	self._carrotHp = self._carrotHp + checknumber(changeValue)
	self._carrotHp = math.max(0, self._carrotHp)

	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameChangeHP, changeValue)
end

function OriMatGameGameController:getCurCarrotHp()
	return self._carrotHp
end

function OriMatGameGameController:getCarrotHpMax()
	return self._carrotHpMax
end

function OriMatGameGameController:getCurkillInfos()
	local killInfos = {}

	for weaponId, count in pairs(self._killCountByWeapon) do
		table.insert(killInfos, {
			weaponId = weaponId,
			killNum = count
		})
	end

	return killInfos
end

function OriMatGameGameController:getCurkillCountMap()
	return self._killCountByWeapon or {}
end

function OriMatGameGameController:getBuildInfos()
	local buildInfos = {}

	for weaponId, count in pairs(self._buildCountByWeapon) do
		table.insert(buildInfos, {
			weaponId = weaponId,
			buildNum = count
		})
	end

	return buildInfos
end

function OriMatGameGameController:getCurBuildCountMap()
	return self._buildCountByWeapon or {}
end

function OriMatGameGameController:getRecycleInfos()
	local recycleInfos = {}

	for weaponId, count in pairs(self._recycleCountByWeapon) do
		table.insert(recycleInfos, {
			weaponId = weaponId,
			recycleNum = count
		})
	end

	return recycleInfos
end

function OriMatGameGameController:getCurRecycleCountMap()
	return self._recycleCountByWeapon or {}
end

function OriMatGameGameController:getLastBuildInfos()
	local lastBuildInfos = {}

	for weaponId, count in pairs(self._buildCountByWeapon) do
		local info = {}

		info.weaponId = weaponId

		local historyCount = count
		local recycleCount = checknumber(self._recycleCountByWeapon[weaponId])

		info.buildNum = historyCount - recycleCount

		table.insert(lastBuildInfos, info)
	end

	return lastBuildInfos
end

function OriMatGameGameController:_updateMonsterSibling()
	self._updateSiblingCD = self._updateSiblingCD - self:getCurDeltaTime()

	if self._updateSiblingCD > 0 then
		return
	end

	self._updateSiblingCD = 1

	local list = {}
	local monsterMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Monster)

	if monsterMap then
		for _, monster in pairs(monsterMap) do
			if monster and monster:isActive() then
				table.insert(list, monster)
			end
		end
	end

	ArraySort.sortOn(list, function(mon)
		return mon.position.y
	end, ArraySort.DESCENDING)

	for i, mon in ipairs(list) do
		local con = mon:getContainer()

		if con then
			con.transform:SetSiblingIndex(i - 1)
		end
	end
end

function OriMatGameGameController:setSelectedWeaponIds(weaponIds)
	self._selectedWeaponIds = weaponIds
end

function OriMatGameGameController:getSelectedWeaponIds()
	return self._selectedWeaponIds
end

function OriMatGameGameController:getMaxWeaponNum()
	if self._gameConfig then
		return checknumber(self._gameConfig.maxWeaponNum)
	end

	return 0
end

function OriMatGameGameController:setActiveTalents(talents)
	self._activeTalents = talents or {}

	local exBuffIds = {}

	for _, talentId in pairs(self._activeTalents) do
		local talentCfg = OriMatGameConfig.instance:getTalentCfg(talentId)

		if talentCfg then
			if not talentCfg.weaponId then
				local weaponId = 0

				if talentCfg then
					if not talentCfg.buffId then
						local buffId = 0
						local buffData = OriMatGameConfig.instance:getBuffCfg(buffId)

						if buffData then
							local targetType = buffData.targetType

							exBuffIds[targetType] = exBuffIds[targetType] or {}
							exBuffIds[targetType][weaponId] = exBuffIds[targetType][weaponId] or {}

							table.insert(exBuffIds[targetType][weaponId], buffId)
						end
					end
				end
			end
		end
	end

	self._exBuffIdsTalent = exBuffIds
end

function OriMatGameGameController:getActiveTalents()
	return self._activeTalents
end

function OriMatGameGameController:isActiveTalent(talentId)
	return self._activeTalents[talentId] ~= nil
end

function OriMatGameGameController:getRandomBlessings(count)
	count = checknumber(count)

	local results = {}

	if count <= 0 then
		return results
	end

	if not self._blessingPool or #self._blessingPool == 0 then
		return results
	end

	local actualCount = math.min(count, #self._blessingPool)

	for i = 1, actualCount do
		if self._blessingPoolTotalWeight <= 0 then
			break
		end

		local random = math.random() * self._blessingPoolTotalWeight
		local totalWeight = 0
		local selectedIndex

		for index, item in ipairs(self._blessingPool) do
			totalWeight = totalWeight + item.weight

			if random <= totalWeight then
				selectedIndex = index

				break
			end
		end

		if selectedIndex then
			local selectedItem = self._blessingPool[selectedIndex]

			table.insert(results, selectedItem.blessingId)

			self._blessingPoolTotalWeight = self._blessingPoolTotalWeight - selectedItem.weight

			table.remove(self._blessingPool, selectedIndex)
		end
	end

	return results
end

function OriMatGameGameController:returnBlessings(blessingIds)
	for _, blessingId in ipairs(blessingIds) do
		local blessingCfg = OriMatGameConfig.instance:getBlessingCfg(blessingId)

		if not blessingCfg then
			printError("OriMatGameGameController:returnBlessings - blessing not found in config: " .. tostring(blessingId))
		else
			local item = {
				blessingId = blessingId,
				weight = checknumber(blessingCfg.weight)
			}

			table.insert(self._blessingPool, item)

			self._blessingPoolTotalWeight = self._blessingPoolTotalWeight + item.weight
		end
	end
end

function OriMatGameGameController:applyBlessingBuff(blessingId)
	table.insert(self._activeBlessings, blessingId)

	local blessingCfg = OriMatGameConfig.instance:getBlessingCfg(blessingId)
	local buffCfg = OriMatGameConfig.instance:getBuffCfg(blessingCfg.buffId)
	local targetType = buffCfg.targetType
	local weaponId = blessingCfg.weaponId
	local buffId = blessingCfg.buffId

	self._exBuffIdsBlessing[targetType] = self._exBuffIdsBlessing[targetType] or {}
	self._exBuffIdsBlessing[targetType][weaponId] = self._exBuffIdsBlessing[targetType][weaponId] or {}

	table.insert(self._exBuffIdsBlessing[targetType][weaponId], buffId)

	if targetType == OriMatGameEnum.UnitType.Weapon then
		local weaponMap = self:getUnitMapByType(OriMatGameEnum.UnitType.Weapon)

		if weaponMap then
			for _, weapon in pairs(weaponMap) do
				if weaponId == 0 or weapon:getWeaponId() == weaponId then
					weapon.addBuffByBuffId(weapon, buffId, weapon)
				end
			end
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.OriMatGameBlessingActive)
end

function OriMatGameGameController:getActiveBlessings()
	return self._activeBlessings
end

function OriMatGameGameController:isHasActiveBlessing(blessingId)
	for _, id in ipairs(self._activeBlessings) do
		if id == blessingId then
			return true
		end
	end

	return false
end

function OriMatGameGameController:getCurBlessingCount()
	return #self._activeBlessings
end

function OriMatGameGameController:getMaxBlessingCount()
	return self._maxBlessingCount or 0
end

function OriMatGameGameController:isReachBlessingLimit()
	return #self._activeBlessings >= self._maxBlessingCount
end

OriMatGameGameController.instance = OriMatGameGameController.New()

return OriMatGameGameController
