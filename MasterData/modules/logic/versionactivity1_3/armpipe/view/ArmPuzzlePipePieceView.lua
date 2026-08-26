-- chunkname: @modules/logic/versionactivity1_3/armpipe/view/ArmPuzzlePipePieceView.lua

module("modules.logic.versionactivity1_3.armpipe.view.ArmPuzzlePipePieceView", package.seeall)

local ArmPuzzlePipePieceView = class("ArmPuzzlePipePieceView", BaseView)

function ArmPuzzlePipePieceView:onInitView()
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._gorightPiece = gohelper.findChild(self.viewGO, "#go_rightPiece")
	self._goPiecePanel = gohelper.findChild(self.viewGO, "#go_PiecePanel")
	self._gopieceItem = gohelper.findChild(self.viewGO, "#go_rightPiece/#go_pieceItem")
	self._godragItem = gohelper.findChild(self.viewGO, "#go_dragItem")
	self._imagedrag = gohelper.findChildImage(self.viewGO, "#go_dragItem/#image_drag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArmPuzzlePipePieceView:addEvents()
	if self._btnUIClick then
		self._btnUIClick:AddClickDownListener(self._onUIClickDown, self)
		self._btnUIClick:AddClickUpListener(self._onUIClickUp, self)
	end

	if self._btnUIdrag then
		self._btnUIdrag:AddDragListener(self._onDragIng, self)
		self._btnUIdrag:AddDragBeginListener(self._onDragBegin, self)
		self._btnUIdrag:AddDragEndListener(self._onDragEnd, self)
	end
end

function ArmPuzzlePipePieceView:removeEvents()
	if self._btnUIClick then
		self._btnUIClick:RemoveClickDownListener()
		self._btnUIClick:RemoveClickUpListener()
	end

	if self._btnUIdrag then
		self._btnUIdrag:RemoveDragBeginListener()
		self._btnUIdrag:RemoveDragListener()
		self._btnUIdrag:RemoveDragEndListener()
	end
end

function ArmPuzzlePipePieceView:_editableInitView()
	self._btnUIdrag = SLFramework.UGUI.UIDragListener.Get(self._gomap)
	self._isDrag = false
	self._godragItemTrs = self._godragItem.transform
	self._gomapTrs = self.viewGO.transform
	self._dragItemAnimator = self._godragItem:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)

	local typeIdList = {
		ArmPuzzlePipeEnum.type.straight,
		ArmPuzzlePipeEnum.type.corner,
		ArmPuzzlePipeEnum.type.t_shape
	}

	self._typeIdList = {}
	self._pieceItemList = self:getUserDataTb_()

	for _, typeId in ipairs(typeIdList) do
		if ArmPuzzlePipeModel.instance:isHasPlaceByTypeId(typeId) then
			table.insert(self._typeIdList, typeId)

			local cloneGo = gohelper.clone(self._gopieceItem, self._gorightPiece, "pieceitem_" .. typeId)
			local pieceItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, ArmPuzzlePipePieceItem, self)

			pieceItem:setTypeId(typeId)
			table.insert(self._pieceItemList, pieceItem)
		end
	end

	for i = 1, 3 do
		local goBg = gohelper.findChild(self.viewGO, "#go_PiecePanel/#image_PanelBG" .. i)

		gohelper.setActive(goBg, i == #self._pieceItemList)
	end

	gohelper.setActive(self._gopieceItem, false)
end

function ArmPuzzlePipePieceView:onUpdateParam()
	return
end

function ArmPuzzlePipePieceView:onOpen()
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.UIPipeDragBegin, self._onDragBeginEvent, self)
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.UIPipeDragIng, self._onDragIngEvent, self)
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.UIPipeDragEnd, self._onDragEndEvent, self)
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.PlaceItemRefresh, self._refreshUI, self)
	self.addEventCb(self, ArmPuzzlePipeController.instance, ArmPuzzlePipeEvent.ResetGameRefresh, self._refreshUI, self)
	self:_refreshUI()
end

function ArmPuzzlePipePieceView:_onGameClear()
	self._isDrag = false

	self:_refreshDragUI()
end

function ArmPuzzlePipePieceView:_onUIClickDown(param, pointerEventData)
	self:_cancelLongPressDown()

	if ArmPuzzlePipeModel.instance:isHasPlace() then
		local x, y = self:_getPipesXY(GamepadController.instance:getMousePosition())

		if x and y and ArmPuzzlePipeModel.instance:isPlaceByXY(x, y) then
			self._isHasLongPressTask = true

			TaskDispatcher.runDelay(self._onLongPressDown, self, 0.3)
		end
	end
end

function ArmPuzzlePipePieceView:_onUIClickUp()
	self:_cancelLongPressDown()

	if self._isCanDragUIOP then
		self._isCanDragUIOP = false

		self:_onDragEndEvent(GamepadController.instance:getMousePosition(), self._fromX, self._fromY)
	end
end

function ArmPuzzlePipePieceView:_onDragBegin(param, pointerEventData)
	if not self._isCanDragUIOP then
		self:_checkDragBegin(pointerEventData.position)
	end
end

function ArmPuzzlePipePieceView:_onDragIng(param, pointerEventData)
	if self._isCanDragUIOP then
		self:_onDragIngEvent(pointerEventData.position)
	end
end

function ArmPuzzlePipePieceView:_onDragEnd(param, pointerEventData)
	if self._isCanDragUIOP then
		self._isCanDragUIOP = false

		self:_onDragEndEvent(pointerEventData.position, self._fromX, self._fromY)
	end
end

function ArmPuzzlePipePieceView:_onDragBeginEvent(position, pipeTypeId, pipeValue)
	self._isDrag = false

	if ArmPuzzlePipeEnum.UIDragRes[pipeTypeId] then
		self._isDrag = true
		self._curDragPipeTypeId = pipeTypeId
		self._curDragPipeValue = pipeValue

		UISpriteSetMgr.instance:setArmPipeSprite(self._imagedrag, ArmPuzzlePipeEnum.UIDragRes[pipeTypeId], true)
		transformhelper.setLocalRotation(self._godragItemTrs, 0, 0, ArmPuzzleHelper.getRotation(pipeTypeId, pipeValue))
		self:_refreshDragUI()
		self:_onDragIngEvent(position)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_lyrics_wrongs)
	end
end

function ArmPuzzlePipePieceView:_cancelLongPressDown()
	if self._isHasLongPressTask then
		self._isHasLongPressTask = false

		TaskDispatcher.cancelTask(self._onLongPressDown, self)
	end
end

function ArmPuzzlePipePieceView:_onLongPressDown()
	self._isHasLongPressTask = false

	if ArmPuzzlePipeModel.instance:isHasPlace() and not self._isCanDragUIOP then
		self:_checkDragBegin()
	end
end

function ArmPuzzlePipePieceView:_checkDragBegin(pos)
	if not pos then
		::label_16_0::

		local position = GamepadController.instance:getMousePosition()

		self._isCanDragUIOP = false
		self._fromX = nil
		self._fromY = nil

		local x, y = self:_getPipesXY(position)
		local tArmPuzzlePipeModel = ArmPuzzlePipeModel.instance

		if x and y and tArmPuzzlePipeModel:isPlaceByXY(x, y) then
			local mo = tArmPuzzlePipeModel:getData(x, y)

			if mo and ArmPuzzlePipeEnum.UIDragRes[mo.typeId] then
				self._isCanDragUIOP = true

				local motypeId = mo.typeId
				local movalue = mo.value

				self._fromX = x
				self._fromY = y

				mo:setParamStr(tArmPuzzlePipeModel:getPlaceStrByXY(x, y))
				self:_onDragBeginEvent(position, motypeId, movalue)
				ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, x, y)
				ArmPuzzlePipeModel.instance:setPlaceSelectXY(x, y)
				self:_refreshPlacePipeItem(x, y)
				AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_mark_finish)
			end
		end
	end
end

function ArmPuzzlePipePieceView:_onDragIngEvent(position)
	if self._isDrag then
		local tempPos = recthelper.screenPosToAnchorPos(position, self._gomapTrs)

		transformhelper.setLocalPosXY(self._godragItemTrs, tempPos.x, tempPos.y)

		local x, y = self:_getPipesXY(position)
		local tArmPuzzlePipeModel = ArmPuzzlePipeModel.instance
		local oldX, oldY = tArmPuzzlePipeModel:getPlaceSelectXY()

		if x and y and tArmPuzzlePipeModel:isPlaceByXY(x, y) then
			if not tArmPuzzlePipeModel:isPlaceSelectXY(x, y) then
				tArmPuzzlePipeModel:setPlaceSelectXY(x, y)
				self:_refreshPlacePipeItem(oldX, oldY)
				self:_refreshPlacePipeItem(x, y)
			end
		else
			tArmPuzzlePipeModel:setPlaceSelectXY(nil, nil)
			self:_refreshPlacePipeItem(oldX, oldY)
		end
	end
end

function ArmPuzzlePipePieceView:_onDragEndEvent(position, fromX, fromY)
	if self._isDrag then
		self._isDrag = false

		local tArmPuzzlePipeModel = ArmPuzzlePipeModel.instance
		local oldX, oldY = tArmPuzzlePipeModel:getPlaceSelectXY()

		tArmPuzzlePipeModel:setPlaceSelectXY(nil, nil)

		local x, y = self:_getPipesXY(position)
		local formMO

		if x and y and tArmPuzzlePipeModel:isPlaceByXY(x, y) then
			local mo = tArmPuzzlePipeModel:getData(x, y)

			if mo then
				if ArmPuzzlePipeEnum.UIDragRes[mo.typeId] and fromX and fromY and tArmPuzzlePipeModel:isPlaceByXY(fromX, fromY) then
					formMO = tArmPuzzlePipeModel:getData(fromX, fromY)
					formMO.typeId = mo.typeId
					formMO.value = mo.value
				end

				mo:setParamStr(tArmPuzzlePipeModel:getPlaceStrByXY(x, y))

				mo.typeId = self._curDragPipeTypeId
				mo.value = self._curDragPipeValue

				ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, x, y)

				if formMO and fromX and fromY then
					ArmPuzzlePipeController.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, fromX, fromY)
				end
			end
		end

		self:_refreshUI()

		if oldX ~= x or oldY ~= y then
			self:_refreshPlacePipeItem(oldX, oldY)
		end
	end
end

function ArmPuzzlePipePieceView:_refreshDragUI()
	gohelper.setActive(self._godragItem, self._isDrag)
end

function ArmPuzzlePipePieceView:_refreshUI()
	local isHasPlace = ArmPuzzlePipeModel.instance:isHasPlace()

	gohelper.setActive(self._gorightPiece, isHasPlace)
	gohelper.setActive(self._goPiecePanel, isHasPlace)
	self:_refreshDragUI()

	if isHasPlace then
		for _, pieceItem in ipairs(self._pieceItemList) do
			pieceItem:refreshUI()
		end
	end
end

function ArmPuzzlePipePieceView:_getPipesXY(position)
	if self.viewContainer then
		return self.viewContainer:getPipesXYByPostion(position)
	end
end

function ArmPuzzlePipePieceView:_refreshPlacePipeItem(x, y)
	if x and y and ArmPuzzlePipeModel.instance:isPlaceByXY(x, y) then
		local pipes = self.viewContainer:getPipes()

		pipes:initItem(x, y)
	end
end

function ArmPuzzlePipePieceView:onClose()
	return
end

function ArmPuzzlePipePieceView:onDestroyView()
	self:_cancelLongPressDown()
end

return ArmPuzzlePipePieceView
