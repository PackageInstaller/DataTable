-- chunkname: @modules/logic/versionactivity3_6/warmup/view/V3a6_WarmUpDayItem2_5.lua

module("modules.logic.versionactivity3_6.warmup.view.V3a6_WarmUpDayItem2_5", package.seeall)

local V3a6_WarmUpDayItem2_5 = class("V3a6_WarmUpDayItem2_5", V3a6_WarmUpDayItemBase)

function V3a6_WarmUpDayItem2_5:onInitView()
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6_WarmUpDayItem2_5:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function V3a6_WarmUpDayItem2_5:removeEvents()
	self._btnClick:RemoveClickListener()
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V3a6_WarmUpDayItem2_5:ctor(...)
	V3a6_WarmUpDayItem2_5.super.ctor(self, ...)
end

function V3a6_WarmUpDayItem2_5:_editableInitView()
	V3a6_WarmUpDayItem2_5.super._editableInitView(self)

	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
end

function V3a6_WarmUpDayItem2_5:onDestroyView()
	V3a6_WarmUpDayItem2_5.super.onDestroyView(self)
end

function V3a6_WarmUpDayItem2_5:setData(mo)
	V3a6_WarmUpDayItem2_5.super.setData(self, mo)

	local isRecevied, localIsPlay = self:getRLOC()
	local bPassed = isRecevied or localIsPlay
	local bShowUnlocked = self:isEpisodeReallyOpen() and self:getSavedPlayedUnlock()

	self:playIdleAnim(bPassed, bShowUnlocked)
end

function V3a6_WarmUpDayItem2_5:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V3a6_WarmUpDayItem2_5:playIdleAnim(bFinished, bUnlocked)
	if bFinished then
		self:playFinishedIdleAnim()
	elseif bUnlocked then
		self:playUnlockIdleAnim()
	else
		self:playLockIdleAnim()
	end
end

function V3a6_WarmUpDayItem2_5:playFinishedIdleAnim(...)
	self:_playAnim("finish_idle", ...)
end

function V3a6_WarmUpDayItem2_5:playUnlockIdleAnim(...)
	self:_playAnim("unlock_idle", ...)
end

function V3a6_WarmUpDayItem2_5:playLockIdleAnim(...)
	self:_playAnim("lock_idle", ...)
end

function V3a6_WarmUpDayItem2_5:playUnlockAnim(...)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	self:_playAnim("unlock", ...)
end

function V3a6_WarmUpDayItem2_5:playFinishAnim(...)
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper)
	self:_playAnim("finish", ...)
end

return V3a6_WarmUpDayItem2_5
