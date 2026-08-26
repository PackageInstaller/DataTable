-- chunkname: @modules/logic/versionactivity2_2/warmup/view/V2a2_WarmUpLeftView_Day3.lua

module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day3", package.seeall)

local Base = require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase")
local V2a2_WarmUpLeftView_Day3 = class("V2a2_WarmUpLeftView_Day3", Base)

function V2a2_WarmUpLeftView_Day3:onInitView()
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "before/#simage_icon1")
	self._btn1 = gohelper.findChildButtonWithAudio(self.viewGO, "before/#btn_1")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "after/#simage_icon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_WarmUpLeftView_Day3:addEvents()
	self._btn1:AddClickListener(self._btn1OnClick, self)
end

function V2a2_WarmUpLeftView_Day3:removeEvents()
	self._btn1:RemoveClickListener()
end

function V2a2_WarmUpLeftView_Day3:_btn1OnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_key_click_20220220)
	self:markGuided()
	self:_setActive_guide(false)

	if not self._allowClick then
		return
	end

	self._allowClick = false

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_key_move_20220221)
	self.playAnim_before_click(self, self._click_before_doneCb, self)
end

function V2a2_WarmUpLeftView_Day3:_click_before_doneCb()
	self._allowClick = false
	self._needWaitCount = 2

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_door_open_20220222)
	self.playAnim_before_out(self, self._onAfterDone, self)
	self.playAnim_after_in(self, self._onAfterDone, self)
end

function V2a2_WarmUpLeftView_Day3:_onAfterDone()
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

function V2a2_WarmUpLeftView_Day3:ctor(ctorParam)
	Base.ctor(self, ctorParam)

	self._needWaitCount = 0
	self._allowClick = false
end

function V2a2_WarmUpLeftView_Day3:_editableInitView()
	Base._editableInitView(self)

	self._guideGo = gohelper.findChild(self.viewGO, "guide_day3")
end

function V2a2_WarmUpLeftView_Day3:onDestroyView()
	Base.onDestroyView(self)
end

function V2a2_WarmUpLeftView_Day3:setData()
	Base.setData(self)

	local isDone = self:checkIsDone()

	if not isDone then
		self:playAnimRaw_before_idle(0, 1)
	end

	self._allowClick = not isDone

	self:setActive_before(not isDone)
	self:setActive_after(isDone)
end

return V2a2_WarmUpLeftView_Day3
