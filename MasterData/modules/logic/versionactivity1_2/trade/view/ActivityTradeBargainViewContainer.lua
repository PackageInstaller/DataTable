-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityTradeBargainViewContainer.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainViewContainer", package.seeall)

local ActivityTradeBargainViewContainer = class("ActivityTradeBargainViewContainer", BaseViewContainer)

function ActivityTradeBargainViewContainer:buildViews()
	local views = {}

	table.insert(views, ActivityTradeBargainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, TabViewGroup.New(2, "#go_content"))

	return views
end

function ActivityTradeBargainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.VersionActivity_1_2_Trade)

		self._navigateButtonView:setCloseCheck(self._closeCheckFunc, self)

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		return {
			ActivityTradeBargainQuoteView.New(),
			ActivityTradeBargainRewardView.New()
		}
	end
end

function ActivityTradeBargainViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.Trade)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.Trade
	})
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function ActivityTradeBargainViewContainer:setActId(actId)
	self.actId = actId
end

function ActivityTradeBargainViewContainer:getActId()
	return self.actId
end

return ActivityTradeBargainViewContainer
