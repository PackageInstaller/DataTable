-- chunkname: @modules/logic/udimo/view/UdimoChangeDecorationViewContainer.lua

module("modules.logic.udimo.view.UdimoChangeDecorationViewContainer", package.seeall)

local UdimoChangeDecorationViewContainer = class("UdimoChangeDecorationViewContainer", BaseViewContainer)

function UdimoChangeDecorationViewContainer:buildViews()
	local views = {}

	self.decorationView = UdimoChangeDecorationView.New()

	table.insert(views, self.decorationView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function UdimoChangeDecorationViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

		return {
			self.navigateView
		}
	end
end

function UdimoChangeDecorationViewContainer:overrideCloseFunc()
	if self.decorationView then
		self.decorationView:onEscapeBtnClick()
	else
		self:closeThis()
	end
end

return UdimoChangeDecorationViewContainer
