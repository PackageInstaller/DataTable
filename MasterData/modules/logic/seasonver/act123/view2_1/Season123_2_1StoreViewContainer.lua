-- chunkname: @modules/logic/seasonver/act123/view2_1/Season123_2_1StoreViewContainer.lua

module("modules.logic.seasonver.act123.view2_1.Season123_2_1StoreViewContainer", package.seeall)

local Season123_2_1StoreViewContainer = class("Season123_2_1StoreViewContainer", BaseViewContainer)

function Season123_2_1StoreViewContainer:buildViews()
	self:buildScrollViews()

	local views = {}

	table.insert(views, self.scrollView)
	table.insert(views, Season123_2_1StoreView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, TabViewGroup.New(2, "#go_righttop"))

	return views
end

function Season123_2_1StoreViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if tabContainerId == 2 then
		local actId = Season123Model.instance:getCurSeasonId() or VersionActivity2_1Enum.ActivityId.Season
		local storeCoinId = Season123Config.instance:getSeasonConstNum(actId, Activity123Enum.Const.StoreCoinId)
		local currencyview = CurrencyView.New({
			storeCoinId
		})

		currencyview.foreHideBtn = true

		return {
			currencyview
		}
	end
end

function Season123_2_1StoreViewContainer:buildScrollViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "mask/#scroll_store"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season123_2_1StoreItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 356
	scrollParam.cellHeight = 376
	scrollParam.cellSpaceH = 4.26
	scrollParam.cellSpaceV = 15.73
	scrollParam.startSpace = 39
	scrollParam.frameUpdateMs = 100
	self.scrollView = LuaListScrollView.New(Season123StoreModel.instance, scrollParam)
end

return Season123_2_1StoreViewContainer
