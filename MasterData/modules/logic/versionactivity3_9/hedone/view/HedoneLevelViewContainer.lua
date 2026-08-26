-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneLevelViewContainer.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneLevelViewContainer", package.seeall)

local HedoneLevelViewContainer = class("HedoneLevelViewContainer", BaseViewContainer)

function HedoneLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, HedoneLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function HedoneLevelViewContainer:buildTabViews(tabContainerId)
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

function HedoneLevelViewContainer:onContainerInit()
	local actId = HedoneModel.instance:getActId()

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

return HedoneLevelViewContainer
