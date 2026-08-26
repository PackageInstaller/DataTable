-- chunkname: @modules/logic/character/view/CharacterExSkillViewContainer.lua

module("modules.logic.character.view.CharacterExSkillViewContainer", package.seeall)

local CharacterExSkillViewContainer = class("CharacterExSkillViewContainer", BaseViewContainer)

function CharacterExSkillViewContainer:buildViews()
	return {
		CharacterExSkillView.New(),
		TabViewGroup.New(1, "#go_btn"),
		CommonRainEffectView.New("bg/#go_glowcontainer")
	}
end

function CharacterExSkillViewContainer:buildTabViews(tabContainerId)
	self.navigateView = NavigateButtonsView.New({
		true,
		true,
		false
	})

	return {
		self.navigateView
	}
end

function CharacterExSkillViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.Play_ui_mould_close)
end

function CharacterExSkillViewContainer:hideHomeBtn()
	self.navigateView:setParam({
		true,
		false,
		false
	})
end

return CharacterExSkillViewContainer
