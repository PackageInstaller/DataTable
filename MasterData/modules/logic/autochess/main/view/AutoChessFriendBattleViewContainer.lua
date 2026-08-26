-- chunkname: @modules/logic/autochess/main/view/AutoChessFriendBattleViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessFriendBattleViewContainer", package.seeall)

local AutoChessFriendBattleViewContainer = class("AutoChessFriendBattleViewContainer", BaseViewContainer)

function AutoChessFriendBattleViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessFriendBattleView.New())
	table.insert(views, TabViewGroup.New(1, "go_topleft"))

	return views
end

function AutoChessFriendBattleViewContainer:buildTabViews(tabContainerId)
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

function AutoChessFriendBattleViewContainer:overrideClose()
	AutoChessController.instance:openMainView()
	self:closeThis()
end

return AutoChessFriendBattleViewContainer
