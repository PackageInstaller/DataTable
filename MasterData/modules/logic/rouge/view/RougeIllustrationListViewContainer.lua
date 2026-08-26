-- chunkname: @modules/logic/rouge/view/RougeIllustrationListViewContainer.lua

module("modules.logic.rouge.view.RougeIllustrationListViewContainer", package.seeall)

local RougeIllustrationListViewContainer = class("RougeIllustrationListViewContainer", BaseViewContainer)

function RougeIllustrationListViewContainer:buildViews()
	local views = {}

	table.insert(views, RougeIllustrationListView.New())
	table.insert(views, RougeScrollAudioView.New("#scroll_view"))
	table.insert(views, TabViewGroup.New(1, "#go_LeftTop"))

	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = RougeIllustrationListPage
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 120
	self._scrollView = LuaMixScrollView.New(RougeIllustrationListModel.instance, scrollParam)

	table.insert(views, self._scrollView)

	return views
end

function RougeIllustrationListViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

return RougeIllustrationListViewContainer
