-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinDiscountCompensateSelectViewContainer.lua

module("modules.logic.store.view.skindiscountcompensate.SkinDiscountCompensateSelectViewContainer", package.seeall)

local SkinDiscountCompensateSelectViewContainer = class("SkinDiscountCompensateSelectViewContainer", BaseViewContainer)

function SkinDiscountCompensateSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, SkinDiscountCompensateSelectView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_List"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_List/Viewport/Content/#go_Item"
	scrollParam.cellClass = SkinDiscountCompensateSelectItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 420
	scrollParam.cellHeight = 800
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 50
	scrollParam.endSpace = 50

	local animTime = {}

	for i = 1, 10 do
		animTime[i] = i * 0.05
	end

	self._scrollView = LuaListScrollViewWithAnimator.New(SkinDiscountCompensateListModel.instance, scrollParam, animTime)

	table.insert(views, self._scrollView)

	return views
end

return SkinDiscountCompensateSelectViewContainer
