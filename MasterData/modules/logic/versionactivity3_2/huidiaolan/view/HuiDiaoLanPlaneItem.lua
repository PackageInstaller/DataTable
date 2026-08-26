-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanPlaneItem.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanPlaneItem", package.seeall)

local HuiDiaoLanPlaneItem = class("HuiDiaoLanPlaneItem", LuaCompBase)

function HuiDiaoLanPlaneItem:ctor(param)
	self.param = param
	self.isSpPlane = self.param.isSpPlane
	self.planeData = self.param.planeData
	self.isSpEpisode = self.param.isSpEpisode
	self.goplaneContent = self.param.goplaneContent
	self.gameInfoData = HuiDiaoLanGameModel.instance:getGameInfoData()
	self.planeWidth = self.param.planeWidth
	self.planeHeight = self.param.planeHeight
	self.sceneView = self.param.scenevView
	self.checkMoveDistance = self.gameInfoData.planeItemWidth / 4
end

function HuiDiaoLanPlaneItem:init(go)
	self:__onInit()

	self.go = go
	self._gonormal = gohelper.findChild(self.go, "#go_normal")
	self._goscene = gohelper.findChild(self.go, "#go_scene")
	self._gowater = gohelper.findChild(self.go, "#go_scene/#go_water")
	self._gogravity = gohelper.findChild(self.go, "#go_scene/#go_gravity")
	self._goskillState = gohelper.findChild(self.go, "#go_skillState")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self._drag = SLFramework.UGUI.UIDragListener.Get(self.go)

	gohelper.setActive(self._goskillState, false)
	gohelper.setActive(self._goselect, false)
end

function HuiDiaoLanPlaneItem:addEventListeners()
	if self._drag then
		self._drag:AddDragBeginListener(self.onItemDragBegin, self)
		self._drag:AddDragEndListener(self.onItemDragEnd, self)
		self._drag:AddDragListener(self.onItemDrag, self)
	end

	self._btnclick:AddClickListener(self._btnItemOnClick, self)
end

function HuiDiaoLanPlaneItem:removeEventListeners()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()
	end

	self._btnclick:RemoveClickListener()
end

function HuiDiaoLanPlaneItem:_btnItemOnClick()
	local isChangeColorState = HuiDiaoLanGameModel.instance:getChangeColorSkillState()
	local isExchangePosState = HuiDiaoLanGameModel.instance:getExchangePosSkillState()

	if isChangeColorState then
		self.sceneView:setChangeColorSkillState(self.posIndex)

		return
	end

	if isExchangePosState then
		self.sceneView:setExchangePosSkillData(self.posIndex)

		return
	end

	if self.isSpEpisode then
		local clickPosIndex = self.posIndex
		local clickPosIndexList = string.splitToNumber(clickPosIndex, "#")
		local clickPosXIndex = clickPosIndexList[1]
		local clickPosYIndex = clickPosIndexList[2]

		if self.planePosX == self.gameInfoData.planeWidthCount then
			clickPosXIndex = clickPosXIndex - 1
		end

		if self.planePosY == self.gameInfoData.planeHeightCount then
			clickPosYIndex = clickPosYIndex - 1
		end

		clickPosIndex = clickPosXIndex .. "#" .. clickPosYIndex

		self.sceneView:onSpPlaneItemClick(clickPosXIndex .. "#" .. clickPosYIndex)
	else
		self.sceneView:onPlaneItemClick(self.posIndex)
	end
end

function HuiDiaoLanPlaneItem:onItemDragBegin(param, pointerEventData)
	local isChangeColorState = HuiDiaoLanGameModel.instance:getChangeColorSkillState()
	local isExchangePosState = HuiDiaoLanGameModel.instance:getExchangePosSkillState()

	if self.isSpEpisode or isChangeColorState or isExchangePosState then
		return
	end

	self.isDragMoving = false
	self.beginPosX, self.beginPosY = self:getMouseAnchorPos(pointerEventData)
	self.beginPosXIndex, self.beginPosYIndex = self:getMousePosIndex(self.beginPosX, self.beginPosY)

	local beginPosIndex = self.beginPosXIndex .. "#" .. self.beginPosYIndex

	self.sceneView:setElementDraggingBegin(beginPosIndex)
end

function HuiDiaoLanPlaneItem:onItemDrag(param, pointerEventData)
	local isChangeColorState = HuiDiaoLanGameModel.instance:getChangeColorSkillState()
	local isExchangePosState = HuiDiaoLanGameModel.instance:getExchangePosSkillState()

	if self.isSpEpisode or isChangeColorState or isExchangePosState then
		return
	end

	local posX, posY = self:getMouseAnchorPos(pointerEventData)
	local posXIndex, posYIndex = self:getMousePosIndex(posX, posY)
	local targetPosXIndex, targetPosYIndex, canMove = self:getDragTargetPosIndex(posXIndex, posYIndex)
	local moveXDistance = Mathf.Abs(posX - self.beginPosX)
	local moveYDistance = Mathf.Abs(posY - self.beginPosY)

	if canMove and (moveXDistance > self.checkMoveDistance or moveYDistance > self.checkMoveDistance) and not self.isDragMoving then
		self.isDragMoving = true

		local endPosIndex = targetPosXIndex .. "#" .. targetPosYIndex
		local beingPosIndex = self.beginPosXIndex .. "#" .. self.beginPosYIndex

		self.sceneView:setElementDraggingEnd(beingPosIndex, endPosIndex)
	end
end

function HuiDiaoLanPlaneItem:onItemDragEnd(param, pointerEventData)
	local isChangeColorState = HuiDiaoLanGameModel.instance:getChangeColorSkillState()
	local isExchangePosState = HuiDiaoLanGameModel.instance:getExchangePosSkillState()

	if self.isSpEpisode or isChangeColorState or isExchangePosState then
		return
	end

	local posX, posY = self:getMouseAnchorPos(pointerEventData)
	local posXIndex, posYIndex = self:getMousePosIndex(posX, posY)
	local targetPosXIndex, targetPosYIndex, canMove = self:getDragTargetPosIndex(posXIndex, posYIndex)

	if canMove and not self.isDragMoving then
		local endPosIndex = targetPosXIndex .. "#" .. targetPosYIndex
		local beingPosIndex = self.beginPosXIndex .. "#" .. self.beginPosYIndex

		self.sceneView:setElementDraggingEnd(beingPosIndex, endPosIndex)
	end
end

function HuiDiaoLanPlaneItem:getDragTargetPosIndex(posXIndex, posYIndex)
	local canMove = false

	if posXIndex > self.beginPosXIndex and posYIndex == self.beginPosYIndex then
		posXIndex = self.beginPosXIndex + 1
		canMove = true
	elseif posXIndex < self.beginPosXIndex and posYIndex == self.beginPosYIndex then
		posXIndex = self.beginPosXIndex - 1
		canMove = true
	elseif posYIndex > self.beginPosYIndex and posXIndex == self.beginPosXIndex then
		posYIndex = self.beginPosYIndex + 1
		canMove = true
	elseif posYIndex < self.beginPosYIndex and posXIndex == self.beginPosXIndex then
		posYIndex = self.beginPosYIndex - 1
		canMove = true
	else
		posXIndex = self.beginPosXIndex
		posYIndex = self.beginPosYIndex
	end

	return posXIndex, posYIndex, canMove
end

function HuiDiaoLanPlaneItem:getMouseAnchorPos(pointerEventData)
	local posX, posY = recthelper.screenPosToAnchorPos2(pointerEventData.position, self.goplaneContent.transform)
	local anchorX = posX + self.planeWidth / 2
	local anchorY = posY - self.planeHeight / 2

	return anchorX, anchorY
end

function HuiDiaoLanPlaneItem:getMousePosIndex(posX, posY)
	local posXIndex = Mathf.Clamp(Mathf.Ceil((posX + HuiDiaoLanEnum.PlaneSpace / 2) / (self.gameInfoData.planeItemWidth + HuiDiaoLanEnum.PlaneSpace)), 1, self.gameInfoData.planeWidthCount)
	local posYIndex = Mathf.Clamp(Mathf.Ceil((HuiDiaoLanEnum.PlaneSpace / 2 - posY) / (self.gameInfoData.planeItemHeight + HuiDiaoLanEnum.PlaneSpace)), 1, self.gameInfoData.planeHeightCount)

	return posXIndex, posYIndex
end

function HuiDiaoLanPlaneItem:refreshUI(posIndex)
	self.posIndex = posIndex

	local planePosList = string.splitToNumber(posIndex, "#")

	self.planePosX = planePosList[1]
	self.planePosY = planePosList[2]

	gohelper.setActive(self._gonormal, not self.isSpPlane)
	gohelper.setActive(self._goscene, self.isSpPlane)

	if not self.isSpPlane or not self.planeData then
		return
	end

	self.isWater = self.planeData.planeType == HuiDiaoLanEnum.PlaneType.Water
	self.isGravity = self.planeData.planeType == HuiDiaoLanEnum.PlaneType.Gravity

	gohelper.setActive(self._gowater, self.isWater)
	gohelper.setActive(self._gogravity, self.isGravity)
end

function HuiDiaoLanPlaneItem:setSelectShowState(state)
	gohelper.setActive(self._goselect, state)
end

function HuiDiaoLanPlaneItem:setSkillReadyState(state)
	gohelper.setActive(self._goskillState, state)
end

function HuiDiaoLanPlaneItem:setPlanePosAndSize(posIndex)
	local posX, posY = HuiDiaoLanGameModel.instance:getPlaneItemAnchorPos(posIndex)

	recthelper.setAnchor(self.go.transform, posX, posY)
	recthelper.setSize(self.go.transform, self.gameInfoData.planeItemWidth, self.gameInfoData.planeItemHeight)
end

function HuiDiaoLanPlaneItem:onDestroy()
	return
end

return HuiDiaoLanPlaneItem
