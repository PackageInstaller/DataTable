-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanSceneView.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanSceneView", package.seeall)

local HuiDiaoLanSceneView = class("HuiDiaoLanSceneView", BaseView)

function HuiDiaoLanSceneView:onInitView()
	self._goslotContent = gohelper.findChild(self.viewGO, "root/slotPlane/#go_slotContent")
	self._goplane = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane")
	self._goplaneContent = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_planeContent")
	self._goitemContent = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_itemContent")
	self._goclickMask = gohelper.findChild(self.viewGO, "#go_clickMask")
	self._gospMovePlane = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_spMovePlane")
	self._gospMovePlaneScale = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_spMovePlane/#go_spMovePlaneScale")
	self._gospMove = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_spMove")
	self._btnSpMove = gohelper.findChildButtonWithAudio(self.viewGO, "root/planeRoot/#go_plane/#go_spMove/#btn_spMove")
	self._gochangeColor = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_changeColor")
	self._gospMoveScale = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_spMove/#go_spMoveScale")
	self._gospMoveDragging = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_spMove/#go_spMoveScale/#go_spMoveDragging")
	self._gospMoveIdle = gohelper.findChild(self.viewGO, "root/planeRoot/#go_plane/#go_spMove/#go_spMoveScale/#go_spMoveIdle")
	self._btncloseMoveSelect = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closeMoveSelect")
	self._godiamondTarget = gohelper.findChild(self.viewGO, "root/info/#go_diamondTarget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HuiDiaoLanSceneView:addEvents()
	self._btnSpMove:AddClickListener(self._btnSpMoveOnClick, self)
	self._btncloseMoveSelect:AddClickListener(self._btnCloseSpMoveOnClick, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self.addEventCb(self, HuiDiaoLanGameController.instance, HuiDiaoLanEvent.ResetGame, self.resetGame, self)
	self.addEventCb(self, HuiDiaoLanGameController.instance, HuiDiaoLanEvent.GameFinish, self.gameFinish, self)
end

function HuiDiaoLanSceneView:removeEvents()
	self._btnSpMove:RemoveClickListener()
	self._btncloseMoveSelect:RemoveClickListener()
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.onScreenResize, self)
	self.removeEventCb(self, HuiDiaoLanGameController.instance, HuiDiaoLanEvent.ResetGame, self.resetGame, self)
	self.removeEventCb(self, HuiDiaoLanGameController.instance, HuiDiaoLanEvent.GameFinish, self.gameFinish, self)
end

function HuiDiaoLanSceneView:_btnCloseSpMoveOnClick()
	if self.isSpEpisode then
		self:setSpMovePlaneSelectShowState(false)
	else
		self:setMovePlaneSelectShowState(false)
	end

	self.beginDragPosIndex = nil
	self.curSelectElement = nil
end

function HuiDiaoLanSceneView:_editableInitView()
	self.planeItemMap = self:getUserDataTb_()

	self:initMap()
end

function HuiDiaoLanSceneView:initMap()
	self.elementItemMap = self:getUserDataTb_()
	self.posIndexList = {}
	self.notSpMovePosIndexList = {}
	self.spMovePosIndexList = {}
	self.spRotateMoveTweenList = self:getUserDataTb_()
	self.curRotateFinishCount = 0
	self.isCombineAllSpPlaneMoveElement = false
	self.isSpRotating = false
	self.isNormalMoveing = false
	self.elementChangeMap = self:getUserDataTb_()
	self.combineElementMap = self:getUserDataTb_()
	self.combineMoveTweenList = self:getUserDataTb_()
	self.levelUpElementDataMap = self:getUserDataTb_()
	self.combineToBornCountMap = self:getUserDataTb_()
	self.isMoveCheckToCombine = false
	self.isMoveActProcessFinish = true
	self.isSceneActProcessFinish = true
	self.waterMoveTweenMap = self:getUserDataTb_()
	self.waterMoveTargetPosMap = self:getUserDataTb_()
	self.gravityMoveTweenMap = self:getUserDataTb_()
	self.gravityMoveTargetPosMap = self:getUserDataTb_()
	self.doWaterMoveCount = 0
	self.doGravityMoveCount = 0
	self.isSetCurElementSelectState = false
	self.isSelectBeCombine = false
	self.diamondFlyoutTweenMap = self:getUserDataTb_()
	self.skillSelectElementItemMap = self:getUserDataTb_()
	self.exchangePosSelectElementList = self:getUserDataTb_()
	self.addEnergyCountList = self:getUserDataTb_()
	self.curSelectElement = nil
	self.beginDragPosIndex = nil
	self.needShowSpPlaneAnim = false

	gohelper.setActive(self._goclickMask, false)
	gohelper.setActive(self._godragginElement, false)
	gohelper.setActive(self._gospMove, false)
	gohelper.setActive(self._gospMovePlane, false)
	gohelper.setActive(self._btnCloseSpMove, false)
	gohelper.setActive(self._gospMoveDragging, false)
end

function HuiDiaoLanSceneView:onUpdateParam()
	return
end

function HuiDiaoLanSceneView:resetGame()
	self:cleanData()
	self:destroyAllElement()
	self.gameView:resetGame()
	self:initMap()
	self:initMapData()
	self:createAndRefreshAllElements()
end

function HuiDiaoLanSceneView:onOpen()
	self:initMapData()
	self:createPlanes()
	self:createAndRefreshAllElements()
end

function HuiDiaoLanSceneView:onOpenFinish()
	self.effectView = self.viewContainer:getHuiDiaoLanEffectView()
end

function HuiDiaoLanSceneView:initMapData()
	self.gameInfoData = HuiDiaoLanGameModel.instance:getGameInfoData()
	self.targetNum = self.gameInfoData.targetNum
	self.moveBorn = self.gameInfoData.moveBorn
	self.treeMergeBorn = self.gameInfoData.treeMergeBorn
	self.fourMergeBorn = self.gameInfoData.fourMergeBorn
	self.isSpEpisode = self.gameInfoData.isSpEpisode
	self.planeItemPath = self.viewContainer:getSetting().otherRes[1]
	self.elementItemPath = self.viewContainer:getSetting().otherRes[2]
	self.planeWidth = self.gameInfoData.planeWidth
	self.planeHeight = self.gameInfoData.planeHeight
	self.planeItemWidth = self.gameInfoData.planeItemWidth
	self.planeItemHeight = self.gameInfoData.planeItemHeight

	recthelper.setSize(self._goplane.transform, self.planeWidth, self.planeHeight)

	if self.isSpEpisode then
		local sizeScale = self.planeItemWidth / HuiDiaoLanEnum.PlaneWidth

		transformhelper.setLocalScale(self._gospMovePlaneScale.transform, sizeScale, sizeScale, 1)
		transformhelper.setLocalScale(self._gospMove.transform, sizeScale, sizeScale, 1)
	end

	self:onScreenResize()

	self.gameView = self.viewContainer:getHuiDiaoLanGameView()
end

function HuiDiaoLanSceneView:onScreenResize()
	local diamondTargetPos = recthelper.rectToRelativeAnchorPos(self._godiamondTarget.transform.position, self._goplaneContent.transform)

	self.diamondTargetPosX = diamondTargetPos.x + self.planeWidth / 2
	self.diamondTargetPosY = diamondTargetPos.y - self.planeHeight / 2
end

function HuiDiaoLanSceneView:createPlanes()
	for row = 1, self.gameInfoData.planeHeightCount do
		for col = 1, self.gameInfoData.planeWidthCount do
			local posIndex = string.format("%d#%d", col, row)
			local isSpPlane, planeData = HuiDiaoLanGameModel.instance:checkAndGetSpPlaneData(posIndex)
			local planeItem = self.planeItemMap[posIndex]

			if not planeItem then
				planeItem = {}
				planeItem.go = self:getResInst(self.planeItemPath, self._goplaneContent, "planeItem" .. posIndex .. ((isSpPlane or nil) and ("_" .. planeData.spIndex or "")))

				local initData = {
					isSpPlane = isSpPlane,
					planeData = planeData,
					isSpEpisode = self.isSpEpisode,
					goplaneContent = self._goplaneContent,
					planeWidth = self.planeWidth,
					planeHeight = self.planeHeight,
					scenevView = self
				}

				planeItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(planeItem.go, HuiDiaoLanPlaneItem, initData)
				planeItem.posIndex = posIndex
				planeItem.planeData = planeData
				planeItem.isSpPlane = isSpPlane
				self.planeItemMap[posIndex] = planeItem
			end

			planeItem.comp:refreshUI(posIndex)
			planeItem.comp:setPlanePosAndSize(posIndex)
		end
	end
end

function HuiDiaoLanSceneView:createAndRefreshAllElements()
	local allElementDataMap = HuiDiaoLanGameModel.instance:getAllElementData()

	for index, elementData in pairs(allElementDataMap) do
		self:createAndRefreshElement(elementData)
	end
end

function HuiDiaoLanSceneView:createAndRefreshElement(elementData)
	local elementItem = self.elementItemMap[elementData.posIndex]

	if not elementItem or not elementItem.go then
		elementItem = {
			go = self:getResInst(self.elementItemPath, self._goitemContent, "elementItem" .. elementData.posIndex)
		}
		elementItem.comp = MonoHelper.addNoUpdateLuaComOnceToGo(elementItem.go, HuiDiaoLanElement)
		elementItem.elementData = elementData

		elementItem.comp:setRootScale(self.gameInfoData)

		self.elementItemMap[elementData.posIndex] = elementItem
	end

	elementItem.comp:playIdleAnim()
	elementItem.comp:refreshUI(elementData)
	self:setElementPos(elementData.posIndex)
end

function HuiDiaoLanSceneView:setElementPos(posIndex)
	local elementItem = self.elementItemMap[posIndex]
	local planeItem = self.planeItemMap[posIndex]

	if elementItem and planeItem then
		local posX, posY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(posIndex)

		recthelper.setAnchor(elementItem.go.transform, posX, posY)
		recthelper.setSize(elementItem.go.transform, self.planeItemWidth, self.planeItemHeight)
	end
end

function HuiDiaoLanSceneView:onPlaneItemClick(posIndex)
	local curClickElement = self.elementItemMap[posIndex]

	if not self.curSelectElement and not curClickElement or posIndex == self.beginDragPosIndex then
		return
	end

	self.isMoveActProcessFinish = false
	self.isSceneActProcessFinish = false
	self.isSetCurElementSelectState = false

	if self.curSelectElement then
		local canMove = false

		for index, movePosIndex in ipairs(self.notSpMovePosIndexList) do
			if movePosIndex == posIndex then
				canMove = true

				self:setElementDraggingEnd(self.beginDragPosIndex, posIndex)

				return
			end
		end

		if not canMove then
			self:cancelMovePlaneSelect()
			self:onPlaneItemClick(posIndex)
		end
	else
		self.curSelectElement = curClickElement
		self.beginDragPosIndex = posIndex

		self:buildAndSetMovePlaneSelectState()
	end
end

function HuiDiaoLanSceneView:buildAndSetMovePlaneSelectState()
	if not self.beginDragPosIndex then
		return
	end

	local curSelectPosIndexList = string.splitToNumber(self.beginDragPosIndex, "#")
	local curSelectPosXIndex = curSelectPosIndexList[1]
	local curSelectPosYIndex = curSelectPosIndexList[2]

	if self.isSpEpisode then
		self.spMovePosIndexList = {}

		local rightPosIndex = string.format("%d#%d", curSelectPosXIndex + 1, curSelectPosYIndex)
		local rightBottomPosIndex = string.format("%d#%d", curSelectPosXIndex + 1, curSelectPosYIndex + 1)
		local bottomPosIndex = string.format("%d#%d", curSelectPosXIndex, curSelectPosYIndex + 1)

		self.spMovePosIndexList = {
			self.beginDragPosIndex,
			rightPosIndex,
			rightBottomPosIndex,
			bottomPosIndex
		}

		self:setMovePlaneSelectShowState(false)
		self:setSpMovePlaneSelectShowState(true, self.beginDragPosIndex)
	else
		self.notSpMovePosIndexList = {}

		local leftPosIndex = string.format("%d#%d", curSelectPosXIndex - 1, curSelectPosYIndex)
		local rightPosIndex = string.format("%d#%d", curSelectPosXIndex + 1, curSelectPosYIndex)
		local topPosIndex = string.format("%d#%d", curSelectPosXIndex, curSelectPosYIndex - 1)
		local bottomPosIndex = string.format("%d#%d", curSelectPosXIndex, curSelectPosYIndex + 1)

		self.notSpMovePosIndexList = {
			leftPosIndex,
			rightPosIndex,
			topPosIndex,
			bottomPosIndex,
			self.beginDragPosIndex
		}

		self:setMovePlaneSelectShowState(true)
		self:setSpMovePlaneSelectShowState(false)
	end
end

function HuiDiaoLanSceneView:setElementDraggingBegin(posIndex)
	local selectElement = self.elementItemMap[posIndex]

	if not selectElement then
		return
	end

	self.curSelectElement = selectElement

	self:setMovePlaneSelectShowState(false)

	self.isSetCurElementSelectState = false
	self.beginDragPosIndex = posIndex

	self:buildAndSetMovePlaneSelectState()

	self.isNormalMoveing = true
	self.isMoveActProcessFinish = false
	self.isSceneActProcessFinish = false
end

function HuiDiaoLanSceneView:setElementDragging()
	if not self.beginDragPosIndex then
		return
	end
end

function HuiDiaoLanSceneView:setElementDraggingEnd(beingPosIndex, targetPosIndex)
	if not self.beginDragPosIndex or not self.elementItemMap[beingPosIndex] then
		return
	end

	self:setMovePlaneSelectShowState(false)
	self:moveToTargetPosIndex(beingPosIndex, targetPosIndex)
	AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_move)
end

function HuiDiaoLanSceneView:setMovePlaneSelectShowState(state)
	for _, posIndex in ipairs(self.notSpMovePosIndexList) do
		local planeItem = self.planeItemMap[posIndex]

		if planeItem then
			planeItem.comp:setSelectShowState(state)
		end
	end
end

function HuiDiaoLanSceneView:moveToTargetPosIndex(curPosIndex, targetPosIndex)
	if curPosIndex == targetPosIndex then
		self.curSelectElement = nil
		self.beginDragPosIndex = nil

		return
	end

	gohelper.setActive(self._goclickMask, true)

	local curPosX, curPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(curPosIndex)
	local targetPosX, targetPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(targetPosIndex)

	self.targetPosIndex = targetPosIndex
	self.curPosIndex = curPosIndex
	self.targetElement = self.elementItemMap[targetPosIndex]

	if self.targetElement then
		self.targetElementMoveTweenId = ZProj.TweenHelper.DOAnchorPos(self.targetElement.go.transform, curPosX, curPosY, HuiDiaoLanEnum.ElementNormalMoveTime, self.moveToTargetPosFinish, self)

		self.targetElement.comp:playMoveAnim()
	end

	if self.curSelectElement then
		self.curElementMoveTweenId = ZProj.TweenHelper.DOAnchorPos(self.curSelectElement.go.transform, targetPosX, targetPosY, HuiDiaoLanEnum.ElementNormalMoveTime, self.moveToTargetPosFinish, self)

		self.curSelectElement.comp:playMoveAnim()
	end
end

function HuiDiaoLanSceneView:moveToTargetPosFinish()
	self.isNormalMoveing = false

	self:cleanTween()
	self.gameView:reduceCurRemainStep()

	self.elementItemMap[self.curPosIndex] = self.elementItemMap[self.targetPosIndex]
	self.elementItemMap[self.targetPosIndex] = self.elementItemMap[self.curPosIndex]

	self:updateElementData(self.targetPosIndex)
	self:updateElementData(self.curPosIndex)
	self:updateElementDataMap()
	self:cleanCombineData()

	self.elementChangeMap[self.targetPosIndex] = self.curSelectElement
	self.elementChangeMap[self.curPosIndex] = self.targetElement

	if self.curSelectElement then
		self.curSelectElement.comp:playIdleAnim()
	end

	if self.targetElement then
		self.targetElement.comp:playIdleAnim()
	end

	local posIndex = self.curSelectElement.elementData.posIndex

	self.targetMovePosIndex = posIndex
	self.isSelectBeCombine = false

	self:combineAllElement(true)
	self:setCurElementSelectState(posIndex)
	self:startSpPlaneMove()
end

function HuiDiaoLanSceneView:setCurElementSelectState(posIndex)
	if self.isSpEpisode then
		return
	end

	self.isSetCurElementSelectState = true

	local curElement = self.elementItemMap[posIndex]

	if not self.isSelectBeCombine then
		self.curSelectElement = curElement
		self.beginDragPosIndex = posIndex

		self:buildAndSetMovePlaneSelectState()
	end
end

function HuiDiaoLanSceneView:onSpPlaneItemClick(posIndex)
	local areaIsHasElement = self:checkSpClickAreaHasElement(posIndex)

	if not areaIsHasElement then
		self:cancelSpMovePlaneSelect()

		return
	end

	if posIndex == self.beginDragPosIndex then
		return
	end

	local curClickElement = self.elementItemMap[posIndex]

	gohelper.setActive(self._gospMoveIdle, true)

	self.curSelectElement = curClickElement
	self.beginDragPosIndex = posIndex
	self.needShowSpPlaneAnim = true

	self:buildAndSetMovePlaneSelectState()
	HuiDiaoLanGameController.instance:dispatchEvent(HuiDiaoLanEvent.OnSpClickElementGuide)
	AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_circle)
end

function HuiDiaoLanSceneView:checkSpClickAreaHasElement(posIndex)
	local curPosIndexList = string.splitToNumber(posIndex, "#")
	local curPosXIndex = curPosIndexList[1]
	local curPosYIndex = curPosIndexList[2]

	for posYIndex = curPosYIndex, curPosYIndex + 1 do
		for posXIndex = curPosXIndex, curPosXIndex + 1 do
			local targetPosIndex = string.format("%d#%d", posXIndex, posYIndex)

			if self.elementItemMap[targetPosIndex] then
				return true
			end
		end
	end

	return false
end

function HuiDiaoLanSceneView:_btnSpMoveOnClick()
	if self.isSpRotating then
		return
	end

	gohelper.setActive(self._gospMoveIdle, true)
	self:rotateSpSelectElement()
	AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_move)
end

function HuiDiaoLanSceneView:rotateSpSelectElement()
	gohelper.setActive(self._goclickMask, true)
	TaskDispatcher.cancelTask(self.levelUpElement, self)

	self.isSpRotating = true
	self.isMoveActProcessFinish = false
	self.isSceneActProcessFinish = false
	self.allRotateTweenCount = 0
	self.spRotateMoveTweenList = self:getUserDataTb_()

	for index, posIndex in ipairs(self.spMovePosIndexList) do
		local targetPosX, targetPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(self.spMovePosIndexList[index + 1] or self.spMovePosIndexList[1])
		local tweenInfo = self.spRotateMoveTweenList[index]

		tweenInfo = tweenInfo or {}
		tweenInfo.elementItem = self.elementItemMap[posIndex] and tabletool.copy(self.elementItemMap[posIndex]) or nil

		if tweenInfo.elementItem then
			self.allRotateTweenCount = self.allRotateTweenCount + 1
			tweenInfo.tweenId = ZProj.TweenHelper.DOAnchorPos(tweenInfo.elementItem.go.transform, targetPosX, targetPosY, HuiDiaoLanEnum.ElementRotateMoveTime, self.spRotateToTargetPosFinish, self)

			tweenInfo.elementItem.comp:playMoveAnim()
		end

		self.spRotateMoveTweenList[index] = tweenInfo
	end
end

function HuiDiaoLanSceneView:spRotateToTargetPosFinish()
	self.curRotateFinishCount = self.curRotateFinishCount + 1

	if self.curRotateFinishCount == self.allRotateTweenCount then
		self:allSpRotateToTargetPosFinish()
	end
end

function HuiDiaoLanSceneView:allSpRotateToTargetPosFinish()
	self.gameView:reduceCurRemainStep()

	self.curRotateFinishCount = 0
	self.isSpRotating = false

	self:cleanCombineData()

	for index, posIndex in ipairs(self.spMovePosIndexList) do
		self.elementItemMap[posIndex] = self.spRotateMoveTweenList[index - 1] and self.spRotateMoveTweenList[index - 1].elementItem or self.spRotateMoveTweenList[#self.spRotateMoveTweenList].elementItem

		local tweenInfo = self.spRotateMoveTweenList[index]

		if tweenInfo and tweenInfo.tweenId then
			ZProj.TweenHelper.KillById(tweenInfo.tweenId)

			tweenInfo.tweenId = nil
		end

		self:updateElementData(posIndex)

		local curElement = self.elementItemMap[posIndex]

		if curElement then
			curElement.comp:playIdleAnim()
		end

		self.elementChangeMap[posIndex] = curElement
	end

	self:combineAllElement(true)
	gohelper.setActive(self._gospMoveIdle, true)
	self:updateElementDataMap()

	self.isSetCurElementSelectState = true

	self:startSpPlaneMove()
end

function HuiDiaoLanSceneView:setSpMovePlaneSelectShowState(state, beginPosIndex)
	if state and self.needShowSpPlaneAnim then
		gohelper.setActive(self._gospMove, false)
		gohelper.setActive(self._gospMovePlane, false)

		self.needShowSpPlaneAnim = false
	end

	gohelper.setActive(self._gospMove, state)
	gohelper.setActive(self._gospMovePlane, state)
	gohelper.setActive(self._btnCloseSpMove, state)

	if not state or not beginPosIndex or beginPosIndex == "0#0" then
		return
	end

	local planePosX, planePosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(beginPosIndex)
	local posX = planePosX + self.planeItemWidth / 2 + HuiDiaoLanEnum.PlaneSpace / 2
	local posY = planePosY - self.planeItemHeight / 2 - HuiDiaoLanEnum.PlaneSpace / 2

	recthelper.setAnchor(self._gospMove.transform, posX, posY)
	recthelper.setAnchor(self._gospMovePlane.transform, posX, posY)

	for _, posIndex in ipairs(self.spMovePosIndexList) do
		local planeItem = self.planeItemMap[posIndex]

		if planeItem then
			planeItem.comp:setSelectShowState(false)
		end
	end
end

function HuiDiaoLanSceneView:getMouseAnchorPos(pointerEventData)
	local posX, posY = recthelper.screenPosToAnchorPos2(pointerEventData.position, self._goplaneContent.transform)
	local anchorX = posX + self.planeWidth / 2
	local anchorY = posY - self.planeHeight / 2

	return anchorX, anchorY
end

function HuiDiaoLanSceneView:updateElementData(posIndex)
	if self.elementItemMap[posIndex] and self.elementItemMap[posIndex].elementData then
		self.elementItemMap[posIndex].elementData.posIndex = posIndex

		if self.elementItemMap[posIndex].elementData.level >= 2 then
			self.elementItemMap[posIndex].elementData.color = HuiDiaoLanEnum.ElementColor.None
		end

		self.elementItemMap[posIndex].comp:refreshUI(self.elementItemMap[posIndex].elementData)
	end
end

function HuiDiaoLanSceneView:updateElementDataMap()
	local elementDataMap = {}

	for posIndex, elementItem in pairs(self.elementItemMap) do
		elementDataMap[posIndex] = elementItem.elementData
	end

	HuiDiaoLanGameModel.instance:updateElementDataMap(elementDataMap)
end

function HuiDiaoLanSceneView:combineAllElement(isMoveCheck)
	if isMoveCheck then
		for index, posIndex in ipairs(self.spMovePosIndexList) do
			self:removeSameElementInMoveing(posIndex)
		end
	end

	self.isMoveCheckToCombine = isMoveCheck
	self.combineToBornCountMap = self:getUserDataTb_()

	for posIndex, curElement in pairs(self.elementChangeMap) do
		self:checkCombine(posIndex, curElement, true)
		self:doCombineElement(posIndex, curElement)
	end

	self.elementChangeMap = self:getUserDataTb_()

	if next(self.levelUpElementDataMap) then
		TaskDispatcher.runDelay(self.levelUpElement, self, HuiDiaoLanEnum.WaitLevelUpElementTime)
	else
		TaskDispatcher.cancelTask(self.levelUpElement, self)

		if isMoveCheck then
			local createCount = self:createRandomElement(self.moveBorn)

			if createCount > 0 then
				AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_occur)
			end

			if tabletool.len(self.elementChangeMap) > 0 then
				self:combineAllElement()
			else
				self.isMoveCheckToCombine = false
			end
		else
			if self.isSetCurElementSelectState then
				self:startSpPlaneMove()
			end

			if self.isCombineAllSpPlaneMoveElement then
				self:onCombineAllSpPlaneMoveElementFinish()
			end
		end
	end
end

function HuiDiaoLanSceneView:removeSameElementInMoveing(posIndex)
	local elementItem = self.elementItemMap[posIndex]

	if elementItem and self.elementChangeMap[posIndex] then
		local posIndexList = string.splitToNumber(posIndex, "#")
		local curPosXIndex = posIndexList[1]
		local curPosYIndex = posIndexList[2]
		local leftPosIndex = string.format("%d#%d", curPosXIndex - 1, curPosYIndex)
		local rightPosIndex = string.format("%d#%d", curPosXIndex + 1, curPosYIndex)
		local topPosIndex = string.format("%d#%d", curPosXIndex, curPosYIndex - 1)
		local bottomPosIndex = string.format("%d#%d", curPosXIndex, curPosYIndex + 1)

		if self.elementChangeMap[leftPosIndex] and self:checkElementIsSame(self.elementChangeMap[leftPosIndex], elementItem) then
			self.elementChangeMap[leftPosIndex] = nil
		elseif self.elementChangeMap[rightPosIndex] and self:checkElementIsSame(self.elementChangeMap[rightPosIndex], elementItem) then
			self.elementChangeMap[rightPosIndex] = nil
		elseif self.elementChangeMap[topPosIndex] and self:checkElementIsSame(self.elementChangeMap[topPosIndex], elementItem) then
			self.elementChangeMap[topPosIndex] = nil
		elseif self.elementChangeMap[bottomPosIndex] and self:checkElementIsSame(self.elementChangeMap[bottomPosIndex], elementItem) then
			self.elementChangeMap[bottomPosIndex] = nil
		end
	end
end

function HuiDiaoLanSceneView:checkElementIsSame(curElementItem, targetElementItem)
	if not curElementItem or not targetElementItem then
		return false
	end

	if curElementItem.elementData.level == targetElementItem.elementData.level then
		if curElementItem.elementData.level == 1 then
			return curElementItem.elementData.color == targetElementItem.elementData.color
		elseif curElementItem.elementData.level == 2 then
			return true
		end
	end

	return false
end

function HuiDiaoLanSceneView:checkCombine(posIndex, combineElementItem, isBeginCheck)
	if self.isSpRotating or self.isNormalMoveing then
		return
	end

	local curElementItem = self.elementItemMap[posIndex]

	if not curElementItem or not next(curElementItem.elementData) or not combineElementItem or not next(combineElementItem.elementData) or self.combineElementMap[combineElementItem.elementData.posIndex] and self.combineElementMap[combineElementItem.elementData.posIndex][posIndex] then
		return
	end

	if not isBeginCheck and curElementItem.elementData.posIndex == combineElementItem.elementData.posIndex or not self:checkElementIsSame(curElementItem, combineElementItem) then
		return
	end

	if self.combineCount then
		self.combineCount = self.combineCount + 1 or 1
	end

	if self.combineCount >= 100 then
		logError("合成宝石的递归次数超了")

		return
	end

	self.combineElementMap[combineElementItem.elementData.posIndex] = self.combineElementMap[combineElementItem.elementData.posIndex] or {}

	if curElementItem.elementData.posIndex ~= combineElementItem.elementData.posIndex then
		self.combineElementMap[combineElementItem.elementData.posIndex][posIndex] = curElementItem

		if self.elementChangeMap[posIndex] then
			self.elementChangeMap[posIndex] = nil
		end
	end

	local posIndexList = string.splitToNumber(posIndex, "#")
	local curPosXIndex = posIndexList[1]
	local curPosYIndex = posIndexList[2]
	local leftPosIndex = string.format("%d#%d", curPosXIndex - 1, curPosYIndex)
	local rightPosIndex = string.format("%d#%d", curPosXIndex + 1, curPosYIndex)
	local topPosIndex = string.format("%d#%d", curPosXIndex, curPosYIndex - 1)
	local bottomPosIndex = string.format("%d#%d", curPosXIndex, curPosYIndex + 1)

	self:checkCombine(leftPosIndex, combineElementItem)
	self:checkCombine(rightPosIndex, combineElementItem)
	self:checkCombine(topPosIndex, combineElementItem)
	self:checkCombine(bottomPosIndex, combineElementItem)
end

function HuiDiaoLanSceneView:doCombineElement(combinePosIndex, combineElementItem)
	if not next(self.combineElementMap) or not self.combineElementMap[combinePosIndex] or not next(self.combineElementMap[combinePosIndex]) or tabletool.len(self.combineElementMap[combinePosIndex]) < HuiDiaoLanEnum.StartCombineNum then
		return
	end

	if self.isSpEpisode then
		self:cancelSpMovePlaneSelect()
	end

	local targetPosX, targetPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(combinePosIndex)

	for posIndex, elementItem in pairs(self.combineElementMap[combinePosIndex]) do
		gohelper.setAsLastSibling(elementItem.go)

		self.combineMoveTweenList[combinePosIndex] = self.combineMoveTweenList[combinePosIndex] or {}

		elementItem.comp:playMoveAnim()

		self.combineMoveTweenList[combinePosIndex][posIndex] = ZProj.TweenHelper.DOAnchorPos(elementItem.go.transform, targetPosX, targetPosY, HuiDiaoLanEnum.ElementNormalMoveTime)

		if not self.curSelectElement or self.curSelectElement and self.curSelectElement.elementData.posIndex == combinePosIndex or self.curSelectElement.elementData.posIndex == posIndex then
			self:cancelMovePlaneSelect()

			self.isSelectBeCombine = true
		end
	end

	if tabletool.len(self.combineElementMap[combinePosIndex]) + 1 > 3 then
		self.combineToBornCountMap[combinePosIndex] = self.fourMergeBorn or self.treeMergeBorn
	end

	local levelUpElementData = tabletool.copy(combineElementItem.elementData)

	levelUpElementData.level = Mathf.Min(levelUpElementData.level + 1, HuiDiaoLanEnum.MaxElementLevel)
	self.levelUpElementDataMap[combinePosIndex] = levelUpElementData
end

function HuiDiaoLanSceneView:levelUpElement()
	local canLevelUp2 = false
	local canLevelUp3 = false

	for posIndex, elementData in pairs(self.levelUpElementDataMap) do
		self.elementItemMap[posIndex].elementData = elementData

		self:updateElementData(posIndex)

		self.elementChangeMap[posIndex] = self.elementItemMap[posIndex]

		self.effectView:playEffectFlying(posIndex)

		if elementData.level == 2 then
			canLevelUp2 = true

			HuiDiaoLanGameController.instance:dispatchEvent(HuiDiaoLanEvent.OnCombineTwoLevelGuide)
		elseif elementData.level == HuiDiaoLanEnum.MaxElementLevel then
			if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.HuiDiaoLanCombineLock) then
				HuiDiaoLanGameController.instance:dispatchEvent(HuiDiaoLanEvent.OnCombineDiamondeGuide)
			end

			canLevelUp3 = true
		end
	end

	if canLevelUp2 then
		AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_syn1)
	end

	if canLevelUp3 then
		AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_syn2)
	end

	self:addCombineEnergyCount()

	for combinePosIndex, elementMap in pairs(self.combineElementMap) do
		if tabletool.len(elementMap) >= HuiDiaoLanEnum.StartCombineNum then
			for posIndex, elementItem in pairs(elementMap) do
				self:destroyElement(posIndex)
			end
		end
	end

	self:updateElementDataMap()
	self:cleanCombineData()

	local haveDiamond = false

	for posIndex, elementItem in pairs(self.elementChangeMap) do
		if elementItem.elementData.level == HuiDiaoLanEnum.MaxElementLevel then
			haveDiamond = true

			break
		end
	end

	if haveDiamond then
		TaskDispatcher.runDelay(self.diamondBeginFlyout, self, HuiDiaoLanEnum.WaitDiamondFlyoutTime)
	else
		self:doCreateElement()
	end
end

function HuiDiaoLanSceneView:diamondBeginFlyout()
	local haveDiamondFlyout = self:diamondFlyOut()

	if haveDiamondFlyout then
		self.effectView:playDiamondAddAnim()
		TaskDispatcher.runDelay(self.doCreateElement, self, 0.5)
	else
		self:doCreateElement()
	end
end

function HuiDiaoLanSceneView:addCombineEnergyCount()
	local addEnergyValue = 0

	for combinePosIndex, elementMap in pairs(self.combineElementMap) do
		if tabletool.len(elementMap) >= HuiDiaoLanEnum.StartCombineNum then
			local elementItem = self.elementItemMap[combinePosIndex]
			local beforeLevel = elementItem.elementData.level - 1
			local mergeCount = tabletool.len(elementMap) + 1
			local addEnergy = HuiDiaoLanConfig.instance:getMergeRecoverEnergy(beforeLevel, mergeCount)

			addEnergyValue = addEnergyValue + addEnergy
		end
	end

	table.insert(self.addEnergyCountList, addEnergyValue)
	TaskDispatcher.runDelay(self.doAddEnergy, self, 0.1)
end

function HuiDiaoLanSceneView:doAddEnergy()
	self.gameView:addEnergy(self.addEnergyCountList[1])
	table.remove(self.addEnergyCountList, 1)
end

function HuiDiaoLanSceneView:doCreateElement()
	local bornCount = 0

	for _, combineCount in pairs(self.combineToBornCountMap) do
		bornCount = bornCount + combineCount
	end

	if self.isMoveCheckToCombine then
		bornCount = bornCount + self.moveBorn
	end

	local createCount = self:createRandomElement(bornCount)

	if createCount > 0 then
		AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_occur)
	end

	if tabletool.len(self.elementChangeMap) > 0 then
		TaskDispatcher.runDelay(self.combineAllElement, self, HuiDiaoLanEnum.WaitBornToCombineTime)
	else
		TaskDispatcher.cancelTask(self.levelUpElement, self)

		self.isMoveCheckToCombine = false
	end
end

function HuiDiaoLanSceneView:cleanCombineData()
	for combinePosIndex, combineTweenMap in pairs(self.combineMoveTweenList) do
		for posIndex, tweenId in pairs(combineTweenMap) do
			if tweenId then
				ZProj.TweenHelper.KillById(tweenId)

				combineTweenMap[posIndex] = nil
			end
		end
	end

	self.combineElementMap = self:getUserDataTb_()
	self.levelUpElementDataMap = self:getUserDataTb_()
	self.combineMoveTweenList = self:getUserDataTb_()
	self.combineCount = 0
end

function HuiDiaoLanSceneView:diamondFlyOut()
	self:cleanDiamondFlyoutTween()

	local haveDiamondFlyout = false

	self.diamondFlyoutTweenMap = self:getUserDataTb_()

	for posIndex, elementItem in pairs(self.elementChangeMap) do
		if elementItem.elementData.level == HuiDiaoLanEnum.MaxElementLevel then
			local diamondTweenInfo = self.diamondFlyoutTweenMap[posIndex]

			diamondTweenInfo = diamondTweenInfo or {}
			diamondTweenInfo.moveParam = {
				posIndex = posIndex,
				elementItem = elementItem
			}
			diamondTweenInfo.tweenId = ZProj.TweenHelper.DOAnchorPos(elementItem.go.transform, self.diamondTargetPosX, self.diamondTargetPosY, HuiDiaoLanEnum.DiamondFlyoutMoveTime, self.diamondMoveFinish, self, diamondTweenInfo.moveParam)
			self.diamondFlyoutTweenMap[posIndex] = diamondTweenInfo
			haveDiamondFlyout = true

			elementItem.comp:playDiamondFlyoutAnim()
		end
	end

	return haveDiamondFlyout
end

function HuiDiaoLanSceneView:diamondMoveFinish(moveParam)
	if self.diamondFlyoutTweenMap[moveParam.posIndex] then
		ZProj.TweenHelper.KillById(self.diamondFlyoutTweenMap[moveParam.posIndex].tweenId)

		self.diamondFlyoutTweenMap[moveParam.posIndex] = nil
	end

	self:destroyElement(moveParam.posIndex)

	self.elementChangeMap[moveParam.posIndex] = nil

	self:updateElementDataMap()
	self.gameView:addCurDiamond()
end

function HuiDiaoLanSceneView:createRandomElement(createCount, createPosIndexList)
	if createCount == 0 then
		return
	end

	self:updateElementDataMap()

	local createRandomElementDataList = HuiDiaoLanGameModel.instance:getRandomElemenetList(createCount)

	if not createPosIndexList then
		::label_49_0::

		local createRandomPosIndexList = HuiDiaoLanGameModel.instance:getRandomElementPosList()

		for index, posIndex in ipairs(createRandomPosIndexList) do
			local elementData = {}

			elementData.posIndex = posIndex
			elementData.color = createRandomElementDataList[index].color
			elementData.level = 1

			self:createAndRefreshElement(elementData)

			local elementItem = self.elementItemMap[posIndex]

			self.elementChangeMap[posIndex] = elementItem

			elementItem.comp:playBornAnim()
		end

		self:updateElementDataMap()

		for index, posIndex in ipairs(createRandomPosIndexList) do
			self:removeSameElementInMoveing(posIndex)
		end

		return #createRandomPosIndexList
	end
end

function HuiDiaoLanSceneView:startSpPlaneMove()
	if not next(self.levelUpElementDataMap) and not self.isMoveCheckToCombine and self.isSetCurElementSelectState then
		if not self.isMoveActProcessFinish then
			self.isMoveActProcessFinish = true
			self.isSceneActProcessFinish = false

			self:setInSpPlaneElementMove()

			self.isSetCurElementSelectState = false
		elseif self.isMoveActProcessFinish and not self.isSceneActProcessFinish then
			self.isMoveActProcessFinish = true
			self.isSceneActProcessFinish = true

			gohelper.setActive(self._goclickMask, false)
			self.gameView:checkGameFinish()
		end
	end
end

function HuiDiaoLanSceneView:setInSpPlaneElementMove()
	self:cleanSpPlaneMoveTween()

	self.elementChangeMap = self:getUserDataTb_()
	self.doWaterMoveCount = 0
	self.doGravityMoveCount = 0
	self.spPlanePosIndexList = HuiDiaoLanGameModel.instance:getSpPlanePosIndexList()

	for _, spPlaneInfo in pairs(self.spPlanePosIndexList) do
		if spPlaneInfo.planeType == HuiDiaoLanEnum.PlaneType.Water then
			self:onWaterPlaneMove(spPlaneInfo.indexList)
		elseif spPlaneInfo.planeType == HuiDiaoLanEnum.PlaneType.Gravity then
			self:onGravityPlaneMove(spPlaneInfo.indexList)
		end
	end

	self:combineAllSpPlaneMoveElement()
end

function HuiDiaoLanSceneView:onWaterPlaneMove(planePosIndexList)
	for index = #planePosIndexList - 1, 1, -1 do
		local curPosIndex = planePosIndexList[index]
		local elementItem = self.elementItemMap[curPosIndex]

		if elementItem then
			local targetPosIndex = self:getWaterMoveTargetPosIndex(planePosIndexList, index)

			if self.curSelectElement and self.beginDragPosIndex == curPosIndex and targetPosIndex then
				self.beginDragPosIndex = targetPosIndex

				self:setMovePlaneSelectShowState(false)
			end

			if targetPosIndex then
				self.waterMoveTargetPosMap[targetPosIndex] = elementItem

				local moveParam = {
					elementItem = elementItem,
					targetPosIndex = targetPosIndex,
					curPosIndex = curPosIndex,
					planePosIndexList = planePosIndexList
				}

				self.doWaterMoveCount = self.doWaterMoveCount + 1

				self:doWaterPlaneMove(moveParam)
			end
		end
	end
end

function HuiDiaoLanSceneView:doWaterPlaneMove(moveParam)
	if moveParam.curPosIndex == moveParam.targetPosIndex then
		if self.waterMoveTweenMap[moveParam.targetPosIndex] then
			ZProj.TweenHelper.KillById(self.waterMoveTweenMap[moveParam.targetPosIndex].tweenId)

			self.waterMoveTweenMap[moveParam.targetPosIndex] = nil
		end

		self.elementItemMap[moveParam.targetPosIndex] = tabletool.copy(moveParam.elementItem)
		self.elementChangeMap[moveParam.targetPosIndex] = self.elementItemMap[moveParam.targetPosIndex]

		self.elementItemMap[moveParam.targetPosIndex].comp:playIdleAnim()

		self.doWaterMoveCount = self.doWaterMoveCount - 1

		if self.doWaterMoveCount == 0 then
			self:updateElementDataMap()
			self:combineAllSpPlaneMoveElement()
		end

		return
	end

	local nextPosIndex = self:getNextWaterMovePosIndex(moveParam.curPosIndex)
	local nextPosX, nextPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(nextPosIndex)

	self.elementItemMap[moveParam.curPosIndex] = self.elementItemMap[nextPosIndex]
	self.elementItemMap[nextPosIndex] = self.elementItemMap[moveParam.curPosIndex]

	self:updateElementData(nextPosIndex)
	self:updateElementData(moveParam.curPosIndex)
	self:updateElementDataMap()

	moveParam.curPosIndex = nextPosIndex

	local tweenInfo = self.waterMoveTweenMap[moveParam.targetPosIndex]

	tweenInfo = tweenInfo or {}
	tweenInfo.tweenId = ZProj.TweenHelper.DOAnchorPos(moveParam.elementItem.go.transform, nextPosX, nextPosY, HuiDiaoLanEnum.ElementNormalMoveTime, self.doWaterPlaneMove, self, moveParam)
	tweenInfo.moveParam = moveParam
	self.waterMoveTweenMap[moveParam.targetPosIndex] = tweenInfo

	moveParam.elementItem.comp:playMoveAnim()
end

function HuiDiaoLanSceneView:getNextWaterMovePosIndex(posIndex)
	local planeItem = self.planeItemMap[posIndex]

	if planeItem and planeItem.isSpPlane then
		local spIndex = Mathf.Min(planeItem.planeData.spIndex + 1, #planeItem.planeData.posIndexList)

		return planeItem.planeData.posIndexList[spIndex]
	end
end

function HuiDiaoLanSceneView:getWaterMoveTargetPosIndex(planePosIndexList, curIndex)
	for index = #planePosIndexList, curIndex + 1, -1 do
		local posIndex = planePosIndexList[index]
		local elementItem = self.elementItemMap[posIndex]

		if not self.waterMoveTargetPosMap[posIndex] and (not elementItem or elementItem and self:checkElementWaterMoving(elementItem)) then
			return planePosIndexList[index]
		end
	end
end

function HuiDiaoLanSceneView:checkElementWaterMoving(elementItem)
	for posIndex, tweenInfo in pairs(self.waterMoveTweenMap) do
		if tweenInfo.moveParam.elementItem == elementItem then
			return true
		end
	end

	return false
end

function HuiDiaoLanSceneView:onGravityPlaneMove(planePosIndexList)
	for index = #planePosIndexList, 1, -1 do
		local curPosIndex = planePosIndexList[index]
		local elementItem = self.elementItemMap[curPosIndex]

		if elementItem then
			local targetPosIndex = self:getGravityMoveTargetPosIndex(planePosIndexList, curPosIndex)

			if self.curSelectElement and self.beginDragPosIndex == curPosIndex and targetPosIndex and targetPosIndex ~= curPosIndex then
				self.beginDragPosIndex = targetPosIndex

				self:setMovePlaneSelectShowState(false)
			end

			if targetPosIndex and targetPosIndex ~= curPosIndex then
				self.gravityMoveTargetPosMap[targetPosIndex] = elementItem

				local moveParam = {
					elementItem = elementItem,
					targetPosIndex = targetPosIndex,
					curPosIndex = curPosIndex,
					planePosIndexList = planePosIndexList
				}

				self.doGravityMoveCount = self.doGravityMoveCount + 1

				self:doGravityPlaneMove(moveParam)
			end
		end
	end
end

function HuiDiaoLanSceneView:doGravityPlaneMove(moveParam)
	if moveParam.curPosIndex == moveParam.targetPosIndex then
		if self.gravityMoveTweenMap[moveParam.targetPosIndex] then
			ZProj.TweenHelper.KillById(self.gravityMoveTweenMap[moveParam.targetPosIndex].tweenId)

			self.gravityMoveTweenMap[moveParam.targetPosIndex] = nil
		end

		self.elementItemMap[moveParam.targetPosIndex] = tabletool.copy(moveParam.elementItem)
		self.elementChangeMap[moveParam.targetPosIndex] = self.elementItemMap[moveParam.targetPosIndex]

		self.elementItemMap[moveParam.targetPosIndex].comp:playIdleAnim()

		self.doGravityMoveCount = self.doGravityMoveCount - 1

		if self.doGravityMoveCount == 0 then
			self:updateElementDataMap()
			self:combineAllSpPlaneMoveElement()
		end

		return
	end

	local nextPosIndex = self:getNextGravityMovePosIndex(moveParam.curPosIndex)
	local nextPosX, nextPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(nextPosIndex)

	self.elementItemMap[moveParam.curPosIndex] = self.elementItemMap[nextPosIndex]
	self.elementItemMap[nextPosIndex] = self.elementItemMap[moveParam.curPosIndex]

	self:updateElementData(nextPosIndex)
	self:updateElementData(moveParam.curPosIndex)
	self:updateElementDataMap()

	moveParam.curPosIndex = nextPosIndex

	local tweenInfo = self.gravityMoveTweenMap[moveParam.targetPosIndex]

	tweenInfo = tweenInfo or {}

	moveParam.elementItem.comp:playMoveAnim()

	tweenInfo.tweenId = ZProj.TweenHelper.DOAnchorPos(moveParam.elementItem.go.transform, nextPosX, nextPosY, HuiDiaoLanEnum.ElementNormalMoveTime, self.doGravityPlaneMove, self, moveParam)
	tweenInfo.moveParam = moveParam
	self.gravityMoveTweenMap[moveParam.targetPosIndex] = tweenInfo
end

function HuiDiaoLanSceneView:getNextGravityMovePosIndex(posIndex)
	local posIndexList = string.splitToNumber(posIndex, "#")
	local curPosXIndex = posIndexList[1]
	local curPosYIndex = posIndexList[2]
	local targetPosYIndex = curPosYIndex + 1

	return string.format("%d#%d", curPosXIndex, targetPosYIndex)
end

function HuiDiaoLanSceneView:getGravityMoveTargetPosIndex(planePosIndexList, curPosIndex)
	local posIndexList = string.splitToNumber(curPosIndex, "#")
	local curPosXIndex = posIndexList[1]
	local curPosYIndex = posIndexList[2]
	local targetPosYIndex = curPosYIndex + 1

	if targetPosYIndex > self.gameInfoData.planeHeightCount then
		return
	end

	local targetPosIndex = string.format("%d#%d", curPosXIndex, targetPosYIndex)
	local elementItem = self.elementItemMap[targetPosIndex]
	local isTargetPos = not self.gravityMoveTargetPosMap[targetPosIndex] and (not elementItem or elementItem and self:checkElementGravityMoving(elementItem))

	if isTargetPos then
		if tabletool.indexOf(planePosIndexList, targetPosIndex) then
			return self:getGravityMoveTargetPosIndex(planePosIndexList, targetPosIndex)
		else
			return targetPosIndex
		end
	else
		return curPosIndex
	end
end

function HuiDiaoLanSceneView:checkElementGravityMoving(elementItem)
	for posIndex, tweenInfo in pairs(self.gravityMoveTweenMap) do
		if tweenInfo.moveParam.elementItem == elementItem then
			return true
		end
	end

	return false
end

function HuiDiaoLanSceneView:combineAllSpPlaneMoveElement()
	self:cleanCombineData()

	if self.doWaterMoveCount == 0 and self.doGravityMoveCount == 0 then
		for posIndex, elementItem in pairs(self.elementChangeMap) do
			self:removeSameElementInMoveing(posIndex)
		end

		self.isCombineAllSpPlaneMoveElement = true

		self:combineAllElement()
	end
end

function HuiDiaoLanSceneView:onCombineAllSpPlaneMoveElementFinish()
	self.isCombineAllSpPlaneMoveElement = false

	if self.curSelectElement then
		local posIndex = self.curSelectElement.elementData.posIndex

		self:setCurElementSelectState(posIndex)
	else
		self:cancelMovePlaneSelect()
	end

	self:checkSpMoveSelectIsEmpty()
	gohelper.setActive(self._goclickMask, false)
	self.gameView:checkGameFinish()
end

function HuiDiaoLanSceneView:setChangeColorSkillReadyState(state)
	if self.isSpEpisode then
		self:cancelSpMovePlaneSelect()
	else
		self:cancelMovePlaneSelect()
	end

	for posIndex, planeItem in pairs(self.planeItemMap) do
		planeItem.comp:setSkillReadyState(state)
	end

	if not state then
		for posIndex, planeItem in pairs(self.planeItemMap) do
			planeItem.comp:setSelectShowState(false)
		end
	end
end

function HuiDiaoLanSceneView:setChangeColorSkillState(posIndex)
	for posIndex, planeItem in pairs(self.planeItemMap) do
		planeItem.comp:setSelectShowState(false)
	end

	local posIndexList = string.splitToNumber(posIndex, "#")
	local posXIndex = posIndexList[1]
	local posYIndex = posIndexList[2]
	local skillCenterPosXIndex = Mathf.Clamp(posXIndex, 2, self.gameInfoData.planeWidthCount - 1)
	local skillCenterPosYIndex = Mathf.Clamp(posYIndex, 2, self.gameInfoData.planeHeightCount - 1)

	self.skillSelectElementItemMap = self:getUserDataTb_()

	for posY = skillCenterPosYIndex - 1, skillCenterPosYIndex + 1 do
		for posX = skillCenterPosXIndex - 1, skillCenterPosXIndex + 1 do
			local itemPosIndex = string.format("%d#%d", posX, posY)
			local planeItem = self.planeItemMap[itemPosIndex]

			if planeItem then
				planeItem.comp:setSelectShowState(true)
			end

			local elementItem = self.elementItemMap[itemPosIndex]

			if elementItem and elementItem.elementData.level == 1 then
				local skillSelectInfo = {}

				skillSelectInfo.posIndex = itemPosIndex
				skillSelectInfo.color = elementItem.elementData.color
				skillSelectInfo.elementItem = elementItem
				self.skillSelectElementItemMap[itemPosIndex] = skillSelectInfo
			end
		end
	end

	if not next(self.skillSelectElementItemMap) then
		self.effectView:playChangeColorSkillErrorAnim()
		self.gameView:_btncloseSkillOnClick()

		for posIndex, planeItem in pairs(self.planeItemMap) do
			planeItem.comp:setSelectShowState(false)
			planeItem.comp:setSkillReadyState(false)
		end

		return
	end

	local centerPosIndex = string.format("%d#%d", skillCenterPosXIndex, skillCenterPosYIndex)
	local selectPlanePosX, selectPlanePosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(centerPosIndex)

	gohelper.setActive(self._gochangeColor, true)
	recthelper.setAnchor(self._gochangeColor.transform, selectPlanePosX, selectPlanePosY)
end

function HuiDiaoLanSceneView:doChangeColorSkill()
	if not next(self.skillSelectElementItemMap) then
		return
	end

	self:cleanCombineData()
	gohelper.setActive(self._goclickMask, true)

	local createPosIndexList = {}

	for posIndex, skillSelectInfo in pairs(self.skillSelectElementItemMap) do
		table.insert(createPosIndexList, posIndex)
		self:destroyElement(posIndex)
	end

	self:updateElementDataMap()

	self.isMoveActProcessFinish = false
	self.isSceneActProcessFinish = false
	self.isSetCurElementSelectState = true

	self:createRandomElement(#createPosIndexList, createPosIndexList)
	TaskDispatcher.runDelay(self.afterChangeColorSkillToCombine, self, 0.6)
	gohelper.setActive(self._gochangeColor, false)

	for posIndex, planeItem in pairs(self.planeItemMap) do
		planeItem.comp:setSelectShowState(false)
		planeItem.comp:setSkillReadyState(false)
	end

	for posIndex, skillSelectInfo in pairs(self.skillSelectElementItemMap) do
		local elementItem = self.elementItemMap[posIndex]

		elementItem.comp:playSwitchAnim(skillSelectInfo.color, elementItem.elementData.color)
	end

	AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_change)

	self.skillSelectElementItemMap = self:getUserDataTb_()

	self.gameView:showSkillCd()
	self.gameView:_btncloseSkillOnClick()
end

function HuiDiaoLanSceneView:afterChangeColorSkillToCombine()
	if tabletool.len(self.elementChangeMap) > 0 then
		self:combineAllElement()
	end
end

function HuiDiaoLanSceneView:setExchangePosSkillReadyState(state)
	if self.isSpEpisode then
		self:cancelSpMovePlaneSelect()
	else
		self:cancelMovePlaneSelect()
	end

	for posIndex, elementItem in pairs(self.elementItemMap) do
		local planeItem = self.planeItemMap[posIndex]

		planeItem.comp:setSkillReadyState(state)
	end

	if not state then
		for posIndex, elementItem in pairs(self.elementItemMap) do
			local planeItem = self.planeItemMap[posIndex]

			planeItem.comp:setSelectShowState(false)
		end

		self.exchangePosSelectElementList = self:getUserDataTb_()
		self.isMoveActProcessFinish = false
		self.isSceneActProcessFinish = false
		self.isSetCurElementSelectState = true
	end
end

function HuiDiaoLanSceneView:setExchangePosSkillData(posIndex)
	local elementItem = self.elementItemMap[posIndex]

	if not elementItem then
		self.effectView:playExchangePosSkillErrorAnim()

		return
	end

	if #self.exchangePosSelectElementList == 1 and self.exchangePosSelectElementList[1] and self.exchangePosSelectElementList[1].elementData.posIndex == posIndex then
		self.effectView:playExchangePosSkillErrorAnim()

		return
	end

	if #self.exchangePosSelectElementList < 2 then
		local planeItem = self.planeItemMap[posIndex]

		planeItem.comp:setSelectShowState(true)
		planeItem.comp:setSkillReadyState(false)
		table.insert(self.exchangePosSelectElementList, elementItem)
	end

	if #self.exchangePosSelectElementList == 2 then
		gohelper.setActive(self._goclickMask, true)

		for posIndex, planeItem in pairs(self.planeItemMap) do
			planeItem.comp:setSelectShowState(false)
			planeItem.comp:setSkillReadyState(false)
		end

		local curElementItem = self.exchangePosSelectElementList[1]
		local targetElementItem = self.exchangePosSelectElementList[2]

		if not curElementItem or not targetElementItem then
			self.effectView:playExchangePosSkillErrorAnim()

			return
		end

		gohelper.setAsLastSibling(curElementItem.go)
		gohelper.setAsLastSibling(targetElementItem.go)

		self.exchangePosElementTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, HuiDiaoLanEnum.ExchangePosSkillMoveTime, self.doExchangePosSkill, self.exchangePosSkillFinish, self)

		AudioMgr.instance:trigger(AudioEnum3_2.HuiDiaoLan.play_ui_shengyan_hdl_swap)
	end
end

function HuiDiaoLanSceneView:doExchangePosSkill(value)
	local curElementItem = self.exchangePosSelectElementList[1]
	local targetElementItem = self.exchangePosSelectElementList[2]
	local curPosX, curPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(curElementItem.elementData.posIndex)
	local targetPosX, targetPosY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(targetElementItem.elementData.posIndex)
	local distance = Vector2.Distance(Vector2(curPosX, curPosY), Vector2(targetPosX, targetPosY))
	local curMovePosX = Mathf.Lerp(curPosX, targetPosX, value)
	local curMovePosY = Mathf.Lerp(curPosY, targetPosY, value) + Mathf.Sin(value * Mathf.PI) * HuiDiaoLanEnum.ExchangePosSkillRadHeight * distance
	local targetMovePosX = Mathf.Lerp(targetPosX, curPosX, value)
	local targetMovePosY = Mathf.Lerp(targetPosY, curPosY, value) - Mathf.Sin(value * Mathf.PI) * HuiDiaoLanEnum.ExchangePosSkillRadHeight * distance

	recthelper.setAnchor(curElementItem.go.transform, curMovePosX, curMovePosY)
	recthelper.setAnchor(targetElementItem.go.transform, targetMovePosX, targetMovePosY)
end

function HuiDiaoLanSceneView:exchangePosSkillFinish()
	local curElementItem = self.exchangePosSelectElementList[1]
	local targetElementItem = self.exchangePosSelectElementList[2]
	local curPosIndex = curElementItem.elementData.posIndex
	local targetPosIndex = targetElementItem.elementData.posIndex

	self.elementItemMap[targetPosIndex], self.elementItemMap[curPosIndex] = self.elementItemMap[curPosIndex], self.elementItemMap[targetPosIndex]

	self:updateElementData(targetPosIndex)
	self:updateElementData(curPosIndex)
	self:updateElementDataMap()
	self:cleanCombineData()

	self.elementChangeMap[targetPosIndex] = self.elementItemMap[targetPosIndex]
	self.elementChangeMap[curPosIndex] = self.elementItemMap[curPosIndex]
	self.exchangePosSelectElementList = self:getUserDataTb_()
	self.isMoveActProcessFinish = false
	self.isSceneActProcessFinish = false
	self.isSetCurElementSelectState = true

	self:combineAllElement()
	self.gameView:showSkillCd()
	self.gameView:_btncloseSkillOnClick()
end

function HuiDiaoLanSceneView:cancelSpMovePlaneSelect()
	self:setSpMovePlaneSelectShowState(false)

	self.beginDragPosIndex = nil
	self.curSelectElement = nil
	self.isSpRotating = false
end

function HuiDiaoLanSceneView:cancelMovePlaneSelect()
	self:setMovePlaneSelectShowState(false)

	self.beginDragPosIndex = nil
	self.curSelectElement = nil
end

function HuiDiaoLanSceneView:checkSpMoveSelectIsEmpty()
	if not self.isSpEpisode then
		return
	end

	local isEmpty = true

	for _, posIndex in ipairs(self.spMovePosIndexList) do
		local elementItem = self.elementItemMap[posIndex]

		if elementItem then
			isEmpty = false

			break
		end
	end

	if isEmpty then
		self:cancelSpMovePlaneSelect()
	end
end

function HuiDiaoLanSceneView:cleanTween()
	if self.targetElementMoveTweenId then
		ZProj.TweenHelper.KillById(self.targetElementMoveTweenId)

		self.targetElementMoveTweenId = nil
	end

	if self.curElementMoveTweenId then
		ZProj.TweenHelper.KillById(self.curElementMoveTweenId)

		self.curElementMoveTweenId = nil
	end

	for index, tweenInfo in ipairs(self.spRotateMoveTweenList) do
		if tweenInfo.tweenId then
			ZProj.TweenHelper.KillById(tweenInfo.tweenId)

			tweenInfo.tweenId = nil
		end
	end

	TaskDispatcher.cancelTask(self.levelUpElement, self)
end

function HuiDiaoLanSceneView:cleanSpPlaneMoveTween()
	for index, tweenInfo in pairs(self.waterMoveTweenMap) do
		if tweenInfo.tweenId then
			ZProj.TweenHelper.KillById(tweenInfo.tweenId)

			tweenInfo.tweenId = nil
		end
	end

	for index, tweenInfo in pairs(self.gravityMoveTweenMap) do
		if tweenInfo.tweenId then
			ZProj.TweenHelper.KillById(tweenInfo.tweenId)

			tweenInfo.tweenId = nil
		end
	end

	self.waterMoveTweenMap = self:getUserDataTb_()
	self.waterMoveTargetPosMap = self:getUserDataTb_()
	self.gravityMoveTweenMap = self:getUserDataTb_()
	self.gravityMoveTargetPosMap = self:getUserDataTb_()
end

function HuiDiaoLanSceneView:cleanDiamondFlyoutTween()
	for index, tweenInfo in pairs(self.diamondFlyoutTweenMap) do
		if tweenInfo.tweenId then
			ZProj.TweenHelper.KillById(tweenInfo.tweenId)

			tweenInfo.tweenId = nil
		end
	end

	self.diamondFlyoutTweenMap = self:getUserDataTb_()
end

function HuiDiaoLanSceneView:destroyElement(posIndex)
	if self.elementItemMap[posIndex] then
		gohelper.destroy(self.elementItemMap[posIndex].go)

		self.elementItemMap[posIndex].go = nil
		self.elementItemMap[posIndex] = nil
	end
end

function HuiDiaoLanSceneView:destroyAllElement()
	for posIndex, elementItem in pairs(self.elementItemMap) do
		if elementItem and elementItem.go then
			gohelper.destroy(elementItem.go)
		end
	end
end

function HuiDiaoLanSceneView:gameFinish()
	self.isSetCurElementSelectState = false

	self:cleanData()
end

function HuiDiaoLanSceneView:cleanData()
	self:cleanTween()
	self:cleanSpPlaneMoveTween()
	self:cleanDiamondFlyoutTween()
	self:cleanCombineData()
	TaskDispatcher.cancelTask(self.doCreateElement, self)
	TaskDispatcher.cancelTask(self.levelUpElement, self)
	TaskDispatcher.cancelTask(self.doAddEnergy, self)
	TaskDispatcher.cancelTask(self.afterChangeColorSkillToCombine, self)
	TaskDispatcher.cancelTask(self.combineAllElement, self)

	for posIndex, planeItem in pairs(self.planeItemMap) do
		planeItem.comp:setSelectShowState(false)
		planeItem.comp:setSkillReadyState(false)
	end
end

function HuiDiaoLanSceneView:onClose()
	self:cleanData()
end

function HuiDiaoLanSceneView:onDestroyView()
	TaskDispatcher.cancelTask(self.doCreateElement, self)
	TaskDispatcher.cancelTask(self.levelUpElement, self)
end

return HuiDiaoLanSceneView
