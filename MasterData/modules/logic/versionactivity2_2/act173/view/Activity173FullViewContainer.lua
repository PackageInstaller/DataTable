-- chunkname: @modules/logic/versionactivity2_2/act173/view/Activity173FullViewContainer.lua

module("modules.logic.versionactivity2_2.act173.view.Activity173FullViewContainer", package.seeall)

local Activity173FullViewContainer = class("Activity173FullViewContainer", BaseViewContainer)

function Activity173FullViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity173FullView.New())

	return views
end

function Activity173FullViewContainer:playCloseTransition()
	self:startViewCloseBlock()

	local player = SLFramework.AnimatorPlayer.Get(self.viewGO)

	player:Play(UIAnimationName.Close, self.onPlayCloseTransitionFinish, self)
end

return Activity173FullViewContainer
