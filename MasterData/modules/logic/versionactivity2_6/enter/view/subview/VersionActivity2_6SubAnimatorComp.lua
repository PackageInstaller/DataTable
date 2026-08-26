-- chunkname: @modules/logic/versionactivity2_6/enter/view/subview/VersionActivity2_6SubAnimatorComp.lua

module("modules.logic.versionactivity2_6.enter.view.subview.VersionActivity2_6SubAnimatorComp", package.seeall)

local VersionActivity2_6SubAnimatorComp = class("VersionActivity2_6SubAnimatorComp", VersionActivitySubAnimatorComp)

function VersionActivity2_6SubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivity2_6SubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivity2_6SubAnimatorComp:playOpenAnim()
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

return VersionActivity2_6SubAnimatorComp
