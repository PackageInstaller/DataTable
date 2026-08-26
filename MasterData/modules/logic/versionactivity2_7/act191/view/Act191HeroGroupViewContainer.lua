-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191HeroGroupViewContainer.lua

module("modules.logic.versionactivity2_7.act191.view.Act191HeroGroupViewContainer", package.seeall)

local Act191HeroGroupViewContainer = class("Act191HeroGroupViewContainer", BaseViewContainer)

function Act191HeroGroupViewContainer:buildViews()
	local views = {}

	self.groupView = Act191HeroGroupView.New()

	table.insert(views, self.groupView)

	self.groupListView = Act191HeroGroupListView.New()

	table.insert(views, self.groupListView)
	table.insert(views, CheckActivityEndView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act191HeroGroupViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, self._closeCallback, nil, nil, self)

		return {
			self.navigateView
		}
	end
end

function Act191HeroGroupViewContainer:_closeCallback()
	local actId = Activity191Controller.instance:getActId()

	DungeonModel.instance:resetSendChapterEpisodeId()
	MainController.instance:enterMainScene(true)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act191MainView)
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity191Controller.instance:openMainView()
		end, nil, actId)
	end)
end

function Act191HeroGroupViewContainer:playOpenTransition()
	self.groupView.anim:Play("open", 0, 0)
	self.groupListView.animSwitch:Play("open", 0, 0)
	TaskDispatcher.runDelay(self.onPlayOpenTransitionFinish, self, 0.33)
end

function Act191HeroGroupViewContainer:playCloseTransition()
	self.groupView.anim:Play("close", 0, 0)
	self.groupListView.animSwitch:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.16)
end

function Act191HeroGroupViewContainer:onContainerDestroy()
	TaskDispatcher.cancelTask(self.onPlayOpenTransitionFinish, self)
	TaskDispatcher.cancelTask(self.onPlayCloseTransitionFinish, self)
end

return Act191HeroGroupViewContainer
