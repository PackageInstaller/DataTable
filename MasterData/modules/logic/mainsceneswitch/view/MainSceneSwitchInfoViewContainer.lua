-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSwitchInfoViewContainer.lua

module("modules.logic.mainsceneswitch.view.MainSceneSwitchInfoViewContainer", package.seeall)

local MainSceneSwitchInfoViewContainer = class("MainSceneSwitchInfoViewContainer", BaseViewContainer)

function MainSceneSwitchInfoViewContainer:buildViews()
	local views = {}

	table.insert(views, MainSceneSwitchInfoDisplayView.New())
	table.insert(views, MainSceneSwitchInfoView.New())

	return views
end

function MainSceneSwitchInfoViewContainer:buildTabViews(tabContainerId)
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

return MainSceneSwitchInfoViewContainer
