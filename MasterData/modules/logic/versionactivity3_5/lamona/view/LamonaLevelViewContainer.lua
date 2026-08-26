-- chunkname: @modules/logic/versionactivity3_5/lamona/view/LamonaLevelViewContainer.lua

module("modules.logic.versionactivity3_5.lamona.view.LamonaLevelViewContainer", package.seeall)

local LamonaLevelViewContainer = class("LamonaLevelViewContainer", BaseViewContainer)

function LamonaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, LamonaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function LamonaLevelViewContainer:buildTabViews(tabContainerId)
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

function LamonaLevelViewContainer:onContainerInit()
	local actId = LamonaModel.instance:getActId()

	ActivityEnterMgr.instance:enterActivity(actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		actId
	})
end

return LamonaLevelViewContainer
