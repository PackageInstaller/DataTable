-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballGameBallItem.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballGameBallItem", package.seeall)

local PinballGameBallItem = class("PinballGameBallItem", LuaCompBase)

function PinballGameBallItem:init(go)
	self.go = go
	self._root = gohelper.findChild(go, "drag_root")
	self._imageicon = gohelper.findChildImage(go, "drag_root/#image_icon")
	self.trans = self._root.transform
	self._click = gohelper.findChildClickWithDefaultAudio(self._root, "")
	self._outParent = go.transform.parent.parent
end

function PinballGameBallItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
	CommonDragHelper.instance:registerDragObj(self._root, self._onBeginDrag, nil, self._onEndDrag, self._check, self)
end

function PinballGameBallItem:removeEventListeners()
	self._click:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(self._root)
end

function PinballGameBallItem:_onBeginDrag()
	self.trans:SetParent(self._outParent)
	CommonDragHelper.instance:refreshParent(self._root)

	self._isDrag = true
end

function PinballGameBallItem:_onEndDrag(_, pointerEventData)
	self.trans:SetParent(self.go.transform)
	CommonDragHelper.instance:refreshParent(self._root)

	self._isDrag = false

	PinballController.instance:dispatchEvent(PinballEvent.DragMarblesEnd, self._index)
end

function PinballGameBallItem:_onClickThis()
	if self._isDrag then
		return
	end

	if self._curResType == 0 then
		return
	end

	PinballController.instance:dispatchEvent(PinballEvent.ClickMarbles, self._index)
end

function PinballGameBallItem:_check()
	return self._curResType == 0 or not self._canDrag or PinballHelper.isBanOper()
end

function PinballGameBallItem:setInfo(curResType, index, canDrag)
	self._index = index
	self._curResType = curResType
	self._canDrag = canDrag

	if curResType > 0 then
		local co = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][curResType]

		UISpriteSetMgr.instance:setAct178Sprite(self._imageicon, co.icon, true)
		ZProj.UGUIHelper.SetColorAlpha(self._imageicon, canDrag and 1 or 0.5)
	end

	gohelper.setActive(self._root, curResType > 0)
	ZProj.TweenHelper.KillByObj(self.trans)
	transformhelper.setLocalPos(self.trans, 0, 0, 0)
end

function PinballGameBallItem:getIndex()
	return self._index
end

function PinballGameBallItem:isMouseOver()
	if self._curResType == 0 then
		return false
	end

	if not self._canDrag then
		return false
	end

	return gohelper.isMouseOverGo(self.go)
end

function PinballGameBallItem:getRootPos()
	return Vector3(transformhelper.getPos(self.go.transform))
end

function PinballGameBallItem:moveBack()
	UIBlockMgr.instance:startBlock("PinballGameBallItem_moveBack")
	ZProj.TweenHelper.DOLocalMove(self.trans, 0, 0, 0, 0.2, self.onMoveBackEnd, self)
end

function PinballGameBallItem:onMoveBackEnd()
	UIBlockMgr.instance:endBlock("PinballGameBallItem_moveBack")
end

function PinballGameBallItem:moveTo(pos, callback, callObj)
	ZProj.TweenHelper.DOMove(self.trans, pos.x, pos.y, pos.z, 0.2, callback, callObj)
end

function PinballGameBallItem:onDestroy()
	ZProj.TweenHelper.KillByObj(self.trans)
	UIBlockMgr.instance:endBlock("PinballGameBallItem_moveBack")
end

return PinballGameBallItem
