-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_1Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_1Container", package.seeall)

local HandbookSkinSuitDetailView2_1Container = class("HandbookSkinSuitDetailView2_1Container", BaseViewContainer)

function HandbookSkinSuitDetailView2_1Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView2_1.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView2_1Container:buildTabViews(tabContainerId)
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

function HandbookSkinSuitDetailView2_1Container:onContainerInit()
	return
end

function HandbookSkinSuitDetailView2_1Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView2_1Container
