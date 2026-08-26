-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotPlayCtrlView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotPlayCtrlView", package.seeall)

local V1a6_CachotPlayCtrlView = class("V1a6_CachotPlayCtrlView", BaseView)

function V1a6_CachotPlayCtrlView:onInitView()
	self._goCtrl = gohelper.findChild(self.viewGO, "#go_control")
	self._icon = gohelper.findChildImage(self.viewGO, "#go_control/bg")
	self._iconCanvasGroup = gohelper.onceAddComponent(self._icon, gohelper.Type_CanvasGroup)
	self._iconTrans = self._icon.transform

	local gointeract = gohelper.findChild(self.viewGO, "#go_interact")

	if gointeract then
		self._gouninteract = gohelper.findChild(gointeract, "uninteract")
		self._gointeract = gohelper.findChild(gointeract, "interactale")
		self._btninteract = gohelper.findChildButton(gointeract, "#btn_interactclick")
	end
end

function V1a6_CachotPlayCtrlView:addEvents()
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goCtrl)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)

	if self._btninteract then
		self._btninteract:AddClickListener(self.onInteract, self)
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.NearEventMoChange, self._onNearEventChange, self)
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.ClickNearEvent, self.onInteract, self)
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.cancelDrag, self)
end

function V1a6_CachotPlayCtrlView:removeEvents()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragEndListener()
	self._drag:RemoveDragListener()

	if self._btninteract then
		self._btninteract:RemoveClickListener()
		V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.NearEventMoChange, self._onNearEventChange, self)
		V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.ClickNearEvent, self.onInteract, self)
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.cancelDrag, self)
end

function V1a6_CachotPlayCtrlView:onOpen()
	self:_onNearEventChange()

	self._iconCanvasGroup.alpha = 0.5

	TaskDispatcher.runRepeat(self._checkInput, self, 0, -1)
end

function V1a6_CachotPlayCtrlView:onClose()
	TaskDispatcher.cancelTask(self._checkInput, self)
	TaskDispatcher.cancelTask(self._delayTriggerEvent, self)
	UIBlockMgr.instance:endBlock("BeginTriggerEvent")

	V1a6_CachotRoomModel.instance.isLockPlayerMove = false
end

function V1a6_CachotPlayCtrlView:_onDragBegin()
	self._beginDrag = true
	self._iconCanvasGroup.alpha = 1
end

function V1a6_CachotPlayCtrlView:_onDragEnd()
	self:cancelDrag()

	self._beginDrag = false
end

function V1a6_CachotPlayCtrlView:_onDrag(param, pointerEventData)
	if not self._beginDrag then
		return
	end

	local pos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._goCtrl.transform)
	local val = Mathf.Clamp(pos.x, -180, 180)

	recthelper.setAnchorX(self._iconTrans, val)

	if val <= 10 and val >= -10 then
		self._dragValue = nil

		return
	end

	self._dragValue = val > 0 and 1 or -1
end

function V1a6_CachotPlayCtrlView:_checkInput()
	local value = 0

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		value = -1
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.RightArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		value = 1
	end

	if value ~= 0 and not self._beginDrag then
		self:onPlayerMove(value)
	elseif self._beginDrag and self._dragValue then
		self:onPlayerMove(self._dragValue)
	else
		V1a6_CachotRoomModel.instance:setIsMoving(false)
	end

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Return) then
		self:onInteract()
	end
end

function V1a6_CachotPlayCtrlView:onPlayerMove(val)
	if not self:canMove() then
		V1a6_CachotRoomModel.instance:setIsMoving(false)

		return
	end

	V1a6_CachotRoomModel.instance:setIsMoving(true)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerMove, val)
end

function V1a6_CachotPlayCtrlView:_onNearEventChange()
	if not self._gouninteract then
		return
	end

	local nowNearMo = V1a6_CachotRoomModel.instance:getNearEventMo()

	gohelper.setActive(self._gouninteract, not nowNearMo)
	gohelper.setActive(self._gointeract, nowNearMo)

	if nowNearMo then
		V1a6_CachotCollectionController.instance:dispatchEvent(V1a6_CachotEvent.GuideNearEvent)
	end
end

function V1a6_CachotPlayCtrlView:onInteract()
	local nowNearEventMo = V1a6_CachotRoomModel.instance:getNearEventMo()

	if not nowNearEventMo then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	UIBlockMgr.instance:startBlock("BeginTriggerEvent")
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.BeginTriggerEvent, nowNearEventMo)

	V1a6_CachotRoomModel.instance.isLockPlayerMove = true

	TaskDispatcher.runDelay(self._delayTriggerEvent, self, 1.067)
end

function V1a6_CachotPlayCtrlView:_delayTriggerEvent()
	local nowNearEventMo = V1a6_CachotRoomModel.instance:getNearEventMo()

	if not nowNearEventMo then
		return
	end

	UIBlockMgr.instance:endBlock("BeginTriggerEvent")

	V1a6_CachotRoomModel.instance.isLockPlayerMove = false

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.TriggerEvent)

	local battleEventMo = V1a6_CachotRoomModel.instance:getNowBattleEventMo()

	if battleEventMo then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, battleEventMo)
	else
		RogueRpc.instance:sendRogueEventStartRequest(V1a6_CachotEnum.ActivityId, nowNearEventMo.eventId)
	end
end

function V1a6_CachotPlayCtrlView:canMove()
	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	local count = PopupController.instance:getPopupCount()

	if count == 1 and ViewMgr.instance:isOpen(ViewName.GuideView) then
		return true
	end

	if count > 0 then
		return false
	end

	return ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) or ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotMainView)
end

function V1a6_CachotPlayCtrlView:cancelDrag()
	if not self._beginDrag then
		return
	end

	self._beginDrag = nil
	self._dragValue = nil
	self._iconCanvasGroup.alpha = 0.5

	recthelper.setAnchorX(self._iconTrans, 0)
end

return V1a6_CachotPlayCtrlView
