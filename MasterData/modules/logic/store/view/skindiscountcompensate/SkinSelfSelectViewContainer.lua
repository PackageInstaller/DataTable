-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinSelfSelectViewContainer.lua

module("modules.logic.store.view.skindiscountcompensate.SkinSelfSelectViewContainer", package.seeall)

local SkinSelfSelectViewContainer = class("SkinSelfSelectViewContainer", SkinDiscountCompensateSelectViewContainer)

function SkinSelfSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, SkinSelfSelectView.New())

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_List"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll_List/Viewport/Content/#go_Item"
	scrollParam.cellClass = SkinSelfSelectItem
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

	self._scrollView = LuaListScrollViewWithAnimator.New(SkinSelfSelectListModel.instance, scrollParam, animTime)

	table.insert(views, self._scrollView)

	return views
end

return SkinSelfSelectViewContainer
