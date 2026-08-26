-- chunkname: @modules/logic/versionactivity1_5/sportsnews/view/SportsNewsViewContainer.lua

module("modules.logic.versionactivity1_5.sportsnews.view.SportsNewsViewContainer", package.seeall)

local SportsNewsViewContainer = class("SportsNewsViewContainer", BaseViewContainer)

function SportsNewsViewContainer:buildViews()
	local views = {}

	table.insert(views, SportsNewsView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function SportsNewsViewContainer:buildTabViews(tabContainerId)
	self._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self._navigateButtonView
	}
end

function SportsNewsViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_5Enum.ActivityId.SportsNews)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_5Enum.ActivityId.SportsNews
	})
end

return SportsNewsViewContainer
