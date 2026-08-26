-- chunkname: @modules/logic/abyss/view/AbyssStageDetailsViewContainer.lua

module("modules.logic.abyss.view.AbyssStageDetailsViewContainer", package.seeall)

local AbyssStageDetailsViewContainer = class("AbyssStageDetailsViewContainer", BaseViewContainer)

function AbyssStageDetailsViewContainer:buildViews()
	local views = {}

	table.insert(views, AbyssStageDetailsView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AbyssStageDetailsViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self.overrideClose, self)

		return {
			self.navigateView
		}
	end
end

return AbyssStageDetailsViewContainer
