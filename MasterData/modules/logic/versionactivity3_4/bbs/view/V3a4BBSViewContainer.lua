-- chunkname: @modules/logic/versionactivity3_4/bbs/view/V3a4BBSViewContainer.lua

module("modules.logic.versionactivity3_4.bbs.view.V3a4BBSViewContainer", package.seeall)

local V3a4BBSViewContainer = class("V3a4BBSViewContainer", BaseViewContainer)

function V3a4BBSViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a4BBSView.New())

	return views
end

function V3a4BBSViewContainer:playCloseTransition()
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
end

function V3a4BBSViewContainer:onCloseAnimDone()
	self:onPlayCloseTransitionFinish()
end

return V3a4BBSViewContainer
