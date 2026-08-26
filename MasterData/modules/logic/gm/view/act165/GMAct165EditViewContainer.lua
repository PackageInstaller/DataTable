-- chunkname: @modules/logic/gm/view/act165/GMAct165EditViewContainer.lua

module("modules.logic.gm.view.act165.GMAct165EditViewContainer", package.seeall)

local GMAct165EditViewContainer = class("GMAct165EditViewContainer", BaseViewContainer)

function GMAct165EditViewContainer:buildViews()
	local views = {}

	table.insert(views, GMAct165EditView.New())
	table.insert(views, TabViewGroup.New(1, "#go_pre/#go_topleft"))

	return views
end

function GMAct165EditViewContainer:buildTabViews(tabContainerId)
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

return GMAct165EditViewContainer
