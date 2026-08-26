-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/repairgame/VersionActivity1_8FactoryRepairPieceView.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairPieceView", package.seeall)

local VersionActivity1_8FactoryRepairPieceView = class("VersionActivity1_8FactoryRepairPieceView", BaseView)
local MAX_PIECE_NUM = 3

function VersionActivity1_8FactoryRepairPieceView:onInitView()
	self._viewGoTrans = self.viewGO.transform
	self._gomap = gohelper.findChild(self.viewGO, "#go_map")
	self._btnMapDrag = SLFramework.UGUI.UIDragListener.Get(self._gomap)
	self._gorightPiece = gohelper.findChild(self.viewGO, "#go_rightPiece")
	self._goPiecePanel = gohelper.findChild(self.viewGO, "#go_PiecePanel")
	self._gopieceItem = gohelper.findChild(self.viewGO, "#go_rightPiece/#go_pieceItem")
	self._godragItem = gohelper.findChild(self.viewGO, "#go_dragItem")
	self._godragItemTrs = self._godragItem.transform
	self._dragItemAnimator = self._godragItem:GetComponent(ArmPuzzlePipeEnum.ComponentType.Animator)
	self._imagedrag = gohelper.findChildImage(self.viewGO, "#go_dragItem/#image_drag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8FactoryRepairPieceView:addEvents()
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragBegin, self._onDragBeginEvent, self)
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragIng, self._onDragIngEvent, self)
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragEnd, self._onDragEndEvent, self)
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceItemRefresh, self._refreshUI, self)
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, self._refreshUI, self)

	if self._btnMapDrag then
		self._btnMapDrag:AddDragBeginListener(self._onDragBegin, self)
		self._btnMapDrag:AddDragListener(self._onDragIng, self)
		self._btnMapDrag:AddDragEndListener(self._onDragEnd, self)
	end
end

function VersionActivity1_8FactoryRepairPieceView:removeEvents()
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragBegin, self._onDragBeginEvent, self)
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragIng, self._onDragIngEvent, self)
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.UIPipeDragEnd, self._onDragEndEvent, self)
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PlaceItemRefresh, self._refreshUI, self)
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, self._refreshUI, self)

	if self._btnMapDrag then
		self._btnMapDrag:RemoveDragBeginListener()
		self._btnMapDrag:RemoveDragListener()
		self._btnMapDrag:RemoveDragEndListener()
	end
end

function VersionActivity1_8FactoryRepairPieceView:_onGameClear()
	self._isDrag = false

	self:_refreshDragUI()
end

function VersionActivity1_8FactoryRepairPieceView:_onDragBeginEvent(position, pipeTypeId, pipeValue)
	self._isDrag = false

	local uiDragRes = ArmPuzzlePipeEnum.UIDragRes[pipeTypeId]

	if uiDragRes then
		self._isDrag = true
		self._curDragPipeTypeId = pipeTypeId
		self._curDragPipeValue = pipeValue

		UISpriteSetMgr.instance:setArmPipeSprite(self._imagedrag, uiDragRes, true)

		local rotation = ArmPuzzleHelper.getRotation(pipeTypeId, pipeValue)

		transformhelper.setLocalRotation(self._godragItemTrs, 0, 0, rotation)
		self:_refreshDragUI()
		self:_onDragIngEvent(position)
		AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_lyrics_wrongs)
	end
end

function VersionActivity1_8FactoryRepairPieceView:_onDragIngEvent(position)
	if not self._isDrag then
		return
	end

	local tempPos = recthelper.screenPosToAnchorPos(position, self._viewGoTrans)

	transformhelper.setLocalPosXY(self._godragItemTrs, tempPos.x, tempPos.y)

	local x, y = self:_getPipesXY(position)
	local act157GameModel = Activity157RepairGameModel.instance
	local oldX, oldY = act157GameModel:getPlaceSelectXY()

	if x and y and act157GameModel:isPlaceByXY(x, y) then
		if not act157GameModel:isPlaceSelectXY(x, y) then
			act157GameModel:setPlaceSelectXY(x, y)
			self:_refreshPlacePipeItem(oldX, oldY)
			self:_refreshPlacePipeItem(x, y)
		end
	else
		act157GameModel:setPlaceSelectXY(nil, nil)
		self:_refreshPlacePipeItem(oldX, oldY)
	end
end

function VersionActivity1_8FactoryRepairPieceView:_onDragEndEvent(position, fromX, fromY)
	if not self._isDrag then
		return
	end

	self._isDrag = false

	local act157GameModel = Activity157RepairGameModel.instance
	local oldX, oldY = act157GameModel:getPlaceSelectXY()

	act157GameModel:setPlaceSelectXY(nil, nil)

	local x, y = self:_getPipesXY(position)
	local formMO

	if x and y and act157GameModel:isPlaceByXY(x, y) then
		local mo = act157GameModel:getData(x, y)

		if mo then
			if ArmPuzzlePipeEnum.UIDragRes[mo.typeId] and fromX and fromY and act157GameModel:isPlaceByXY(fromX, fromY) then
				formMO = act157GameModel:getData(fromX, fromY)
				formMO.typeId = mo.typeId
				formMO.value = mo.value
			end

			mo:setParamStr(act157GameModel:getPlaceStrByXY(x, y))

			mo.typeId = self._curDragPipeTypeId
			mo.value = self._curDragPipeValue

			Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, x, y)

			if formMO and fromX and fromY then
				Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, fromX, fromY)
			end
		end
	end

	self:_refreshUI()

	if oldX ~= x or oldY ~= y then
		self:_refreshPlacePipeItem(oldX, oldY)
	end
end

function VersionActivity1_8FactoryRepairPieceView:_onDragBegin(param, pointerEventData)
	if not self._isCanDragUIOP then
		self:_checkDragBegin(pointerEventData.position)
	end
end

function VersionActivity1_8FactoryRepairPieceView:_checkDragBegin(pos)
	if not pos then
		::label_9_0::

		local position = GamepadController.instance:getMousePosition()

		self._isCanDragUIOP = false
		self._fromX = nil
		self._fromY = nil

		local x, y = self:_getPipesXY(position)
		local act157GameModel = Activity157RepairGameModel.instance

		if x and y and act157GameModel:isPlaceByXY(x, y) then
			local mo = act157GameModel:getData(x, y)

			if mo and ArmPuzzlePipeEnum.UIDragRes[mo.typeId] then
				self._isCanDragUIOP = true

				local motypeId = mo.typeId
				local movalue = mo.value

				self._fromX = x
				self._fromY = y

				mo:setParamStr(act157GameModel:getPlaceStrByXY(x, y))
				self:_onDragBeginEvent(position, motypeId, movalue)
				Activity157Controller.instance:dispatchEvent(ArmPuzzlePipeEvent.PlaceRefreshPipesGrid, x, y)
				Activity157RepairGameModel.instance:setPlaceSelectXY(x, y)
				self:_refreshPlacePipeItem(x, y)
				AudioMgr.instance:trigger(AudioEnum.Va3Armpipe.play_ui_activity_mark_finish)
			end
		end
	end
end

function VersionActivity1_8FactoryRepairPieceView:_onDragIng(param, pointerEventData)
	if not self._isCanDragUIOP then
		return
	end

	self:_onDragIngEvent(pointerEventData.position)
end

function VersionActivity1_8FactoryRepairPieceView:_onDragEnd(param, pointerEventData)
	if self._isCanDragUIOP then
		self._isCanDragUIOP = false

		self:_onDragEndEvent(pointerEventData.position, self._fromX, self._fromY)
	end
end

function VersionActivity1_8FactoryRepairPieceView:_editableInitView()
	self._isDrag = false

	local typeIdList = {
		ArmPuzzlePipeEnum.type.straight,
		ArmPuzzlePipeEnum.type.corner,
		ArmPuzzlePipeEnum.type.t_shape
	}

	self._typeIdList = {}
	self._pieceItemList = self:getUserDataTb_()

	for _, typeId in ipairs(typeIdList) do
		local isTypeIdHasPlace = Activity157RepairGameModel.instance:isHasPlaceByTypeId(typeId)

		if isTypeIdHasPlace then
			table.insert(self._typeIdList, typeId)

			local cloneGo = gohelper.clone(self._gopieceItem, self._gorightPiece, "pieceitem_" .. typeId)
			local pieceItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, VersionActivity1_8FactoryRepairPieceItem, self)

			pieceItem:setTypeId(typeId)
			table.insert(self._pieceItemList, pieceItem)
		end
	end

	gohelper.setActive(self._gopieceItem, false)

	local pieceItemCount = #self._pieceItemList

	for i = 1, MAX_PIECE_NUM do
		local goBg = gohelper.findChild(self.viewGO, "#go_PiecePanel/#image_PanelBG" .. i)

		gohelper.setActive(goBg, i == pieceItemCount)
	end
end

function VersionActivity1_8FactoryRepairPieceView:onUpdateParam()
	return
end

function VersionActivity1_8FactoryRepairPieceView:onOpen()
	self:_refreshUI()
end

function VersionActivity1_8FactoryRepairPieceView:_refreshUI()
	local isHasPlace = Activity157RepairGameModel.instance:isHasPlace()

	gohelper.setActive(self._gorightPiece, isHasPlace)
	gohelper.setActive(self._goPiecePanel, isHasPlace)

	if isHasPlace then
		for _, pieceItem in ipairs(self._pieceItemList) do
			pieceItem:refreshUI()
		end
	end

	self:_refreshDragUI()
end

function VersionActivity1_8FactoryRepairPieceView:_refreshDragUI()
	gohelper.setActive(self._godragItem, self._isDrag)
end

function VersionActivity1_8FactoryRepairPieceView:_refreshPlacePipeItem(x, y)
	if x and y and Activity157RepairGameModel.instance:isPlaceByXY(x, y) then
		local pipes = self.viewContainer:getPipes()

		pipes:initItem(x, y)
	end
end

function VersionActivity1_8FactoryRepairPieceView:_getPipesXY(position)
	if self.viewContainer then
		return self.viewContainer:getPipesXYByPosition(position)
	end
end

function VersionActivity1_8FactoryRepairPieceView:onClose()
	return
end

function VersionActivity1_8FactoryRepairPieceView:onDestroyView()
	return
end

return VersionActivity1_8FactoryRepairPieceView
