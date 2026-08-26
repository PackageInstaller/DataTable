-- chunkname: @modules/logic/versionactivity3_6/yami/view/handbook/V3a6YaMiProductHandbookViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.handbook.V3a6YaMiProductHandbookViewContainer", package.seeall)

local V3a6YaMiProductHandbookViewContainer = class("V3a6YaMiProductHandbookViewContainer", BaseViewContainer)

function V3a6YaMiProductHandbookViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/scroll_productslist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V3a6YaMiProductHandBookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 220
	scrollParam.cellHeight = 200
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 10
	self._scrollview = LuaListScrollView.New(V3a6YaMiProductHandbookListModel.instance, scrollParam)

	table.insert(views, self._scrollview)
	table.insert(views, V3a6YaMiProductHandbookView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/#go_panel"))
	table.insert(views, TabViewGroup.New(3, "root/#go_fundingitem"))

	return views
end

function V3a6YaMiProductHandbookViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self.detailView = V3a6YaMiProductHandbookDetailView.New()

		return {
			self.detailView
		}
	elseif tabContainerId == 3 then
		self.currencyView = V3a6YaMiCurrencyView.New()

		return {
			self.currencyView
		}
	end
end

return V3a6YaMiProductHandbookViewContainer
