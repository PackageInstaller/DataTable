-- chunkname: @modules/logic/character/view/CharacterTalentViewContainer.lua

module("modules.logic.character.view.CharacterTalentViewContainer", package.seeall)

local CharacterTalentViewContainer = class("CharacterTalentViewContainer", BaseViewContainer)

function CharacterTalentViewContainer:buildViews()
	self.talent_view = CharacterTalentView.New()

	return {
		TabViewGroup.New(1, "#go_btns"),
		self.talent_view
	}
end

function CharacterTalentViewContainer:buildTabViews(tabContainerId)
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

function CharacterTalentViewContainer:onContainerInit()
	HelpController.instance:registerCallback(HelpEvent.RefreshHelp, self._navigateButtonView.showHelpBtnIcon, self._navigateButtonView)
end

function CharacterTalentViewContainer:onContainerDestroy()
	HelpController.instance:unregisterCallback(HelpEvent.RefreshHelp, self._navigateButtonView.showHelpBtnIcon, self._navigateButtonView)
end

function CharacterTalentViewContainer:onContainerOpenFinish()
	self._navigateButtonView:resetOnCloseViewAudio(AudioEnum.Talent.play_ui_resonate_close)
end

function CharacterTalentViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

function CharacterTalentViewContainer:playCloseTransition()
	CharacterTalentViewContainer.super.playCloseTransition(self, {
		anim = "charactertalentup_out"
	})

	local head_ani = gohelper.findChildComponent(self.viewGO, "commen/rentouxiang/ani/tou/tou", typeof(UnityEngine.Animator))

	if head_ani then
		gohelper.setActive(gohelper.findChild(self.viewGO, "commen/rentouxiang/ani/tou/tou_in"), false)

		head_ani.enabled = true

		gohelper.setActive(head_ani.gameObject, true)
		head_ani:Play("0")
	end

	gohelper.findChildComponent(self.viewGO, "commen/rentouxiang/ani", typeof(UnityEngine.Animator)):Play("ani_0")
	gohelper.findChildComponent(self.viewGO, "#btn_chessboard", typeof(UnityEngine.Animator)):Play("chessboard_out")
	self.talent_view:playChessIconOutAni()
end

return CharacterTalentViewContainer
