-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/CruiseGameMainViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.CruiseGameMainViewContainer", package.seeall)

local CruiseGameMainViewContainer = class("CruiseGameMainViewContainer", BaseViewContainer)

function CruiseGameMainViewContainer:buildViews()
	return {
		CruiseGameMainView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function CruiseGameMainViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		}, nil)

		return {
			self.navigateButtonView
		}
	end
end

return CruiseGameMainViewContainer
