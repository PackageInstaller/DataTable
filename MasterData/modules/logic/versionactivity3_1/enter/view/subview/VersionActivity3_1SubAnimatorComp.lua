-- chunkname: @modules/logic/versionactivity3_1/enter/view/subview/VersionActivity3_1SubAnimatorComp.lua

module("modules.logic.versionactivity3_1.enter.view.subview.VersionActivity3_1SubAnimatorComp", package.seeall)

local VersionActivity3_1SubAnimatorComp = class("VersionActivity3_1SubAnimatorComp", VersionActivityFixedSubAnimatorComp)

function VersionActivity3_1SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity3_1SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity3_1SubAnimatorComp:playOpenAnim()
	if self.view.viewParam.skipOpenAnim then
		self.animator:Play(UIAnimationName.Open, 0, 1)

		self.view.viewParam.skipOpenAnim = false

		self.viewContainer:markPlayedSubViewAnim()

		return
	end

	if self.viewContainer:getIsFirstPlaySubViewAnim() then
		if self.view.viewParam.playVideo then
			self.viewContainer:markPlayedSubViewAnim()
			self.animator:Play("open1", 0, 0)

			self.animator.speed = 0

			self.view:playLogoAnim("open1")
			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		else
			self.viewContainer:markPlayedSubViewAnim()
			self.animator:Play("open1", 0, 0)

			self.animator.speed = 1

			self.view:playLogoAnim("open1")
			self:_playAudio()
		end
	else
		self.animator:Play(UIAnimationName.Open, 0, 0)

		self.animator.speed = 1

		self.view:playLogoAnim(UIAnimationName.Open)
		self:_playAudio()
	end
end

function VersionActivity3_1SubAnimatorComp:_playAudio()
	if not self.view.viewParam.isExitFight then
		AudioMgr.instance:trigger(AudioEnum3_1.VersionActivity3_1Enter.play_ui_mingdi_entrance)
	end
end

function VersionActivity3_1SubAnimatorComp:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	if self.animator.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_1SubAnimatorComp:_delayPlayOpen1Anim()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

	if self.animator.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, 4)
end

function VersionActivity3_1SubAnimatorComp:_playOpen1Anim()
	self.animator.speed = 1

	self.animator:Play("open1", 0, 0)
	self.view:playLogoAnim("open1")
	self:_playAudio()
end

function VersionActivity3_1SubAnimatorComp:destroy()
	VersionActivity3_1SubAnimatorComp.super.destroy(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
end

return VersionActivity3_1SubAnimatorComp
