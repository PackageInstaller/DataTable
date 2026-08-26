-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/view/PuzzleMazeDrawBaseView.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.view.PuzzleMazeDrawBaseView", package.seeall)

local PuzzleMazeDrawBaseView = class("PuzzleMazeDrawBaseView", BaseView)

function PuzzleMazeDrawBaseView:_editableInitView()
	self:onInit()
end

function PuzzleMazeDrawBaseView:onOpen()
	self:startGame()
end

function PuzzleMazeDrawBaseView:onClose()
	self:unregisterDragCallBacks()
	self:destroyPawnObj()
	self:removeAllPathLines()
	self:removeAllMapLines()
	self:removeAllObjects()
end

function PuzzleMazeDrawBaseView:onInit()
	self._curDragLine = {
		x2 = 0,
		y2 = 0,
		x1 = 0,
		y1 = 0
	}
	self._objectMap = {}
	self._pathLineMap = {}
	self._mapLineSet = {}
	self._alertObjList = {}
	self._alertFreePool = {}

	self:setCanTouch(true)

	self._modelInst = self:getModelInst()
	self._ctrlInst = self:getCtrlInst()
	self._alertTriggerFuncMap = {}

	self:registerDragCallBacks()
end

function PuzzleMazeDrawBaseView:registerDragCallBacks()
	local goDrag = self:getDragGo()

	if goDrag then
		self._drag = SLFramework.UGUI.UIDragListener.Get(goDrag)

		self._drag:AddDragBeginListener(self.onBeginDragHandler, self)
		self._drag:AddDragListener(self.onDragHandler, self)
		self._drag:AddDragEndListener(self.onEndDragHandler, self)
	end
end

function PuzzleMazeDrawBaseView:unregisterDragCallBacks()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end
end

function PuzzleMazeDrawBaseView:startGame()
	self:setCanTouch(true)
	self:setGameFinished(false)
	self:removeAllPathLines()
	self:removeAllMapLines()
	self:removeAllObjects()
	self:initAllMapLines()
	self:initAllObjects()
	self:initPawn()
	self:syncPath()
	self:syncAlertObjs()
	self:syncCheckPoints()
	self._ctrlInst:dispatchEvent(PuzzleEvent.InitGameDone)
end

function PuzzleMazeDrawBaseView:restartGame()
	self._ctrlInst:restartGame()
	self:startGame()
end

function PuzzleMazeDrawBaseView:initAllMapLines()
	local width, height = self._modelInst:getGameSize()

	for i = 1, width + 1 do
		for j = 1, height + 1 do
			if i <= width then
				self:initMapLine(i, j, i + 1, j)
			end

			if j <= height then
				self:initMapLine(i, j, i, j + 1)
			end
		end
	end
end

function PuzzleMazeDrawBaseView:initMapLine(startPosX, startPosY, endPosX, endPosY)
	startPosX, startPosY, endPosX, endPosY = PuzzleMazeHelper.formatPos(startPosX, startPosY, endPosX, endPosY)

	local key = PuzzleMazeHelper.getLineKey(startPosX, startPosY, endPosX, endPosY)
	local lineObj = self._mapLineSet[key]

	if not lineObj then
		local lineObjCls = self:getLineObjCls(PuzzleEnum.LineType.Map)
		local lineResUrl = self:getLineResUrl(PuzzleEnum.LineType.Map)
		local lineParentGo = self:getLineParentGo(PuzzleEnum.LineType.Map)
		local itemGo = self:getResInst(lineResUrl, lineParentGo, key)
		local fillOrigin_left, fillOrigin_right = self:getLineTemplateFillOrigin()

		lineObj = lineObjCls.New(itemGo, fillOrigin_left, fillOrigin_right)
		self._mapLineSet[key] = lineObj
	end

	lineObj:onInit(startPosX, startPosY, endPosX, endPosY)

	return lineObj
end

function PuzzleMazeDrawBaseView:getOrCreatePathLine(lineType, x1, y1, x2, y2)
	x1, y1, x2, y2 = PuzzleMazeHelper.formatPos(x1, y1, x2, y2)

	local key = PuzzleMazeHelper.getLineKey(x1, y1, x2, y2)
	local lineObj = self._pathLineMap[key]

	if not lineObj then
		local lineObjCls = self:getLineObjCls(lineType)
		local lineResUrl = self:getLineResUrl(lineType)
		local lineParentGo = self:getLineParentGo(lineType)
		local itemGo = self:getResInst(lineResUrl, lineParentGo, key)
		local fillOrigin_left, fillOrigin_right = self:getLineTemplateFillOrigin()

		lineObj = lineObjCls.New(itemGo, fillOrigin_left, fillOrigin_right)

		lineObj:onInit(x1, y1, x2, y2)

		self._pathLineMap[key] = lineObj
	end

	return lineObj
end

function PuzzleMazeDrawBaseView:removeAllPathLines()
	for k, itemObj in pairs(self._pathLineMap) do
		itemObj:destroy()

		self._pathLineMap[k] = nil
	end
end

function PuzzleMazeDrawBaseView:removeAllMapLines()
	for k, itemObj in pairs(self._mapLineSet) do
		itemObj:destroy()

		self._mapLineSet[k] = nil
	end
end

function PuzzleMazeDrawBaseView:getOrCreateObject(mo)
	local key = mo:getKey()
	local itemObj = self._objectMap[key]

	if not itemObj then
		local objParentGo = self:getObjectParentGo()
		local objResUrl = self:getObjectResUrl(mo.objType, mo.subType, mo.group)
		local itemGo = self:getResInst(objResUrl, objParentGo, key)
		local cls = self:getMazeObjCls(mo.objType, mo.subType, mo.group)

		itemObj = cls.New(itemGo)
		self._objectMap[key] = itemObj
	end

	return itemObj
end

function PuzzleMazeDrawBaseView:removeAllObjects()
	for k, itemObj in pairs(self._objectMap) do
		itemObj:destroy()

		self._objectMap[k] = nil
	end
end

function PuzzleMazeDrawBaseView:initAllObjects()
	local moList = self._modelInst:getList()

	for _, mo in ipairs(moList) do
		local itemObj = self:getOrCreateObject(mo)

		itemObj:onInit(mo)
	end
end

function PuzzleMazeDrawBaseView:getOrCreateAlertObj(alertType)
	local itemObj

	if #self._alertFreePool <= 0 then
		local alertParentObj = self:getAlertParentGo(alertType)
		local alertResUrl = self:getAlertResUrl(alertType)
		local alertObjCls = self:getAlertObjCls(alertType)

		if self._alertObjList then
			if not #self._alertObjList then
				local alertUseCount = 0
				local alertObjName = string.format("alert_%s", alertUseCount + 1)
				local itemGo = self:getResInst(alertResUrl, alertParentObj, alertObjName)

				itemObj = alertObjCls.New(itemGo)
			end
		end
	else
		itemObj = table.remove(self._alertFreePool)
	end

	table.insert(self._alertObjList, itemObj)

	return itemObj
end

function PuzzleMazeDrawBaseView:recycleAlertObjs()
	for i = #self._alertObjList, 1, -1 do
		local itemObj = self._alertObjList[i]

		itemObj:onDisable()
		itemObj:onRecycle()
		table.insert(self._alertFreePool, itemObj)

		self._alertObjList[i] = nil
	end
end

function PuzzleMazeDrawBaseView:initPawn()
	local startX, startY = self._ctrlInst:getLastPos()

	if startX ~= nil then
		local x, y = self._modelInst:getObjectAnchor(startX, startY)
		local itemObj = self:getOrCreatePawnObj()

		itemObj:onInit(x, y)
	end
end

function PuzzleMazeDrawBaseView:getOrCreatePawnObj()
	local itemObj = self._objPawn

	if not itemObj then
		local pawnResUrl = self:getPawnResUrl()
		local pawnParentGo = self:getPawnParentGo()
		local itemGo = self:getResInst(pawnResUrl, pawnParentGo, "pawn")

		gohelper.setAsLastSibling(itemGo)

		local pawnObjCls = self:getPawnObjCls()

		itemObj = pawnObjCls.New(itemGo)
		self._objPawn = itemObj
	end

	return itemObj
end

function PuzzleMazeDrawBaseView:destroyPawnObj()
	local itemObj = self:getOrCreatePawnObj()

	if itemObj then
		itemObj:destroy()
	end
end

function PuzzleMazeDrawBaseView:syncPath()
	local passXList, passYList = self._ctrlInst:getPassedPoints()
	local lastX, lastY
	local syncSet = {}

	for i = 1, (passXList or nil) and (#passXList or 0) do
		local x, y = passXList[i], passYList[i]

		if lastX ~= nil then
			do
				local forwardDir = PuzzleMazeHelper.getFromToDir(lastX, lastY, x, y)

				if forwardDir then
					do
						local key = PuzzleMazeHelper.getLineKey(lastX, lastY, x, y)
						local lineObj = self:getOrCreatePathLine(PuzzleEnum.LineType.Path, lastX, lastY, x, y)

						lineObj:onCrossFull(forwardDir)
						lineObj:onAlert(self._alertType)

						syncSet[key] = true
					end
				else
					logNormal(string.format("error dir in (%s,%s,%s,%s)", lastX, lastY, x, y))
				end
			end

			lastY = y
		end

		lastX = x
	end

	for k, itemObj in pairs(self._pathLineMap) do
		if not syncSet[k] then
			itemObj:clear()
		end
	end

	self._ctrlInst:resetLineDirty()
end

function PuzzleMazeDrawBaseView:syncDragLine()
	local isDirty = false
	local x, y, progressX, progressY = self._ctrlInst:getProgressLine()

	if not self._ctrlInst:isBackward(x, y) then
		local alertMap = self._ctrlInst:getAlertMap()

		for mo, _ in pairs(alertMap) do
			return false
		end
	end

	local progress = progressX or progressY

	if x and y and progress then
		local curX, curY = self._ctrlInst:getLastPos()
		local x1, y1, x2, y2 = PuzzleMazeHelper.formatPos(curX, curY, x, y)

		if self._curDragLine.x1 ~= x1 or self._curDragLine.y1 ~= y1 or self._curDragLine.x2 ~= x2 or self._curDragLine.y2 ~= y2 then
			self._curDragLine.x1, self._curDragLine.y1, self._curDragLine.x2, self._curDragLine.y2 = x1, y1, x2, y2
			isDirty = true

			self:cleanDragLine()
		end

		local dir = PuzzleMazeHelper.getFromToDir(curX, curY, x, y)
		local pawnObj = self:getOrCreatePawnObj()

		pawnObj:setDir(dir)

		local lineObj = self:getOrCreatePathLine(PuzzleEnum.LineType.Path, x1, y1, x2, y2)

		lineObj:onCrossHalf(dir, progress)

		return isDirty
	end

	return false
end

function PuzzleMazeDrawBaseView:syncAlertObjs()
	self:recycleAlertObjs()

	self._alertType = PuzzleEnum.MazeAlertType.None

	local alertMap = self._ctrlInst:getAlertMap()

	if alertMap then
		for key, alertType in pairs(alertMap) do
			self:onTriggerAlert(alertType, key)

			self._alertType = alertType

			return
		end
	end
end

function PuzzleMazeDrawBaseView:onTriggerAlert(alertType, alertObj)
	local alertItem = self:getOrCreateAlertObj(alertType)

	alertItem:onEnable(alertType, alertObj)

	local alertTriggerFunc = self:getAlertTriggerFunc(alertType)

	if alertTriggerFunc then
		alertTriggerFunc(self, alertObj)
	end
end

function PuzzleMazeDrawBaseView:registerAlertTriggerFunc(alertType, alertTriggerFunc)
	if not alertType or not alertTriggerFunc then
		logError("注册警告触发方法时警告类型及回调方法不可为空")

		return
	end

	if self._alertTriggerFuncMap[alertType] then
		logError("注册了重复的警告执行方法 :" .. tostring(alertType))

		return
	end

	self._alertTriggerFuncMap[alertType] = alertTriggerFunc
end

function PuzzleMazeDrawBaseView:getAlertTriggerFunc(alertType)
	if not alertType then
		return
	end

	return self._alertTriggerFuncMap and self._alertTriggerFuncMap[alertType]
end

function PuzzleMazeDrawBaseView:onBeginDragHandler(_, pointerEventData)
	local canTouch = self:canTouch()

	if not canTouch then
		self:onBeginDragFailed(pointerEventData)

		return
	end

	self:onBeginDragSucc(pointerEventData)
end

function PuzzleMazeDrawBaseView:onDragHandler(_, pointerEventData)
	local canTouch = self:canTouch()

	if not canTouch then
		return
	end

	if self._isPawnMoving then
		local dragGo = self:getDragGo()
		local tempPos = recthelper.screenPosToAnchorPos(pointerEventData.position, dragGo.transform)

		self:onDrag_StartProcessPos(pointerEventData, tempPos)
		self:onDrag_EndProcessPos(pointerEventData, tempPos)
	end
end

function PuzzleMazeDrawBaseView:onDrag_StartProcessPos(pointerEventData, dragPos)
	local x, y = self._modelInst:getClosePosByTouchPos(dragPos.x, dragPos.y)

	if x ~= -1 then
		self._ctrlInst:goPassPos(x, y)
	else
		local rs, x1, y1, x2, y2, progressX, progressY = self._modelInst:getLineFieldByTouchPos(dragPos.x, dragPos.y)

		if rs then
			self._ctrlInst:goPassLine(x1, y1, x2, y2, progressX, progressY)
		end
	end
end

function PuzzleMazeDrawBaseView:onDrag_EndProcessPos(pointerEventData, dragPos)
	self:onDrag_SyncPawn(pointerEventData, dragPos)
	self:onDrag_SyncPath(pointerEventData, dragPos)
end

function PuzzleMazeDrawBaseView:onDrag_SyncPath(pointerEventData, dragPos)
	local isLineDirty = self._ctrlInst:isLineDirty()

	if isLineDirty then
		self:syncPath()
		self:syncAlertObjs()
		self:syncCheckPoints()
	end

	local isDirty = self:syncDragLine()

	if not isLineDirty and isDirty then
		self:syncPath()
	end

	if isLineDirty then
		self:checkGameFinished()
	end
end

function PuzzleMazeDrawBaseView:onEndDragHandler(_, pointerEventData)
	local canTouch = self:canTouch()

	if not canTouch then
		return
	end

	if self._isPawnMoving then
		self._isPawnMoving = false

		if self._ctrlInst:hasAlertObj() then
			self:onEndDrag_HasAlert()
		else
			self:onEndDrag_NoneAlert()
		end
	end
end

function PuzzleMazeDrawBaseView:cleanDragLine()
	for _, lineObj in pairs(self._pathLineMap) do
		local progress = lineObj:getProgress()

		if progress <= 0.999 and progress >= 0.01 then
			lineObj:clear()
		end
	end
end

function PuzzleMazeDrawBaseView:syncCheckPoints()
	local objList = self._modelInst:getList()
	local checkSum = {}
	local checkCount = 0

	for _, mo in ipairs(objList) do
		local itemObj = self:getOrCreateObject(mo)

		if mo.objType == PuzzleEnum.MazeObjType.CheckPoint and self._ctrlInst:alreadyCheckPoint(mo) then
			table.insert(checkSum, tostring(mo))

			checkCount = checkCount + 1
		end

		self:tickObjBehaviour(mo, itemObj)
	end

	checkSum = table.concat(checkSum)

	self:onEndRefreshCheckPoint(self._lastCheckSum, checkSum, self._lastCheckCount, checkCount)
end

function PuzzleMazeDrawBaseView:tickObjBehaviour(mo, itemObj)
	local alreadyCheck = false

	if mo.objType ~= PuzzleEnum.MazeObjType.Block then
		alreadyCheck = self._ctrlInst:alreadyPassed(mo.x, mo.y)
	end

	local hasEnter = itemObj:HasEnter()

	if hasEnter then
		if alreadyCheck then
			itemObj:onAlreadyEnter()
		else
			itemObj:onExit()
		end
	elseif not hasEnter and alreadyCheck then
		itemObj:onEnter()
	end
end

function PuzzleMazeDrawBaseView:checkGameFinished()
	local isFinished = self:isGameFinished()

	if isFinished then
		return
	end

	local isFailed = self:checkIsGameFailed()

	if isFailed then
		self:onGameFailed()

		return
	end

	local isSucc = self:checkIsGameSucc()

	if isSucc then
		self:onGameSucc()

		return
	end
end

function PuzzleMazeDrawBaseView:onBeginDragSucc(pointerEventData)
	local lastX, lastY = self._ctrlInst:getLastPos()
	local x, y = self:getPawnPosByPointerEventData(pointerEventData)

	if x ~= -1 and lastX == x and lastY == y then
		self:onBeginDrag_SyncPawn()
	end
end

function PuzzleMazeDrawBaseView:getPawnPosByPointerEventData(pointerEventData)
	local dragGo = self:getDragGo()
	local tempPos = recthelper.screenPosToAnchorPos(pointerEventData.position, dragGo.transform)
	local x, y = self._modelInst:getClosePosByTouchPos(tempPos.x - PuzzleEnum.mazeMonsterTouchOffsetX, tempPos.y - PuzzleEnum.mazeMonsterHeight)

	return x, y
end

function PuzzleMazeDrawBaseView:onEndDrag_HasAlert()
	self._ctrlInst:goBackPos()
	self:onEndDrag_SyncPawn()
	self:syncAlertObjs()
	self:syncPath()
	self:cleanDragLine()
	self:syncCheckPoints()
end

function PuzzleMazeDrawBaseView:onEndDrag_NoneAlert()
	self:onEndDrag_SyncPawn()
	self:syncPath()
	self:cleanDragLine()
	self:checkGameFinished()
end

function PuzzleMazeDrawBaseView:onBeginDrag_SyncPawn()
	self._isPawnMoving = true

	local pawnObj = self:getOrCreatePawnObj()

	pawnObj:onBeginDrag()
	self._ctrlInst:dispatchEvent(PuzzleEvent.OnBeginDragPawn)
end

function PuzzleMazeDrawBaseView:onDrag_SyncPawn(pointerEventData, dragPos)
	local pawnObj = self:getOrCreatePawnObj()

	pawnObj:onDraging(dragPos.x, dragPos.y)
end

function PuzzleMazeDrawBaseView:onEndDrag_SyncPawn()
	local curX, curY = self._ctrlInst:getLastPos()
	local x, y = self._modelInst:getObjectAnchor(curX, curY)
	local itemObj = self:getOrCreatePawnObj()

	itemObj:onEndDrag(x, y)
	self._ctrlInst:dispatchEvent(PuzzleEvent.OnEndDragPawn)
end

function PuzzleMazeDrawBaseView:canTouch()
	return self._canTouch
end

function PuzzleMazeDrawBaseView:setCanTouch(canTouch)
	self._canTouch = canTouch
end

function PuzzleMazeDrawBaseView:onBeginDragFailed(pointerEventData)
	return
end

function PuzzleMazeDrawBaseView:onEndRefreshCheckPoint(lastCheckSum, checkSum, lastCheckCount, checkCount)
	self._lastCheckSum = checkSum
	self._lastCheckCount = checkCount
end

function PuzzleMazeDrawBaseView:checkIsGameSucc()
	return self._ctrlInst:isGameClear()
end

function PuzzleMazeDrawBaseView:onGameSucc()
	if self._isPawnMoving then
		self:onEndDrag_SyncPawn()
	end

	self:setCanTouch(false)
	self:setGameFinished(true)
	self._modelInst:setGameStatus(true)

	local elementCo = self._modelInst:getElementCo()
	local elementId = elementCo and elementCo.id
	local isElementFinished = DungeonModel.instance:isFinishElementList(elementCo)

	if elementId and not isElementFinished then
		DungeonRpc.instance:sendMapElementRequest(elementId)
	end

	self._ctrlInst:dispatchEvent(PuzzleEvent.OnGameFinished, elementId)
end

function PuzzleMazeDrawBaseView:checkIsGameFailed()
	return
end

function PuzzleMazeDrawBaseView:onGameFailed()
	self:setGameFinished(true)
end

function PuzzleMazeDrawBaseView:isGameFinished()
	return self._isFinished
end

function PuzzleMazeDrawBaseView:setGameFinished(isFinished)
	self._isFinished = isFinished
end

function PuzzleMazeDrawBaseView:getModelInst()
	return
end

function PuzzleMazeDrawBaseView:getCtrlInst()
	return
end

function PuzzleMazeDrawBaseView:getDragGo()
	return
end

function PuzzleMazeDrawBaseView:getLineParentGo()
	return
end

function PuzzleMazeDrawBaseView:getPawnParentGo()
	return
end

function PuzzleMazeDrawBaseView:getObjectParentGo()
	return
end

function PuzzleMazeDrawBaseView:getAlertParentGo()
	return
end

function PuzzleMazeDrawBaseView:getMazeObjCls(objType, subType, group)
	return
end

function PuzzleMazeDrawBaseView:getPawnObjCls()
	return
end

function PuzzleMazeDrawBaseView:getLineObjCls(lineType)
	return
end

function PuzzleMazeDrawBaseView:getAlertObjCls(alertType)
	return
end

function PuzzleMazeDrawBaseView:getPawnResUrl()
	return
end

function PuzzleMazeDrawBaseView:getLineResUrl(lineType)
	return
end

function PuzzleMazeDrawBaseView:getObjectResUrl(objType, subType, group)
	return
end

function PuzzleMazeDrawBaseView:getAlertResUrl(alertType)
	return
end

function PuzzleMazeDrawBaseView:getLineTemplateFillOrigin()
	return
end

return PuzzleMazeDrawBaseView
