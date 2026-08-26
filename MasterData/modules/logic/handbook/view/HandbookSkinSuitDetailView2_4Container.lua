-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView2_4Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView2_4Container", package.seeall)

local HandbookSkinSuitDetailView2_4Container = class("HandbookSkinSuitDetailView2_4Container", BaseViewContainer)

function HandbookSkinSuitDetailView2_4Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView2_4.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView2_4Container:buildTabViews(tabContainerId)
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

function HandbookSkinSuitDetailView2_4Container:onContainerInit()
	return
end

function HandbookSkinSuitDetailView2_4Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView2_4Container
