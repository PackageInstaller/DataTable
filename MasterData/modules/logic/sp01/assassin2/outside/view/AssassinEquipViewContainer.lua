-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinEquipViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinEquipViewContainer", package.seeall)

local AssassinEquipViewContainer = class("AssassinEquipViewContainer", BaseViewContainer)

function AssassinEquipViewContainer:buildViews()
	local views = {}

	table.insert(views, AssassinEquipView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AssassinEquipViewContainer:buildTabViews(tabContainerId)
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

return AssassinEquipViewContainer
