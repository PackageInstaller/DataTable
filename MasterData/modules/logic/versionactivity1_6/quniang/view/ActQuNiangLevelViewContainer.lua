-- chunkname: @modules/logic/versionactivity1_6/quniang/view/ActQuNiangLevelViewContainer.lua

module("modules.logic.versionactivity1_6.quniang.view.ActQuNiangLevelViewContainer", package.seeall)

local ActQuNiangLevelViewContainer = class("ActQuNiangLevelViewContainer", BaseViewContainer)

function ActQuNiangLevelViewContainer:buildViews()
	local views = {}

	table.insert(views, ActQuNiangLevelView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function ActQuNiangLevelViewContainer:buildTabViews(tabContainerId)
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

return ActQuNiangLevelViewContainer
