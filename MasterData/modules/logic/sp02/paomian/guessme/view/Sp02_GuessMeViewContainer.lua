-- chunkname: @modules/logic/sp02/paomian/guessme/view/Sp02_GuessMeViewContainer.lua

module("modules.logic.sp02.paomian.guessme.view.Sp02_GuessMeViewContainer", package.seeall)

local Sp02_GuessMeViewContainer = class("Sp02_GuessMeViewContainer", BaseViewContainer)

function Sp02_GuessMeViewContainer:buildViews()
	local views = {}

	table.insert(views, Sp02_GuessMeView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function Sp02_GuessMeViewContainer:buildTabViews(tabContainerId)
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

return Sp02_GuessMeViewContainer
