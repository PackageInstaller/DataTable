-- chunkname: @modules/logic/dungeon/view/puzzle/DungeonPuzzleMazeDraw.lua

module("modules.logic.dungeon.view.puzzle.DungeonPuzzleMazeDraw", package.seeall)

local DungeonPuzzleMazeDraw = class("DungeonPuzzleMazeDraw", BaseView)

function DungeonPuzzleMazeDraw:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._goconnect = gohelper.findChild(self.viewGO, "#go_connect")
	self._imagelinetemplater = gohelper.findChildImage(self.viewGO, "#image_line_template_r")
	self._imagelinetemplatel = gohelper.findChildImage(self.viewGO, "#image_line_template_l")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonPuzzleMazeDraw:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function DungeonPuzzleMazeDraw:removeEvents()
	self._btnreset:RemoveClickListener()
end

function DungeonPuzzleMazeDraw:_editableInitView()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gomap)

	self._drag:AddDragBeginListener(self.onDragBeginHandler, self)
	self._drag:AddDragListener(self.onDragCallHandler, self)
	self._drag:AddDragEndListener(self.onDragEndHandler, self)

	self._drawHandleMap = {
		[DungeonPuzzleEnum.MazeObjType.Start] = self.drawNormalObject,
		[DungeonPuzzleEnum.MazeObjType.End] = self.drawNormalObject,
		[DungeonPuzzleEnum.MazeObjType.CheckPoint] = self.drawCheckPoint,
		[DungeonPuzzleEnum.MazeObjType.CheckPointPassed] = self.drawCheckPoint,
		[DungeonPuzzleEnum.MazeObjType.Block] = self.drawBlockObject
	}
	self._curDragLine = {
		x2 = 0,
		y2 = 0,
		x1 = 0,
		y1 = 0
	}
	self._objectMap = {}
	self._lineMap = {}
	self._alertObjList = {}
	self._alertSymbolPool = {}
	self._canTouch = true
end

function DungeonPuzzleMazeDraw:onDestroyView()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end
end

function DungeonPuzzleMazeDraw:onOpen()
	self:drawAllObjects()
	self:restartGame()
end

function DungeonPuzzleMazeDraw:onClose()
	local itemObj = self:getOrCreatePawnObj()

	if itemObj.animEvent then
		itemObj.animEvent:RemoveEventListener(DungeonPuzzleEnum.AnimEvent_OnJump)
	end
end

function DungeonPuzzleMazeDraw:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		self:_resetGame()
	end)
end

function DungeonPuzzleMazeDraw:_resetGame()
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	self:removeAllLine()
	self:removeAllObjects()
	self:restartGame()
	self:drawAllObjects()

	local itemObj = self:getOrCreatePawnObj()

	gohelper.setAsLastSibling(itemObj.go)
end

function DungeonPuzzleMazeDraw:drawAllObjects()
	local moList = DungeonPuzzleMazeDrawModel.instance:getList()

	for _, mo in ipairs(moList) do
		local func = self._drawHandleMap[mo.objType]

		if func then
			if mo.isPos then
				func(self, mo, mo.x, mo.y)
			else
				func(self, mo, mo.x1, mo.y1, mo.x2, mo.y2)
			end
		end
	end
end

function DungeonPuzzleMazeDraw:drawNormalObject(mo, x, y)
	local itemObj = self:getOrCreateObject(true, x, y)

	gohelper.setActive(itemObj.go, true)

	local resConst = DungeonPuzzleEnum.MazeObjResType[mo.objType]
	local path = resConst[1]

	UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
	recthelper.setAnchor(itemObj.imageTf, resConst[2], resConst[3])

	if mo.objType == DungeonPuzzleEnum.MazeObjType.Start or mo.objType == DungeonPuzzleEnum.MazeObjType.End then
		gohelper.setActive(itemObj.goChecked, true)
		itemObj.anim:Play("highlight_loop", 0, 0)
	end
end

function DungeonPuzzleMazeDraw:drawBlockObject(mo, x1, y1, x2, y2)
	local itemObj = self:getOrCreateObject(false, x1, y1, x2, y2)

	gohelper.setActive(itemObj.go, true)

	if not DungeonPuzzleEnum.mazeBlockResMap[mo.val] then
		local resConst = DungeonPuzzleEnum.MazeObjResType[mo.objType]
		local path = resConst[1]

		UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
		recthelper.setAnchor(itemObj.imageTf, resConst[2], resConst[3])
	end
end

function DungeonPuzzleMazeDraw:drawCheckPoint(mo, x, y)
	local itemObj = self:getOrCreateObject(true, x, y)

	gohelper.setActive(itemObj.go, true)

	local objType = mo.objType
	local resConst

	if DungeonPuzzleMazeDrawController.instance:alreadyCheckPoint(mo) then
		gohelper.setActive(itemObj.goChecked, true)

		objType = DungeonPuzzleEnum.MazeObjType.CheckPointPassed
		resConst = DungeonPuzzleEnum.mazeCheckPointPassedResMap[mo.val] or DungeonPuzzleEnum.MazeObjResType[objType]
	else
		gohelper.setActive(itemObj.goChecked, false)

		resConst = DungeonPuzzleEnum.mazeCheckPointResMap[mo.val] or DungeonPuzzleEnum.MazeObjResType[objType]
	end

	local path = resConst[1]

	UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
	UISpriteSetMgr.instance:setPuzzleSprite(itemObj.imageChecked, path, true)
	recthelper.setAnchor(itemObj.imageTf, resConst[2], resConst[3])
end

function DungeonPuzzleMazeDraw:getOrCreatePawnObj()
	local itemObj = self._objPawn

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local itemPath = self.viewContainer:getSetting().otherRes[3]
		local itemGo = self:getResInst(itemPath, self._gomap, "pawn")

		itemObj.go = itemGo
		itemObj.image = gohelper.findChildImage(itemGo, "#go_ctrl/#image_content")
		itemObj.imageTf = itemObj.image.transform
		itemObj.goCtrl = gohelper.findChild(itemGo, "#go_ctrl")
		itemObj.tf = itemGo.transform
		itemObj.dir = DungeonPuzzleEnum.dir.left
		itemObj.anim = itemObj.image.gameObject:GetComponent(typeof(UnityEngine.Animator))

		itemObj.anim:Play("open")

		itemObj.animEvent = itemObj.image.gameObject:GetComponent(typeof(ZProj.AnimationEventWrap))

		itemObj.animEvent:AddEventListener(DungeonPuzzleEnum.AnimEvent_OnJump, self.onPawnJump, self)
		transformhelper.setLocalScale(itemObj.goCtrl.transform, 1.5, 1.5, 1)

		local resConst = DungeonPuzzleEnum.MazePawnPath
		local path = resConst[1]

		UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
		recthelper.setAnchor(itemObj.goCtrl.transform, resConst[2], resConst[3])

		self._objPawn = itemObj
	end

	return itemObj
end

function DungeonPuzzleMazeDraw:onPawnJump()
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_move)
end

function DungeonPuzzleMazeDraw:initPawn()
	local startX, startY = DungeonPuzzleMazeDrawModel.instance:getStartPoint()

	if startX ~= nil then
		local x, y = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(startX, startY)
		local itemObj = self:getOrCreatePawnObj()

		recthelper.setAnchor(itemObj.tf, x, y)
		gohelper.setAsLastSibling(itemObj.go)
	end
end

function DungeonPuzzleMazeDraw:restartGame()
	logNormal("restartGame")

	self._canTouch = true
	self._isClear = false
	self._alreadyDrag = false

	DungeonPuzzleMazeDrawController.instance:startGame()
	self:initPawn()
end

function DungeonPuzzleMazeDraw:syncPath()
	local passXList, passYList = DungeonPuzzleMazeDrawController.instance:getPassedPoints()
	local lastX, lastY
	local syncSet = {}

	for i = 1, #passXList do
		local x, y = passXList[i], passYList[i]

		if lastX ~= nil then
			do
				local forwardDir = DungeonPuzzleMazeDrawController.getFromToDir(lastX, lastY, x, y)

				if forwardDir then
					do
						local x1, y1, x2, y2 = DungeonPuzzleMazeDrawController.formatPos(lastX, lastY, x, y)
						local key = DungeonPuzzleMazeDrawModel.getLineKey(x1, y1, x2, y2)
						local lineObj = self:getOrCreateLine(key, x1, y1, x2, y2)

						self:refreshLineDir(lineObj, forwardDir)

						if self:isReverseDir(forwardDir) then
							self:refreshLineProgress(lineObj, forwardDir, 0)
						else
							self:refreshLineProgress(lineObj, forwardDir, 1)
						end

						syncSet[key] = 1
					end
				else
					logNormal(string.format("error dir in (%s,%s,%s,%s)", lastX, lastY, x, y))
				end
			end

			lastY = y
		end

		lastX = x
	end

	for k, itemObj in pairs(self._lineMap) do
		if not syncSet[k] then
			itemObj.image.fillAmount = 0
			itemObj.dir = nil
		end
	end

	DungeonPuzzleMazeDrawController.instance:resetLineDirty()
end

function DungeonPuzzleMazeDraw:syncDragLine()
	local isDirty = false
	local x, y, progressX, progressY = DungeonPuzzleMazeDrawController.instance:getProgressLine()

	if not DungeonPuzzleMazeDrawController.instance:isBackward(x, y) then
		local alertMap = DungeonPuzzleMazeDrawController.instance:getAlertMap()

		for mo, _ in pairs(alertMap) do
			return false
		end
	end

	local progress = progressX or progressY

	if x and y and progress then
		local curX, curY = DungeonPuzzleMazeDrawController.instance:getLastPos()
		local x1, y1, x2, y2 = DungeonPuzzleMazeDrawController.formatPos(curX, curY, x, y)

		if self._curDragLine.x1 ~= x1 or self._curDragLine.y1 ~= y1 or self._curDragLine.x2 ~= x2 or self._curDragLine.y2 ~= y2 then
			self._curDragLine.x1, self._curDragLine.y1, self._curDragLine.x2, self._curDragLine.y2 = x1, y1, x2, y2
			isDirty = true

			self:cleanDragLine()
		end

		local dir = DungeonPuzzleMazeDrawController.getFromToDir(curX, curY, x, y)

		self:refreshPawnDir(dir)

		local key = DungeonPuzzleMazeDrawModel.getLineKey(x1, y1, x2, y2)
		local lineObj = self:getOrCreateLine(key, x1, y1, x2, y2)

		self:refreshLineProgress(lineObj, dir, progress)

		return isDirty
	end

	return false
end

function DungeonPuzzleMazeDraw:refreshPawnDir(dir)
	if dir ~= DungeonPuzzleEnum.dir.up and dir ~= DungeonPuzzleEnum.dir.down then
		transformhelper.setLocalRotation(self._objPawn.tf, 0, dir == DungeonPuzzleEnum.dir.right and 180 or 0, 0)

		self._objPawn.dir = dir
	end
end

function DungeonPuzzleMazeDraw:syncAlertObjs()
	self:recycleAlertObjs()

	local alertMap = DungeonPuzzleMazeDrawController.instance:getAlertMap()
	local anchorX, anchorY

	for alertObj, _ in pairs(alertMap) do
		local alertObjType = type(alertObj)

		if alertObjType == "table" then
			local alertItem = self:getOrCreateAlertObj()
			local x1, y1, x2, y2 = alertObj.x1, alertObj.y1, alertObj.x2, alertObj.y2

			anchorX, anchorY = DungeonPuzzleMazeDrawModel.instance:getLineAnchor(x1, y1, x2, y2)

			recthelper.setAnchor(alertItem.tf, anchorX + DungeonPuzzleEnum.MazeAlertBlockOffsetX, anchorY + DungeonPuzzleEnum.MazeAlertBlockOffsetY)
			gohelper.setAsLastSibling(alertItem.go)
			AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)

			return
		end
	end

	local isAlert = false

	for alertObj, _ in pairs(alertMap) do
		local alertObjType = type(alertObj)

		if alertObjType == "string" then
			local alertItem = self:getOrCreateAlertObj()
			local linePos = string.splitToNumber(alertObj, "_")
			local var_22_0, var_22_1 = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(linePos[1], linePos[2])

			recthelper.setAnchor(alertItem.tf, var_22_0 + DungeonPuzzleEnum.MazeAlertCrossOffsetX, var_22_1 + DungeonPuzzleEnum.MazeAlertCrossOffsetY)
			gohelper.setAsLastSibling(alertItem.go)

			if not isAlert then
				AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_warn)

				isAlert = true
			end
		end
	end
end

function DungeonPuzzleMazeDraw:syncPawn()
	local curX, curY = DungeonPuzzleMazeDrawController.instance:getLastPos()
	local x, y = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(curX, curY)
	local itemObj = self:getOrCreatePawnObj()

	recthelper.setAnchor(itemObj.tf, x, y)
end

function DungeonPuzzleMazeDraw:refreshLineDir(lineObj, dir)
	local rotationX, rotationY, rotationZ, width = 0, 0, 0, DungeonPuzzleEnum.mazeUILineHorizonUIWidth

	if dir == DungeonPuzzleEnum.dir.left then
		rotationY = lineObj.resCfg[5] == true and 180 or 0

		if lineObj.resCfg[5] == true then
			lineObj.image.fillOrigin = self._imagelinetemplatel.fillOrigin or self._imagelinetemplater.fillOrigin
		end
	elseif dir == DungeonPuzzleEnum.dir.right then
		rotationY = lineObj.resCfg[5] == true and 180 or 0

		if lineObj.resCfg[5] == true then
			lineObj.image.fillOrigin = self._imagelinetemplater.fillOrigin or self._imagelinetemplatel.fillOrigin
		end
	elseif dir == DungeonPuzzleEnum.dir.up then
		if lineObj.resCfg[5] == true then
			rotationX = 180
		else
			rotationX = 0
			width = DungeonPuzzleEnum.mazeUILineVerticalUIWidth
			rotationZ = 90
		end

		rotationY = 0

		if lineObj.resCfg[5] == true then
			lineObj.image.fillOrigin = self._imagelinetemplater.fillOrigin or self._imagelinetemplatel.fillOrigin
		end
	elseif dir == DungeonPuzzleEnum.dir.down then
		if lineObj.resCfg[5] == true then
			rotationX = 180
		else
			rotationX = 0
			width = DungeonPuzzleEnum.mazeUILineVerticalUIWidth
			rotationZ = 90
		end

		rotationY = 0

		if lineObj.resCfg[5] == true then
			lineObj.image.fillOrigin = self._imagelinetemplatel.fillOrigin or self._imagelinetemplater.fillOrigin
		end
	end

	transformhelper.setLocalRotation(lineObj.imageTf, rotationX, rotationY, rotationZ)
	recthelper.setWidth(lineObj.imageTf, width)

	lineObj.dir = dir
end

function DungeonPuzzleMazeDraw:refreshLineProgress(lineObj, dir, progress)
	if lineObj.dir == nil and dir ~= nil then
		self:refreshLineDir(lineObj, dir)
	end

	if lineObj.dir ~= nil then
		if self:isReverseDir(lineObj.dir) then
			progress = 1 - progress
		end

		lineObj.image.fillAmount = progress
	end
end

function DungeonPuzzleMazeDraw:isReverseDir(dir)
	return dir == DungeonPuzzleEnum.dir.left or dir == DungeonPuzzleEnum.dir.down
end

function DungeonPuzzleMazeDraw:cleanDragLine()
	for k, lineObj in pairs(self._lineMap) do
		local fillAmount = lineObj.image.fillAmount

		if fillAmount <= 0.999 and fillAmount >= 0.01 then
			lineObj.image.fillAmount = 0
		end
	end
end

function DungeonPuzzleMazeDraw:refreshAlertColor()
	local isAlert = DungeonPuzzleMazeDrawController.instance:hasAlertObj()
	local alertMap = DungeonPuzzleMazeDrawController.instance:getAlertMap()

	for key, lineObj in pairs(self._lineMap) do
		UISpriteSetMgr.instance:setPuzzleSprite(lineObj.image, (isAlert or nil) and (lineObj.resCfg[4] or lineObj.resCfg[1]), false)
	end

	for key, itemObj in pairs(self._objectMap) do
		local mo = DungeonPuzzleMazeDrawModel.instance:getObjByLineKey(key)

		if mo and mo.objType == DungeonPuzzleEnum.MazeObjType.Block then
			local isBlockAlert = alertMap[mo]
			local resCfg = DungeonPuzzleEnum.mazeBlockResMap[mo.val]

			if isBlockAlert then
				if not resCfg[4] then
					local path = resCfg[1]

					UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, true)
				end
			end
		end
	end
end

function DungeonPuzzleMazeDraw:refreshCheckPoints()
	local objList = DungeonPuzzleMazeDrawModel.instance:getList()
	local checkSum = ""
	local checkCount = 0

	for _, mo in ipairs(objList) do
		if mo.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint then
			self:drawCheckPoint(mo, mo.x, mo.y)

			if DungeonPuzzleMazeDrawController.instance:alreadyCheckPoint(mo) then
				checkSum = checkSum .. tostring(mo)
				checkCount = checkCount + 1
			end
		end
	end

	if self._lastCheckSum ~= nil and self._lastCheckSum ~= checkSum and checkCount >= self._lastCheckCount then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_unlock)
	end

	self._lastCheckSum = checkSum
	self._lastCheckCount = checkCount
end

function DungeonPuzzleMazeDraw:getOrCreateLine(key, x1, y1, x2, y2)
	local itemObj = self._lineMap[key]

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local itemPath = self.viewContainer:getSetting().otherRes[2]
		local itemGo = self:getResInst(itemPath, self._goconnect, key)

		itemObj.go = itemGo
		itemObj.image = gohelper.findChildImage(itemGo, "image_horizon")
		itemObj.imageTf = itemObj.image.transform
		itemObj.x1, itemObj.y1, itemObj.x2, itemObj.y2 = x1, y1, x2, y2

		if not DungeonPuzzleEnum.SpecLineResMap[key] then
			local resCfg = DungeonPuzzleEnum.NormalLineResPath

			itemObj.resCfg = resCfg

			local path = resCfg[1]

			UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, path, false)

			local anchorX, anchorY = DungeonPuzzleMazeDrawModel.instance:getLineAnchor(x1, y1, x2, y2)
			local rectTf = itemGo.transform

			recthelper.setAnchor(rectTf, anchorX - 0.5, anchorY - 1.3)

			self._lineMap[key] = itemObj
		end
	end

	return itemObj
end

function DungeonPuzzleMazeDraw:getOrCreateObject(isPos, x1, y1, x2, y2)
	local key = isPos and DungeonPuzzleMazeDrawModel.getPosKey(x1, y1) or DungeonPuzzleMazeDrawModel.getLineKey(x1, y1, x2, y2)
	local itemObj = self._objectMap[key]

	if not itemObj then
		itemObj = self:getUserDataTb_()

		local itemPath = self.viewContainer:getSetting().otherRes[1]
		local itemGo = self:getResInst(itemPath, self._gomap, key)

		itemObj.go = itemGo
		itemObj.image = gohelper.findChildImage(itemGo, "#image_content")
		itemObj.imageChecked = gohelper.findChildImage(itemGo, "highlight/#image_content (1)")
		itemObj.goChecked = gohelper.findChild(itemGo, "highlight")
		itemObj.imageTf = itemObj.image.transform
		itemObj.anim = itemObj.goChecked:GetComponent(typeof(UnityEngine.Animator))

		local anchorX, anchorY

		if isPos then
			anchorX, anchorY = DungeonPuzzleMazeDrawModel.instance:getObjectAnchor(x1, y1)
		else
			anchorX, anchorY = DungeonPuzzleMazeDrawModel.instance:getLineObjectAnchor(x1, y1, x2, y2)
		end

		local rectTf = itemGo.transform

		recthelper.setAnchor(rectTf, anchorX, anchorY)

		self._objectMap[key] = itemObj
	end

	return itemObj
end

function DungeonPuzzleMazeDraw:getOrCreateAlertObj()
	local itemObj

	if #self._alertSymbolPool <= 0 then
		itemObj = self:getUserDataTb_()

		local itemPath = self.viewContainer:getSetting().otherRes[1]
		local itemGo = self:getResInst(itemPath, self._gomap, "alertObj")

		itemObj.go = itemGo
		itemObj.image = gohelper.findChildImage(itemGo, "#image_content")
		itemObj.imageTf = itemObj.image.transform
		itemObj.tf = itemGo.transform

		UISpriteSetMgr.instance:setPuzzleSprite(itemObj.image, DungeonPuzzleEnum.MazeAlertResPath, true)
	else
		itemObj = table.remove(self._alertSymbolPool)

		gohelper.setActive(itemObj.go, true)
	end

	table.insert(self._alertObjList, itemObj)

	return itemObj
end

function DungeonPuzzleMazeDraw:recycleAlertObjs()
	for i = #self._alertObjList, 1, -1 do
		local itemObj = self._alertObjList[i]

		gohelper.setActive(itemObj.go, false)
		table.insert(self._alertSymbolPool, itemObj)

		self._alertObjList[i] = nil
	end
end

function DungeonPuzzleMazeDraw:removeAllLine()
	for k, itemObj in pairs(self._lineMap) do
		gohelper.destroy(itemObj.go)

		itemObj.go = nil
		itemObj.image = nil
		itemObj.imageTf = nil
		self._lineMap[k] = nil
	end
end

function DungeonPuzzleMazeDraw:removeAllObjects()
	for k, itemObj in pairs(self._objectMap) do
		gohelper.destroy(itemObj.go)

		itemObj.go = nil
		itemObj.image = nil
		itemObj.imageTf = nil
		self._objectMap[k] = nil
	end
end

function DungeonPuzzleMazeDraw:onDragBeginHandler(_, pointerEventData)
	if not self._canTouch then
		GameFacade.showToast(ToastEnum.DungeonPuzzle)

		return
	end

	local tempPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._gomap.transform)
	local lastX, lastY = DungeonPuzzleMazeDrawController.instance:getLastPos()
	local x, y = DungeonPuzzleMazeDrawModel.instance:getClosePosByTouchPos(tempPos.x - DungeonPuzzleEnum.mazeMonsterTouchOffsetX, tempPos.y - DungeonPuzzleEnum.mazeMonsterHeight)

	if x ~= -1 and lastX == x and lastY == y then
		self:startDrag()
	end
end

function DungeonPuzzleMazeDraw:onDragCallHandler(_, pointerEventData)
	if self._isPawnMoving then
		local tempPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._gomap.transform)
		local w, h = DungeonPuzzleMazeDrawModel.instance:getUIGridSize()
		local x, y = DungeonPuzzleMazeDrawModel.instance:getClosePosByTouchPos(tempPos.x, tempPos.y)

		if x ~= -1 then
			DungeonPuzzleMazeDrawController.instance:goPassPos(x, y)
		else
			local rs, x1, y1, x2, y2, progressX, progressY = DungeonPuzzleMazeDrawModel.instance:getLineFieldByTouchPos(tempPos.x, tempPos.y)

			if rs then
				DungeonPuzzleMazeDrawController.instance:goPassLine(x1, y1, x2, y2, progressX, progressY)
			end
		end

		local isLineDirty = DungeonPuzzleMazeDrawController.instance:isLineDirty()

		if isLineDirty then
			self:syncPath()
			self:refreshAlertColor()
			self:syncAlertObjs()
			self:refreshCheckPoints()
		end

		local isDirty = self:syncDragLine()

		if not isLineDirty and isDirty then
			self:syncPath()
		end

		local pawnObj = self:getOrCreatePawnObj()

		recthelper.setAnchor(pawnObj.tf, tempPos.x, tempPos.y)

		if isLineDirty then
			self:checkGameClear()
		end
	end
end

function DungeonPuzzleMazeDraw:onDragEndHandler(_, pointerEventData)
	self:endDrag()
end

function DungeonPuzzleMazeDraw:startDrag()
	self._isPawnMoving = true

	local pawnObj = self:getOrCreatePawnObj()

	pawnObj.anim:Play("image_content_drag")

	if not self._alreadyDrag then
		local x1, y1 = DungeonPuzzleMazeDrawModel.instance:getStartPoint()

		self:closeCheckObject(x1, y1)

		self._alreadyDrag = true
	end
end

function DungeonPuzzleMazeDraw:endDrag()
	if self._isPawnMoving then
		self._isPawnMoving = false

		local pawnObj = self:getOrCreatePawnObj()

		pawnObj.anim:Play("open")

		if DungeonPuzzleMazeDrawController.instance:hasAlertObj() then
			DungeonPuzzleMazeDrawController.instance:goBackPos()
			self:syncPawn()
			self:syncPath()
			self:cleanDragLine()
			self:refreshAlertColor()
			self:syncAlertObjs()
			self:refreshCheckPoints()
		else
			self:syncPawn()
			self:syncPath()
			self:cleanDragLine()
			self:checkGameClear()
		end
	end
end

function DungeonPuzzleMazeDraw:closeCheckObject(x1, y1)
	local key = DungeonPuzzleMazeDrawModel.getPosKey(x1, y1)
	local itemObj = self._objectMap[key]

	if itemObj then
		gohelper.setActive(itemObj.goChecked, false)
	end
end

function DungeonPuzzleMazeDraw:checkGameClear()
	if self._isClear then
		return
	end

	local isClear = DungeonPuzzleMazeDrawController.instance:isGameClear()

	if isClear then
		AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)

		local x1, y1 = DungeonPuzzleMazeDrawModel.instance:getEndPoint()

		self:closeCheckObject(x1, y1)
		DungeonPuzzleMazeDrawModel.instance:setClearStatus(isClear)

		self._canTouch = false
		self._isClear = true

		DungeonPuzzleMazeDrawController.instance:dispatchEvent(DungeonPuzzleEvent.MazeDrawGameClear)
		logNormal("MazeDraw Game Clear!!!")

		if self._isPawnMoving then
			self:endDrag()
		end
	end
end

return DungeonPuzzleMazeDraw
