-- chunkname: @modules/logic/abyss/view/AbyssMainViewContainer.lua

module("modules.logic.abyss.view.AbyssMainViewContainer", package.seeall)

local AbyssMainViewContainer = class("AbyssMainViewContainer", BaseViewContainer)

function AbyssMainViewContainer:buildViews()
	local views = {}
	local mainView = AbyssMainView.New()

	self.mainView = mainView

	table.insert(views, mainView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function AbyssMainViewContainer:buildTabViews(tabContainerId)
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

function AbyssMainViewContainer:overrideClose()
	self.mainView:onClickClose()
end

return AbyssMainViewContainer
