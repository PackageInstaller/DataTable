-- chunkname: @modules/versionactivitybase/enterview/view/VersionActivityEnterBaseSubView.lua

module("modules.versionactivitybase.enterview.view.VersionActivityEnterBaseSubView", package.seeall)

local VersionActivityEnterBaseSubView = class("VersionActivityEnterBaseSubView", BaseView)

function VersionActivityEnterBaseSubView:onInitView()
	return
end

function VersionActivityEnterBaseSubView:_editableInitView()
	return
end

function VersionActivityEnterBaseSubView:onOpen()
	local viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if viewAnimator then
		viewAnimator:Play(UIAnimationName.Open, 0, 0)
	end

	self:everySecondCall()
	self:beginPerSecondRefresh()
end

function VersionActivityEnterBaseSubView:onOpenFinish()
	return
end

function VersionActivityEnterBaseSubView:onEnterVideoFinished()
	local viewAnimator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	viewAnimator:Play(UIAnimationName.Open, 0, 0)
end

function VersionActivityEnterBaseSubView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
end

function VersionActivityEnterBaseSubView:onUpdateParam()
	self:everySecondCall()
end

function VersionActivityEnterBaseSubView:onDestroyView()
	return
end

function VersionActivityEnterBaseSubView:beginPerSecondRefresh()
	TaskDispatcher.runRepeat(self.everySecondCall, self, 1)
end

function VersionActivityEnterBaseSubView:everySecondCall()
	return
end

return VersionActivityEnterBaseSubView
