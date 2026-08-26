-- chunkname: @modules/logic/character/view/CharacterTalentLevelUpViewContainer.lua

module("modules.logic.character.view.CharacterTalentLevelUpViewContainer", package.seeall)

local CharacterTalentLevelUpViewContainer = class("CharacterTalentLevelUpViewContainer", BaseViewContainer)

function CharacterTalentLevelUpViewContainer:buildViews()
	return {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_righttop"),
		CharacterTalentLevelUpView.New()
	}
end

function CharacterTalentLevelUpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Talent)

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		local currencyType = CurrencyEnum.CurrencyType
		local currencyParam = {
			currencyType.Gold
		}

		return {
			CurrencyView.New(currencyParam)
		}
	end
end

function CharacterTalentLevelUpViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

function CharacterTalentLevelUpViewContainer:playCloseTransition()
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_open)
	CharacterTalentLevelUpViewContainer.super.playCloseTransition(self, {
		anim = "charactertalentlevelup_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, self._head_close_ani1 or "2_1", not not self._head_close_ani1, self._head_close_ani2 or "ani_2_1", true)
end

return CharacterTalentLevelUpViewContainer
