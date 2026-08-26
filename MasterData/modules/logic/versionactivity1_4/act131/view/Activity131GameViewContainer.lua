-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131GameViewContainer.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131GameViewContainer", package.seeall)

local Activity131GameViewContainer = class("Activity131GameViewContainer", BaseViewContainer)

function Activity131GameViewContainer:buildViews()
	self._act131GameView = Activity131GameView.New()

	return {
		self._act131GameView,
		Activity131Map.New(),
		TabViewGroup.New(1, "#go_topbtns")
	}
end

function Activity131GameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self._navigateButtonView:setOverrideClose(self._overrideCloseFunc, self)

		return {
			self._navigateButtonView
		}
	end
end

function Activity131GameViewContainer:_overrideCloseFunc()
	self._act131GameView._viewAnim:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doClose, self, 0.167)
end

function Activity131GameViewContainer:_doClose()
	self:closeThis()
	Activity131Controller.instance:dispatchEvent(Activity131Event.BackToLevelView, true)
end

return Activity131GameViewContainer
