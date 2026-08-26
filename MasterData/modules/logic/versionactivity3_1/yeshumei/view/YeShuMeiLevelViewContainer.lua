-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiLevelViewContainer.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiLevelViewContainer", package.seeall)

local YeShuMeiLevelViewContainer = class("YeShuMeiLevelViewContainer", BaseViewContainer)

function YeShuMeiLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, YeShuMeiLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function YeShuMeiLevelViewContainer:buildTabViews(tabContainerId)
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

function YeShuMeiLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_1Enum.ActivityId.YeShuMei)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_1Enum.ActivityId.YeShuMei
	})
end

return YeShuMeiLevelViewContainer
