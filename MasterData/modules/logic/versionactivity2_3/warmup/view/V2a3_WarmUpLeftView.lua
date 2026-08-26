-- chunkname: @modules/logic/versionactivity2_3/warmup/view/V2a3_WarmUpLeftView.lua

module("modules.logic.versionactivity2_3.warmup.view.V2a3_WarmUpLeftView", package.seeall)

local V2a3_WarmUpLeftView = class("V2a3_WarmUpLeftView", BaseView)

function V2a3_WarmUpLeftView:onInitView()
	self._Middle = gohelper.findChild(self.viewGO, "Middle")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a3_WarmUpLeftView:addEvents()
	return
end

function V2a3_WarmUpLeftView:removeEvents()
	return
end

local kFirstLocked = -1
local kFirstUnlocked = 0
local kHasDragged = 1
local csAnimatorPlayer = SLFramework.AnimatorPlayer
local csTweenHelper = ZProj.TweenHelper
local csUIMesh = UIMesh
local States = {
	DraggedDone = 1
}

function V2a3_WarmUpLeftView:_editableInitView()
	self._drag = UIDragListenerHelper.New()
	self._draggedState = kFirstLocked
	self._needWaitCount = 0
	self._iconGo = gohelper.findChild(self._Middle, "#icon")

	local simageiconGO = gohelper.findChild(self._iconGo, "#simage_icon")

	self._simageicon = simageiconGO:GetComponent(typeof(csUIMesh))
	self._centerGo = gohelper.findChild(self._Middle, "#go_center")
	self._centerTrans = self._centerGo.transform
	self._dragGo = gohelper.findChild(self._centerGo, "#go_drag")
	self._firstGo = gohelper.findChild(self._Middle, "first")
	self._dec2Go = gohelper.findChild(self._firstGo, "dec2")
	self._rudderTran = self._dec2Go.transform
	self._firstAnimPlayer = csAnimatorPlayer.Get(self._firstGo)
	self._firstAnimator = self._firstAnimPlayer.animator
	self._iconAnimPlayer = csAnimatorPlayer.Get(self._iconGo)
	self._iconAnimator = self._iconAnimPlayer.animator
	self._firstAnimator.enabled = false
	self._dragEnabled = false

	self:_setActive_drag(true)
end

function V2a3_WarmUpLeftView:onDestroyView()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweener")
	GameUtil.onDestroyViewMember(self, "_drag")
end

function V2a3_WarmUpLeftView:onDataUpdateFirst()
	local isDone = self:_checkIsDone()

	if isDone then
		self._draggedState = kFirstUnlocked or kFirstLocked
	end

	self._drag:create(self._dragGo)
	self._drag:registerCallback(self._drag.EventBegin, self._onDragBegin, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDrag, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onDragEnd, self)

	self._centerScreenPosV2 = recthelper.uiPosToScreenPos(self._centerTrans)

	self:_setActive_icon(isDone)
	self:_setActive_rudder(not isDone)
end

function V2a3_WarmUpLeftView:onDataUpdate()
	self._hasDraggedAngle = 0

	self:_refresh()
end

function V2a3_WarmUpLeftView:onSwitchEpisode()
	local isDone = self:_checkIsDone()

	if self._draggedState == kFirstUnlocked and not isDone then
		self._draggedState = kFirstLocked - 1
	elseif self._draggedState < kFirstLocked and isDone then
		self._draggedState = kFirstUnlocked
	end

	self._hasDraggedAngle = 0

	self:_refresh()
end

function V2a3_WarmUpLeftView:_episodeId()
	return self.viewContainer:getCurSelectedEpisode()
end

function V2a3_WarmUpLeftView:_getImgResUrl(episodeId)
	local i = self:_episode2Index(episodeId)

	return self.viewContainer:getImgResUrl(i)
end

function V2a3_WarmUpLeftView:_episode2Index(episodeId)
	return self.viewContainer:episode2Index(episodeId or self:_episodeId())
end

function V2a3_WarmUpLeftView:_checkIsDone(episodeId)
	return self.viewContainer:checkIsDone(episodeId or self:_episodeId())
end

function V2a3_WarmUpLeftView:_saveStateDone(isDone, episodeId)
	self.viewContainer:saveStateDone(episodeId or self:_episodeId(), isDone)
end

function V2a3_WarmUpLeftView:_saveState(value, episodeId)
	assert(value ~= 1999, "please call _saveStateDone instead")
	self.viewContainer:saveState(episodeId or self:_episodeId(), value)
end

function V2a3_WarmUpLeftView:_getState(defaultValue, episodeId)
	return self.viewContainer:getState(episodeId or self:_episodeId(), defaultValue)
end

function V2a3_WarmUpLeftView:_setActive_drag(isActive)
	gohelper.setActive(self._dragGo, isActive)
end

function V2a3_WarmUpLeftView:_setActive_guide(isActive)
	return
end

function V2a3_WarmUpLeftView:onOpen()
	return
end

function V2a3_WarmUpLeftView:onClose()
	self:_clearFrameTimer()
	GameUtil.onDestroyViewMember_TweenId(self, "_tweener")
end

function V2a3_WarmUpLeftView:_refresh()
	local episodeId = self:_episodeId()
	local isDone = self:_checkIsDone()

	self:_loadImage(episodeId)
	self:_setActive_icon(isDone)
	self:_setActive_rudder(not isDone)
	self:_setActive_guide(not isDone and self._draggedState <= kFirstLocked)

	if isDone then
		self._dragEnabled = false
	else
		local state = self:_getState()

		if state == 0 then
			self._dragEnabled = true

			self:_playAnim_Rudder_idle()
		elseif States.DraggedDone == state then
			self._dragEnabled = false

			self:_playAnim_Rudder_click()
		else
			logError("[V2a3_WarmUpLeftView] invalid state:" .. state)
		end
	end
end

function V2a3_WarmUpLeftView:_getImgRes(episodeId)
	local resUrl = self:_getImgResUrl(episodeId)

	return self.viewContainer:getRes(resUrl)
end

function V2a3_WarmUpLeftView:_loadImage(episodeId)
	self._simageicon.texture = self:_getImgRes(episodeId)

	self._simageicon:SetMaterialDirty()
end

function V2a3_WarmUpLeftView:_setActive_icon(isActive)
	gohelper.setActive(self._iconGo, isActive)
end

function V2a3_WarmUpLeftView:_setActive_rudder(isActive)
	gohelper.setActive(self._firstGo, isActive)
end

function V2a3_WarmUpLeftView:_canDrag()
	return self._dragEnabled
end

function V2a3_WarmUpLeftView:_onDragBegin()
	self:_clearFrameTimer()

	if not self:_canDrag() then
		return
	end

	self:_setActive_guide(false)

	self._draggedState = kHasDragged
end

local kPassDegrees = 240

function V2a3_WarmUpLeftView:_onDrag(dragObj)
	if not self:_canDrag() then
		return
	end

	self._hasDraggedAngle = self._hasDraggedAngle or 0

	local q, angleInDeg, isClockWise = dragObj:quaternionToMouse(self._rudderTran, self._centerScreenPosV2)

	if isClockWise then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_rudder_turn_loop_20234004)
		self:_createFTimer()

		self._rudderTran.rotation = self._rudderTran.rotation * q
		self._hasDraggedAngle = self._hasDraggedAngle + angleInDeg
	end

	if self._hasDraggedAngle >= kPassDegrees then
		self._dragEnabled = false

		self:_saveState(States.DraggedDone)
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_rudder_reset_20234006)
		self:_playAnim_Rudder_click()
	end
end

function V2a3_WarmUpLeftView:_onDragEnd()
	self:_clearFrameTimer()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)

	if not self:_canDrag() then
		return
	end
end

function V2a3_WarmUpLeftView:_resetRudder(duration, cb, cbObj)
	duration = duration or 0.7

	GameUtil.onDestroyViewMember_TweenId(self, "_tweener")

	self._tweener = csTweenHelper.DOLocalRotate(self._rudderTran, 0, 0, 0, duration, cb, cbObj, nil, EaseType.OutCirc)
end

function V2a3_WarmUpLeftView:_playAnim_Rudder(name, cb, cbObj)
	self._firstAnimator.enabled = true

	self._firstAnimPlayer:Play(name, cb, cbObj)
end

function V2a3_WarmUpLeftView:_playAnim_Icon(name, cb, cbObj)
	self:_setActive_icon(true)

	self._iconAnimator.enabled = true

	self._iconAnimPlayer:Play(name, cb, cbObj)
end

function V2a3_WarmUpLeftView:_playAnim_Rudder_idle()
	self._firstAnimator.enabled = true

	self._firstAnimator:Play(UIAnimationName.Idle, 0, 1)
	self._firstAnimator:Update(0)

	self._firstAnimator.enabled = false
end

function V2a3_WarmUpLeftView:_playAnim_Rudder_click()
	self._playAnim_Rudder(self, UIAnimationName.Click, self._onAfterClickAnim, self)
end

function V2a3_WarmUpLeftView:_onAfterClickAnim()
	self._needWaitCount = 2

	self._playAnim_Rudder(self, UIAnimationName.Close, self._onFinishAnim, self)
	self._playAnim_Icon(self, UIAnimationName.In, self._onFinishAnim, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_taskinterface_2000011)
end

function V2a3_WarmUpLeftView:_onFinishAnim()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount > 0 then
		return
	end

	self:_saveStateDone(true)
	self.viewContainer:openDesc()
end

local kMaxCheckDragCount = 3
local kEp = 1e-06

function V2a3_WarmUpLeftView:_checkIsDragging()
	if self._checkDraggingCount == kMaxCheckDragCount then
		self:_clearFrameTimer()
	elseif self._checkDraggingCount < kMaxCheckDragCount then
		local dt = math.abs(self._lastDraggedAngle - self._hasDraggedAngle)

		if dt < kEp then
			self._checkDraggingCount = self._checkDraggingCount + 1 or 0
		end

		self._lastDraggedAngle = self._hasDraggedAngle
	end
end

function V2a3_WarmUpLeftView:_createFTimer()
	if not self._fTimer then
		self._fTimer = FrameTimerController.instance:register(self._checkIsDragging, self, 3, 9)

		self._fTimer:Start()
	end
end

function V2a3_WarmUpLeftView:_clearFrameTimer()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)
	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	self._checkDraggingCount = 0
	self._lastDraggedAngle = self._hasDraggedAngle
end

return V2a3_WarmUpLeftView
