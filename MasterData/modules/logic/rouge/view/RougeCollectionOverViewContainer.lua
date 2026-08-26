-- chunkname: @modules/logic/rouge/view/RougeCollectionOverViewContainer.lua

module("modules.logic.rouge.view.RougeCollectionOverViewContainer", package.seeall)

local RougeCollectionOverViewContainer = class("RougeCollectionOverViewContainer", BaseViewContainer)

function RougeCollectionOverViewContainer:buildViews()
	self._scrollView = self:buildScrollView()

	return {
		TabViewGroup.New(1, "#go_lefttop"),
		TabViewGroup.New(2, "#go_rougemapdetailcontainer"),
		RougeCollectionOverView.New(),
		self._scrollView
	}
end

local rowDelayShowTime = 0.06

function RougeCollectionOverViewContainer:buildScrollView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_view/Viewport/Content/#go_collectionitem"
	scrollParam.cellClass = RougeCollectionOverListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 620
	scrollParam.cellHeight = 190
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = -6
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0

	local animationDelayTimes = {}
	local row = 5

	for i = 1, row do
		for j = 1, scrollParam.lineCount do
			local index = (i - 1) * scrollParam.lineCount + j

			animationDelayTimes[index] = i * rowDelayShowTime
		end
	end

	return (LuaListScrollViewWithAnimator.New(RougeCollectionOverListModel.instance, scrollParam, animationDelayTimes))
end

function RougeCollectionOverViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == 2 then
		return {
			RougeCollectionDetailBtnComp.New()
		}
	end
end

return RougeCollectionOverViewContainer
