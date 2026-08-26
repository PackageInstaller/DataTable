-- chunkname: @modules/logic/versionactivity2_2/warmup/view/V2a2_WarmUpLeftView_Day5.lua

module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day5", package.seeall)

local Base = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local V2a2_WarmUpLeftView_Day5 = class("V2a2_WarmUpLeftView_Day5", Base)

function V2a2_WarmUpLeftView_Day5:onInitView()
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "before/#simage_icon1")
	self._goValidArea = gohelper.findChild(self.viewGO, "before/#go_ValidArea")
	self._btn1 = gohelper.findChildButtonWithAudio(self.viewGO, "before/#btn_1")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "after/#simage_icon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_WarmUpLeftView_Day5:addEvents()
	self._btn1:AddClickListener(self._btn1OnClick, self)
end

function V2a2_WarmUpLeftView_Day5:removeEvents()
	self._btn1:RemoveClickListener()
end

local States = {
	Clicked = 1
}

function V2a2_WarmUpLeftView_Day5:_btn1OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220226)
end

function V2a2_WarmUpLeftView_Day5:ctor(ctorParam)
	Base.ctor(self, ctorParam)

	self._dragEnabled = false
	self._needWaitCount = 0
end

function V2a2_WarmUpLeftView_Day5:_editableInitView()
	Base._editableInitView(self)

	self._guideGo = gohelper.findChild(self.viewGO, "guide_day5")
	self._startGo = self._btn1.gameObject
	self._startTrans = self._startGo.transform
	self._startX, self._startY = recthelper.getAnchor(self._startTrans)
	self._startAnimation = self._startGo:GetComponent(gohelper.Type_Animation)
	self._endGo = self._goValidArea
	self._endTrans = self._endGo.transform

	CommonDragHelper.instance:registerDragObj(self._startGo, self._onBeginDrag, self._onDrag, self._onEndDrag, self._checkCanDrag, self)
end

function V2a2_WarmUpLeftView_Day5:onDestroyView()
	CommonDragHelper.instance:unregisterDragObj(self._startGo)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_youyu_yure_cut_loop_20220229)
	Base.onDestroyView(self)
end

function V2a2_WarmUpLeftView_Day5:_checkCanDrag()
	return not self:_canDrag()
end

function V2a2_WarmUpLeftView_Day5:_canDrag()
	return self._dragEnabled
end

function V2a2_WarmUpLeftView_Day5:_onBeginDrag(_, pointerEventData)
	if not self:_canDrag() then
		return
	end

	self._startAnimation.enabled = false

	Base._onDragBegin(self)
end

function V2a2_WarmUpLeftView_Day5:_onDrag(_, pointerEventData)
	if not self:_canDrag() then
		return
	end

	if gohelper.isMouseOverGo(self._endTrans, pointerEventData.position) then
		CommonDragHelper.instance:setGlobalEnabled(false)

		self._dragEnabled = false

		self:saveState(States.Clicked)
		self:_onStateClicked()
	end
end

function V2a2_WarmUpLeftView_Day5:_onEndDrag(_, pointerEventData)
	if not self:_canDrag() then
		return
	end

	self:tweenAnchorPos(self._startTrans, self._startX, self._startY)
end

function V2a2_WarmUpLeftView_Day5:_onStateClicked()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_cut_loop_20220227)
	self.playAnim_before_click(self, self._click_before_doneCb, self)
end

function V2a2_WarmUpLeftView_Day5:_click_before_doneCb()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_youyu_yure_cut_loop_20220229)

	self._needWaitCount = 2

	self.playAnim_before_out(self, self._onAfterDone, self)
	self.playAnim_after_in(self, self._onAfterDone, self)
end

function V2a2_WarmUpLeftView_Day5:_onAfterDone()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount > 0 then
		return
	end

	self:saveStateDone(true)
	self:setActive_before(false)
	self:setActive_after(true)
	self:openDesc()
end

function V2a2_WarmUpLeftView_Day5:setData()
	Base.setData(self)

	local isDone = self:checkIsDone()

	self:setActive_before(not isDone)
	self:setActive_after(isDone)
	self:playAnimRaw_before_idle(0, 1)

	self._startAnimation.enabled = true

	if isDone then
		self._dragEnabled = false
	else
		local state = self:getState()

		if state == 0 then
			self._dragEnabled = true

			recthelper.setAnchor(self._startTrans, self._startX, self._startY)
		elseif States.Clicked == state then
			self._dragEnabled = false

			self:_onStateClicked()
		else
			logError("[V2a2_WarmUpLeftView_Day5] invalid state:" .. state)
		end
	end
end

return V2a2_WarmUpLeftView_Day5
