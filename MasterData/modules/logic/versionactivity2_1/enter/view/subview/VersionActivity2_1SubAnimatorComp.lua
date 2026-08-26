-- chunkname: @modules/logic/versionactivity2_1/enter/view/subview/VersionActivity2_1SubAnimatorComp.lua

module("modules.logic.versionactivity2_1.enter.view.subview.VersionActivity2_1SubAnimatorComp", package.seeall)

local VersionActivity2_1SubAnimatorComp = class("VersionActivity2_1SubAnimatorComp", VersionActivitySubAnimatorComp)

function VersionActivity2_1SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity2_1SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity2_1SubAnimatorComp:playOpenAnim()
	if self.view.viewParam.skipOpenAnim then
		self.animator:Play(UIAnimationName.Open, 0, 1)

		self.view.viewParam.skipOpenAnim = false

		self.viewContainer:markPlayedSubViewAnim()

		return
	end

	if self.viewContainer:getIsFirstPlaySubViewAnim() then
		if self.view.viewParam.playVideo then
			self.viewContainer:markPlayedSubViewAnim()
			self:playFirstOpenAnim()

			self.animator.speed = 0

			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		else
			self.viewContainer:markPlayedSubViewAnim()
			self:playFirstOpenAnim()

			self.animator.speed = 1
		end
	else
		self.animator:Play(UIAnimationName.Open, 0, 0)

		self.animator.speed = 1
	end
end

function VersionActivity2_1SubAnimatorComp:playFirstOpenAnim()
	self.animator:Play("open1", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1Enter.play_ui_open)
end

return VersionActivity2_1SubAnimatorComp
