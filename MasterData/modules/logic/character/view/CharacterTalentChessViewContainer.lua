-- chunkname: @modules/logic/character/view/CharacterTalentChessViewContainer.lua

module("modules.logic.character.view.CharacterTalentChessViewContainer", package.seeall)

local CharacterTalentChessViewContainer = class("CharacterTalentChessViewContainer", BaseViewContainer)

function CharacterTalentChessViewContainer:buildViews()
	self.chess_view = CharacterTalentChessView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		self.chess_view
	}
end

function CharacterTalentChessViewContainer:buildTabViews(tabContainerId)
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

function CharacterTalentChessViewContainer:onContainerInit()
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self._navigateButtonView.showHelpBtnIcon, self._navigateButtonView)
end

function CharacterTalentChessViewContainer:onContainerDestroy()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self._navigateButtonView.showHelpBtnIcon, self._navigateButtonView)
end

function CharacterTalentChessViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.UI.play_ui_checkpoint_click)
end

function CharacterTalentChessViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

function CharacterTalentChessViewContainer:playCloseTransition()
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_close)
	CharacterTalentChessViewContainer.super.playCloseTransition(self, {
		anim = "charactertalentchess_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "3_1", false, "ani_3_1", true)
	self.chess_view:playChessIconOutAni()
end

return CharacterTalentChessViewContainer
