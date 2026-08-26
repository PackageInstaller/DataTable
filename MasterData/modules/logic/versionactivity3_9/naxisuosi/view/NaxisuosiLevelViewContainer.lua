-- chunkname: @modules/logic/versionactivity3_9/naxisuosi/view/NaxisuosiLevelViewContainer.lua

module("modules.logic.versionactivity3_9.naxisuosi.view.NaxisuosiLevelViewContainer", package.seeall)

local NaxisuosiLevelViewContainer = class("NaxisuosiLevelViewContainer", BaseViewContainer)

function NaxisuosiLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, NaxisuosiLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function NaxisuosiLevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonsView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonsView
		}
	end
end

function NaxisuosiLevelViewContainer:onContainerInit()
	local actId = NaxisuosiModel.instance:getActId()

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

return NaxisuosiLevelViewContainer
