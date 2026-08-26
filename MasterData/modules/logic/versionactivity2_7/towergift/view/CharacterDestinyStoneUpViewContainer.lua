-- chunkname: @modules/logic/versionactivity2_7/towergift/view/CharacterDestinyStoneUpViewContainer.lua

module("modules.logic.versionactivity2_7.towergift.view.CharacterDestinyStoneUpViewContainer", package.seeall)

local CharacterDestinyStoneUpViewContainer = class("CharacterDestinyStoneUpViewContainer", BaseViewContainer)

function CharacterDestinyStoneUpViewContainer:buildViews()
	local views = {}

	self._stoneView = CharacterDestinyStoneUpView.New()

	table.insert(views, self._stoneView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CharacterDestinyStoneUpViewContainer:buildTabViews(tabContainerId)
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

return CharacterDestinyStoneUpViewContainer
