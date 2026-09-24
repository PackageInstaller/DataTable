-- chunkname: @modules/logic/versionactivity4_0/enter/view/subview/VersionActivity4_0SubAnimatorComp.lua

module("modules.logic.versionactivity4_0.enter.view.subview.VersionActivity4_0SubAnimatorComp", package.seeall)

local VersionActivity4_0SubAnimatorComp = class("VersionActivity4_0SubAnimatorComp", VersionActivityFixedSubAnimatorComp)

function VersionActivity4_0SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity4_0SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity4_0SubAnimatorComp:playOpenAnim()
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

		self:_playAudio(true)
	else
		self.animator:Play(UIAnimationName.Open, 0, 0)

		self.animator.speed = 1

		self:_playAudio(false)
	end
end

function VersionActivity4_0SubAnimatorComp:onPlayVideoDone()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)

	if self.animator.speed == 1 then
		return
	end

	self:_playOpen1Anim()
end

function VersionActivity4_0SubAnimatorComp:_delayPlayOpen1Anim()
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

	if self.animator.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity4_0Enum.OpenAnimDelayTime)
end

function VersionActivity4_0SubAnimatorComp:_playOpen1Anim()
	self.animator.speed = 1

	self.animator:Play("open1", 0, 0)
end

function VersionActivity4_0SubAnimatorComp:_playAudio(isFirst)
	if not self.view.viewParam.isExitFight then
		if isFirst then
			AudioMgr.instance:trigger(AudioEnum4_0.EnterView.open_1)
		else
			AudioMgr.instance:trigger(AudioEnum4_0.EnterView.open_2)
		end
	end
end

function VersionActivity4_0SubAnimatorComp:destroy()
	VersionActivity4_0SubAnimatorComp.super.destroy(self)
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
end

return VersionActivity4_0SubAnimatorComp
