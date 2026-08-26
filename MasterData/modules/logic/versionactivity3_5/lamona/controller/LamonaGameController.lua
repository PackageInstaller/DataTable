-- chunkname: @modules/logic/versionactivity3_5/lamona/controller/LamonaGameController.lua

module("modules.logic.versionactivity3_5.lamona.controller.LamonaGameController", package.seeall)

local LamonaGameController = class("LamonaGameController", BaseController)

function LamonaGameController:onInit()
	return
end

function LamonaGameController:onInitFinish()
	return
end

function LamonaGameController:addConstEvents()
	return
end

function LamonaGameController:reInit()
	return
end

function LamonaGameController:enterGame(episodeId, gameId)
	local curGameId = LamonaGameModel.instance:getGameId()

	if curGameId or not episodeId or not gameId then
		return
	end

	LamonaGameModel.instance:onEnterGame(episodeId, gameId)
	ViewMgr.instance:openView(ViewName.LamonaGameView)
	self:dispatchEvent(LamonaEvent.GuideOnEnterGame, episodeId)
end

function LamonaGameController:resetGame()
	local curEpisodeId = LamonaGameModel.instance:getGameEpisodeId()
	local curGameId = LamonaGameModel.instance:getGameId()

	LamonaGameModel.instance:onEnterGame(curEpisodeId, curGameId)
	self:dispatchEvent(LamonaEvent.RefreshGame)
end

function LamonaGameController:exitGame()
	LamonaGameModel.instance:clearAllData()
end

function LamonaGameController:rollbackGame()
	local gameInfo = LamonaGameModel.instance:popLastSaveGameInfo()

	if not gameInfo then
		return
	end

	LamonaGameModel.instance:setGhostMoveTurn()
	LamonaGameModel.instance:setRound(gameInfo.round)
	LamonaGameModel.instance:setPropCount(gameInfo.propCount)
	LamonaGameModel.instance:setCaughtGhostCount(gameInfo.caughtGhostCount)
	LamonaGameModel.instance:loadUnitInfos(gameInfo.unitInfoDict)
	self:dispatchEvent(LamonaEvent.RefreshGame)
end

function LamonaGameController:_saveGame()
	local gameId = LamonaGameModel.instance:getGameId()

	if not gameId then
		return
	end

	local isGameEnd = LamonaGameModel.instance:getIsGameEnd()

	if isGameEnd then
		return
	end

	LamonaGameModel.instance:saveGameInfo()
end

function LamonaGameController:_addGameRound()
	LamonaGameModel.instance:addRound()
	self:_checkGameEnd()
	self:dispatchEvent(LamonaEvent.OnAddRound)
end

function LamonaGameController:_checkGameEnd()
	local alreadyEnd = LamonaGameModel.instance:getIsGameEnd()

	if alreadyEnd then
		return
	end

	local round = LamonaGameModel.instance:getRound()
	local maxRound = LamonaConfig.instance:getLamonaConst(LamonaEnum.ConstId.MaxRound, false, true)
	local caughtCount = LamonaGameModel.instance:getCaughtGhostCount()
	local targetCount = LamonaGameModel.instance:getTargetGhostCount()

	if targetCount <= caughtCount or maxRound <= round then
		LamonaGameModel.instance:setGameEnd()

		local episodeId = LamonaGameModel.instance:getGameEpisodeId()
		local gameId = LamonaGameModel.instance:getGameId()

		ViewMgr.instance:openView(ViewName.LamonaResultView, {
			episodeId = episodeId,
			gameId = gameId,
			caughtCount = caughtCount,
			targetCount = targetCount
		})
	end
end

function LamonaGameController:playerMove(direction)
	if not direction then
		return
	end

	local isPlayerTurn = LamonaGameModel.instance:getIsPlayerTurn()

	if not isPlayerTurn then
		return
	end

	local playerMO = LamonaGameModel.instance:getPlayerMO()

	if not playerMO then
		return
	end

	local isCanPlace = false
	local playerUid = playerMO:getUid()
	local curGridX, curGridY = playerMO:getGridXY()
	local targetGridX = curGridX + (LamonaEnum.DirChangeGridX[direction] or 0)
	local targetGridY = curGridY + (LamonaEnum.DirChangeGridY[direction] or 0)
	local canCatchGhostUids = {}
	local allGhostUids = LamonaGameModel.instance:getUnitUidsInGrid(targetGridX, targetGridY, LamonaEnum.UnitType.Ghost)

	if allGhostUids and #allGhostUids <= 0 then
		isCanPlace = LamonaGameModel.instance:getIsCanPlaceUnitInGrid(playerUid, targetGridX, targetGridY)
	else
		for _, ghostUid in ipairs(allGhostUids) do
			local ghostMO = LamonaGameModel.instance:getUnitByUid(ghostUid)

			if ghostMO and not ghostMO:getIsCaught() then
				canCatchGhostUids[#canCatchGhostUids + 1] = ghostUid
			end
		end
	end

	local canCatchGhostCount = #canCatchGhostUids
	local hasGhostCanCatch = canCatchGhostCount > 0

	if isCanPlace or hasGhostCanCatch then
		self:_saveGame()
		playerMO:setDirection(direction)

		if hasGhostCanCatch then
			local caughtCount = LamonaGameModel.instance:getCaughtGhostCount()

			LamonaGameModel.instance:setCaughtGhostCount(caughtCount + canCatchGhostCount)

			for _, ghostUid in ipairs(canCatchGhostUids) do
				local ghostMO = LamonaGameModel.instance:getUnitByUid(ghostUid)

				if ghostMO then
					ghostMO:setIsCaught(true)
				end
			end

			self:dispatchEvent(LamonaEvent.CatchGhosts, canCatchGhostUids)
		else
			local result = self:trySetUnit2Grid(playerUid, targetGridX, targetGridY)

			if result then
				self:_checkHasGhostMove()
				AudioMgr.instance:trigger(AudioEnum3_5.Lamona.play_ui_lusongshi_lmn_move1)
			end
		end

		self:_addGameRound()
		self.dispatchEvent(self, LamonaEvent.PlayUnitMove, playerUid, self._onPlayerMoveEnd, self)
	else
		playerMO:setDirection(direction)
		self:dispatchEvent(LamonaEvent.PlayUnitMove, playerUid)
	end
end

function LamonaGameController:_checkHasGhostMove()
	local playerMO = LamonaGameModel.instance:getPlayerMO()

	if not playerMO then
		return
	end

	local playerX, playerY = playerMO:getGridXY()
	local hasGhostMove = false
	local ghostMODict = LamonaGameModel.instance:getUnitDictByType(LamonaEnum.UnitType.Ghost) or {}

	for _, mo in pairs(ghostMODict) do
		local stepX = 0
		local stepY = 0
		local absDist = 0
		local ghostX, ghostY = mo:getGridXY()

		if ghostX == playerX then
			local dist = playerY - ghostY

			stepY = dist > 0 and 1 or -1
			absDist = math.abs(dist)
		elseif ghostY == playerY then
			local dist = playerX - ghostX

			stepX = dist > 0 and 1 or -1
			absDist = math.abs(dist)
		end

		local willMoving = false
		local viewRange = mo:getAttrValue(LamonaEnum.UnitAttrKey.ViewRange)
		local stepCount = mo:getAttrValue(LamonaEnum.UnitAttrKey.Step)

		if absDist > 0 and absDist <= viewRange and stepCount > 0 then
			willMoving = true

			for i = 1, absDist - 1 do
				local checkX = ghostX + i * stepX
				local checkY = ghostY + i * stepY
				local hasObstacle = LamonaGameModel.instance:getHasUnityTypeInGrid(checkX, checkY, LamonaEnum.UnitType.Obstacle)

				if hasObstacle then
					willMoving = false

					break
				end
			end
		end

		if willMoving then
			local ghostDir = mo:getDirection()
			local nextDir = self:_findGhostNextStepDir(viewRange, ghostX, ghostY, ghostDir, playerX, playerY)

			if nextDir then
				mo:setIsMoving(true)

				hasGhostMove = true
			end
		end
	end

	LamonaGameModel.instance:setGhostMoveTurn(hasGhostMove)
end

function LamonaGameController:_onPlayerMoveEnd()
	self:dispatchEvent(LamonaEvent.PlayGhostShockBeforeMove)
end

function LamonaGameController:beginGhostMove()
	self:_ghostMoveNextStep()
end

function LamonaGameController:_ghostMoveNextStep()
	local isGhostMoveTurn = LamonaGameModel.instance:getIsGhostMoveTurn()

	if not isGhostMoveTurn then
		return
	end

	local playerMO = LamonaGameModel.instance:getPlayerMO()

	if not playerMO then
		return
	end

	local playerX, playerY = playerMO:getGridXY()
	local moveGhostUidList = {}
	local ghostMODict = LamonaGameModel.instance:getUnitDictByType(LamonaEnum.UnitType.Ghost) or {}

	for _, mo in pairs(ghostMODict) do
		local isMoving = mo:getIsMoving()

		if isMoving then
			local uid = mo:getUid()
			local viewRange = mo:getAttrValue(LamonaEnum.UnitAttrKey.ViewRange)
			local ghostX, ghostY = mo:getGridXY()
			local ghostDir = mo:getDirection()
			local nextDir = self:_findGhostNextStepDir(viewRange, ghostX, ghostY, ghostDir, playerX, playerY)

			if nextDir then
				mo:setDirection(nextDir)

				local nextX = ghostX + (LamonaEnum.DirChangeGridX[nextDir] or 0)
				local nextY = ghostY + (LamonaEnum.DirChangeGridY[nextDir] or 0)
				local result = self:trySetUnit2Grid(uid, nextX, nextY)

				if result then
					self:_checkPropEffectGhost(uid)
				end

				mo:addHaveMovedStep()
				table.insert(moveGhostUidList, uid)
			end

			local haveMovedSteps = mo:getHaveMovedSteps()
			local stepCount = mo:getAttrValue(LamonaEnum.UnitAttrKey.Step)

			if not nextDir or stepCount <= haveMovedSteps then
				mo:setIsMoving(false)
				mo:setPropTempImpacted()
				self:_checkPropEffectGhost(uid)

				if not nextDir then
					self:dispatchEvent(LamonaEvent.OnGhostMoveEnd, uid)
				end
			end
		end
	end

	if #moveGhostUidList <= 0 then
		LamonaGameModel.instance:setGhostMoveTurn(false)
	else
		self.dispatchEvent(self, LamonaEvent.PlayUnitListMove, moveGhostUidList, self._ghostMoveNextStep, self)
	end
end

function LamonaGameController:_findGhostNextStepDir(viewRange, ghostX, ghostY, ghostDir, playerX, playerY)
	if ghostX == playerX and ghostY == playerY then
		return
	end

	local dirHasPlayer

	if ghostX == playerX then
		local dy = playerY - ghostY

		if viewRange >= math.abs(dy) then
			dirHasPlayer = dy > 0 and LamonaEnum.Direction.Up or LamonaEnum.Direction.Down
		end
	elseif ghostY == playerY then
		local dx = playerX - ghostX

		if viewRange >= math.abs(dx) then
			dirHasPlayer = dx > 0 and LamonaEnum.Direction.Right or LamonaEnum.Direction.Left
		end
	end

	local maxObsDist = -1
	local dir2ObstacleDistant = {}
	local backDir = LamonaEnum.OppositeDir[ghostDir]
	local mapWidth, mapHeight = LamonaGameModel.instance:getMapSize()

	for _, dir in ipairs(LamonaEnum.DirOrderClock) do
		if dir ~= dirHasPlayer and dir ~= backDir then
			if not LamonaEnum.DirChangeGridX[dir] then
				local dx = 0

				if not LamonaEnum.DirChangeGridY[dir] then
					local dy = 0
					local firstObsDist = viewRange + 1

					for i = 1, viewRange do
						local cx = ghostX + dx * i
						local cy = ghostY + dy * i
						local isOutside = LamonaHelper.isOutsizeMap(cx, cy, mapWidth, mapHeight)
						local hasObstacle = LamonaGameModel.instance:getHasUnityTypeInGrid(cx, cy, LamonaEnum.UnitType.Obstacle)

						if isOutside or hasObstacle then
							firstObsDist = i

							break
						end
					end

					if firstObsDist > 1 then
						if maxObsDist < firstObsDist then
							maxObsDist = firstObsDist
						end

						dir2ObstacleDistant[dir] = firstObsDist
					end
				end
			end
		end
	end

	if not next(dir2ObstacleDistant) then
		if backDir == dirHasPlayer then
			return
		else
			return backDir
		end
	end

	local bestDirDict = {}

	for d, dist in pairs(dir2ObstacleDistant) do
		if dist == maxObsDist then
			bestDirDict[d] = true
		end
	end

	local awayDir = dirHasPlayer and LamonaEnum.OppositeDir[dirHasPlayer]

	if awayDir and bestDirDict[awayDir] then
		return awayDir
	end

	if ghostDir and bestDirDict[ghostDir] then
		return ghostDir
	end

	for _, dirInClock in ipairs(LamonaEnum.DirOrderClock) do
		if bestDirDict[dirInClock] then
			return dirInClock
		end
	end
end

function LamonaGameController:_checkPropEffectGhost(ghostUid)
	local ghostMO = LamonaGameModel.instance:getUnitByUid(ghostUid)
	local targetType = ghostMO and ghostMO:getType()

	if targetType ~= LamonaEnum.UnitType.Ghost then
		return
	end

	local needRemovePropUidList = {}
	local ghostX, ghostY = ghostMO:getGridXY()
	local propMODict = LamonaGameModel.instance:getUnitDictByType(LamonaEnum.UnitType.Prop) or {}

	for propUid, propMO in pairs(propMODict) do
		local propX, propY = propMO:getGridXY()
		local effectRange = propMO:getAttrValue(LamonaEnum.UnitAttrKey.EffectRange)
		local dx = math.abs(ghostX - propX)
		local dy = math.abs(ghostY - propY)
		local isInRange = effectRange >= dx + dy

		if isInRange then
			local result = self:_tryAddPropEffect(ghostMO, propMO)

			if result then
				local propId = propMO:getId()
				local needRemove = LamonaConfig.instance:getLamonaUnitRemoveAfterEffect(propId)

				if needRemove then
					needRemovePropUidList[#needRemovePropUidList + 1] = propUid
				end
			end
		end
	end

	for _, propUid in ipairs(needRemovePropUidList) do
		self:removeUnit(propUid)
	end
end

function LamonaGameController:_tryAddPropEffect(ghostMO, propMO)
	if not ghostMO or not propMO then
		return
	end

	local result = false
	local ghostUid = ghostMO:getUid()
	local propUid = propMO:getUid()
	local propId = propMO:getId()
	local hasImpacted = ghostMO:getPropHasAlreadyImpacted(propUid)
	local changeAttrList = LamonaConfig.instance:getLamonaUnitChangeGhostAttrs(propId)

	if not hasImpacted and changeAttrList and #changeAttrList > 0 then
		for _, strChange in ipairs(changeAttrList) do
			local arr = string.split(strChange, "#")
			local attrKey = arr[1]
			local hasAttr = ghostMO:getHasAttr(attrKey)

			if not hasAttr then
				return
			end

			local attrValue = ghostMO:getAttrValue(attrKey)
			local changeValue = tonumber(arr[2]) or 0

			ghostMO:setAttrValue(attrKey, attrValue + changeValue)
		end

		ghostMO:addPropImpacted(propUid, propId)

		result = true

		self:dispatchEvent(LamonaEvent.OnGhostAddPropEffect, ghostUid, propId)
	end

	local changeTempAttrList = LamonaConfig.instance:getLamonaUnitChangeGhostTempAttrs(propId)
	local tempImpactedPropUid = ghostMO:getTempImpactedProp()

	if tempImpactedPropUid ~= propUid and changeTempAttrList and #changeTempAttrList > 0 then
		local tempAttrChangeDict = {}

		for _, strChange in ipairs(changeTempAttrList) do
			local arr = string.split(strChange, "#")
			local attrKey = arr[1]

			tempAttrChangeDict[attrKey] = tonumber(arr[2]) or 0
		end

		ghostMO:setPropTempImpacted(propUid, propId, tempAttrChangeDict)
		self:dispatchEvent(LamonaEvent.OnGhostAddPropEffect, ghostUid, propId)

		result = true
	end

	return result
end

function LamonaGameController:playerUseProp()
	local isPlayerTurn = LamonaGameModel.instance:getIsPlayerTurn()

	if not isPlayerTurn then
		return
	end

	local playerMO = LamonaGameModel.instance:getPlayerMO()

	if not playerMO then
		return
	end

	local propCount = LamonaGameModel.instance:getPropCount()

	if propCount <= 0 then
		GameFacade.showToast(ToastEnum.LamonaNotEnoughProp)

		return
	end

	self:_saveGame()

	local playerX, playerY = playerMO:getGridXY()
	local gameId = LamonaGameModel.instance:getGameId()
	local propId = LamonaConfig.instance:getLamonaPropId(gameId)

	if not propId or propId == 0 then
		return
	end

	local attrDict = {}
	local attrStrList = LamonaConfig.instance:getLamonaUnitAttrList(propId)

	for _, attrStr in ipairs(attrStrList) do
		local attrData = string.split(attrStr, "#")
		local attrKey = attrData[1]

		attrDict[attrKey] = tonumber(attrData[2])
	end

	self:addUnit(propId, {
		x = playerX,
		y = playerY,
		attrDict = attrDict
	})
	LamonaGameModel.instance:setPropCount(propCount - 1)
	GameFacade.showToast(ToastEnum.LamonaUseProp)
	self:_addGameRound()
	self:dispatchEvent(LamonaEvent.OnUseProp)
end

function LamonaGameController:trySetUnit2Grid(uid, targetGridX, targetGridY)
	local isCanPlace = LamonaGameModel.instance:getIsCanPlaceUnitInGrid(uid, targetGridX, targetGridY)

	if isCanPlace then
		LamonaGameModel.instance:setUnitGrid(uid, targetGridX, targetGridY)
	end

	return isCanPlace
end

function LamonaGameController:addUnit(id, info)
	local mo = LamonaGameModel.instance:addUnitMO(id, info)

	if not mo then
		return
	end

	local uid = mo:getUid()

	self:dispatchEvent(LamonaEvent.AddUnit, uid)
end

function LamonaGameController:removeUnit(uid)
	LamonaGameModel.instance:removeUnitMO(uid)
	self:dispatchEvent(LamonaEvent.RemoveUnit, uid)
end

LamonaGameController.instance = LamonaGameController.New()

return LamonaGameController
