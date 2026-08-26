-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130LevelViewContainer.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130LevelViewContainer", package.seeall)

local Activity130LevelViewContainer = class("Activity130LevelViewContainer", BaseViewContainer)

function Activity130LevelViewContainer:buildViews()
	local views = {}

	self._mapViewScene = Activity130LevelScene.New()
	self._levelView = Activity130LevelView.New()
	self._sceneChangeView = Activity130DungeonChange.New()

	table.insert(views, self._mapViewScene)
	table.insert(views, self._levelView)
	table.insert(views, self._sceneChangeView)
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function Activity130LevelViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function Activity130LevelViewContainer:buildTabViews(tabContainerId)
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

function Activity130LevelViewContainer:_overrideCloseFunc()
	self._levelView._viewAnimator:Play(UIAnimationName.Close, 0, 0)
	TaskDispatcher.runDelay(self._doClose, self, 0.333)
end

function Activity130LevelViewContainer:_doClose()
	self:closeThis()
end

function Activity130LevelViewContainer:changeLvScene(type)
	self._mapViewScene:changeLvScene(type)
end

return Activity130LevelViewContainer
