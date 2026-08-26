-- chunkname: @modules/logic/versionactivity3_3/enter/view/subview/VersionActivity3_3SubAnimatorComp.lua

module("modules.logic.versionactivity3_3.enter.view.subview.VersionActivity3_3SubAnimatorComp", package.seeall)

local VersionActivity3_3SubAnimatorComp = class("VersionActivity3_3SubAnimatorComp", VersionActivitySubAnimatorComp)

function VersionActivity3_3SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity3_3SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity3_3SubAnimatorComp:playOpenAnim()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)

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

function VersionActivity3_3SubAnimatorComp:onPlayVideoDone()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoStarted, self._delayPlayOpen1Anim, self)

	self.animator.speed = 1

	self.animator:Play("open1", 0, 0)
end

function VersionActivity3_3SubAnimatorComp:_delayPlayOpen1Anim()
	if self.animator.speed == 1 then
		return
	end

	TaskDispatcher.runDelay(self._playOpen1Anim, self, VersionActivity3_3Enum.Open1AnimDelayPlayTime)
end

function VersionActivity3_3SubAnimatorComp:_playOpen1Anim()
	self:onPlayVideoDone()
end

function VersionActivity3_3SubAnimatorComp:_playAudio(isFirst)
	if not self.view.viewParam.isExitFight then
		if isFirst then
			AudioMgr.instance:trigger(AudioEnum3_3.VersionActivity3_3Enter.play_ui_yuanzheng_open_1)
		else
			AudioMgr.instance:trigger(AudioEnum3_3.VersionActivity3_3Enter.play_ui_yuanzheng_open_2)
		end
	end
end

function VersionActivity3_3SubAnimatorComp:destroy()
	TaskDispatcher.cancelTask(self._playOpen1Anim, self)
	VersionActivity3_3SubAnimatorComp.super.destroy(self)
end

return VersionActivity3_3SubAnimatorComp
