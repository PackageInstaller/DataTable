-- chunkname: @modules/logic/herogroup/view/EnemyInfoViewContainer.lua

module("modules.logic.herogroup.view.EnemyInfoViewContainer", package.seeall)

local EnemyInfoViewContainer = class("EnemyInfoViewContainer", BaseViewContainer)

function EnemyInfoViewContainer:buildViews()
	return {
		EnemyInfoView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function EnemyInfoViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigationView
		}
	end
end

function EnemyInfoViewContainer:onContainerOpenFinish()
	self.navigationView:resetCloseBtnAudioId(AudioEnum.HeroGroupUI.Play_UI_Action_Return)
end

return EnemyInfoViewContainer
