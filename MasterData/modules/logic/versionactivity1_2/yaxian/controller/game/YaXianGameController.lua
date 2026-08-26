-- chunkname: @modules/logic/versionactivity1_2/yaxian/controller/game/YaXianGameController.lua

module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianGameController", package.seeall)

local YaXianGameController = class("YaXianGameController", BaseController)

function YaXianGameController:onInit()
	return
end

function YaXianGameController:reInit()
	return
end

function YaXianGameController:release()
	if self.state then
		self.state:removeAll()
	end

	if self.stepMgr then
		self.stepMgr:removeAll()
		self.stepMgr:dispose()
	end

	self.interactItemList = nil
	self.state = nil
	self.stepMgr = nil
	self.searchTree = nil
	self.selectInteractObjId = nil
	self.clickStatus = YaXianGameEnum.SelectPosStatus.None
end

function YaXianGameController:enterChessGame(episodeId)
	Activity115Rpc.instance:sendAct115StartEpisodeRequest(YaXianGameEnum.ActivityId, episodeId, self._openGame, self)
end

function YaXianGameController:_openGame(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local bossInteractMo = YaXianGameModel.instance:getInteractMo(YaXianGameEnum.BossInteractId)

	if bossInteractMo then
		bossInteractMo:setXY(YaXianGameEnum.FakeBossStartPos.posX, YaXianGameEnum.FakeBossStartPos.posY)
		bossInteractMo:setDirection(YaXianGameEnum.FakeBossDirection)
		YaXianGameModel.instance:setNeedFeatureInteractMo(bossInteractMo)
	else
		YaXianGameModel.instance:clearFeatureInteract()
	end

	Stat1_2Controller.instance:yaXianStatStart()
	ViewMgr.instance:openView(ViewName.YaXianGameView)
end

function YaXianGameController:initMapByMapMsg(actId, map)
	YaXianGameModel.instance:release()
	YaXianGameModel.instance:initLocalConfig(actId, map.id)
	YaXianGameModel.instance:initServerDataByServerData(map)
	self:setSelectObj()

	self.state = self.state or YaXianStateMgr.New()

	self.state:removeAll()
	self.state:setCurEvent(map.currentEvent)

	self.stepMgr = self.stepMgr or YaXianStepMgr.New()

	self.stepMgr:disposeAllStep()
end

function YaXianGameController:initMapByMapMo(mapMo)
	YaXianGameModel.instance:release()
	YaXianGameModel.instance:initLocalConfig(mapMo.actId, mapMo.episodeId)
	YaXianGameModel.instance:initServerDataByMapMo(mapMo)
	self:setSelectObj()

	self.state = self.state or YaXianStateMgr.New()

	self.state:removeAll()
	self.state:setCurEvent(mapMo.currentEvent)

	self.stepMgr = self.stepMgr or YaXianStepMgr.New()

	self.stepMgr:disposeAllStep()
end

function YaXianGameController:setInteractItemList(interactItemList)
	self.interactItemList = interactItemList
end

function YaXianGameController:setPlayerInteractItem(playerInteractItem)
	self.playerInteractItem = playerInteractItem
end

function YaXianGameController:getInteractItemList()
	return self.interactItemList
end

function YaXianGameController:getInteractItem(interactId)
	for _, interactItem in ipairs(self.interactItemList) do
		if interactItem.id == interactId then
			return interactItem
		end
	end
end

function YaXianGameController:getPlayerInteractItem()
	return self.playerInteractItem
end

function YaXianGameController:getSelectedInteractItem()
	return self:getInteractItem(self.selectInteractObjId)
end

function YaXianGameController:initSceneTree(goTouch, offsetSceneY)
	self.searchTree = YaXianGameTree.New()

	local treeRoot = self.searchTree:createLeaveNode()
	local w, h = YaXianGameModel.instance:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local node = {}
			local tmpX, tmpY, tmpZ = YaXianGameHelper.calcTilePosInScene(x - 1, y - 1)
			local pos = recthelper.worldPosToAnchorPos(Vector3.New(tmpX, tmpY + offsetSceneY, 0), goTouch.transform)

			node.x, node.y = pos.x, pos.y
			node.tileX, node.tileY = x - 1, y - 1

			table.insert(treeRoot.nodes, node)

			treeRoot.keys = node
		end
	end

	self.searchTree:growToBranch(treeRoot)
	self.searchTree:buildTree(treeRoot)
end

function YaXianGameController:searchInteractByPos(x, y, filterFunc)
	local interactMoList = YaXianGameModel.instance:getInteractMoList()
	local targetMoList = {}

	for _, interactMo in ipairs(interactMoList) do
		if interactMo.posX == x and interactMo.posY == y and (not filterFunc or filterFunc(interactMo.config)) then
			table.insert(targetMoList, interactMo)
		end
	end

	if #targetMoList > 1 then
		table.sort(targetMoList, self.sortSelectObj)
	end

	return targetMoList
end

function YaXianGameController.sortSelectObj(a, b)
	if not YaXianGameEnum.InteractSelectPriority[a.config.interactType] then
		local aPriority = a.id

		if not YaXianGameEnum.InteractSelectPriority[b.config.interactType] then
			local bPriority = b.id

			return aPriority < bPriority
		end
	end
end

function YaXianGameController:updateAllPosInteractActive()
	local updatedPosDict = {}

	for _, interactMo in ipairs(YaXianGameModel.instance:getInteractMoList()) do
		local key = YaXianGameHelper.getPosHashKey(interactMo.posX, interactMo.posY)

		if not updatedPosDict[key] then
			self:updatePosInteractActive(interactMo.posX, interactMo.posY)

			updatedPosDict[key] = true
		end
	end
end

function YaXianGameController:updatePosInteractActive(x, y)
	local interactMoList = self:searchInteractByPos(x, y)

	if #interactMoList < 1 then
		return
	end

	if #interactMoList == 1 then
		local interactItem = self:getInteractItem(interactMoList[1].id)

		interactItem:updateActiveByShowPriority(YaXianGameEnum.MinShowPriority)

		return
	end

	local maxPriority = YaXianGameEnum.MinShowPriority
	local interactItemList = {}

	for _, interactMo in ipairs(interactMoList) do
		table.insert(interactItemList, self:getInteractItem(interactMo.id))
	end

	for _, interactItem in ipairs(interactItemList) do
		local priority = interactItem:getShowPriority()

		if maxPriority < priority then
			maxPriority = interactItem:getShowPriority()
		end
	end

	for _, interactItem in ipairs(interactItemList) do
		interactItem:updateActiveByShowPriority(maxPriority)
	end
end

function YaXianGameController:setSelectObj(interactId)
	if self.selectInteractObjId and self.selectInteractObjId ~= interactId then
		self:dispatchEvent(YaXianEvent.OnCancelSelectInteract, self.selectInteractObjId)
	end

	self.selectInteractObjId = interactId

	if interactId ~= nil and interactId ~= 0 then
		self:dispatchEvent(YaXianEvent.OnSelectInteract, self.selectInteractObjId)
	end
end

function YaXianGameController:getSelectInteractId()
	return self.selectInteractObjId
end

function YaXianGameController:isSelectingPlayer()
	return self.selectInteractObjId and self.selectInteractObjId == YaXianGameModel.instance:getPlayerInteractMo().id
end

function YaXianGameController:autoSelectPlayer()
	self:setSelectObj(YaXianGameModel.instance:getPlayerInteractMo().id)
end

function YaXianGameController.sortInteractObjById(a, b)
	return a.id < b.id
end

function YaXianGameController:gameVictory()
	YaXianGameModel.instance:setResult(true)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Success)
	self:dispatchEvent(YaXianEvent.OnGameVictory)
end

function YaXianGameController:gameOver()
	YaXianGameModel.instance:setResult(false)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Fail)
	self:dispatchEvent(YaXianEvent.OnGameFail)
end

function YaXianGameController:posCanWalk(x, y)
	if YaXianGameModel.instance:isPosInChessBoard(x, y) and YaXianGameModel.instance:getBaseTile(x, y) ~= YaXianGameEnum.TileBaseType.None then
		return self:posObjCanWalk(x, y)
	end

	return false
end

function YaXianGameController:posObjCanWalk(x, y)
	local targetMoList = self:searchInteractByPos(x, y)

	for _, interactMo in ipairs(targetMoList) do
		if YaXianGameHelper.canBlock(interactMo.config) then
			return false
		end
	end

	return true
end

function YaXianGameController:getMoveTargetPos(param)
	local posX = param.posX
	local posY = param.posY
	local moveDirection = param.moveDirection
	local throughDistance = param.throughDistance
	local isHide = param.isHide
	local isBafflePos = param.isBafflePos
	local lastCanWalkPosX = param.lastCanWalkPosX
	local lastCanWalkPosY = param.lastCanWalkPosY
	local usedThrough = param.usedThrough

	if param.level then
		if not (param.level + 1) then
			local level = 1

			if usedThrough and not isBafflePos and self:posObjCanWalk(posX, posY) then
				return posX, posY, usedThrough
			end

			lastCanWalkPosX = lastCanWalkPosX or posX
			lastCanWalkPosY = lastCanWalkPosY or posY

			if level > 1 and not isHide and YaXianGameModel.instance:isAlertArea(lastCanWalkPosX, lastCanWalkPosY) then
				return lastCanWalkPosX, lastCanWalkPosY, usedThrough
			end

			if YaXianGameModel.instance:hasInteract(lastCanWalkPosX, lastCanWalkPosY) then
				return lastCanWalkPosX, lastCanWalkPosY, usedThrough
			end

			local nextPosX, nextPosY, curBaffleDirectionPowerPos, nextBaffleDirectionPowerPos

			if moveDirection == YaXianGameEnum.MoveDirection.Bottom then
				nextPosX = posX
				nextPosY = posY - 1
				curBaffleDirectionPowerPos = YaXianGameEnum.BaffleDirectionPowerPos.Bottom
				nextBaffleDirectionPowerPos = YaXianGameEnum.BaffleDirectionPowerPos.Top
			elseif moveDirection == YaXianGameEnum.MoveDirection.Left then
				nextPosX = posX - 1
				nextPosY = posY
				curBaffleDirectionPowerPos = YaXianGameEnum.BaffleDirectionPowerPos.Left
				nextBaffleDirectionPowerPos = YaXianGameEnum.BaffleDirectionPowerPos.Right
			elseif moveDirection == YaXianGameEnum.MoveDirection.Right then
				nextPosX = posX + 1
				nextPosY = posY
				curBaffleDirectionPowerPos = YaXianGameEnum.BaffleDirectionPowerPos.Right
				nextBaffleDirectionPowerPos = YaXianGameEnum.BaffleDirectionPowerPos.Left
			elseif moveDirection == YaXianGameEnum.MoveDirection.Top then
				nextPosX = posX
				nextPosY = posY + 1
				curBaffleDirectionPowerPos = YaXianGameEnum.BaffleDirectionPowerPos.Top
				nextBaffleDirectionPowerPos = YaXianGameEnum.BaffleDirectionPowerPos.Bottom
			else
				logError(string.format("un support direction, x : %s, y : %s, direction : %s", posX, posY, moveDirection))

				return lastCanWalkPosX, lastCanWalkPosY, usedThrough
			end

			if not YaXianGameModel.instance:isPosInChessBoard(nextPosX, nextPosY) then
				return lastCanWalkPosX, lastCanWalkPosY, usedThrough
			end

			if YaXianGameModel.instance:getBaseTile(nextPosX, nextPosY) == 0 then
				return lastCanWalkPosX, lastCanWalkPosY, usedThrough
			end

			if isBafflePos then
				if self:posObjCanWalk(nextPosX, nextPosY) then
					return nextPosX, nextPosY, usedThrough
				else
					return self:getMoveTargetPos({
						isBafflePos = false,
						posX = nextPosX,
						posY = nextPosY,
						moveDirection = moveDirection,
						throughDistance = throughDistance - 1,
						isHide = isHide,
						lastCanWalkPosX = lastCanWalkPosX,
						lastCanWalkPosY = lastCanWalkPosY,
						usedThrough = usedThrough,
						level = level
					})
				end
			end

			if YaXianGameHelper.hasBaffle(YaXianGameModel.instance:getBaseTile(posX, posY), curBaffleDirectionPowerPos) or YaXianGameHelper.hasBaffle(YaXianGameModel.instance:getBaseTile(nextPosX, nextPosY), nextBaffleDirectionPowerPos) then
				if throughDistance <= 0 then
					return lastCanWalkPosX, lastCanWalkPosY, usedThrough
				else
					return self:getMoveTargetPos({
						isBafflePos = true,
						usedThrough = true,
						posX = posX,
						posY = posY,
						moveDirection = moveDirection,
						throughDistance = throughDistance - 1,
						isHide = isHide,
						lastCanWalkPosX = lastCanWalkPosX,
						lastCanWalkPosY = lastCanWalkPosY,
						level = level
					})
				end
			elseif self:posObjCanWalk(nextPosX, nextPosY) then
				return self:getMoveTargetPos({
					isBafflePos = false,
					posX = nextPosX,
					posY = nextPosY,
					moveDirection = moveDirection,
					throughDistance = throughDistance,
					isHide = isHide,
					usedThrough = usedThrough,
					level = level
				})
			elseif throughDistance <= 0 then
				return lastCanWalkPosX, lastCanWalkPosY, usedThrough
			else
				return self:getMoveTargetPos({
					isBafflePos = false,
					usedThrough = true,
					posX = nextPosX,
					posY = nextPosY,
					moveDirection = moveDirection,
					throughDistance = throughDistance - 1,
					isHide = isHide,
					lastCanWalkPosX = lastCanWalkPosX,
					lastCanWalkPosY = lastCanWalkPosY,
					level = level
				})
			end
		end
	end
end

function YaXianGameController:getNearestScenePos(x, y)
	if not self.searchTree then
		return nil
	end

	local nodes = self.searchTree:search(x, y)
	local minDistance = 99999999
	local nearestNode
	local yWeight = YaXianGameEnum.ClickYWeight

	if nodes then
		for i = 1, #nodes do
			local node = nodes[i]
			local deltaX, deltaY = node.x - x, node.y - y

			if math.abs(deltaX) <= YaXianGameEnum.ClickRangeX and math.abs(deltaY) <= YaXianGameEnum.ClickRangeY then
				local tmpDist = deltaX * deltaX + deltaY * deltaY * yWeight

				if tmpDist < minDistance then
					nearestNode = node
					minDistance = tmpDist
				end
			end
		end
	end

	if nearestNode then
		return nearestNode.tileX, nearestNode.tileY
	else
		return nil
	end
end

function YaXianGameController:getInteractStatusPool()
	self.interactStatusPool = self.interactStatusPool or LuaObjPool.New(16, YaXianGameStatusMo.NewFunc, YaXianGameStatusMo.releaseFunc, YaXianGameStatusMo.resetFunc)

	return self.interactStatusPool
end

function YaXianGameController:stopRunningStep()
	if self.stepMgr then
		self.stepMgr:disposeAllStep()
	end
end

function YaXianGameController:playEffectAudio(audioId)
	if not audioId or audioId == 0 then
		return
	end

	self.lastPlayTimeDict = self.lastPlayTimeDict or {}

	local lastPlayTime = self.lastPlayTimeDict[audioId]
	local now = Time.realtimeSinceStartup

	if not lastPlayTime or now - lastPlayTime >= YaXianGameEnum.EffectInterval then
		AudioMgr.instance:trigger(audioId)

		self.lastPlayTimeDict[audioId] = now
	end
end

YaXianGameController.instance = YaXianGameController.New()

return YaXianGameController
