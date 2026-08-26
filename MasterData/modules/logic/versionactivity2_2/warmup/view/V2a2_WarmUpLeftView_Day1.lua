-- chunkname: @modules/logic/versionactivity2_2/warmup/view/V2a2_WarmUpLeftView_Day1.lua

module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day1", package.seeall)

local Base = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local V2a2_WarmUpLeftView_Day1 = class("V2a2_WarmUpLeftView_Day1", Base)

function V2a2_WarmUpLeftView_Day1:onInitView()
	self._btn1 = gohelper.findChildButtonWithAudio(self.viewGO, "before/#btn_1")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "before/#simage_icon1")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "after/#simage_icon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_WarmUpLeftView_Day1:addEvents()
	self._btn1:AddClickListener(self._btn1OnClick, self)
end

function V2a2_WarmUpLeftView_Day1:removeEvents()
	self._btn1:RemoveClickListener()
end

local States = {
	Clicked = 1
}

function V2a2_WarmUpLeftView_Day1:_btn1OnClick()
	self:_setActive_guide(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220215)
end

function V2a2_WarmUpLeftView_Day1:ctor(ctorParam)
	Base.ctor(self, ctorParam)

	self._dragEnabled = false
	self._needWaitCount = 0
	self._drag = UIDragListenerHelper.New()
end

function V2a2_WarmUpLeftView_Day1:_editableInitView()
	Base._editableInitView(self)

	self._guideGo = gohelper.findChild(self.viewGO, "guide_day1")
	self._startGo = self._btn1.gameObject
	self._startTrans = self._startGo.transform
	self._startX, self._startY = recthelper.getAnchor(self._startTrans)
	self._endGo = gohelper.findChild(self.viewGO, "before/img_xieqian1")
	self._endTrans = gohelper.findChild(self.viewGO, "before/#go_dragEnd").transform
	self._towardDir = Vector3.Normalize(self._endTrans.position - self._startTrans.position)

	self._drag:create(self._startGo)
	self._drag:registerCallback(self._drag.EventBegin, self._onBeginDrag, self)
	self._drag:registerCallback(self._drag.EventDragging, self._onDrag, self)
	self._drag:registerCallback(self._drag.EventEnd, self._onEndDrag, self)
end

function V2a2_WarmUpLeftView_Day1:_checkCanDrag()
	return not self:_canDrag()
end

function V2a2_WarmUpLeftView_Day1:_canDrag()
	return self._dragEnabled
end

function V2a2_WarmUpLeftView_Day1:_onBeginDrag()
	if not self:_canDrag() then
		return
	end

	Base._onDragBegin(self)
	self:playAnimRaw_before_click(0, 0)
end

function V2a2_WarmUpLeftView_Day1:_onDrag(dragObj)
	if not self:_canDrag() then
		return
	end

	dragObj:tweenToMousePosWithConstrainedDirV2(self._towardDir, self._endTrans)

	local screenPosV2 = recthelper.uiPosToScreenPos(dragObj:transform())

	if gohelper.isMouseOverGo(self._endTrans, screenPosV2) then
		self._dragEnabled = false

		self:saveState(States.Clicked)
		self.setPosToEnd(self, self._endTrans, dragObj:transform(), true, nil, self._onStateClicked, self)
	end
end

function V2a2_WarmUpLeftView_Day1:_onStateClicked()
	self.playAnim_before_finish(self, self._finish_before_doneCb, self)
end

function V2a2_WarmUpLeftView_Day1:_finish_before_doneCb()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_release_20220216)

	self._needWaitCount = 2

	self.playAnim_before_out(self, self._onAfterDone, self)
	self.playAnim_after_in(self, self._onAfterDone, self)
end

function V2a2_WarmUpLeftView_Day1:_onAfterDone()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount > 0 then
		return
	end

	self:markIsFinishedInteractive(true)
	self:saveStateDone(true)
	self:setActive_before(false)
	self:setActive_after(true)
	self:openDesc()
end

function V2a2_WarmUpLeftView_Day1:_onEndDrag()
	if not self:_canDrag() then
		return
	end

	self:playAnimRaw_before_click_r(0, 0)
	self:tweenAnchorPos(self._startTrans, self._startX, self._startY)
end

function V2a2_WarmUpLeftView_Day1:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_drag")
	Base.onDestroyView(self)
end

function V2a2_WarmUpLeftView_Day1:setData()
	Base.setData(self)

	local isDone = self:checkIsDone()

	self:setActive_before(not isDone)
	self:setActive_after(isDone)

	if isDone then
		self._dragEnabled = false
	else
		local state = self:getState()

		if state == 0 then
			self._dragEnabled = true

			recthelper.setAnchor(self._startTrans, self._startX, self._startY)
			self:playAnimRaw_before_idle(0, 1)
		elseif States.Clicked == state then
			self._dragEnabled = false

			self:setPosToEnd(self._endTrans, self._startTrans)
			self:_onStateClicked()
		else
			logError("[V2a2_WarmUpLeftView_Day1] invalid state:" .. state)
		end
	end
end

return V2a2_WarmUpLeftView_Day1
