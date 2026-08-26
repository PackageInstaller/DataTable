-- chunkname: @modules/logic/item/view/ItemTalentHeroUpViewContainer.lua

module("modules.logic.item.view.ItemTalentHeroUpViewContainer", package.seeall)

local ItemTalentHeroUpViewContainer = class("ItemTalentHeroUpViewContainer", BaseViewContainer)

function ItemTalentHeroUpViewContainer:buildViews()
	return {
		ItemTalentHeroUpView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function ItemTalentHeroUpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	end
end

function ItemTalentHeroUpViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

function ItemTalentHeroUpViewContainer:playCloseTransition()
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_success_close)
	ItemTalentHeroUpViewContainer.super.playCloseTransition(self, {
		anim = "charactertalentlevelupresult_out"
	})
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentLevelUpViewInAni)
end

return ItemTalentHeroUpViewContainer
