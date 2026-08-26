-- chunkname: @modules/logic/teaching/view/TeachingEnterViewContainer.lua

module("modules.logic.teaching.view.TeachingEnterViewContainer", package.seeall)

local TeachingEnterViewContainer = class("TeachingEnterViewContainer", BaseViewContainer)

function TeachingEnterViewContainer:buildViews()
	local views = {}

	table.insert(views, TeachingEnterView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topLeft"))

	return views
end

function TeachingEnterViewContainer:buildTabViews(tabContainerId)
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

return TeachingEnterViewContainer
