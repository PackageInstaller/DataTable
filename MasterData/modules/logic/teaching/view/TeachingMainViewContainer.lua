-- chunkname: @modules/logic/teaching/view/TeachingMainViewContainer.lua

module("modules.logic.teaching.view.TeachingMainViewContainer", package.seeall)

local TeachingMainViewContainer = class("TeachingMainViewContainer", BaseViewContainer)

function TeachingMainViewContainer:buildViews()
	local views = {}

	table.insert(views, TeachingMainView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function TeachingMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

return TeachingMainViewContainer
