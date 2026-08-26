-- chunkname: @modules/logic/player/view/PlayerViewContainer.lua

module("modules.logic.player.view.PlayerViewContainer", package.seeall)

local PlayerViewContainer = class("PlayerViewContainer", BaseViewContainer)

function PlayerViewContainer:buildViews()
	local views = {}

	table.insert(views, PlayerView.New())
	table.insert(views, PlayerViewAchievement.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function PlayerViewContainer:buildTabViews(tabContainerId)
	self.navigationView = self.viewParam and self.viewParam.hideHomeBtn and NavigateButtonsView.New({
		true,
		false,
		false
	}) or NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigationView
	}
end

function PlayerViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_Player_Interface_Close)
end

return PlayerViewContainer
