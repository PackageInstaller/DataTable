-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianLevelViewContainer.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianLevelViewContainer", package.seeall)

local LuSiJianLevelViewContainer = class("LuSiJianLevelViewContainer", BaseViewContainer)

function LuSiJianLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, LuSiJianLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function LuSiJianLevelViewContainer:buildTabViews(tabContainerId)
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

function LuSiJianLevelViewContainer:onContainerInit()
	ActivityEnterMgr.instance:enterActivity(VersionActivity3_4Enum.ActivityId.LuSiJian)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity3_4Enum.ActivityId.LuSiJian
	})
end

return LuSiJianLevelViewContainer
