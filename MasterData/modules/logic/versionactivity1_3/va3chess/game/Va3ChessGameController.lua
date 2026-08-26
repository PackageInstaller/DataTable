-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/Va3ChessGameController.lua

module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessGameController", package.seeall)

local Va3ChessGameController = class("Va3ChessGameController", BaseController)

function Va3ChessGameController:onInit()
	return
end

function Va3ChessGameController:reInit()
	return
end

function Va3ChessGameController:_registerGameController()
	return {
		[Va3ChessEnum.ActivityId.Act122] = Activity1_3ChessGameController.instance
	}
end

function Va3ChessGameController:_getActiviyXGameControllerIns(actId)
	if not self._actXGameCtlInsMap then
		self._actXGameCtrlInsMap = self:_registerGameController()
	end

	return self._actXGameCtrlInsMap[actId]
end

function Va3ChessGameController:release()
	if self.interacts then
		self.interacts:removeAll()
	end

	if self.event then
		self.event:removeAll()
	end

	self._treeComp = nil
	self.interacts = nil
	self.event = nil
	self._hasMap = false
end

function Va3ChessGameController:setViewName(value)
	if value then
		self._viewName = value
	end
end

function Va3ChessGameController:getViewName()
	return self._viewName or ViewName.Va3ChessGameScene
end

function Va3ChessGameController:enterChessGame(actId, mapId, viewName)
	logNormal("Va3ChessGameController : enterChessGame!")

	local episodeId = Va3ChessModel.instance:getEpisodeId()

	GuideController.instance:dispatchEvent(GuideEvent["OnChessEnter" .. episodeId])
	self:initData(actId, mapId)

	self._viewName = viewName or self._viewName

	ViewMgr.instance:openView(self._viewName, self:packViewParam())
end

function Va3ChessGameController:packViewParam()
	return {
		fromRefuseBattle = Va3ChessController.instance:getFromRefuseBattle()
	}
end

function Va3ChessGameController:initData(actId, mapId)
	self._treeComp = Va3ChessGameTree.New()

	Va3ChessGameModel.instance:initData(actId, mapId)

	self._tempSelectObjId = nil

	local mapCO = Va3ChessConfig.instance:getMapCo(actId, mapId)

	if mapCO and not string.nilorempty(mapCO.offset) then
		local offsetArr = string.splitToNumber(mapCO.offset, ",")

		self._cacheOffsetX = offsetArr[1]
		self._cacheOffsetY = offsetArr[2]
	else
		self._cacheOffsetX = nil
		self._cacheOffsetY = nil
	end
end

function Va3ChessGameController:initServerMap(actId, map)
	if map.mapId then
		Va3ChessGameModel.instance:initData(actId, map.mapId)
	end

	Va3ChessGameModel.instance:setRound(map.currentRound)
	Va3ChessGameModel.instance:setHp(map.hp)
	Va3ChessGameModel.instance:setFinishedTargetNum(map.targetNum)
	Va3ChessGameModel.instance:setResult(nil)
	Va3ChessGameModel.instance:setFireBallCount(map.fireballNum)
	Va3ChessGameModel.instance:updateFinishInteracts(map.finishInteracts)
	Va3ChessGameModel.instance:updateAllFinishInteracts(map.allFinishInteracts)

	if map.fragileTilebases then
		Va3ChessGameModel.instance:updateFragileTilebases(actId, map.fragileTilebases)
	end

	if map.brokenTilebases then
		Va3ChessGameModel.instance:updateBrokenTilebases(actId, map.brokenTilebases)
	end

	self:setClickStatus(Va3ChessEnum.SelectPosStatus.None)

	self._selectObj = nil

	self:setSelectObj(nil)

	self.interacts = self.interacts or Va3ChessInteractMgr.New()

	self.interacts:removeAll()
	Va3ChessGameModel.instance:initObjects(actId, map.interactObjects or map.id2Interact)

	if map.brazierIds then
		Va3ChessGameModel.instance:updateLightUpBrazier(actId, map.brazierIds)
	end

	self:initObjects()

	self.event = self.event or Va3ChessEventMgr.New()

	self.event:removeAll()
	self.event:setCurEvent(map.currentEvent)
	self:onInitServerMap(actId, map)

	self._hasMap = true
end

function Va3ChessGameController:isNeedBlock()
	if self.event and self.event:isNeedBlock() then
		return true
	end

	return false
end

function Va3ChessGameController:onInitServerMap(actId, mapData)
	local gameCtrl = self:_getActiviyXGameControllerIns(actId)

	if gameCtrl and gameCtrl.onInitServerMap then
		gameCtrl:onInitServerMap(mapData)
	end
end

function Va3ChessGameController:updateServerMap(actId, mapData)
	local gameCtrl = self:_getActiviyXGameControllerIns(actId)

	if gameCtrl and gameCtrl.onUpdateServerMap then
		gameCtrl:onUpdateServerMap(mapData)
	end
end

function Va3ChessGameController:initObjects()
	local objList = Va3ChessGameModel.instance:getInteractDatas()

	for _, originData in ipairs(objList) do
		local interactObj = Va3ChessInteractObject.New()

		interactObj:init(originData)

		if interactObj.config ~= nil then
			self.interacts:add(interactObj)
		end
	end

	self:onInitObjects()

	local interactList = self.interacts:getList()

	for _, interact in ipairs(interactList) do
		interact.goToObject:init()
	end

	self:dispatchEvent(Va3ChessEvent.AllObjectCreated)
end

function Va3ChessGameController:onInitObjects()
	local actId = Va3ChessModel.instance:getActId()
	local gameCtrl = self:_getActiviyXGameControllerIns(actId)

	if gameCtrl and gameCtrl.onInitObjects then
		gameCtrl:onInitObjects()
	end
end

function Va3ChessGameController:initSceneTree(goTouch, offsetSceneY)
	self._treeSceneComp = Va3ChessGameTree.New()
	self._offsetSceneY = offsetSceneY

	local treeRoot = self._treeSceneComp:createLeaveNode()
	local w, h = Va3ChessGameModel.instance:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local node = {}
			local tmpX, tmpY, tmpZ = self:calcTilePosInScene(x - 1, y - 1)
			local pos = recthelper.worldPosToAnchorPos(Vector3.New(tmpX, tmpY + offsetSceneY, 0), goTouch.transform)

			node.x, node.y = pos.x, pos.y
			node.tileX, node.tileY = x - 1, y - 1

			table.insert(treeRoot.nodes, node)

			treeRoot.keys = node
		end
	end

	self._treeSceneComp:growToBranch(treeRoot)
	self._treeSceneComp:buildTree(treeRoot)
end

function Va3ChessGameController:calcTilePosInScene(tileX, tileY, offsetOrder, calcPosZByPosXY)
	local setting = Va3ChessEnum.TileShowSettings

	if not self._cacheOffsetX then
		local cacheOffsetX = Va3ChessEnum.ChessBoardOffsetX

		if not self._cacheOffsetY then
			local cacheOffsetY = Va3ChessEnum.ChessBoardOffsetY
			local x = tileX * setting.width + setting.offsetX * tileY + setting.offsetXY * (tileX + tileY) + cacheOffsetX
			local y = tileY * setting.height + setting.offsetY * tileX + setting.offsetYX * (tileX + tileY) + cacheOffsetY

			x = x * 0.01
			y = y * 0.01

			local offsetZ = (offsetOrder or 0) * 0.001

			return x, y, calcPosZByPosXY and self:getPosZ(tileX, tileY) + offsetZ or y * 0.001 + offsetZ
		end
	end
end

function Va3ChessGameController:getPosZ(posX, posY)
	local w, h = Va3ChessGameModel.instance:getGameSize()
	local xRate = posX / w
	local xOffsetZ = Mathf.Lerp(Va3ChessEnum.ScenePosZRange.Min, Va3ChessEnum.ScenePosZRange.Max, xRate)
	local yRate = posY / h
	local yOffsetZ = Mathf.Lerp(Va3ChessEnum.ScenePosZRange.Max, Va3ChessEnum.ScenePosZRange.Min, yRate)

	return xOffsetZ + yOffsetZ
end

function Va3ChessGameController:getOffsetSceneY()
	return self._offsetSceneY
end

function Va3ChessGameController:addInteractObj(interactData)
	local interactObj = Va3ChessInteractObject.New()

	interactObj:init(interactData)
	self.interacts:add(interactObj)
	interactObj.goToObject:init()
	self:dispatchEvent(Va3ChessEvent.AddInteractObj, interactObj)
end

function Va3ChessGameController:deleteInteractObj(id)
	self.interacts:remove(id)
	self:dispatchEvent(Va3ChessEvent.DeleteInteractObj, id)
end

function Va3ChessGameController:searchInteractByPos(x, y, filterFunc)
	local list = self.interacts:getList()
	local targetObj, targetObjList
	local count = 0

	for _, interactObj in ipairs(list) do
		if interactObj.originData.posX == x and interactObj.originData.posY == y and (not filterFunc or filterFunc(interactObj)) then
			if targetObj ~= nil then
				targetObjList = targetObjList or {
					targetObj
				}

				table.insert(targetObjList, interactObj)
			else
				targetObj = interactObj
			end

			count = count + 1
		end
	end

	if count > 1 then
		table.sort(targetObjList, Va3ChessGameController.sortSelectObj)
	end

	return count, targetObjList or targetObj
end

function Va3ChessGameController.sortSelectObj(a, b)
	return a:getSelectPriority() < b:getSelectPriority()
end

function Va3ChessGameController.filterSelectable(targetObj)
	return targetObj.config and (targetObj.config.interactType == Va3ChessEnum.InteractType.Player or targetObj.config.interactType == Va3ChessEnum.InteractType.AssistPlayer)
end

function Va3ChessGameController:existGame()
	return self._hasMap
end

function Va3ChessGameController:setSelectObj(selectObj)
	if self._selectObj == selectObj then
		return
	end

	if self._selectObj ~= nil then
		self._selectObj:onCancelSelect()
	end

	self._selectObj = selectObj

	if selectObj ~= nil then
		selectObj:onSelected()
	end
end

function Va3ChessGameController:forceRefreshObjSelectedView()
	if self._selectObj ~= nil then
		self._selectObj:onSelected()
	end
end

function Va3ChessGameController:saveTempSelectObj()
	if self._selectObj then
		self._tempSelectObjId = self._selectObj.id
	end
end

function Va3ChessGameController:isTempSelectObj(id)
	return self._tempSelectObjId == id
end

function Va3ChessGameController:tryResumeSelectObj()
	if self.interacts and self._tempSelectObjId then
		local obj = self.interacts:get(self._tempSelectObjId)

		if obj then
			self:setSelectObj(obj)

			self._tempSelectObjId = nil

			return true
		end
	end

	self:autoSelectPlayer(true)

	return false
end

function Va3ChessGameController:refreshAllInteractKillEff()
	local interactList = self.interacts:getList()

	for _, interact in ipairs(interactList) do
		if interact and interact.chessEffectObj and interact.chessEffectObj.refreshKillEffect then
			interact.chessEffectObj:refreshKillEffect()
		end
	end
end

function Va3ChessGameController:syncServerMap()
	local actId = Va3ChessGameModel.instance:getActId()
	local mapId = Va3ChessGameModel.instance:getMapId()

	self._tempInteractMgr = self.interacts
	self._tempEventMgr = self.event

	if actId and mapId then
		self.interacts = nil
		self.event = nil

		Va3ChessGameModel.instance:release()
		Va3ChessGameModel.instance:initData(actId, mapId)
		Va3ChessRpcController.instance:sendGetActInfoRequest(actId, self.onReceiveWhenSync, self)
		self:dispatchEvent(Va3ChessEvent.ResetMapView)
	end
end

function Va3ChessGameController:onReceiveWhenSync(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	local actId = Va3ChessGameModel.instance:getActId()
	local mapId = Va3ChessGameModel.instance:getMapId()

	if actId and mapId then
		if self._tempInteractMgr then
			self._tempInteractMgr:dispose()

			self._tempInteractMgr = nil
		end

		if self._tempEventMgr then
			self._tempEventMgr:removeAll()

			self._tempEventMgr = nil
		end

		self:initData(actId, mapId)
		self:initObjects()
	end
end

function Va3ChessGameController:getSelectObj()
	return self._selectObj
end

function Va3ChessGameController:setClickStatus(status)
	self._clickStatus = status
end

function Va3ChessGameController:getClickStatus()
	return self._clickStatus
end

function Va3ChessGameController:autoSelectPlayer(includeAssistPlayer)
	if not self.interacts then
		return
	end

	local list = self.interacts:getList()

	if not list then
		return
	end

	local players = {}

	for _, interact in pairs(list) do
		if interact.config then
			if not interact.config.interactType then
				local interactType
				local isPlayer = interactType == Va3ChessEnum.InteractType.Player
				local isAddIncludeAssistPlayer = includeAssistPlayer and interactType == Va3ChessEnum.InteractType.AssistPlayer

				if isPlayer or isAddIncludeAssistPlayer then
					table.insert(players, interact)
				end
			end
		end
	end

	table.sort(players, Va3ChessGameController.sortInteractObjById)

	if #players > 0 then
		self:setSelectObj(players[1])
	end
end

function Va3ChessGameController.sortInteractObjById(a, b)
	local aType = a.config.interactType
	local bType = b.config.interactType

	if aType ~= bType then
		return aType < bType
	end

	return a.id < b.id
end

function Va3ChessGameController:gameClear()
	Va3ChessGameModel.instance:setResult(true)
	self:dispatchEvent(Va3ChessEvent.SetViewVictory)
	self:dispatchEvent(Va3ChessEvent.CurrentConditionUpdate)
end

function Va3ChessGameController:gameOver()
	Va3ChessGameModel.instance:setResult(false)
	self:dispatchEvent(Va3ChessEvent.SetViewFail)
	self:dispatchEvent(Va3ChessEvent.CurrentConditionUpdate)
end

function Va3ChessGameController:posCanWalk(x, y, fromDir, walkObjType)
	local result = false

	if not Va3ChessGameModel.instance:isPosInChessBoard(x, y) then
		return result
	end

	local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)

	if not tileMO or tileMO.tileType == Va3ChessEnum.TileBaseType.None then
		return result
	end

	local isFinishTriggerPoSui = tileMO:isFinishTrigger(Va3ChessEnum.TileTrigger.PoSui)
	local isFinishTriggerBroken = tileMO:isFinishTrigger(Va3ChessEnum.TileTrigger.Broken)

	if not isFinishTriggerPoSui and not isFinishTriggerBroken then
		local isBaffleBlock = self:isBaffleBlock(x, y, fromDir)

		if not isBaffleBlock then
			result = self:posObjCanWalk(x, y, fromDir, walkObjType)
		end
	end

	return result
end

function Va3ChessGameController:getPlayerNextCanWalkPosDict()
	local result = {}
	local mainPlayer = self.interacts and self.interacts:getMainPlayer(true) or nil

	if not mainPlayer then
		return result
	end

	local x, y = mainPlayer.originData.posX, mainPlayer.originData.posY
	local nextPosList = {
		{
			x = x,
			y = y + 1
		},
		{
			x = x,
			y = y - 1
		},
		{
			x = x - 1,
			y = y
		},
		{
			x = x + 1,
			y = y
		}
	}

	for _, nextPos in ipairs(nextPosList) do
		local dir = Va3ChessMapUtils.ToDirection(x, y, nextPos.x, nextPos.y)

		if self:posCanWalk(nextPos.x, nextPos.y, dir, mainPlayer.objType) then
			local posHashKey = Activity142Helper.getPosHashKey(nextPos.x, nextPos.y)

			result[posHashKey] = true
		end
	end

	return result
end

function Va3ChessGameController:isBaffleBlock(x, y, fromDir)
	local result = false
	local preX, preY, baffleBlockDir

	if fromDir == Va3ChessEnum.Direction.Down then
		preX = x
		preY = y + 1
		baffleBlockDir = Va3ChessEnum.Direction.Up
	elseif fromDir == Va3ChessEnum.Direction.Left then
		preX = x + 1
		preY = y
		baffleBlockDir = Va3ChessEnum.Direction.Right
	elseif fromDir == Va3ChessEnum.Direction.Right then
		preX = x - 1
		preY = y
		baffleBlockDir = Va3ChessEnum.Direction.Left
	elseif fromDir == Va3ChessEnum.Direction.Up then
		preX = x
		preY = y - 1
		baffleBlockDir = Va3ChessEnum.Direction.Down
	else
		logError(string.format("Va3ChessGameController:isBaffleBlock error, un support direction, x : %s, y : %s, direction : %s", x, y, fromDir))

		return result
	end

	local preTileMO = Va3ChessGameModel.instance:getTileMO(preX, preY)
	local tileMO = Va3ChessGameModel.instance:getTileMO(x, y)

	result = (preTileMO or nil) and preTileMO:isHasBaffleInDir(fromDir) or (tileMO or nil) and tileMO:isHasBaffleInDir(baffleBlockDir)

	return result
end

function Va3ChessGameController:posObjCanWalk(x, y, fromDir, walkObjType)
	local len, rs = self:searchInteractByPos(x, y)

	if len == 1 then
		if rs then
			if rs:canBlock(fromDir, walkObjType) then
				return false
			else
				local params = {
					dir = fromDir,
					objType = walkObjType
				}

				rs:showStateView(Va3ChessEnum.ObjState.Interoperable, params)
			end
		end
	elseif len > 1 then
		for i = 1, len do
			if rs[i] then
				if rs[i]:canBlock(fromDir, walkObjType) then
					return false
				else
					local params = {
						dir = fromDir,
						objType = walkObjType
					}

					rs[i]:showStateView(Va3ChessEnum.ObjState.Interoperable, params)
				end
			end
		end
	else
		return true
	end

	return true
end

function Va3ChessGameController:resetObjStateOnNewRound()
	local interactList = self.interacts:getList()

	for _, interactObj in ipairs(interactList) do
		interactObj:showStateView(Va3ChessEnum.ObjState.Idle)
	end
end

function Va3ChessGameController:getNearestScenePos(x, y)
	if not self._treeSceneComp then
		return nil
	end

	local nodes = self._treeSceneComp:search(x, y)
	local minDistance = 99999999
	local nearestNode
	local yWeight = Va3ChessEnum.ClickYWeight

	if nodes then
		for i = 1, #nodes do
			local node = nodes[i]
			local deltaX, deltaY = node.x - x, node.y - y

			if math.abs(deltaX) <= Va3ChessEnum.ClickRangeX and math.abs(deltaY) <= Va3ChessEnum.ClickRangeY then
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

Va3ChessGameController.instance = Va3ChessGameController.New()

LuaEventSystem.addEventMechanism(Va3ChessGameController.instance)

return Va3ChessGameController
