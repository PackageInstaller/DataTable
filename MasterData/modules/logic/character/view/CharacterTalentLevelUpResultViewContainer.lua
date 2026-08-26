-- chunkname: @modules/logic/character/view/CharacterTalentLevelUpResultViewContainer.lua

module("modules.logic.character.view.CharacterTalentLevelUpResultViewContainer", package.seeall)

local CharacterTalentLevelUpResultViewContainer = class("CharacterTalentLevelUpResultViewContainer", BaseViewContainer)

function CharacterTalentLevelUpResultViewContainer:buildViews()
	return {
		CharacterTalentLevelUpResultView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function CharacterTalentLevelUpResultViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Talent)

		return {
			self._navigateButtonView
		}
	end
end

function CharacterTalentLevelUpResultViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

function CharacterTalentLevelUpResultViewContainer:playCloseTransition()
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_success_close)
	CharacterTalentLevelUpResultViewContainer.super.playCloseTransition(self, {
		anim = "charactertalentlevelupresult_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentLevelUpViewInAni)
end

return CharacterTalentLevelUpResultViewContainer
