-- chunkname: @modules/logic/versionactivity1_4/act133/view/Activity133ViewContainer.lua

module("modules.logic.versionactivity1_4.act133.view.Activity133ViewContainer", package.seeall)

local Activity133ViewContainer = class("Activity133ViewContainer", BaseViewContainer)
local navigatetionview = 1
local currencyview = 2

function Activity133ViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Activity133ListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 268
	scrollParam.cellHeight = 650
	scrollParam.cellSpaceH = 30
	scrollParam.startSpace = 20
	scrollParam.endSpace = 20

	local animationDelayTimes = {}

	for i = 1, 4 do
		animationDelayTimes[i] = (i - 1) * 0.06
	end

	self._scrollview = LuaListScrollViewWithAnimator.New(Activity133ListModel.instance, scrollParam, animationDelayTimes)

	table.insert(views, self._scrollview)
	table.insert(views, Activity133View.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_topright"))

	return views
end

function Activity133ViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == navigatetionview then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == currencyview then
		local currencyType = CurrencyEnum.CurrencyType
		local currencyParam = currencyType.Act133

		self._currencyView = CurrencyView.New({
			currencyParam
		})
		self._currencyView.foreHideBtn = true

		return {
			self._currencyView
		}
	end
end

return Activity133ViewContainer
