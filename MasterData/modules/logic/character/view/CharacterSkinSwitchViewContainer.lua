-- chunkname: @modules/logic/character/view/CharacterSkinSwitchViewContainer.lua

module("modules.logic.character.view.CharacterSkinSwitchViewContainer", package.seeall)

local CharacterSkinSwitchViewContainer = class("CharacterSkinSwitchViewContainer", BaseViewContainer)

function CharacterSkinSwitchViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterSkinSwitchView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(views, CharacterSkinSwitchSpineGCView.New())

	return views
end

function CharacterSkinSwitchViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigateView
	}
end

function CharacterSkinSwitchViewContainer:on()
	self.navigateView:resetOnCloseViewAudio(AudioEnum.UI.UI_role_skin_close)
end

return CharacterSkinSwitchViewContainer
