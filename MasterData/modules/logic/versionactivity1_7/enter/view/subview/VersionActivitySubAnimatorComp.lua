-- chunkname: @modules/logic/versionactivity1_7/enter/view/subview/VersionActivitySubAnimatorComp.lua

module("modules.logic.versionactivity1_7.enter.view.subview.VersionActivitySubAnimatorComp", package.seeall)

local VersionActivitySubAnimatorComp = class("VersionActivitySubAnimatorComp", UserDataDispose)

function VersionActivitySubAnimatorComp.get(animatorGo, view)
	local instance = VersionActivitySubAnimatorComp.New()

	instance:init(animatorGo, view)

	return instance
end

function VersionActivitySubAnimatorComp:init(animatorGo, view)
	self:__onInit()

	self.animatorGo = animatorGo
	self.animator = self.animatorGo:GetComponent(typeof(UnityEngine.Animator))
	self.view = view
	self.viewContainer = view.viewContainer
end

function VersionActivitySubAnimatorComp:playOpenAnim()
	if self.view.viewParam.skipOpenAnim then
		self.animator:Play(UIAnimationName.Open, 0, 1)

		self.view.viewParam.skipOpenAnim = false

		self.viewContainer:markPlayedSubViewAnim()

		return
	end

	if self.viewContainer:getIsFirstPlaySubViewAnim() then
		if self.view.viewParam.playVideo then
			self.viewContainer:markPlayedSubViewAnim()
			self.animator:Play(UIAnimationName.Open, 0, 0)

			self.animator.speed = 0

			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
			self.addEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
		else
			self.animator:Play(UIAnimationName.Open, 0, 0)

			self.animator.speed = 1
		end
	else
		self.animator:Play(UIAnimationName.Open, 0, 0)

		self.animator.speed = 1
	end
end

function VersionActivitySubAnimatorComp:onPlayVideoDone()
	self.animator.speed = 1

	self.animator:Play(UIAnimationName.Open, 0, 0)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayFinished, self.onPlayVideoDone, self)
	self.removeEventCb(self, VideoController.instance, VideoEvent.OnVideoPlayOverTime, self.onPlayVideoDone, self)
end

function VersionActivitySubAnimatorComp:destroy()
	self:__onDispose()
end

return VersionActivitySubAnimatorComp
