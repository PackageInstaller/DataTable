-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyTrialViewContainer.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyTrialViewContainer", package.seeall)

local PartyGameLobbyTrialViewContainer = class("PartyGameLobbyTrialViewContainer", BaseViewContainer)

function PartyGameLobbyTrialViewContainer:buildViews()
	local views = {}

	table.insert(views, PartyGameLobbyTrialView.New())
	table.insert(views, TabViewGroup.New(1, "root/LeftTop"))

	return views
end

function PartyGameLobbyTrialViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navigateButtonView:setCloseCheck(self.closeCallback, self)

		return {
			navigateButtonView
		}
	end
end

function PartyGameLobbyTrialViewContainer:closeCallback()
	PartyGameTrialController.instance:exitTrialView()
	ViewMgr.instance:closeView(ViewName.PartyGameLobbyTrialView)
end

return PartyGameLobbyTrialViewContainer
