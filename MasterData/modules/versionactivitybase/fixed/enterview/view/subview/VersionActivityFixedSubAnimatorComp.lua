-- chunkname: @modules/versionactivitybase/fixed/enterview/view/subview/VersionActivityFixedSubAnimatorComp.lua

module("modules.versionactivitybase.fixed.enterview.view.subview.VersionActivityFixedSubAnimatorComp", package.seeall)

local VersionActivityFixedSubAnimatorComp = class("VersionActivityFixedSubAnimatorComp", VersionActivitySubAnimatorComp)

function VersionActivityFixedSubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivityFixedSubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivityFixedSubAnimatorComp:playOpenAnim()
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

return VersionActivityFixedSubAnimatorComp
