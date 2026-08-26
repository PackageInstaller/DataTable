-- chunkname: @modules/logic/sp02/paomian/marcus/view/Sp02_MarcusViewContainer.lua

module("modules.logic.sp02.paomian.marcus.view.Sp02_MarcusViewContainer", package.seeall)

local Sp02_MarcusViewContainer = class("Sp02_MarcusViewContainer", BaseViewContainer)

function Sp02_MarcusViewContainer:buildViews()
	local views = {}

	table.insert(views, Sp02_MarcusView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Sp02_MarcusViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

return Sp02_MarcusViewContainer
