-- chunkname: @modules/logic/versionactivity1_6/getian/view/ActGeTianLevelViewContainer.lua

module("modules.logic.versionactivity1_6.getian.view.ActGeTianLevelViewContainer", package.seeall)

local ActGeTianLevelViewContainer = class("ActGeTianLevelViewContainer", BaseViewContainer)

function ActGeTianLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActGeTianLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActGeTianLevelViewContainer:buildTabViews(tabContainerId)
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

return ActGeTianLevelViewContainer
