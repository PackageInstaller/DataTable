-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174GameViewContainer.lua

module("modules.logic.versionactivity2_3.act174.view.Act174GameViewContainer", package.seeall)

local Act174GameViewContainer = class("Act174GameViewContainer", BaseViewContainer)

function Act174GameViewContainer:buildViews()
	local views = {}

	self.mainView = Act174GameView.New()

	table.insert(views, self.mainView)
	table.insert(views, Act174GameShopView.New())
	table.insert(views, Act174GameWarehouseView.New())
	table.insert(views, Act174GameTeamView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Act174GameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, self.OnClickClose, nil, nil, self)

		return {
			self.navigateView
		}
	end
end

function Act174GameViewContainer:OnClickClose()
	local actId = Activity174Model.instance:getCurActId()

	Activity174Controller.instance:syncLocalTeam2Server(actId)
end

function Act174GameViewContainer:playCloseTransition()
	self.mainView.anim:Play(UIAnimationName.Close)
	TaskDispatcher.runDelay(self.onPlayCloseTransitionFinish, self, 0.2)
end

return Act174GameViewContainer
