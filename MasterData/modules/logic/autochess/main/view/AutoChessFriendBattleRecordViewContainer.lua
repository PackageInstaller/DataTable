-- chunkname: @modules/logic/autochess/main/view/AutoChessFriendBattleRecordViewContainer.lua

module("modules.logic.autochess.main.view.AutoChessFriendBattleRecordViewContainer", package.seeall)

local AutoChessFriendBattleRecordViewContainer = class("AutoChessFriendBattleRecordViewContainer", BaseViewContainer)

function AutoChessFriendBattleRecordViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessFriendBattleRecordView.New())
	table.insert(views, TabViewGroup.New(1, "go_topleft"))

	return views
end

function AutoChessFriendBattleRecordViewContainer:buildTabViews(tabContainerId)
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

return AutoChessFriendBattleRecordViewContainer
