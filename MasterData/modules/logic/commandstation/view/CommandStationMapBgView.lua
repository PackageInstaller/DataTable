-- chunkname: @modules/logic/commandstation/view/CommandStationMapBgView.lua

module("modules.logic.commandstation.view.CommandStationMapBgView", package.seeall)

local CommandStationMapBgView = class("CommandStationMapBgView", BaseView)

function CommandStationMapBgView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#go_bg/#simage_FullBG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationMapBgView:_editableInitView()
	self._tempVector = Vector2()
	self._dragDeltaPos = Vector2()

	self:_initDrag()
end

function CommandStationMapBgView:_initDrag()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gobg)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function CommandStationMapBgView:_onDragBegin(param, pointerEventData)
	self._dragBeginPos = pointerEventData.position
	self._bgBeginPos = self._gobg.transform.localPosition
end

function CommandStationMapBgView:_onDragEnd(param, pointerEventData)
	self._dragBeginPos = nil
	self._bgBeginPos = nil
end

function CommandStationMapBgView:_onDrag(param, pointerEventData)
	if not self._dragBeginPos then
		return
	end

	local deltaPos = pointerEventData.position - self._dragBeginPos

	self:drag(deltaPos)
end

function CommandStationMapBgView:drag(deltaPos)
	if not self._bgBeginPos then
		return
	end

	self._dragDeltaPos.x = deltaPos.x
	self._dragDeltaPos.y = deltaPos.y

	local targetPos = self:vectorAdd(self._bgBeginPos, self._dragDeltaPos)

	self:setBgPosSafety(targetPos)
end

function CommandStationMapBgView:vectorAdd(v1, v2)
	local tempVector = self._tempVector

	tempVector.x = v1.x + v2.x
	tempVector.y = v1.y + v2.y

	return tempVector
end

function CommandStationMapBgView:setBgPosSafety(targetPos, tween)
	if targetPos.x < self._mapMinX then
		targetPos.x = self._mapMinX
	elseif targetPos.x > self._mapMaxX then
		targetPos.x = self._mapMaxX
	end

	if targetPos.y < self._mapMinY then
		targetPos.y = self._mapMinY
	elseif targetPos.y > self._mapMaxY then
		targetPos.y = self._mapMaxY
	end

	self._targetPos = targetPos

	recthelper.setAnchor(self._gobg.transform, targetPos.x, targetPos.y)
end

function CommandStationMapBgView:onOpen()
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.SelectTimePoint, self._onSelectTimePoint, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenResize, self)
	self:_showTimeId(CommandStationMapModel.instance:getTimeId())
end

function CommandStationMapBgView:_onScreenResize()
	if self._targetPos then
		self:setBgPosSafety(self._targetPos)
	end
end

function CommandStationMapBgView:_onSelectTimePoint(timeId)
	self:_showTimeId(timeId)
end

function CommandStationMapBgView:_showTimeId(timeId)
	if not timeId then
		return
	end

	if self._timeId == timeId then
		return
	end

	self._timeId = timeId

	CommandStationMapModel.instance:setTimeId(timeId)

	local timeGroupConfig = CommandStationConfig.instance:getTimeGroupByTimeId(timeId)

	self._simageFullBG:LoadImage("singlebg/commandstation/map/commandstation_map2.png", self._loadedFullBGComplete, self)
end

function CommandStationMapBgView:_loadedFullBGComplete()
	self:_initSceneBoundary()
	self:setBgPosSafety(Vector2())
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MapLoadFinish)
end

function CommandStationMapBgView:_initSceneBoundary()
	local screenWidth, screenHeight = self:_getScreenSize()

	self._bgWidth = recthelper.getWidth(self._simageFullBG.transform)
	self._bgHeight = recthelper.getHeight(self._simageFullBG.transform)

	local deltaWidth = self._bgWidth - screenWidth

	deltaWidth = math.max(0, deltaWidth / 2)

	local deltaHeight = self._bgHeight - screenHeight

	deltaHeight = math.max(0, deltaHeight / 2)
	self._mapMinX = -deltaWidth
	self._mapMaxX = deltaWidth
	self._mapMinY = -deltaHeight
	self._mapMaxY = deltaHeight
end

function CommandStationMapBgView:_getScreenSize()
	return recthelper.getWidth(ViewMgr.instance:getUIRoot().transform), recthelper.getHeight(ViewMgr.instance:getUIRoot().transform)
end

function CommandStationMapBgView:onClose()
	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragListener()
		self._drag:RemoveDragEndListener()

		self._drag = nil
	end
end

return CommandStationMapBgView
