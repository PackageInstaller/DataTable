-- chunkname: @modules/logic/versionactivity3_0/karong/view/KaRongLevelViewContainer.lua

module("modules.logic.versionactivity3_0.karong.view.KaRongLevelViewContainer", package.seeall)

local KaRongLevelViewContainer = class("KaRongLevelViewContainer", BaseViewContainer)

function KaRongLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, KaRongLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function KaRongLevelViewContainer:buildTabViews(tabContainerId)
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

function KaRongLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_0Enum.ActivityId.KaRong)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_0Enum.ActivityId.KaRong
	})
end

return KaRongLevelViewContainer
