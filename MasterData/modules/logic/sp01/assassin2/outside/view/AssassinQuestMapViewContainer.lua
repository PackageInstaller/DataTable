-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinQuestMapViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinQuestMapViewContainer", package.seeall)

local AssassinQuestMapViewContainer = class("AssassinQuestMapViewContainer", BaseViewContainer)

function AssassinQuestMapViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	self.assassinMapView = AssassinQuestMapView.New()

	table.insert(views, self.assassinMapView)

	if isDebugBuild then
		table.insert(views, AssassinQuestMapEditView.New())
	end

	return views
end

function AssassinQuestMapViewContainer:buildTabViews(tabContainerId)
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

return AssassinQuestMapViewContainer
