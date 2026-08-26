-- chunkname: @modules/logic/handbook/view/HandBookCharacterSwitchViewContainer.lua

module("modules.logic.handbook.view.HandBookCharacterSwitchViewContainer", package.seeall)

local HandBookCharacterSwitchViewContainer = class("HandBookCharacterSwitchViewContainer", BaseViewContainer)

function HandBookCharacterSwitchViewContainer:buildViews()
	local views = {}

	self.navigateHandleView = HandBookCharacterNavigateHandleView.New()

	table.insert(views, self.navigateHandleView)
	table.insert(views, HandBookCharacterSwitchView.New())
	table.insert(views, HandBookCharacterView.New())
	table.insert(views, HandBookCharacterSwitchViewEffect.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandBookCharacterSwitchViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self.navigateHandleView.onCloseBtnClick, self.navigateHandleView)

		return {
			self.navigateView
		}
	end
end

function HandBookCharacterSwitchViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandBookCharacterSwitchViewContainer
