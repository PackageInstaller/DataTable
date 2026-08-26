-- chunkname: @modules/logic/autochess/main/view/AutoChessCultivateViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessCultivateViewContainer", package.seeall)

local AutoChessCultivateViewContainer = class("AutoChessCultivateViewContainer", BaseViewContainer)

function AutoChessCultivateViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessCultivateView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AutoChessCultivateViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return AutoChessCultivateViewContainer
