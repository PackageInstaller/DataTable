-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131LevelViewContainer.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131LevelViewContainer", package.seeall)

local Activity131LevelViewContainer = class("Activity131LevelViewContainer", BaseViewContainer)

function Activity131LevelViewContainer:buildViews()
	local views = {}

	self._mapViewScene = Activity131LevelScene.New()
	self._levelView = Activity131LevelView.New()

	table.insert(views, self._mapViewScene)
	table.insert(views, self._levelView)
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Activity131LevelViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function Activity131LevelViewContainer:buildTabViews(tabContainerId)
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

function Activity131LevelViewContainer:_overrideCloseFunc()
	self._levelView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doClose, self, 0.333)
end

function Activity131LevelViewContainer:_doClose()
	self:closeThis()
end

return Activity131LevelViewContainer
