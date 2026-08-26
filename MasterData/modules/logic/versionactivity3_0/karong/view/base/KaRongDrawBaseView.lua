-- chunkname: @modules/logic/versionactivity3_0/karong/view/base/KaRongDrawBaseView.lua

module("modules.logic.versionactivity3_0.karong.view.base.KaRongDrawBaseView", package.seeall)

local KaRongDrawBaseView = class("KaRongDrawBaseView", BaseView)

function KaRongDrawBaseView:_editableInitView()
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
	self._modelInst = self:getModelInst()
	self._ctrlInst = self:getCtrlInst()
	self._alertTriggerFuncMap = {}

	local goDrag = self:getDragGo()

	if goDrag then
		self._drag = SLFramework.UGUI.UIDragListener.Get(goDrag)

		self._drag:AddDragBeginListener(self.onBeginDragHandler, self)
		self._drag:AddDragListener(self.onDragHandler, self)
		self._drag:AddDragEndListener(self.onEndDragHandler, self)
	end
end

function KaRongDrawBaseView:onDestroyView()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end

	self:destroyPawnObj()
	self:removeAllPathLines()
	self:removeAllMapLines()
	self:removeAllObjects()
end

function KaRongDrawBaseView:startGame()
	self._hasAvatar = not not self._modelInst:getAvatarStartPos()

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
	self._ctrlInst:dispatchEvent(KaRongDrawEvent.InitGameDone)
end

function KaRongDrawBaseView:restartGame()
	self._ctrlInst:restartGame()
	self:startGame()
end

function KaRongDrawBaseView:initAllMapLines()
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

function KaRongDrawBaseView:initMapLine(startPosX, startPosY, endPosX, endPosY)
	startPosX, startPosY, endPosX, endPosY = KaRongDrawHelper.formatPos(startPosX, startPosY, endPosX, endPosY)

	local key = KaRongDrawHelper.getLineKey(startPosX, startPosY, endPosX, endPosY)
	local lineObj = self._mapLineSet[key]

	if not lineObj then
		local lineObjCls = self:getLineObjCls(KaRongDrawEnum.LineType.Map)
		local lineResUrl = self:getLineResUrl(KaRongDrawEnum.LineType.Map)
		local lineParentGo = self:getLineParentGo(KaRongDrawEnum.LineType.Map)
		local itemGo = self:getResInst(lineResUrl, lineParentGo, key)
		local fillOrigin_left, fillOrigin_right = self:getLineTemplateFillOrigin()

		lineObj = lineObjCls.New(itemGo, fillOrigin_left, fillOrigin_right)
		self._mapLineSet[key] = lineObj
	end

	lineObj:onInit(startPosX, startPosY, endPosX, endPosY)

	return lineObj
end

function KaRongDrawBaseView:getOrCreatePathLine(lineType, x1, y1, x2, y2)
	x1, y1, x2, y2 = KaRongDrawHelper.formatPos(x1, y1, x2, y2)

	local key = KaRongDrawHelper.getLineKey(x1, y1, x2, y2)
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

function KaRongDrawBaseView:removeAllPathLines()
	for k, itemObj in pairs(self._pathLineMap) do
		itemObj:destroy()

		self._pathLineMap[k] = nil
	end
end

function KaRongDrawBaseView:removeAllMapLines()
	for k, itemObj in pairs(self._mapLineSet) do
		itemObj:destroy()

		self._mapLineSet[k] = nil
	end
end

function KaRongDrawBaseView:getOrCreateObject(mo)
	local key = mo.key
	local itemObj = self._objectMap[key]

	if not itemObj then
		local objParentGo = self:getObjectParentGo(mo.objType)
		local objResUrl = self:getObjectResUrl(mo.objType, mo.subType, mo.group)
		local itemGo = self:getResInst(objResUrl, objParentGo, key)
		local cls = self:getMazeObjCls(mo.objType, mo.subType, mo.group)

		itemObj = cls.New(itemGo)
		self._objectMap[key] = itemObj
	end

	return itemObj
end

function KaRongDrawBaseView:removeAllObjects()
	for k, itemObj in pairs(self._objectMap) do
		itemObj:destroy()

		self._objectMap[k] = nil
	end
end

function KaRongDrawBaseView:initAllObjects()
	local moList = self._modelInst:getList()

	for _, mo in ipairs(moList) do
		local itemObj = self:getOrCreateObject(mo)

		itemObj:onInit(mo)
	end
end

function KaRongDrawBaseView:getOrCreateAlertObj(alertType)
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

function KaRongDrawBaseView:recycleAlertObjs()
	for i = #self._alertObjList, 1, -1 do
		local itemObj = self._alertObjList[i]

		itemObj:onDisable()
		table.insert(self._alertFreePool, itemObj)

		self._alertObjList[i] = nil
	end
end

function KaRongDrawBaseView:initPawn()
	local startX, startY = self._ctrlInst:getLastPos()

	if startX ~= nil then
		local x, y = self._modelInst:getObjectAnchor(startX, startY)
		local itemObj = self:getOrCreatePawnObj()

		itemObj:onInit(x, y)
	end

	local pos = self._modelInst:getAvatarStartPos()

	if pos then
		local x, y = self._modelInst:getObjectAnchor(pos.x, pos.y)
		local itemObj = self:getOrCreateAvatar()

		itemObj:onInit(x, y)
	end
end

function KaRongDrawBaseView:getOrCreatePawnObj()
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

function KaRongDrawBaseView:getOrCreateAvatar()
	if not self._objAvatar then
		local pawnResUrl = self:getPawnResUrl()
		local pawnParentGo = self:getPawnParentGo()
		local itemGo = self:getResInst(pawnResUrl, pawnParentGo, "avatar")

		gohelper.setAsLastSibling(itemGo)

		local pawnObjCls = self:getPawnObjCls()

		self._objAvatar = pawnObjCls.New(itemGo, true)
	end

	return self._objAvatar
end

function KaRongDrawBaseView:destroyPawnObj()
	if self._objPawn then
		self._objPawn:destroy()
	end

	if self._objAvatar then
		self._objAvatar:destroy()
	end
end

function KaRongDrawBaseView:syncPath()
	local passXList, passYList = self._ctrlInst:getPassedPoints()
	local lastX, lastY
	local syncSet = {}

	for i = 1, (passXList or nil) and (#passXList or 0) do
		local x, y = passXList[i], passYList[i]

		if lastX ~= nil then
			do
				local forwardDir = KaRongDrawHelper.getFromToDir(lastX, lastY, x, y)

				if forwardDir then
					local key = KaRongDrawHelper.getLineKey(lastX, lastY, x, y)
					local lineObj = self:getOrCreatePathLine(KaRongDrawEnum.LineType.Path, lastX, lastY, x, y)

					lineObj:onCrossFull(forwardDir)
					lineObj:onAlert(self._alertType)

					syncSet[key] = true
				end
			end

			lastY = y
		end

		lastX = x
	end

	local passPoints = self._ctrlInst:getAvatarPassPoints()

	if passPoints then
		lastY = nil
		lastX = nil

		for _, v in ipairs(passPoints) do
			if lastX ~= nil then
				do
					local forwardDir = KaRongDrawHelper.getFromToDir(lastX, lastY, v.x, v.y)

					if forwardDir then
						local key = KaRongDrawHelper.getLineKey(lastX, lastY, v.x, v.y)
						local lineObj = self:getOrCreatePathLine(KaRongDrawEnum.LineType.Path, lastX, lastY, v.x, v.y)

						lineObj:onCrossFull(forwardDir)
						lineObj:onAlert(self._alertType)

						syncSet[key] = true
					end
				end

				lastY = v.y
			end

			lastX = v.x
		end
	end

	for k, itemObj in pairs(self._pathLineMap) do
		if not syncSet[k] then
			itemObj:clear()
		end
	end

	self._ctrlInst:resetLineDirty()
end

function KaRongDrawBaseView:syncDragLine()
	local isDirty = false
	local x, y, progressX, progressY = self._ctrlInst:getProgressLine()

	if not self._ctrlInst:isBackward(x, y) then
		local alertMap = self._ctrlInst:getAlertMap()

		if next(alertMap) then
			return false
		end
	end

	local progress = progressX or progressY

	if x and y and progress then
		local curX, curY = self._ctrlInst:getLastPos()
		local x1, y1, x2, y2 = KaRongDrawHelper.formatPos(curX, curY, x, y)

		if self._curDragLine.x1 ~= x1 or self._curDragLine.y1 ~= y1 or self._curDragLine.x2 ~= x2 or self._curDragLine.y2 ~= y2 then
			self._curDragLine.x1, self._curDragLine.y1, self._curDragLine.x2, self._curDragLine.y2 = x1, y1, x2, y2
			isDirty = true

			self:cleanDragLine()
		end

		local dir = KaRongDrawHelper.getFromToDir(curX, curY, x, y)
		local pawnObj = self:getOrCreatePawnObj()

		pawnObj:setDir(dir)

		if self._hasAvatar then
			local avatar = self:getOrCreateAvatar()

			avatar:setDir(dir)
		end

		local lineObj = self:getOrCreatePathLine(KaRongDrawEnum.LineType.Path, x1, y1, x2, y2)

		lineObj:onCrossHalf(dir, progress)

		return isDirty
	end

	return false
end

function KaRongDrawBaseView:syncAlertObjs()
	self:recycleAlertObjs()

	self._alertType = KaRongDrawEnum.MazeAlertType.None

	local alertMap = self._ctrlInst:getAlertMap()

	if alertMap then
		for key, alertType in pairs(alertMap) do
			self:onTriggerAlert(alertType, key)

			self._alertType = alertType

			return
		end
	end
end

function KaRongDrawBaseView:onTriggerAlert(alertType, alertObj)
	local alertItem = self:getOrCreateAlertObj(alertType)

	alertItem:onEnable(alertType, alertObj)

	local alertTriggerFunc = self:getAlertTriggerFunc(alertType)

	if alertTriggerFunc then
		alertTriggerFunc(self, alertObj)
	end
end

function KaRongDrawBaseView:registerAlertTriggerFunc(alertType, alertTriggerFunc)
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

function KaRongDrawBaseView:getAlertTriggerFunc(alertType)
	if not alertType then
		return
	end

	return self._alertTriggerFuncMap and self._alertTriggerFuncMap[alertType]
end

function KaRongDrawBaseView:onBeginDragHandler(_, pointerEventData)
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	local lastX, lastY = self._ctrlInst:getLastPos()
	local x, y = self:getPawnPosByPointerEventData(pointerEventData)

	if x ~= -1 and lastX == x and lastY == y then
		self._isPawnMoving = true

		local pawnObj = self:getOrCreatePawnObj()

		pawnObj:onBeginDrag()
		self._ctrlInst:dispatchEvent(KaRongDrawEvent.OnBeginDragPawn)
	end
end

function KaRongDrawBaseView:onDragHandler(_, pointerEventData)
	if not self._canTouch then
		return
	end

	if self._isPawnMoving then
		local isCheckPoint = false
		local dragGo = self:getDragGo()
		local dragPos = recthelper.screenPosToAnchorPos(pointerEventData.position, dragGo.transform)
		local x, y = self._modelInst:getClosePosByTouchPos(dragPos.x, dragPos.y)

		if x ~= -1 then
			isCheckPoint = self._ctrlInst:goPassPos(x, y)
		else
			local rs, x1, y1, x2, y2, progressX, progressY = self._modelInst:getLineFieldByTouchPos(dragPos.x, dragPos.y)

			if rs then
				self._ctrlInst:goPassLine(x1, y1, x2, y2, progressX, progressY)
			end
		end

		local pawnObj = self:getOrCreatePawnObj()

		pawnObj:onDraging(dragPos.x, dragPos.y)
		self:onDrag_SyncPath(pointerEventData, dragPos)

		if isCheckPoint then
			self:onEndDragHandler()
		end
	end
end

function KaRongDrawBaseView:onDrag_SyncPath(pointerEventData, dragPos)
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

function KaRongDrawBaseView:onEndDragHandler(_, pointerEventData)
	if not self._canTouch then
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

function KaRongDrawBaseView:onEndDrag_HasAlert()
	self._ctrlInst:goBackPos()
	self:onEndDrag_SyncPawn()
	self:syncAlertObjs()
	self:syncPath()
	self:cleanDragLine()
	self:syncCheckPoints()
end

function KaRongDrawBaseView:onEndDrag_NoneAlert()
	self:onEndDrag_SyncPawn()
	self:syncPath()
	self:cleanDragLine()
	self:checkGameFinished()
end

function KaRongDrawBaseView:cleanDragLine()
	for _, lineObj in pairs(self._pathLineMap) do
		local progress = lineObj:getProgress()

		if progress <= 0.999 and progress >= 0.01 then
			lineObj:clear()
		end
	end
end

function KaRongDrawBaseView:syncCheckPoints()
	local objList = self._modelInst:getList()
	local checkSum = {}
	local checkCount = 0

	for _, mo in ipairs(objList) do
		local itemObj = self:getOrCreateObject(mo)

		if mo.objType == KaRongDrawEnum.MazeObjType.CheckPoint and self._ctrlInst:alreadyCheckPoint(mo) then
			table.insert(checkSum, tostring(mo))

			checkCount = checkCount + 1
		end

		self:tickObjBehaviour(mo, itemObj)
	end

	checkSum = table.concat(checkSum)

	if self._lastCheckSum and self._lastCheckSum ~= checkSum and checkCount >= self._lastCheckCount then
		AudioMgr.instance:trigger(AudioEnum3_0.ActKaRong.play_ui_lushang_arrival)
	end

	self._lastCheckSum = checkSum
	self._lastCheckCount = checkCount
end

function KaRongDrawBaseView:tickObjBehaviour(mo, itemObj)
	local alreadyCheck = false

	if not mo.obstacle then
		alreadyCheck = self._ctrlInst:alreadyPassed(mo.x, mo.y) or self._ctrlInst:alreadyAvatarPassed(mo.x, mo.y)
	end

	if itemObj.isEnter then
		if not alreadyCheck then
			itemObj:onExit()
		end
	elseif alreadyCheck then
		itemObj:onEnter()
	end
end

function KaRongDrawBaseView:checkGameFinished()
	local isFinished = self:isGameFinished()

	if isFinished then
		return
	end

	local isSucc = self._ctrlInst:isGameClear()

	if isSucc then
		self:onGameSucc()

		return
	end
end

function KaRongDrawBaseView:getPawnPosByPointerEventData(pointerEventData)
	local dragGo = self:getDragGo()
	local tempPos = recthelper.screenPosToAnchorPos(pointerEventData.position, dragGo.transform)
	local x, y = self._modelInst:getClosePosByTouchPos(tempPos.x - KaRongDrawEnum.mazeMonsterTouchOffsetX, tempPos.y - KaRongDrawEnum.mazeMonsterHeight)

	return x, y
end

function KaRongDrawBaseView:onEndDrag_SyncPawn()
	local curX, curY = self._ctrlInst:getLastPos()
	local x, y = self._modelInst:getObjectAnchor(curX, curY)
	local itemObj = self:getOrCreatePawnObj()

	itemObj:onEndDrag(x, y)
	self:_syncAvatar()
	self._ctrlInst:dispatchEvent(KaRongDrawEvent.OnEndDragPawn)
end

function KaRongDrawBaseView:setCanTouch(canTouch)
	self._canTouch = canTouch
end

function KaRongDrawBaseView:onGameSucc()
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

	self._ctrlInst:dispatchEvent(KaRongDrawEvent.OnGameFinished, elementId)
end

function KaRongDrawBaseView:isGameFinished()
	return self._isFinished
end

function KaRongDrawBaseView:setGameFinished(isFinished)
	self._isFinished = isFinished
end

function KaRongDrawBaseView:getModelInst()
	return
end

function KaRongDrawBaseView:getCtrlInst()
	return
end

function KaRongDrawBaseView:getDragGo()
	return
end

function KaRongDrawBaseView:getLineParentGo()
	return
end

function KaRongDrawBaseView:getPawnParentGo()
	return
end

function KaRongDrawBaseView:getObjectParentGo()
	return
end

function KaRongDrawBaseView:getAlertParentGo()
	return
end

function KaRongDrawBaseView:getMazeObjCls(objType, subType, group)
	return
end

function KaRongDrawBaseView:getPawnObjCls()
	return
end

function KaRongDrawBaseView:getLineObjCls(lineType)
	return
end

function KaRongDrawBaseView:getAlertObjCls(alertType)
	return
end

function KaRongDrawBaseView:getPawnResUrl()
	return
end

function KaRongDrawBaseView:getLineResUrl(lineType)
	return
end

function KaRongDrawBaseView:getObjectResUrl(objType, subType, group)
	return
end

function KaRongDrawBaseView:getAlertResUrl(alertType)
	return
end

function KaRongDrawBaseView:getLineTemplateFillOrigin()
	return
end

function KaRongDrawBaseView:_syncAvatar()
	local pos = self._ctrlInst:getAvatarPos()

	if pos then
		local x, y = self._modelInst:getObjectAnchor(pos.x, pos.y)
		local avatar = self:getOrCreateAvatar()

		avatar:onEndDrag(x, y)
	end
end

return KaRongDrawBaseView
