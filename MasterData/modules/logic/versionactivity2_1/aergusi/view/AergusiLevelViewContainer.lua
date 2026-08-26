-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiLevelViewContainer.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiLevelViewContainer", package.seeall)

local AergusiLevelViewContainer = class("AergusiLevelViewContainer", BaseViewContainer)

function AergusiLevelViewContainer:buildViews()
	self._levelView = AergusiLevelView.New()

	return {
		self._levelView,
		TabViewGroup.New(1, "#go_btns")
	}
end

function AergusiLevelViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function AergusiLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonsView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonsView
		}
	end
end

function AergusiLevelViewContainer:_overrideCloseFunc()
	self._levelView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doClose, self, 0.333)
end

function AergusiLevelViewContainer:_doClose()
	self:closeThis()
end

return AergusiLevelViewContainer
