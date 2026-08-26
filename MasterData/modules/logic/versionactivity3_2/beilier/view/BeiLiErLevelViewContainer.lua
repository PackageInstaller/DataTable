-- chunkname: @modules/logic/versionactivity3_2/beilier/view/BeiLiErLevelViewContainer.lua

module("modules.logic.versionactivity3_2.beilier.view.BeiLiErLevelViewContainer", package.seeall)

local BeiLiErLevelViewContainer = class("BeiLiErLevelViewContainer", BaseViewContainer)

function BeiLiErLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, BeiLiErLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function BeiLiErLevelViewContainer:buildTabViews(tabContainerId)
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

function BeiLiErLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_2Enum.ActivityId.BeiLiEr)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_2Enum.ActivityId.BeiLiEr
	})
end

return BeiLiErLevelViewContainer
