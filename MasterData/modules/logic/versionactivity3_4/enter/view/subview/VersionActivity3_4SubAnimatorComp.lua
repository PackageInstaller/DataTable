-- chunkname: @modules/logic/versionactivity3_4/enter/view/subview/VersionActivity3_4SubAnimatorComp.lua

module("modules.logic.versionactivity3_4.enter.view.subview.VersionActivity3_4SubAnimatorComp", package.seeall)

local VersionActivity3_4SubAnimatorComp = class("VersionActivity3_4SubAnimatorComp", VersionActivityFixedSubAnimatorComp)

function VersionActivity3_4SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity3_4SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity3_4SubAnimatorComp:playOpenAnim()
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

function VersionActivity3_4SubAnimatorComp:onPlayVideoDone()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	if self.animator.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity3_4SubAnimatorComp:_delayPlayOpen1Anim()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

	if self.animator.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity3_4Enum.OpenAnimDelayTime)
end

function VersionActivity3_4SubAnimatorComp:_playOpen1Anim()
	self.animator.speed = 1

	self.animator:Play("open1", 0, 0)
end

function VersionActivity3_4SubAnimatorComp:destroy()
	VersionActivity3_4SubAnimatorComp.super.destroy(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
end

return VersionActivity3_4SubAnimatorComp
