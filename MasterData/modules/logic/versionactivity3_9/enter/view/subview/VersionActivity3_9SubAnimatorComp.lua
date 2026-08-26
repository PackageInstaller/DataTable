-- chunkname: @modules/logic/versionactivity3_9/enter/view/subview/VersionActivity3_9SubAnimatorComp.lua

module("modules.logic.versionactivity3_9.enter.view.subview.VersionActivity3_9SubAnimatorComp", package.seeall)

local VersionActivity3_9SubAnimatorComp = class("VersionActivity3_9SubAnimatorComp", VersionActivityFixedSubAnimatorComp)

function VersionActivity3_9SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity3_9SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity3_9SubAnimatorComp:playOpenAnim()
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

			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
		else
			self.viewContainer:markPlayedSubViewAnim()
			self.animator:Play("open1", 0, 0)

			self.animator.speed = 1
		end
	else
		self.animator:Play(UIAnimationName.Open, 0, 0)

		self.animator.speed = 1
	end
end

function VersionActivity3_9SubAnimatorComp:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	if self.animator.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_9SubAnimatorComp:skipPlayVideo()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	self:_playOpen1Anim()
end

function VersionActivity3_9SubAnimatorComp:_delayPlayOpen1Anim()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

	if self.animator.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity3_9Enum.OpenAnimDelayTime)
end

function VersionActivity3_9SubAnimatorComp:_playOpen1Anim()
	self.animator.speed = 1

	self.animator:Play("open1", 0, 0)
end

function VersionActivity3_9SubAnimatorComp:destroy()
	VersionActivity3_9SubAnimatorComp.super.destroy(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
end

return VersionActivity3_9SubAnimatorComp
