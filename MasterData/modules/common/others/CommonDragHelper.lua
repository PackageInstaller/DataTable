-- chunkname: @modules/common/others/CommonDragHelper.lua

module("modules.common.others.CommonDragHelper", package.seeall)

local CommonDragHelper = class("CommonDragHelper")

function CommonDragHelper:ctor()
	self._list = {}
	self._nowDragData = nil
	self.enabled = true
end

function CommonDragHelper:registerDragObj(go, beginCallBack, dragCallBack, endCallBack, checkCallBack, callObj, params, isNoMove, moveOffset, dragScale, dragDefaultScale)
	if not go or gohelper.isNil(go) then
		logError("go can not be nil")

		return
	end

	if self:getDragData(go) then
		logWarn("repeat register")
		self:unregisterDragObj(go)
	end

	local data = {}
	local drag = SLFramework.UGUI.UIDragListener.Get(go)

	drag:AddDragBeginListener(self._onBeginDrag, self, data)
	drag:AddDragListener(self._onDrag, self, data)
	drag:AddDragEndListener(self._onEndDrag, self, data)

	data.go = go
	data.transform = go.transform
	data.parent = go.transform.parent
	data.beginCallBack = beginCallBack
	data.dragCallBack = dragCallBack
	data.endCallBack = endCallBack
	data.checkCallBack = checkCallBack
	data.callObj = callObj
	data.drag = drag
	data.params = params
	data.enabled = true
	data.isNoMove = isNoMove
	data.moveOffset = moveOffset
	data.dragScale = dragScale or 1
	data.dragDefaultScale = dragDefaultScale or 1

	table.insert(self._list, data)
end

function CommonDragHelper:setCallBack(go, beginCallBack, dragCallBack, endCallBack, checkCallBack, callObj, params)
	local data = self:getDragData(go)

	if not data then
		return
	end

	data.beginCallBack = beginCallBack
	data.dragCallBack = dragCallBack
	data.endCallBack = endCallBack
	data.checkCallBack = checkCallBack
	data.callObj = callObj
	data.params = params
end

function CommonDragHelper:refreshParent(go)
	local data = self:getDragData(go)

	if not data then
		return
	end

	data.parent = data.transform.parent

	ZProj.TweenHelper.KillByObj(data.transform)
end

function CommonDragHelper:_onBeginDrag(data, pointerEventData)
	if not data.enabled or not self.enabled then
		return
	end

	if data.checkCallBack and data.checkCallBack(data.callObj, data.params) then
		return
	end

	if self._nowDragData then
		return
	end

	self._nowDragData = data

	if not data.isNoMove then
		self:_tweenToPos(data, pointerEventData.position)
		gohelper.setAsLastSibling(data.go)
	end

	if data.dragScale ~= data.dragDefaultScale then
		ZProj.TweenHelper.KillByObj(data.transform)
		ZProj.TweenHelper.DOScale(data.transform, data.dragScale, data.dragScale, data.dragScale, 0.16)
	end

	if data.beginCallBack then
		data.beginCallBack(data.callObj, data.params, pointerEventData)
	end
end

function CommonDragHelper:_tweenToPos(data, position)
	if data.moveOffset then
		position = position + data.moveOffset
	end

	local anchorPos = recthelper.screenPosToAnchorPos(position, data.parent)
	local trans = data.transform
	local curAnchorX, curAnchorY = recthelper.getAnchor(trans)

	if math.abs(curAnchorX - anchorPos.x) > 10 or math.abs(curAnchorY - anchorPos.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(trans, anchorPos.x, anchorPos.y, 0.2)
	else
		recthelper.setAnchor(trans, anchorPos.x, anchorPos.y)
	end
end

function CommonDragHelper:_onDrag(data, pointerEventData)
	if self._nowDragData ~= data then
		return
	end

	if not data.isNoMove then
		self:_tweenToPos(data, pointerEventData.position)
	end

	if data.dragCallBack then
		data.dragCallBack(data.callObj, data.params, pointerEventData)
	end
end

function CommonDragHelper:_onEndDrag(data, pointerEventData)
	if self._nowDragData ~= data then
		return
	end

	if data.dragScale ~= data.dragDefaultScale then
		ZProj.TweenHelper.DOScale(data.transform, data.dragDefaultScale, data.dragDefaultScale, data.dragDefaultScale, 0.16)
	end

	if data.endCallBack then
		data.endCallBack(data.callObj, data.params, pointerEventData)
	end

	self._nowDragData = nil
end

function CommonDragHelper:setDragEnabled(go, isEnabled)
	local data = self:getDragData(go)

	if not data then
		return
	end

	data.enabled = isEnabled

	if not isEnabled and self._nowDragData == data then
		self:stopDrag(go)
	end
end

function CommonDragHelper:setGlobalEnabled(isEnabled)
	self.enabled = isEnabled

	if not isEnabled and self._nowDragData then
		self:stopDrag(self._nowDragData.go)
	end
end

function CommonDragHelper:getDragData(go)
	for index, data in ipairs(self._list) do
		if data.go == go then
			return data, index
		end
	end
end

function CommonDragHelper:stopDrag(go, isEndCall)
	if self._nowDragData and self._nowDragData.go == go then
		if isEndCall then
			self._nowDragData.endCallBack(self._nowDragData.callObj, self._nowDragData.params, GamepadController.instance:getMousePosition())
		end

		self._nowDragData = nil
	end
end

function CommonDragHelper:unregisterDragObj(go)
	local data, index = self:getDragData(go)

	if not data then
		return
	end

	local drag = data.drag

	if not gohelper.isNil(drag) then
		drag:RemoveDragListener()
		drag:RemoveDragBeginListener()
		drag:RemoveDragEndListener()
	end

	table.remove(self._list, index)

	if self._nowDragData == data then
		self._nowDragData = nil
	end
end

function CommonDragHelper:clear()
	for _, data in ipairs(self._list) do
		local drag = data.drag

		if not gohelper.isNil(drag) then
			drag:RemoveDragListener()
			drag:RemoveDragBeginListener()
			drag:RemoveDragEndListener()
		end
	end

	self._list = {}
	self._nowDragData = nil
end

CommonDragHelper.instance = CommonDragHelper.New()

return CommonDragHelper
