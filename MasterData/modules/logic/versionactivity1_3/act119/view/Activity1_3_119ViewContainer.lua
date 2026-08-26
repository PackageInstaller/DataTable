-- chunkname: @modules/logic/versionactivity1_3/act119/view/Activity1_3_119ViewContainer.lua

module("modules.logic.versionactivity1_3.act119.view.Activity1_3_119ViewContainer", package.seeall)

local Activity1_3_119ViewContainer = class("Activity1_3_119ViewContainer", BaseViewContainer)

function Activity1_3_119ViewContainer:buildViews()
	local views = {}

	self._view = Activity1_3_119View.New()

	table.insert(views, self._view)
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))

	return views
end

function Activity1_3_119ViewContainer:buildTabViews(tabContainerId)
	local navigateView = NavigateButtonsView.New({
		true,
		true,
		true
	}, HelpEnum.HelpId.VersionActivity_1_3_119)

	return {
		navigateView
	}
end

function Activity1_3_119ViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_3Enum.ActivityId.Act307)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_3Enum.ActivityId.Act307
	})
end

function Activity1_3_119ViewContainer:playOpenTransition()
	local data = Activity119Model.instance:getData()
	local config = Activity119Config.instance:getConfig(VersionActivity1_3Enum.ActivityId.Act307, data.lastSelectDay)

	Activity1_3_119ViewContainer.super.playOpenTransition(self, {
		anim = (data.lastSelectModel == 2 and DungeonModel.instance:hasPassLevel(config.normalCO.id) or nil) and "hard"
	})
end

function Activity1_3_119ViewContainer:playCloseTransition()
	local data = Activity119Model.instance:getData()

	Activity1_3_119ViewContainer.super.playCloseTransition(self, {
		anim = (data.lastSelectModel == 2 or nil) and "hardclose"
	})
end

return Activity1_3_119ViewContainer
