-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandLevelViewContainer.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelViewContainer", package.seeall)

local CooperGarlandLevelViewContainer = class("CooperGarlandLevelViewContainer", BaseViewContainer)

function CooperGarlandLevelViewContainer:buildViews()
	local views = {}

	self._levelView = CooperGarlandLevelView.New()

	table.insert(views, self._levelView)
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function CooperGarlandLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function CooperGarlandLevelViewContainer:setVisibleInternal(isVisible)
	CooperGarlandLevelViewContainer.super.setVisibleInternal(self, isVisible)

	self._levelView.openAnimComplete = false

	if isVisible then
		self.playAnim(self, UIAnimationName.Open, self._playOpenAnimFinish, self)
	end
end

function CooperGarlandLevelViewContainer:_playOpenAnimFinish()
	if not self._levelView then
		return
	end

	self._levelView.openAnimComplete = true

	self._levelView:playEpisodeFinishAnim()
end

function CooperGarlandLevelViewContainer:playAnim(aniName, cb, cbObj)
	self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	if self.animatorPlayer then
		self.animatorPlayer:Play(aniName, cb, cbObj)
	end
end

return CooperGarlandLevelViewContainer
