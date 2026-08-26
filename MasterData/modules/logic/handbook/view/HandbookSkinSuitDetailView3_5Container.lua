-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitDetailView3_5Container.lua

module("modules.logic.handbook.view.HandbookSkinSuitDetailView3_5Container", package.seeall)

local HandbookSkinSuitDetailView3_5Container = class("HandbookSkinSuitDetailView3_5Container", BaseViewContainer)

function HandbookSkinSuitDetailView3_5Container:buildViews()
	local views = {}

	table.insert(views, HandbookSkinSuitDetailView3_5.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookSkinSuitDetailView3_5Container:buildTabViews(tabContainerId)
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

function HandbookSkinSuitDetailView3_5Container:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.Play_UI_CloseHouse)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.UI_checkpoint_story_close)
end

return HandbookSkinSuitDetailView3_5Container
