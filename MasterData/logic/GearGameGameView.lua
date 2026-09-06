-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/geargame/view/GearGameGameView.lua

module("logic.extensions.geargame.view.GearGameGameView", package.seeall)

local GearGameGameView = class("GearGameGameView", ViewComponent)
local kCellSize = 84
local kHalfCell = kCellSize * 0.5
local kPreviewColorInvalid = 0
local kPreviewColorValid = 1
local kCheckAnimDuration = 1
local kCheckAnimSpeed = 360
local kPlacePuzzleScale = 0.65

function GearGameGameView:ctor()
	GearGameGameView.super.ctor(self)
end

function GearGameGameView:unbindEvents()
	GearGameGameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnRotate)
	GameUtil.rmClickHandler(self._btnFlip)
	GameUtil.rmClickHandler(self._imgMask)
end

function GearGameGameView:bindEvents()
	GearGameGameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickBtnStart, self)
	GameUtil.addClickHandler(self._btnRotate, self._onClickBtnRotate, self)
	GameUtil.addClickHandler(self._btnFlip, self._onClickBtnFlip, self)
	GameUtil.addClickHandler(self._imgMask, self._onClickImgMask, self)
end

function GearGameGameView:buildUI()
	GearGameGameView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnStart = self:getGo("btnStart")
	self._map = self:getGo("map")
	self._originGeer = self:getGo("map/originGeer")
	self._cheseBoard = self:getGo("map/cheseBoard")
	self._puzzle = self:getGo("map/puzzle")
	self._preview = self:getGo("map/preview")
	self._place = self:getGo("place")
	self._puzzles = self:getGo("place/puzzles")
	self._imgMask = self:getGo("place/imgMask")
	self._operatePuzzle = self:getGo("place/operatePuzzle")
	self._btnRotate = self:getGo("place/operatePuzzle/btnRotate")
	self._btnFlip = self:getGo("place/operatePuzzle/btnFlip")
	self._puzzlePosLimit = self:getGo("place/puzzlePosLimit")
	self._puzzleCell = self:getGo("puzzleCell")
	self._cellSelect = self:getGo("cellSelect")
	self._cellBg = self:getGo("cellBg")
	self._cellItem = self:getGo("cellItem")
	self._geerCell = self:getGo("geerCell")
	self._originGeerCell = self:getGo("originGeerCell")
	self._cellBgDrag = self:getGo("cellBgDrag")

	GameUtil.SetActive(self._puzzleCell, false)
	GameUtil.SetActive(self._cellSelect, false)
	GameUtil.SetActive(self._cellBg, false)
	GameUtil.SetActive(self._cellItem, false)
	GameUtil.SetActive(self._geerCell, false)
	GameUtil.SetActive(self._originGeerCell, false)
	GameUtil.SetActive(self._cellBgDrag, false)
	GameUtil.SetActive(self._imgMask, false)
	GameUtil.SetActive(self._operatePuzzle, false)
end

function GearGameGameView:onExit()
	self:_clearCheckTimer()
	self:_clearDragEvents()
	self:_clearDynamicItems()
	self:_releaseClickBlock()
	GearGameGameView.super.onExit(self)
end

function GearGameGameView:onEnter()
	GearGameGameView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_GearGameStartGameRes, self._onStartGameRes, self)
	self.addGEvent(self, GlobalNotify.PM_GearGameEndGameRes, self.close, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 604001
	end

	self._stageId = checknumber(params[2])

	if self._stageId <= 0 then
		self._stageId = 1
	end

	self._startingGame = false
	self._actCfg = GearGameConfig.instance:getActivityCfg(self._activityId)

	self:_initGame()

	local key = "GearGameGameView_" .. self._activityId
	local isNotFirst = GameUtil.getUserData(key)

	if not isNotFirst then
		GameUtil.saveUserData(key, true)
		self:_onClickBtnTip()
	end
end

function GearGameGameView:_initGame()
	self:_clearCheckTimer()
	self:_clearDragEvents()
	self:_clearDynamicItems()

	self._selectedData = nil
	self._dragData = nil
	self._dragOffset = nil
	self._isDragging = false
	self._isChecking = false
	self._isPassed = false
	self._hasSendEndGameReq = false
	self._uidSeed = 0
	self._allPuzzles = {}
	self._boardCellOwner = {}
	self._powerGearMap = {}
	self._powerGearIds = {}
	self._powerGearGoMap = {}
	self._gearGoMap = {}
	self._gearCellMap = {}
	self._powerGearClickList = {}
	self._stageCfg = GearGameConfig.instance:getStageCfg(self._activityId, self._stageId)

	if not self._stageCfg then
		FloatWordMgr.instance:show("缺少小游戏关卡配置")

		return
	end

	self._mapWidth = checknumber(self._stageCfg.mapWidth)
	self._mapHeight = checknumber(self._stageCfg.mapHeight)
	self._gameMode = checknumber(self._stageCfg.gameMode)
	self._boardLeft = -self._mapWidth * kCellSize * 0.5
	self._boardBottom = -self._mapHeight * kCellSize * 0.5

	self:_createBoard()
	self:_createPowerGears()
	self:_createInitialPuzzles()
	self:_createPlacePuzzles()
end

function GearGameGameView:_clearDynamicItems()
	for _, data in ipairs(self._allPuzzles or {}) do
		if data.cell and not goutil.isNil(data.cell) and data.cell.transform.parent ~= self._puzzles.transform and data.cell.transform.parent ~= self._puzzle.transform then
			goutil.destroy(data.cell)
		end
	end

	if self._cheseBoard then
		goutil.clearChildren(self._cheseBoard)
	end

	if self._originGeer then
		goutil.clearChildren(self._originGeer)
	end

	if self._puzzle then
		goutil.clearChildren(self._puzzle)
	end

	if self._preview then
		goutil.clearChildren(self._preview)
	end

	if self._puzzles then
		goutil.clearChildren(self._puzzles)
	end
end

function GearGameGameView:_createBoard()
	GameUtil.SetActive(self._btnStart, true)

	for h = 1, self._mapHeight do
		for w = 1, self._mapWidth do
			local go = goutil.cloneAndSetParent(self._cellBg, self._cheseBoard.transform, string.format("bg_%s_%s", w, h))

			self:_resizeCell(go)

			local x, y = self:_coordToLocalPos(w, h)

			GameUtil.setAnchoredPos(go, x, y)
			GameUtil.SetActive(go, true)
		end
	end
end

function GearGameGameView:_createPowerGears()
	if not self._stageCfg.powerGeerList then
		if not self._stageCfg.powerGeerPosXList then
			local posXList = {}

			if not self._stageCfg.powerGeerPosYList then
				local posYList = {}

				for i, id in ipairs(self._stageCfg.powerGeerList) do
					id = checknumber(id)

					if id > 0 then
						local x = posXList[i]
						local y = posYList[i]

						if x == nil or y == nil then
							local w, h = self:_idToCoord(id)
							local offsetX, offsetY = self:_getPowerGearOffset(w, h)
							local defaultX, defaultY = self:_coordToLocalPos(w, h)

							x = defaultX + offsetX
							y = defaultY + offsetY
						end

						local go = goutil.cloneAndSetParent(self._originGeerCell, self._originGeer.transform, "origin_geer_" .. id)

						self:_resizeCell(go)
						self:_setNativeImageSize(go)
						GameUtil.setAnchoredPos(go, checknumber(x), checknumber(y))
						GameUtil.SetActive(go, true)
						self:_setRaycast(go, true)

						local gearId = id

						GameUtil.addClickHandler(go, function()
							self:_onClickPowerGear(gearId)
						end)
						table.insert(self._powerGearClickList, go)
						table.insert(self._powerGearIds, id)

						self._powerGearMap[id] = true
						self._powerGearGoMap[id] = go
					end
				end
			end
		end
	end
end

function GearGameGameView:_createInitialPuzzles()
	if not self._stageCfg.puzzleList then
		if not self._stageCfg.flipList then
			local flipList = {}

			if not self._stageCfg.roateList then
				local rotateList = {}

				for idx, puzzleId in ipairs(self._stageCfg.puzzleList) do
					puzzleId = checknumber(puzzleId)

					if puzzleId > 0 then
						local anchorW, anchorH = self:_idToCoord(idx)
						local flip = checknumber(flipList[idx])
						local rotate = checknumber(rotateList[idx])
						local data = self:_createPuzzleData(puzzleId, rotate, flip, true)

						if data then
							self:_renderPuzzle(data)
							self:_putPuzzleOnBoard(data, anchorW, anchorH, true)
						end
					end
				end
			end
		end
	end
end

function GearGameGameView:_createPlacePuzzles()
	local usedMap = self:_listToMap(self._stageCfg.useedPuzzleList)
	local puzzleCfgs = GearGameConfig.instance:getPuzzleCfgs() or {}
	local list = {}

	if puzzleCfgs.dataList then
		for _, cfg in ipairs(puzzleCfgs.dataList) do
			if cfg.puzzleId and not usedMap[cfg.puzzleId] then
				table.insert(list, cfg.puzzleId)
			end
		end
	else
		for puzzleId, cfg in pairs(puzzleCfgs) do
			if type(puzzleId) == "number" and cfg and not usedMap[puzzleId] then
				table.insert(list, puzzleId)
			end
		end

		table.sort(list)
	end

	for i, puzzleId in ipairs(list) do
		local data = self:_createPuzzleData(checknumber(puzzleId), 0, 0, false)

		if data then
			self:_renderPuzzle(data)
			self:_putPuzzleInPlace(data, self:_getPlaceAutoPos(i, data))
			table.insert(self._allPuzzles, data)
		end
	end
end

function GearGameGameView:_createPuzzleData(puzzleId, rotate, flip, isInitial)
	local cfg = GearGameConfig.instance:getPuzzleCfg(puzzleId)

	if not cfg then
		return nil
	end

	self._uidSeed = self._uidSeed + 1

	local data = {}

	data.uid = self._uidSeed
	data.puzzleId = puzzleId
	data.cfg = cfg
	data.rotate = checknumber(rotate)
	data.flip = checknumber(flip) == 1
	data.isInitial = isInitial == true
	data.location = "none"

	self:_refreshPuzzleCells(data)

	return data
end

function GearGameGameView:_refreshPuzzleCells(data)
	local width = checknumber(data.cfg.width)
	local height = checknumber(data.cfg.height)
	local cutMap = self:_listToMap(data.cfg.cutdownId)
	local gearMap = self:_listToMap(data.cfg.geerId)
	local cells = {}

	for h = 1, height do
		for w = 1, width do
			local id = (h - 1) * width + w

			if not cutMap[id] then
				table.insert(cells, {
					x = w,
					y = h,
					originX = w,
					originY = h,
					isGear = gearMap[id] == true
				})
			end
		end
	end

	local rotate = self:_getPuzzleRotateTimes(data.rotate)

	for _ = 1, rotate do
		cells, width, height = self:_rotateCellsClockwise(cells, width, height)
	end

	if data.flip then
		cells = self:_flipCellsHorizontal(cells, width)
	end

	table.sort(cells, function(a, b)
		if a.y ~= b.y then
			return a.y < b.y
		end

		return a.x < b.x
	end)

	data.cells = cells
	data.widthCells = width
	data.heightCells = height
end

function GearGameGameView:_getPuzzleRotateTimes(rotate)
	rotate = checknumber(rotate)

	return rotate % 4
end

function GearGameGameView:_rotateCellsClockwise(cells, width, height)
	local result = {}

	for _, cell in ipairs(cells) do
		table.insert(result, {
			x = cell.y,
			y = width - cell.x + 1,
			originX = cell.originX,
			originY = cell.originY,
			isGear = cell.isGear
		})
	end

	return result, height, width
end

function GearGameGameView:_flipCellsHorizontal(cells, width)
	local result = {}

	for _, cell in ipairs(cells) do
		table.insert(result, {
			x = width - cell.x + 1,
			y = cell.y,
			originX = cell.originX,
			originY = cell.originY,
			isGear = cell.isGear
		})
	end

	return result
end

function GearGameGameView:_renderPuzzle(data)
	if not data.cell or goutil.isNil(data.cell) then
		data.cell = goutil.clone(self._cellItem, "puzzle_" .. data.uid)
	end

	self:_clearPuzzleDragEvents(data)

	local partRoot = goutil.findChild(data.cell, "partImgs")
	local gearRoot = goutil.findChild(data.cell, "geers")
	local dragRoot = goutil.findChild(data.cell, "drag")

	self:_renderPuzzleVisual(data)
	goutil.clearChildren(partRoot)
	goutil.clearChildren(gearRoot)
	goutil.clearChildren(dragRoot)

	for _, cell in ipairs(data.cells) do
		local x, y = self:_relativeCellToLocal(cell.x, cell.y)
		local dragGo = goutil.cloneAndSetParent(self._cellBgDrag, dragRoot.transform, string.format("drag_%s_%s", cell.x, cell.y))

		self:_resizeCell(dragGo)
		GameUtil.setAnchoredPos(dragGo, x, y)
		GameUtil.SetActive(dragGo, not data.isInitial)

		if not data.isInitial then
			self:_addPuzzleDragEvent(data, dragGo)
		end

		if cell.isGear then
			local gearGo = goutil.cloneAndSetParent(self._geerCell, gearRoot.transform, string.format("gear_%s_%s", cell.x, cell.y))
			local gearX, gearY = self:_getPuzzleGearLocalPos(data, cell)

			self:_resizeCell(gearGo)
			self:_setNativeImageSize(gearGo)
			GameUtil.setAnchoredPos(gearGo, gearX, gearY)
			GameUtil.SetActive(gearGo, true)

			cell.gearGo = gearGo
		end
	end

	GameUtil.SetActive(data.cell, true)
end

function GearGameGameView:_renderPuzzleVisual(data)
	local visualRoot = goutil.findChild(data.cell, "visual")
	local flipRoot = goutil.findChild(data.cell, "visual/flipRoot")
	local rotateRoot = goutil.findChild(data.cell, "visual/flipRoot/rotateRoot")
	local imgPuzzle = goutil.findChild(data.cell, "visual/flipRoot/rotateRoot/imgPuzzle")

	if not visualRoot or not flipRoot or not rotateRoot or not imgPuzzle then
		return
	end

	local rotate = self:_getPuzzleRotateTimes(data.rotate)
	local baseWidth = checknumber(data.cfg.width) * kCellSize
	local baseHeight = checknumber(data.cfg.height) * kCellSize
	local finalWidth = data.widthCells * kCellSize
	local finalHeight = data.heightCells * kCellSize
	local centerX = (data.widthCells - 1) * kHalfCell
	local centerY = (data.heightCells - 1) * kHalfCell
	local flipScaleX = data.flip and -1 or 1

	GameUtil.setWidth(visualRoot, finalWidth)
	GameUtil.setHeight(visualRoot, finalHeight)
	GameUtil.setAnchoredPos(visualRoot, centerX, centerY)
	GameUtil.setLocalScale(visualRoot, 1, 1, 1)
	GameUtil.setLocalRotation(visualRoot, 0, 0, 0)
	GameUtil.setWidth(flipRoot, finalWidth)
	GameUtil.setHeight(flipRoot, finalHeight)
	GameUtil.setAnchoredPos(flipRoot, 0, 0)
	GameUtil.setLocalScale(flipRoot, flipScaleX, 1, 1)
	GameUtil.setLocalRotation(flipRoot, 0, 0, 0)
	GameUtil.setWidth(rotateRoot, baseWidth)
	GameUtil.setHeight(rotateRoot, baseHeight)
	GameUtil.setAnchoredPos(rotateRoot, 0, 0)
	GameUtil.setLocalScale(rotateRoot, 1, 1, 1)
	GameUtil.setLocalRotation(rotateRoot, 0, 0, -90 * rotate)
	GameUtil.setWidth(imgPuzzle, baseWidth)
	GameUtil.setHeight(imgPuzzle, baseHeight)
	GameUtil.setAnchoredPos(imgPuzzle, 0, 0)
	GameUtil.setLocalScale(imgPuzzle, 1, 1, 1)
	GameUtil.setLocalRotation(imgPuzzle, 0, 0, 0)
	GameUtil.setUIImageSpriteIdx(imgPuzzle, self:_getPuzzleSpriteIdx(data))
	GameUtil.SetActive(visualRoot, true)
end

function GearGameGameView:_getPuzzleSpriteIdx(data)
	return checknumber(data.puzzleId) - 1
end

function GearGameGameView:_getPuzzleGearLocalPos(data, cell)
	local rotate = self:_getPuzzleRotateTimes(data.rotate)
	local originX = checknumber(cell.originX)
	local originY = checknumber(cell.originY)

	if originX <= 0 then
		originX = checknumber(cell.x)
	end

	if originY <= 0 then
		originY = checknumber(cell.y)
	end

	local baseCenterX = (checknumber(data.cfg.width) - 1) * kHalfCell
	local baseCenterY = (checknumber(data.cfg.height) - 1) * kHalfCell
	local finalCenterX = (data.widthCells - 1) * kHalfCell
	local finalCenterY = (data.heightCells - 1) * kHalfCell
	local x = (originX - 1) * kCellSize - baseCenterX
	local y = (originY - 1) * kCellSize - baseCenterY

	for _ = 1, rotate do
		y = -x
		x = y
	end

	if data.flip then
		x = -x
	end

	if x < 0 then
		x = x - 4
	elseif x > 0 then
		x = x + 4
	end

	if y < 0 then
		y = y - 4
	elseif y > 0 then
		y = y + 4
	end

	return finalCenterX + x, finalCenterY + y
end

function GearGameGameView:_addPuzzleDragEvent(data, dragCell)
	local handlers = {}

	handlers.dragCell = dragCell
	handlers.bdh = BeginDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		self:_onBeginDragPuzzle(data, eventData)
	end)
	handlers.dh = DragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		self:_onDragPuzzle(data, eventData)
	end)
	handlers.edh = EndDragHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		self:_onEndDragPuzzle(data, eventData)
	end)
	handlers.pch = PointerClickHandler.Get(dragCell):AddLuaHandler(function(_go, eventData)
		self:_onClickPuzzle(data, eventData)
	end)
	data.dragHandlers = data.dragHandlers or {}

	table.insert(data.dragHandlers, handlers)
end

function GearGameGameView:_clearDragEvents()
	for _, data in ipairs(self._allPuzzles or {}) do
		self:_clearPuzzleDragEvents(data)
	end
end

function GearGameGameView:_clearPuzzleDragEvents(data)
	if not data or not data.dragHandlers then
		return
	end

	for _, handlers in ipairs(data.dragHandlers) do
		if handlers.dragCell and not goutil.isNil(handlers.dragCell) then
			if handlers.bdh then
				BeginDragHandler.Get(handlers.dragCell):RemoveLuaHandler(handlers.bdh)
			end

			if handlers.dh then
				DragHandler.Get(handlers.dragCell):RemoveLuaHandler(handlers.dh)
			end

			if handlers.edh then
				EndDragHandler.Get(handlers.dragCell):RemoveLuaHandler(handlers.edh)
			end

			if handlers.pch then
				PointerClickHandler.Get(handlers.dragCell):RemoveLuaHandler(handlers.pch)
			end
		end
	end

	data.dragHandlers = nil
end

function GearGameGameView:_onClickPuzzle(data, eventData)
	if self._isDragging or self._isChecking or self._isPassed then
		return
	end

	if data.location == "place" then
		self:_selectPuzzle(data)
	end
end

function GearGameGameView:_selectPuzzle(data)
	if self._selectedData == data then
		self:_showSelection(data, false)

		return
	end

	self:_cancelSelect()

	self._selectedData = data

	self:_showSelection(data, true)
end

function GearGameGameView:_showSelection(data, refreshActionPos)
	if not data or data.location ~= "place" then
		return
	end

	self:_movePlacePuzzleAboveMask(data)
	self:_clampCurrentPlacePuzzle(data)
	GameUtil.SetActive(self._imgMask, true)
	GameUtil.SetActive(self._operatePuzzle, true)

	if refreshActionPos then
		self:_updateActionButtonPos(data)
	end
end

function GearGameGameView:_cancelSelect()
	if self._selectedData and self._selectedData.location == "place" then
		self:_movePlacePuzzleBack(self._selectedData)
	end

	self._selectedData = nil

	GameUtil.SetActive(self._imgMask, false)
	GameUtil.SetActive(self._operatePuzzle, false)
end

function GearGameGameView:_hideSelectWithoutReparent()
	self._selectedData = nil

	GameUtil.SetActive(self._imgMask, false)
	GameUtil.SetActive(self._operatePuzzle, false)
end

function GearGameGameView:_movePlacePuzzleAboveMask(data)
	if not data or not data.cell or goutil.isNil(data.cell) then
		return
	end

	local pos = GameUtil.getAnchoredPos(data.cell)

	goutil.addChildToParent(data.cell, self._place)
	GameUtil.setAnchoredPos(data.cell, pos.x, pos.y)
end

function GearGameGameView:_movePlacePuzzleBack(data)
	if not data or not data.cell or goutil.isNil(data.cell) then
		return
	end

	local pos = GameUtil.getAnchoredPos(data.cell)

	goutil.addChildToParent(data.cell, self._puzzles)
	GameUtil.setAnchoredPos(data.cell, pos.x, pos.y)
end

function GearGameGameView:_updateActionButtonPos(data)
	local pos = GameUtil.getAnchoredPos(data.cell)

	if data.location == "place" then
		if not kPlacePuzzleScale then
			local scale = 1
			local x = pos.x + (data.widthCells - 1) * kHalfCell * scale + 20
			local y = pos.y - kCellSize * scale - 40

			GameUtil.setAnchoredPos(self._operatePuzzle, x, y)
		end
	end
end

function GearGameGameView:_onClickBtnRotate()
	local data = self._selectedData

	if not data or data.location ~= "place" or self._isChecking or self._isPassed then
		return
	end

	data.rotate = data.rotate + 1

	self:_refreshPuzzleCells(data)
	self:_renderPuzzle(data)
	self:_showSelection(data, false)
end

function GearGameGameView:_onClickBtnFlip()
	local data = self._selectedData

	if not data or data.location ~= "place" or self._isChecking or self._isPassed then
		return
	end

	data.flip = not data.flip

	self:_refreshPuzzleCells(data)
	self:_renderPuzzle(data)
	self:_showSelection(data, false)
end

function GearGameGameView:_onClickBtnClose()
	local passOrNot = 0

	GearGameController.instance:sendPM_GearGameEndGameReq(self._activityId, self._stageId, passOrNot)
	self:close()
end

function GearGameGameView:_onClickImgMask()
	if self._isDragging then
		return
	end

	self:_cancelSelect()
end

function GearGameGameView:_onClickBtnTip()
	local ruleCfg = GearGameConfig.instance:getGameRuleCfgs(self._actCfg.ruleId)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList, lang("游戏规则"), function()
		self._isPause = false
	end)
end

function GearGameGameView:_onBeginDragPuzzle(data, eventData)
	if self._isChecking or self._isPassed or data.isInitial then
		return
	end

	self._isDragging = true
	self._dragData = data
	self._dragStart = {
		location = data.location,
		rotate = data.rotate,
		flip = data.flip,
		anchorW = data.anchorW,
		anchorH = data.anchorH,
		pos = GameUtil.getAnchoredPos(data.cell)
	}

	self:_hideSelectWithoutReparent()
	self:_clearPreview()

	if data.location == "place" then
		self:_setPuzzleScale(data, 1)
	end

	if data.location == "board" then
		self:_removePuzzleFromBoard(data)
	end

	local vec = goutil.screenToLocalPos(eventData.position, data.cell.transform)
	local pos = data.cell.transform:TransformPoint(vec)

	self._dragOffset = data.cell.transform.position - pos

	goutil.addChildToParent(data.cell, self.mainGO)

	data.cell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._dragOffset

	GameUtil.SetActive(self._imgMask, true)
end

function GearGameGameView:_onDragPuzzle(data, eventData)
	if self._dragData ~= data then
		return
	end

	data.cell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._dragOffset

	self:_refreshPreview(data)
end

function GearGameGameView:_onEndDragPuzzle(data, eventData)
	if self._dragData ~= data then
		return
	end

	data.cell.transform.position = uGuiUtil.GetTouchWorldPosition() + self._dragOffset

	local success = false
	local anchorW, anchorH = self:_getDragAnchor(data)

	if anchorW and self:_canPlaceAt(data, anchorW, anchorH) then
		self:_putPuzzleOnBoard(data, anchorW, anchorH, false)

		success = true
	elseif self:_isPuzzleIntersectPlace(data) then
		local placePos = self._place.transform:InverseTransformPoint(data.cell.transform.position)

		self:_putPuzzleInPlace(data, placePos.x, placePos.y)

		success = true
	end

	if not success then
		self:_restoreDragPuzzle(data)
	end

	self._isDragging = false
	self._dragData = nil
	self._dragStart = nil
	self._dragOffset = nil

	self:_clearPreview()
	GameUtil.SetActive(self._imgMask, false)
end

function GearGameGameView:_restoreDragPuzzle(data)
	if not self._dragStart then
		return
	end

	data.rotate = self._dragStart.rotate
	data.flip = self._dragStart.flip

	self:_refreshPuzzleCells(data)
	self:_renderPuzzle(data)

	if self._dragStart.location == "board" then
		self:_putPuzzleOnBoard(data, self._dragStart.anchorW, self._dragStart.anchorH, false)
	else
		self:_putPuzzleInPlace(data, self._dragStart.pos.x, self._dragStart.pos.y)
	end
end

function GearGameGameView:_putPuzzleInPlace(data, x, y)
	goutil.addChildToParent(data.cell, self._puzzles)
	self:_setPuzzleScale(data, kPlacePuzzleScale)

	x, y = self:_clampPlacePuzzlePos(data, x, y)

	GameUtil.setAnchoredPos(data.cell, x, y)
	GameUtil.SetActive(data.cell, true)

	data.location = "place"
	data.anchorW = nil
	data.anchorH = nil
end

function GearGameGameView:_putPuzzleOnBoard(data, anchorW, anchorH, isInitial)
	goutil.addChildToParent(data.cell, self._puzzle)
	self:_setPuzzleScale(data, 1)

	local x, y = self:_coordToLocalPos(anchorW, anchorH)

	GameUtil.setAnchoredPos(data.cell, x, y)
	GameUtil.SetActive(data.cell, true)

	data.location = "board"
	data.anchorW = anchorW
	data.anchorH = anchorH
	data.isInitial = data.isInitial or isInitial == true

	self:_addPuzzleToBoard(data)
	self:_syncPuzzleGearMap(data)
end

function GearGameGameView:_addPuzzleToBoard(data)
	for _, cell in ipairs(data.cells) do
		local id = self:_coordToId(data.anchorW + cell.x - 1, data.anchorH + cell.y - 1)

		if id then
			self._boardCellOwner[id] = data
		end
	end
end

function GearGameGameView:_removePuzzleFromBoard(data)
	for _, cell in ipairs(data.cells) do
		local id = self:_coordToId(data.anchorW + cell.x - 1, data.anchorH + cell.y - 1)

		if id and self._boardCellOwner[id] == data then
			self._boardCellOwner[id] = nil
		end
	end

	self:_removePuzzleGearMap(data)

	data.location = "drag"
end

function GearGameGameView:_syncPuzzleGearMap(data)
	self:_removePuzzleGearMap(data)

	data.gearBoardIds = {}

	for _, cell in ipairs(data.cells) do
		if cell.isGear then
			local id = self:_coordToId(data.anchorW + cell.x - 1, data.anchorH + cell.y - 1)

			if id then
				table.insert(data.gearBoardIds, id)
				self:_addGearGo(id, cell.gearGo)
			end
		end
	end
end

function GearGameGameView:_removePuzzleGearMap(data)
	if not data or not data.gearBoardIds then
		return
	end

	for _, id in ipairs(data.gearBoardIds) do
		local list = self._gearGoMap[id]

		if list then
			for i = #list, 1, -1 do
				local go = list[i]

				if self:_isGearGoBelongToPuzzle(data, go) then
					table.remove(list, i)
				end
			end

			if #list <= 0 then
				self._gearGoMap[id] = nil
			end
		end

		self:_refreshGearCellFlag(id)
	end

	data.gearBoardIds = nil
end

function GearGameGameView:_isGearGoBelongToPuzzle(data, go)
	for _, cell in ipairs(data.cells or {}) do
		if cell.gearGo == go then
			return true
		end
	end

	return false
end

function GearGameGameView:_addGearGo(id, go)
	if not go then
		return
	end

	self._gearGoMap[id] = self._gearGoMap[id] or {}

	table.insert(self._gearGoMap[id], go)
	self:_refreshGearCellFlag(id)
end

function GearGameGameView:_refreshGearCellFlag(id)
	self._gearCellMap[id] = self._gearGoMap[id] and #self._gearGoMap[id] > 0
end

function GearGameGameView:_canPlaceAt(data, anchorW, anchorH)
	for _, cell in ipairs(data.cells) do
		local w = anchorW + cell.x - 1
		local h = anchorH + cell.y - 1
		local id = self:_coordToId(w, h)

		if not id then
			return false
		end

		if self._boardCellOwner[id] ~= nil then
			return false
		end
	end

	return true
end

function GearGameGameView:_refreshPreview(data)
	self:_clearPreview()

	local anchorW, anchorH = self:_getDragAnchor(data)

	if not anchorW then
		return
	end

	local valid = self:_canPlaceAt(data, anchorW, anchorH)

	for _, cell in ipairs(data.cells) do
		local w = anchorW + cell.x - 1
		local h = anchorH + cell.y - 1

		if self:_coordToId(w, h) then
			local go = goutil.cloneAndSetParent(self._cellSelect, self._preview.transform, string.format("preview_%s_%s", w, h))
			local x, y = self:_coordToLocalPos(w, h)

			self:_resizeCell(go)
			GameUtil.setAnchoredPos(go, x, y)
			GameUtil.setUIImageColorIdx(go, (valid or nil) and (kPreviewColorValid or kPreviewColorInvalid))
			GameUtil.SetActive(go, true)
		end
	end
end

function GearGameGameView:_clearPreview()
	if self._preview then
		goutil.clearChildren(self._preview)
	end
end

function GearGameGameView:_onClickPowerGear(startId)
	if self._isChecking or self._isPassed or self._isDragging then
		return
	end

	self:_cancelSelect()

	local connectedMap = self:_collectConnectedGears(startId)
	local success = self:_isAllPowerGearConnected(connectedMap)

	if success and self._gameMode == 1 then
		success = self:_isAllPlacePuzzleUsed()
	end

	self:_playCheckGearAnim(startId, connectedMap, success)
end

function GearGameGameView:_collectConnectedGears(startId)
	local result = {}

	if not self._gearCellMap[startId] then
		return result
	end

	local queue = {
		startId
	}

	result[startId] = 0

	while #queue > 0 do
		local id = table.remove(queue, 1)
		local w, h = self:_idToCoord(id)
		local dirs = {
			{
				1,
				0
			},
			{
				-1,
				0
			},
			{
				0,
				1
			},
			{
				0,
				-1
			}
		}

		for _, dir in ipairs(dirs) do
			local nextId = self:_coordToId(w + dir[1], h + dir[2])

			if nextId and self._gearCellMap[nextId] and not result[nextId] then
				result[nextId] = result[id] + 1

				table.insert(queue, nextId)
			end
		end
	end

	return result
end

function GearGameGameView:_isAllPowerGearConnected(connectedMap)
	for _, id in ipairs(self._powerGearIds or {}) do
		if not connectedMap[id] then
			return false
		end
	end

	return #self._powerGearIds > 0
end

function GearGameGameView:_isAllPlacePuzzleUsed()
	for _, data in ipairs(self._allPuzzles or {}) do
		if data.location ~= "board" then
			return false
		end
	end

	return true
end

function GearGameGameView:_playCheckGearAnim(startId, connectedMap, success)
	local gearAnimList = {}

	if self._powerGearGoMap then
		if self._powerGearGoMap and not goutil.isNil(self._powerGearGoMap) then
			table.insert(gearAnimList, {
				dir = -1,
				go = self._powerGearGoMap
			})
		end

		for id, distance in pairs(connectedMap) do
			local dir = distance % 2 == 0 and 1 or -1

			if self._powerGearGoMap then
				local powerGo = self._powerGearGoMap[id]

				if id ~= startId and powerGo and not goutil.isNil(powerGo) then
					table.insert(gearAnimList, {
						go = powerGo,
						dir = dir
					})
				end

				local list = self._gearGoMap[id]

				if list then
					for _, go in ipairs(list) do
						if go and not goutil.isNil(go) then
							table.insert(gearAnimList, {
								go = go,
								dir = dir
							})
						end
					end
				end
			end
		end

		self._checkAnimData = {
			elapsed = 0,
			gearAnimList = gearAnimList,
			success = success == true
		}
		self._isChecking = true

		ViewBlockMgr.instance:blockClick(true, self)

		self._isClickBlocked = true

		removetimer(self._onCheckAnimTick, self)
		settimer(0, self._onCheckAnimTick, self, true)
	end
end

function GearGameGameView:_onCheckAnimTick()
	if not self._checkAnimData then
		self:_clearCheckTimer()

		return
	end

	self._checkAnimData.elapsed = self._checkAnimData.elapsed + Time.deltaTime

	local angle = self._checkAnimData.elapsed * kCheckAnimSpeed

	for _, data in ipairs(self._checkAnimData.gearAnimList or {}) do
		local go = data.go

		if go and not goutil.isNil(go) then
			GameUtil.setLocalRotation(go, 0, 0, angle * data.dir)
		end
	end

	if self._checkAnimData.elapsed >= kCheckAnimDuration then
		local success = self._checkAnimData.success

		self:_clearCheckTimer()
		self:_releaseClickBlock()

		if success then
			self._isPassed = true

			TipsFacade.instance:openTipWindowNoX("提示", "恭喜通关！", function()
				self:_endGameCallBack()
			end, "确定")
		elseif self._gameMode == 1 then
			FloatWordMgr.instance:show(lang("齿轮无法全部连通或拼图没有全部放入，请重新尝试"))
		else
			FloatWordMgr.instance:show(lang("齿轮无法全部连通，请重新尝试"))
		end
	end
end

function GearGameGameView:_clearCheckTimer()
	removetimer(self._onCheckAnimTick, self)

	if self._checkAnimData then
		for _, data in ipairs(self._checkAnimData.gearAnimList or {}) do
			local go = data.go

			if go and not goutil.isNil(go) then
				GameUtil.setLocalRotation(go, 0, 0, 0)
			end
		end
	end

	self._checkAnimData = nil
	self._isChecking = false
end

function GearGameGameView:_releaseClickBlock()
	if self._isClickBlocked then
		ViewBlockMgr.instance:blockClick(false, self)

		self._isClickBlocked = false
	end
end

function GearGameGameView:_getDragAnchor(data)
	local pos = self._map.transform:InverseTransformPoint(data.cell.transform.position)

	return self:_localPosToAnchor(pos.x, pos.y)
end

function GearGameGameView:_localPosToAnchor(x, y)
	local w = math.floor((x - self._boardLeft) / kCellSize) + 1
	local h = math.floor((y - self._boardBottom) / kCellSize) + 1

	if w < 1 or h < 1 or w > self._mapWidth or h > self._mapHeight then
		return nil, nil
	end

	return w, h
end

function GearGameGameView:_isScreenInPlace(screenPos)
	local pos = goutil.screenToLocalPos(screenPos, self._place.transform)
	local minX, maxX, minY, maxY = self:_getPuzzlePosLimitRectInPlace()

	return minX <= pos.x and maxX >= pos.x and minY <= pos.y and maxY >= pos.y
end

function GearGameGameView:_isPuzzleIntersectPlace(data)
	if not data or not data.cell or goutil.isNil(data.cell) then
		return false
	end

	local minX, maxX, minY, maxY = self:_getPuzzleBoundsInPlace(data)
	local limitMinX, limitMaxX, limitMinY, limitMaxY = self:_getPuzzlePosLimitRectInPlace()

	return limitMinX <= maxX and minX <= limitMaxX and limitMinY <= maxY and minY <= limitMaxY
end

function GearGameGameView:_getPuzzlePosLimitRectInPlace()
	local limitGo = self._puzzlePosLimit

	if not limitGo or goutil.isNil(limitGo) then
		limitGo = self._place
	end

	local width = GameUtil.getWidth(limitGo)
	local height = GameUtil.getHeight(limitGo)
	local halfWidth = width * 0.5
	local halfHeight = height * 0.5
	local corners = {
		Vector3.New(-halfWidth, -halfHeight, 0),
		Vector3.New(-halfWidth, halfHeight, 0),
		Vector3.New(halfWidth, -halfHeight, 0),
		Vector3.New(halfWidth, halfHeight, 0)
	}
	local minX, maxX, minY, maxY

	for _, corner in ipairs(corners) do
		local worldPos = limitGo.transform:TransformPoint(corner)
		local placePos = self._place.transform:InverseTransformPoint(worldPos)

		minX = minX and math.min(minX, placePos.x) or placePos.x
		maxX = maxX and math.max(maxX, placePos.x) or placePos.x
		minY = minY and math.min(minY, placePos.y) or placePos.y
		maxY = maxY and math.max(maxY, placePos.y) or placePos.y
	end

	return minX, maxX, minY, maxY
end

function GearGameGameView:_getPuzzleBoundsInPlace(data)
	local minLocalX, maxLocalX, minLocalY, maxLocalY = self:_getPuzzleLocalBounds(data, 1)
	local corners = {
		Vector3.New(minLocalX, minLocalY, 0),
		Vector3.New(minLocalX, maxLocalY, 0),
		Vector3.New(maxLocalX, minLocalY, 0),
		Vector3.New(maxLocalX, maxLocalY, 0)
	}
	local minX, maxX, minY, maxY

	for _, corner in ipairs(corners) do
		local worldPos = data.cell.transform:TransformPoint(corner)
		local placePos = self._place.transform:InverseTransformPoint(worldPos)

		minX = minX and math.min(minX, placePos.x) or placePos.x
		maxX = maxX and math.max(maxX, placePos.x) or placePos.x
		minY = minY and math.min(minY, placePos.y) or placePos.y
		maxY = maxY and math.max(maxY, placePos.y) or placePos.y
	end

	return minX, maxX, minY, maxY
end

function GearGameGameView:_getPuzzleLocalBounds(data, scale)
	scale = scale or 1

	local minX = -kHalfCell * scale
	local maxX = ((data.widthCells - 1) * kCellSize + kHalfCell) * scale
	local minY = -kHalfCell * scale
	local maxY = ((data.heightCells - 1) * kCellSize + kHalfCell) * scale

	return minX, maxX, minY, maxY
end

function GearGameGameView:_clampPlacePuzzlePos(data, x, y)
	local minX, maxX, minY, maxY = self:_getPuzzleLocalBounds(data, kPlacePuzzleScale)
	local limitMinX, limitMaxX, limitMinY, limitMaxY = self:_getPuzzlePosLimitRectInPlace()
	local minRootX = limitMinX - minX
	local maxRootX = limitMaxX - maxX
	local minRootY = limitMinY - minY
	local maxRootY = limitMaxY - maxY

	x = maxRootX < minRootX and (minRootX + maxRootX) * 0.5 or math.max(minRootX, math.min(maxRootX, x))
	y = maxRootY < minRootY and (minRootY + maxRootY) * 0.5 or math.max(minRootY, math.min(maxRootY, y))

	return x, y
end

function GearGameGameView:_clampCurrentPlacePuzzle(data)
	if not data or not data.cell or goutil.isNil(data.cell) then
		return
	end

	local pos = GameUtil.getAnchoredPos(data.cell)
	local x, y = self:_clampPlacePuzzlePos(data, pos.x, pos.y)

	GameUtil.setAnchoredPos(data.cell, x, y)
end

function GearGameGameView:_setPuzzleScale(data, scale)
	if not data or not data.cell or goutil.isNil(data.cell) then
		return
	end

	GameUtil.setLocalScale(data.cell, scale, scale, 1)
end

function GearGameGameView:_getPlaceAutoPos(index, data)
	local minX, maxX, minY, maxY = self:_getPuzzlePosLimitRectInPlace()
	local itemMinX, itemMaxX, itemMinY, itemMaxY = self:_getPuzzleLocalBounds(data, kPlacePuzzleScale)
	local areaCount = 3
	local areaIndex = math.floor((index - 1) / 2) + 1
	local isLeft = (index - 1) % 2 == 0

	areaIndex = math.min(areaCount, areaIndex)

	local areaHeight = (maxY - minY) / areaCount
	local itemCenterY = (itemMinY + itemMaxY) * 0.5
	local areaCenterY = maxY - areaHeight * (areaIndex - 0.5)

	if isLeft then
		if not (minX - itemMinX) then
			local x = maxX - itemMaxX
			local y = areaCenterY - itemCenterY

			return x, y
		end
	end
end

function GearGameGameView:_coordToLocalPos(w, h)
	return self._boardLeft + (w - 1) * kCellSize + kHalfCell, self._boardBottom + (h - 1) * kCellSize + kHalfCell
end

function GearGameGameView:_getPowerGearOffset(w, h)
	local offsetX = 0
	local offsetY = 0

	if w == 1 then
		offsetX = -kHalfCell
	elseif w == self._mapWidth then
		offsetX = kHalfCell
	end

	if h == 1 then
		offsetY = -kHalfCell
	elseif h == self._mapHeight then
		offsetY = kHalfCell
	end

	return offsetX, offsetY
end

function GearGameGameView:_relativeCellToLocal(w, h)
	return (w - 1) * kCellSize, (h - 1) * kCellSize
end

function GearGameGameView:_idToCoord(id)
	local w = (id - 1) % self._mapWidth + 1
	local h = math.floor((id - 1) / self._mapWidth) + 1

	return w, h
end

function GearGameGameView:_coordToId(w, h)
	if w < 1 or h < 1 or w > self._mapWidth or h > self._mapHeight then
		return nil
	end

	return (h - 1) * self._mapWidth + w
end

function GearGameGameView:_listToMap(list)
	local map = {}

	if list then
		for _, id in ipairs(list) do
			map[checknumber(id)] = true
		end
	end

	return map
end

function GearGameGameView:_resizeCell(go)
	GameUtil.setWidth(go, kCellSize)
	GameUtil.setHeight(go, kCellSize)
end

function GearGameGameView:_setNativeImageSize(go)
	if not go or goutil.isNil(go) then
		return
	end

	local img = go:GetComponent(goutil.Type_UIImage)

	if img then
		img:SetNativeSize()
	end
end

function GearGameGameView:_setRaycast(go, value)
	if not go or goutil.isNil(go) then
		return
	end

	local img = go:GetComponent(goutil.Type_UIImage)

	if img then
		img.raycastTarget = value == true
	end
end

function GearGameGameView:_endGameCallBack()
	local passOrNot = 1

	GearGameController.instance:sendPM_GearGameEndGameReq(self._activityId, self._stageId, passOrNot)
end

function GearGameGameView:_onClickBtnStart()
	if not self._startingGame then
		self._startingGame = true

		GearGameController.instance:sendPM_GearGameStartGameReq(self._activityId)
	end
end

function GearGameGameView:_onStartGameRes()
	GameUtil.SetActive(self._btnStart, false)

	self._startingGame = false
end

return GearGameGameView
