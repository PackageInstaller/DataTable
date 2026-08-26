-- chunkname: @modules/logic/handbook/view/HandbookCGViewContainer.lua

module("modules.logic.handbook.view.HandbookCGViewContainer", package.seeall)

local HandbookCGViewContainer = class("HandbookCGViewContainer", BaseViewContainer)

function HandbookCGViewContainer:buildViews()
	local views = {}
	local mixScrollParam = MixScrollParam.New()

	mixScrollParam.scrollGOPath = "#scroll_cg"
	mixScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	mixScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	mixScrollParam.cellClass = HandbookCGItem
	mixScrollParam.scrollDir = ScrollEnum.ScrollDirV
	self._csScrollView = LuaMixScrollView.New(HandbookCGTripleListModel.instance, mixScrollParam)

	table.insert(views, HandbookCGView.New())
	table.insert(views, self._csScrollView)
	table.insert(views, TabViewGroup.New(1, "#go_btns"))

	return views
end

function HandbookCGViewContainer:buildTabViews(tabContainerId)
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

function HandbookCGViewContainer:getCsScroll()
	return self._csScrollView
end

function HandbookCGViewContainer:onContainerOpenFinish()
	self.navigateView:resetCloseBtnAudioId(AudioEnum.UI.play_ui_screenplay_photo_close)
	self.navigateView:resetHomeBtnAudioId(AudioEnum.UI.play_ui_screenplay_photo_close)
end

return HandbookCGViewContainer
