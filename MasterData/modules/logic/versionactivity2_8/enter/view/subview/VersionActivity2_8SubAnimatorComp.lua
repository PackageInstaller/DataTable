-- chunkname: @modules/logic/versionactivity2_8/enter/view/subview/VersionActivity2_8SubAnimatorComp.lua

module("modules.logic.versionactivity2_8.enter.view.subview.VersionActivity2_8SubAnimatorComp", package.seeall)

local VersionActivity2_8SubAnimatorComp = class("VersionActivity2_8SubAnimatorComp", VersionActivitySubAnimatorComp)

function VersionActivity2_8SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity2_8SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity2_8SubAnimatorComp:playOpenAnim()
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

return VersionActivity2_8SubAnimatorComp
