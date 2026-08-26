-- chunkname: @modules/logic/chessgame/controller/ChessGameController.lua

module("modules.logic.chessgame.controller.ChessGameController", package.seeall)

local ChessGameController = class("ChessGameController", BaseController)

function ChessGameController:addConstEvents()
	return
end

function ChessGameController:initServerMap(actId, map)
	local mapGroupId

	if map.episodeId and map.currMapIndex then
		local currMapIndex = map.currMapIndex + 1

		ChessGameModel.instance:clear()
		self:checkShowEffect()
		ChessGameInteractModel.instance:clear()
		ChessGameModel.instance:initData(actId, map.episodeId, currMapIndex)
		ChessGameModel.instance:setNowMapIndex(currMapIndex)
		ChessGameModel.instance:setCompletedCount(map.completedCount)

		mapGroupId = ChessConfig.instance:getEpisodeCo(actId, map.episodeId).mapIds

		ChessGameConfig.instance:setCurrentMapGroupId(mapGroupId)

		local mapCo = ChessGameConfig.instance:getMapCo(mapGroupId)

		ChessGameNodeModel.instance:setNodeDatas(mapCo[currMapIndex].nodes)

		if map.interact then
			ChessGameInteractModel.instance:setInteractDatas(map.interact, currMapIndex)
		end
	end

	self:setClickStatus(ChessGameEnum.SelectPosStatus.None)

	self._selectObj = nil

	self:setSelectObj(nil)

	self.interactsMgr = self.interactsMgr or ChessInteractMgr.New()

	if not self:existGame() then
		self.interactsMgr:removeAll()
	end

	self:initObjects(map.currMapIndex + 1)

	self.eventMgr = self.eventMgr or ChessEventMgr.New()

	self.eventMgr:removeAll()
	self.eventMgr:setCurEvent(nil)

	self._isPlaying = true

	ChessGameController.instance:dispatchEvent(ChessGameEvent.CurrentConditionUpdate)
end

function ChessGameController:enterChessGame(actId, mapGroupId, viewName)
	logNormal("ChessGameController : enterChessGame!")

	self._viewName = viewName or self._viewName

	ViewMgr.instance:openView(self._viewName, self:packViewParam())
	ChessGameModel.instance:clearRollbackNum()
	ChessStatController.instance:startStat()
end

function ChessGameController:exitGame()
	ChessGameModel.instance:clear()
	ChessGameInteractModel.instance:clear()
	ChessGameNodeModel.instance:clear()
	ChessGameModel.instance:clearRollbackNum()
	self:abortGame()

	local actId = 0

	if not ChessGameJumpHandler["jump" .. actId] then
		ChessGameJumpHandler["jump" .. actId]()
	end
end

function ChessGameController:reInit()
	self:release()
end

function ChessGameController:release()
	if self.interactsMgr then
		self.interactsMgr:removeAll()
	end

	if self.eventMgr then
		self.eventMgr:removeAll()
	end

	self._treeComp = nil
	self.interactsMgr = nil
	self.eventMgr = nil
	self._isPlaying = false
end

function ChessGameController:setViewName(value)
	if value then
		self._viewName = value
	end
end

function ChessGameController:getViewName()
	return self._viewName or ViewName.ChessGameScene
end

function ChessGameController:packViewParam()
	return
end

function ChessGameController:deleteInteractObj(id)
	if not ChessGameInteractModel.instance:getInteractById(id) then
		return
	end

	ChessGameInteractModel.instance:deleteInteractById(id)
	self.interactsMgr:remove(id)
end

function ChessGameController:addInteractObj(serverData)
	local id = serverData.id
	local comp = ChessGameController.instance.interactsMgr:get(id)

	if comp and comp:tryGetGameObject() then
		return
	end

	if not serverData.mapGroupId then
		local mapGroupId = ChessGameConfig.instance:getCurrentMapGroupId()
		local mapIndex = ChessGameModel.instance:getNowMapIndex()
		local co = ChessGameConfig.instance:getInteractCoById(mapGroupId, id)
		local mo = ChessGameInteractModel.instance:addInteractMo(co, serverData)

		if mo:isShow() then
			local interactObj = ChessInteractComp.New()

			interactObj:init(mapIndex, mo)

			if interactObj.config ~= nil then
				self.interactsMgr:add(interactObj)
			end

			self:dispatchEvent(ChessGameEvent.AddInteractObj, interactObj)
		end
	end
end

function ChessGameController:getSelectObj()
	return self._selectObj
end

function ChessGameController:isNeedBlock()
	if self.eventMgr and self.eventMgr:isNeedBlock() then
		return true
	end

	return false
end

function ChessGameController:initObjects(mapIndex)
	local moDict = ChessGameInteractModel.instance:getInteractsByMapIndex(mapIndex)
	local compList = self.interactsMgr:getList()

	if #compList > 0 then
		for _, mo in pairs(moDict) do
			local comp = self.interactsMgr:get(mo.id)

			if not comp then
				self:addInteractObj(mo)
			elseif comp and mo:isShow() and not comp:isShow() then
				self.interactsMgr:remove(mo.id)
				self:addInteractObj(mo)
			else
				comp:updateComp(mo)
			end
		end

		for i = #compList, 1, -1 do
			local comp = compList[i]
			local mo = ChessGameInteractModel.instance:getInteractById(comp.mo.id)

			if not mo or not mo:isShow() then
				self.interactsMgr:hideCompById(comp.mo.id)
				self.interactsMgr:remove(comp.mo.id)
			end
		end
	else
		for _, mo in pairs(moDict) do
			local comp = ChessInteractComp.New()

			comp:init(mapIndex, mo)

			if comp.config ~= nil then
				self.interactsMgr:add(comp)
			end
		end

		self:dispatchEvent(ChessGameEvent.AllObjectCreated)
	end
end

function ChessGameController:setClickStatus(status)
	self._clickStatus = status
end

function ChessGameController:getClickStatus()
	return self._clickStatus
end

function ChessGameController:setSelectObj(selectObj)
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

function ChessGameController.filterSelectable(targetObj)
	return targetObj.config and targetObj.config.interactType == ChessGameEnum.InteractType.Role
end

function ChessGameController:searchInteractByPos(x, y, filterFunc)
	local list = self.interactsMgr:getList()
	local targetObj, targetObjList
	local count = 0

	for _, interactObj in ipairs(list) do
		if interactObj.mo.posX == x and interactObj.mo.posY == y and interactObj:isShow() and (not filterFunc or filterFunc(interactObj)) then
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

	return count, targetObjList or targetObj
end

function ChessGameController.sortSelectObj(a, b)
	return a:getSelectPriority() < b:getSelectPriority()
end

function ChessGameController:autoSelectPlayer()
	if not self.interactsMgr then
		return
	end

	local list = self.interactsMgr:getList()

	if not list then
		return
	end

	local players = {}

	for _, interact in pairs(list) do
		if interact.config then
			if not interact.config.interactType then
				local interactType
				local isPlayer = interactType == ChessGameEnum.InteractType.Role

				if isPlayer then
					table.insert(players, interact)
				end
			end
		end
	end

	table.sort(players, ChessGameController.sortInteractObjById)

	if #players > 0 then
		self:setSelectObj(players[1])
	end
end

function ChessGameController.sortInteractObjById(a, b)
	local aType = a.config.interactType
	local bType = b.config.interactType

	if aType ~= bType then
		return aType < bType
	end

	return a.id < b.id
end

function ChessGameController:posCanWalk(x, y)
	local tileMo = ChessGameNodeModel.instance:getNode(x, y)

	if not tileMo then
		return false
	end

	if tileMo.tileType == ChessGameEnum.TileBaseType.None then
		return false
	end

	return (self:checkInteractCanWalk(x, y))
end

function ChessGameController:checkInteractCanWalk(x, y)
	local len, result = self:searchInteractByPos(x, y)

	if not result then
		return true
	end

	local interactMo
	local isCatch = ChessGameModel.instance:getCatchObj()

	if len > 1 then
		for _, comp in ipairs(result) do
			interactMo = comp.mo

			if not comp.mo.walkable then
				return false
			end

			if isCatch then
				if interactMo.interactType == ChessGameEnum.InteractType.Prey or interactMo.interactType == ChessGameEnum.InteractType.Hunter then
					return false
				end

				if comp:checkShowAvatar() then
					return false
				end
			end
		end
	else
		interactMo = result.mo

		if not result.mo.walkable then
			return false
		end

		if isCatch then
			if interactMo.interactType == ChessGameEnum.InteractType.Prey or interactMo.interactType == ChessGameEnum.InteractType.Hunter then
				return false
			end

			if result:checkShowAvatar() then
				return false
			end
		end
	end

	return true
end

function ChessGameController:saveTempSelectObj()
	if self._selectObj then
		self._tempSelectObjId = self._selectObj.id
	end
end

function ChessGameController:isTempSelectObj(id)
	return self._tempSelectObjId == id
end

function ChessGameController:tryResumeSelectObj()
	if self.interactsMgr and self._tempSelectObjId then
		local obj = self.interactsMgr:get(self._tempSelectObjId)

		if obj then
			self:setSelectObj(obj)

			self._tempSelectObjId = nil

			return true
		end
	end

	self:autoSelectPlayer(true)

	return false
end

function ChessGameController:setCatchObj(catchObj)
	self._catchObj = catchObj
end

function ChessGameController:getCatchObj()
	return self._catchObj
end

function ChessGameController:forceRefreshObjSelectedView()
	if self._selectObj ~= nil then
		self._selectObj:onSelected()
	end
end

function ChessGameController:setLoadingScene(state)
	self._isLoadingScene = state
end

function ChessGameController:isLoadingScene()
	return self._isLoadingScene
end

function ChessGameController:setSceneCamera(enterScene)
	if enterScene then
		local camera = CameraMgr.instance:getMainCamera()
		local unitCamera = CameraMgr.instance:getUnitCamera()

		unitCamera.orthographic = true
		unitCamera.orthographicSize = camera.orthographicSize

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), true)
		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		PostProcessingMgr.instance:setUnitActive(true)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", false)
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", 0)
	else
		local unitCamera = CameraMgr.instance:getUnitCamera()

		unitCamera.orthographic = false

		gohelper.setActive(CameraMgr.instance:getUnitCameraGO(), false)
		PostProcessingMgr.instance:setUnitActive(false)
		PostProcessingMgr.instance:setUnitPPValue("localBloomActive", true)
		PostProcessingMgr.instance:setUnitPPValue("bloomActive", true)
	end
end

function ChessGameController:existGame()
	return self._isPlaying
end

function ChessGameController:abortGame()
	self._isPlaying = false
end

function ChessGameController:gameOver()
	ChessGameModel.instance:setGameState(ChessGameEnum.GameState.Fail)
	ChessStatController.instance:statFail()

	self._isPlaying = false
end

function ChessGameController:gameWin()
	ChessGameModel.instance:setGameState(ChessGameEnum.GameState.Win)
	ChessStatController.instance:statSuccess()

	self._isPlaying = false
end

function ChessGameController:checkInteractCanUse(xList, yList)
	local targetList

	for i = 1, #xList do
		local x = xList[i]
		local y = yList[i]
		local interact = self:getPosCanClickInteract(x, y)

		if interact then
			local effectType = interact.mo:getEffectType()

			if effectType and effectType ~= ChessGameEnum.GameEffectType.None then
				interact.chessEffectObj:onAvatarFinish(effectType)
			end

			targetList = targetList or {}
			targetList[interact.mo.id] = interact
		end
	end

	local list = ChessGameInteractModel.instance:getShowEffects()

	if not list then
		return
	end

	for interactId, state in pairs(list) do
		if targetList then
			if not targetList[interactId] and state then
				local interact = self.interactsMgr:get(interactId)

				if interact then
					interact.chessEffectObj:hideEffect()
				end
			end
		elseif state then
			local interact = self.interactsMgr:get(interactId)

			if interact then
				interact.chessEffectObj:hideEffect()
			end
		end

		local interactMo = ChessGameInteractModel.instance:getInteractById(interactId)

		if interactMo and ChessGameInteractModel.instance:checkInteractFinish(interactMo.id) then
			local interact = self.interactsMgr:get(interactId)

			if interact then
				interact.chessEffectObj:hideEffect()
			end
		end
	end
end

function ChessGameController:getPosCanClickInteract(x, y)
	local len, result = self:searchInteractByPos(x, y)
	local clickObj

	if len > 1 then
		for _, comp in ipairs(result) do
			if comp:checkShowAvatar() and comp.config.touchTrigger then
				clickObj = comp

				break
			end
		end
	else
		clickObj = result and result:checkShowAvatar() and result.config.touchTrigger and result
	end

	return clickObj
end

function ChessGameController:checkShowEffect()
	local list = ChessGameInteractModel.instance:getShowEffects()

	if not list or not self.interactsMgr then
		return
	end

	for interactId, state in pairs(list) do
		local interact = self.interactsMgr:get(interactId)

		if interact then
			interact.chessEffectObj:hideEffect()
		end
	end
end

ChessGameController.instance = ChessGameController.New()

LuaEventSystem.addEventMechanism(ChessGameController.instance)

return ChessGameController
