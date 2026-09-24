-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView4_0_1Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView4_0_1Container", package.seeall)

local HandbookSkinSuitDetailView4_0_1Container = class("HandbookSkinSuitDetailView4_0_1Container", BaseViewContainer)

function HandbookSkinSuitDetailView4_0_1Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView4_0_1.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView4_0_1Container:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end
end

function HandbookSkinSuitDetailView4_0_1Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView4_0_1Container
