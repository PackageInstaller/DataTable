-- chunkname: @modules/logic/versionactivity2_2/warmup/view/V2a2_WarmUpLeftView_Day2.lua

module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day2", package.seeall)

local Base = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local V2a2_WarmUpLeftView_Day2 = class("V2a2_WarmUpLeftView_Day2", Base)

function V2a2_WarmUpLeftView_Day2:onInitView()
	self._btn1 = gohelper.findChildButtonWithAudio(self.viewGO, "before/#btn_1")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "after/#simage_icon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_WarmUpLeftView_Day2:addEvents()
	self._btn1:AddClickListener(self._btn1OnClick, self)
end

function V2a2_WarmUpLeftView_Day2:removeEvents()
	self._btn1:RemoveClickListener()
end

function V2a2_WarmUpLeftView_Day2:_btn1OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220217)

	if not self._allowClick then
		return
	end

	self:markGuided()
	self:_setActive_guide(false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_horn_20220218)
	self.playAnim_before_click(self, self._click_before_doneCb, self)
end

function V2a2_WarmUpLeftView_Day2:_click_before_doneCb()
	self._allowClick = false
	self._needWaitCount = 2

	self.playAnim_before_out(self, self._onAfterDone, self)
	self.playAnim_after_in(self, self._onAfterDone, self)
end

function V2a2_WarmUpLeftView_Day2:_onAfterDone()
	self._needWaitCount = self._needWaitCount - 1

	if self._needWaitCount > 0 then
		return
	end

	self:markIsFinishedInteractive(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_release_20220219)
	self:saveStateDone(true)
	self:setActive_before(false)
	self:setActive_after(true)
	self:openDesc()
end

function V2a2_WarmUpLeftView_Day2:ctor(ctorParam)
	Base.ctor(self, ctorParam)

	self._needWaitCount = 0
	self._allowClick = false
end

function V2a2_WarmUpLeftView_Day2:_editableInitView()
	Base._editableInitView(self)

	self._guideGo = gohelper.findChild(self.viewGO, "guide_day2")
	self._click_after = gohelper.getClick(self._simageicon2.gameObject)

	self._click_after:AddClickListener(self._onclick_after, self)
end

function V2a2_WarmUpLeftView_Day2:_onclick_after()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220217)
end

function V2a2_WarmUpLeftView_Day2:onDestroyView()
	Base.onDestroyView(self)
	self._click_after:RemoveClickListener()
end

function V2a2_WarmUpLeftView_Day2:setData()
	Base.setData(self)

	local isDone = self:checkIsDone()

	if not isDone then
		self:playAnimRaw_before_idle(0, 1)
	end

	self._allowClick = not isDone

	self:setActive_before(not isDone)
	self:setActive_after(isDone)
end

return V2a2_WarmUpLeftView_Day2
