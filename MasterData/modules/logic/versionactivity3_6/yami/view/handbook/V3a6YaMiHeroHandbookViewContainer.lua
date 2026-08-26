-- chunkname: @modules/logic/versionactivity3_6/yami/view/handbook/V3a6YaMiHeroHandbookViewContainer.lua

module("modules.logic.versionactivity3_6.yami.view.handbook.V3a6YaMiHeroHandbookViewContainer", package.seeall)

local V3a6YaMiHeroHandbookViewContainer = class("V3a6YaMiHeroHandbookViewContainer", BaseViewContainer)

function V3a6YaMiHeroHandbookViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/scroll_employeelist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V3a6YaMiHeroHandBookItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = V3a6YaMiEnum.HeroHandbookRowCount
	scrollParam.cellWidth = 275
	scrollParam.cellHeight = V3a6YaMiEnum.HeroHandbookItemHight
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 10
	self._scrollview = LuaListScrollView.New(V3a6YaMiHeroHandbookListModel.instance, scrollParam)

	table.insert(views, self._scrollview)
	table.insert(views, V3a6YaMiHeroHandbookView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "root/#go_panel"))
	table.insert(views, TabViewGroup.New(3, "root/#go_fundingitem"))

	return views
end

function V3a6YaMiHeroHandbookViewContainer:buildTabViews(tabContainerId)
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
		self.detailView = V3a6YaMiHeroHandbookDetailView.New()

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

function V3a6YaMiHeroHandbookViewContainer:isForceHideUnlockBtn()
	return true
end

return V3a6YaMiHeroHandbookViewContainer
