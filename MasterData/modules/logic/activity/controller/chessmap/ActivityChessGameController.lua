-- chunkname: @modules/logic/activity/controller/chessmap/ActivityChessGameController.lua

module("modules.logic.activity.controller.chessmap.ActivityChessGameController", package.seeall)

local ActivityChessGameController = class("ActivityChessGameController", BaseController)

function ActivityChessGameController:onInit()
	return
end

function ActivityChessGameController:reInit()
	return
end

function ActivityChessGameController:release()
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

function ActivityChessGameController:enterChessGame(actId, mapId)
	logNormal("ActivityChessGameController : enterChessGame!")

	local episodeId = Activity109ChessModel.instance:getEpisodeId()

	GuideController.instance:dispatchEvent(GuideEvent["OnChessEnter" .. episodeId])
	self:initData(actId, mapId)
	ViewMgr.instance:openView(ViewName.ActivityChessGame, self:packViewParam())
	Activity109ChessController.instance:statStart()
end

function ActivityChessGameController:packViewParam()
	return {
		fromRefuseBattle = Activity109ChessController.instance:getFromRefuseBattle()
	}
end

function ActivityChessGameController:initData(actId, mapId)
	self._treeComp = ActivityChessGameTree.New()

	ActivityChessGameModel.instance:initData(actId, mapId)

	self._tempSelectObjId = nil

	local mapCO = Activity109Config.instance:getMapCo(actId, mapId)

	if mapCO and not string.nilorempty(mapCO.offset) then
		local offsetArr = string.splitToNumber(mapCO.offset, ",")

		self._cacheOffsetX = offsetArr[1]
		self._cacheOffsetY = offsetArr[2]
	else
		self._cacheOffsetX = nil
		self._cacheOffsetY = nil
	end
end

function ActivityChessGameController:initServerMap(actId, map)
	self:setClickStatus(ActivityChessEnum.SelectPosStatus.None)
	self:setSelectObj(nil)

	self.interacts = self.interacts or ActivityChessInteractMgr.New()

	self.interacts:removeAll()
	ActivityChessGameModel.instance:initObjects(actId, map.interactObjects)
	self:initObjects()

	self.event = self.event or ActivityChessEventMgr.New()

	self.event:removeAll()
	self.event:setCurEvent(map.currentEvent)
	ActivityChessGameModel.instance:setRound(map.currentRound)
	ActivityChessGameModel.instance:setResult(nil)
	ActivityChessGameModel.instance:updateFinishInteracts(map.finishInteracts)

	self._hasMap = true
end

function ActivityChessGameController:initObjects()
	local objList = ActivityChessGameModel.instance:getInteractDatas()

	for _, originData in ipairs(objList) do
		local interactObj = ActivityChessInteractObject.New()

		interactObj:init(originData)

		if interactObj.config ~= nil then
			self.interacts:add(interactObj)
		end
	end

	local interactList = self.interacts:getList()

	for _, interact in ipairs(interactList) do
		interact.goToObject:init()
	end

	self:dispatchEvent(ActivityChessEvent.AllObjectCreated)
end

function ActivityChessGameController:initSceneTree(goTouch, offsetSceneY)
	self._treeSceneComp = ActivityChessGameTree.New()
	self._offsetSceneY = offsetSceneY

	local treeRoot = self._treeSceneComp:createLeaveNode()
	local w, h = ActivityChessGameModel.instance:getGameSize()

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

function ActivityChessGameController:calcTilePosInScene(tileX, tileY, offsetOrder)
	local setting = ActivityChessEnum.TileShowSettings
	local x, y

	if not self._cacheOffsetX then
		y = tileY * setting.height + setting.offsetY * tileX + setting.offsetYX * (tileX + tileY) + ActivityChessEnum.ChessBoardOffsetY
		x = tileX * setting.width + setting.offsetX * tileY + setting.offsetXY * (tileX + tileY) + ActivityChessEnum.ChessBoardOffsetX
	else
		y = tileY * setting.height + setting.offsetY * tileX + setting.offsetYX * (tileX + tileY) + self._cacheOffsetY
		x = tileX * setting.width + setting.offsetX * tileY + setting.offsetXY * (tileX + tileY) + self._cacheOffsetX
	end

	return x * 0.01, y * 0.01, y * 0.001 + (offsetOrder or 0) * 1e-06
end

function ActivityChessGameController:getOffsetSceneY()
	return self._offsetSceneY
end

function ActivityChessGameController:addInteractObj(interactData)
	local interactObj = ActivityChessInteractObject.New()

	interactObj:init(interactData)
	self.interacts:add(interactObj)
	interactObj.goToObject:init()
	self:dispatchEvent(ActivityChessEvent.InteractObjectCreated, interactObj)
end

function ActivityChessGameController:deleteInteractObj(id)
	self.interacts:remove(id)
end

function ActivityChessGameController:searchInteractByPos(x, y, filterFunc)
	local list = self.interacts:getList()
	local targetObj, targetObjList
	local result = 0

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

			result = result + 1
		end
	end

	if result > 1 then
		table.sort(targetObjList, ActivityChessGameController.sortSelectObj)
	end

	return result, targetObjList or targetObj
end

function ActivityChessGameController.sortSelectObj(a, b)
	return a:getSelectPriority() < b:getSelectPriority()
end

function ActivityChessGameController.filterSelectable(targetObj)
	return targetObj.config and targetObj.config.interactType == ActivityChessEnum.InteractType.Player
end

function ActivityChessGameController:existGame()
	return self._hasMap
end

function ActivityChessGameController:setSelectObj(selectObj)
	if self._selectObj == selectObj then
		return
	end

	if self._selectObj ~= nil and self._selectObj:getHandler() then
		self._selectObj:getHandler():onCancelSelect()
	end

	self._selectObj = selectObj

	if selectObj ~= nil and self._selectObj:getHandler() then
		selectObj:getHandler():onSelectCall()
	end
end

function ActivityChessGameController:saveTempSelectObj()
	if self._selectObj then
		self._tempSelectObjId = self._selectObj.id
	end
end

function ActivityChessGameController:tryResumeSelectObj()
	if self.interacts and self._tempSelectObjId then
		local obj = self.interacts:get(self._tempSelectObjId)

		if obj then
			self:setSelectObj(obj)

			self._tempSelectObjId = nil

			return true
		end
	end

	return false
end

function ActivityChessGameController:syncServerMap()
	local actId = ActivityChessGameModel.instance:getActId()
	local mapId = ActivityChessGameModel.instance:getMapId()

	self._tempInteractMgr = self.interacts
	self._tempEventMgr = self.event

	if actId and mapId then
		self.interacts = nil
		self.event = nil

		ActivityChessGameModel.instance:release()
		ActivityChessGameModel.instance:initData(actId, mapId)
		Activity109Rpc.instance:sendGetAct109InfoRequest(actId, self.onReceiveWhenSync, self)
		self:dispatchEvent(ActivityChessEvent.ResetMapView)
	end
end

function ActivityChessGameController:onReceiveWhenSync(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	local actId = ActivityChessGameModel.instance:getActId()
	local mapId = ActivityChessGameModel.instance:getMapId()

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

function ActivityChessGameController:getSelectObj()
	return self._selectObj
end

function ActivityChessGameController:setClickStatus(status)
	self._clickStatus = status
end

function ActivityChessGameController:getClickStatus()
	return self._clickStatus
end

function ActivityChessGameController:autoSelectPlayer()
	if not self.interacts then
		return
	end

	local list = self.interacts:getList()

	if list then
		local players = {}

		for k, player in pairs(list) do
			if player.config and player.config.interactType == ActivityChessEnum.InteractType.Player then
				table.insert(players, player)
			end
		end

		table.sort(players, ActivityChessGameController.sortInteractObjById)

		if #players > 0 then
			self:setSelectObj(players[1])
		end
	end
end

function ActivityChessGameController.sortInteractObjById(a, b)
	return a.id < b.id
end

function ActivityChessGameController:gameClear()
	ActivityChessGameModel.instance:setResult(true)
	self:dispatchEvent(ActivityChessEvent.SetViewVictory)
	self:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
end

function ActivityChessGameController:gameOver()
	ActivityChessGameModel.instance:setResult(false)
	self:dispatchEvent(ActivityChessEvent.SetViewFail)
	self:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
end

function ActivityChessGameController:checkInActivityDuration()
	local actId = ActivityChessGameModel.instance:getActId()
	local actMo = ActivityModel.instance:getActMO(actId)

	if actMo ~= nil and ActivityModel.instance:isActOnLine(actId) and actMo:isOpen() and not actMo:isExpired() then
		return true
	end

	self:closeViewFromActivityExpired()

	return false
end

function ActivityChessGameController:closeViewFromActivityExpired()
	local function yesFunc()
		ViewMgr.instance:closeView(ViewName.ActivityChessGame)
		ViewMgr.instance:closeView(ViewName.Activity109ChessEntry)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, yesFunc)
end

function ActivityChessGameController:posCanWalk(x, y)
	if ActivityChessGameModel.instance:isPosInChessBoard(x, y) and ActivityChessGameModel.instance:getBaseTile(x, y) ~= ActivityChessEnum.TileBaseType.None then
		return self:posObjCanWalk(x, y)
	end

	return false
end

function ActivityChessGameController:posObjCanWalk(x, y)
	local len, rs = self:searchInteractByPos(x, y)

	if len == 1 then
		if rs and rs:canBlock() then
			return false
		end
	elseif len > 1 then
		for i = 1, len do
			if rs[i] and rs[i]:canBlock() then
				return false
			end
		end
	else
		return true
	end

	return true
end

function ActivityChessGameController:getNearestScenePos(x, y)
	if not self._treeSceneComp then
		return nil
	end

	local nodes = self._treeSceneComp:search(x, y)
	local minDistance = 99999999
	local nearestNode
	local yWeight = ActivityChessEnum.ClickYWeight

	if nodes then
		for i = 1, #nodes do
			local node = nodes[i]
			local deltaX, deltaY = node.x - x, node.y - y

			if math.abs(deltaX) <= ActivityChessEnum.ClickRangeX and math.abs(deltaY) <= ActivityChessEnum.ClickRangeY then
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

ActivityChessGameController.instance = ActivityChessGameController.New()

LuaEventSystem.addEventMechanism(ActivityChessGameController.instance)

return ActivityChessGameController
