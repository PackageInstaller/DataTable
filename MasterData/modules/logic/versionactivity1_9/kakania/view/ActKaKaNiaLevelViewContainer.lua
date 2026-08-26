-- chunkname: @modules/logic/versionactivity1_9/kakania/view/ActKaKaNiaLevelViewContainer.lua

module("modules.logic.versionactivity1_9.kakania.view.ActKaKaNiaLevelViewContainer", package.seeall)

local ActKaKaNiaLevelViewContainer = class("ActKaKaNiaLevelViewContainer", BaseViewContainer)

function ActKaKaNiaLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActKaKaNiaLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActKaKaNiaLevelViewContainer:buildTabViews(tabContainerId)
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

function ActKaKaNiaLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_9Enum.ActivityId.KaKaNia)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_9Enum.ActivityId.KaKaNia
	})
end

return ActKaKaNiaLevelViewContainer
