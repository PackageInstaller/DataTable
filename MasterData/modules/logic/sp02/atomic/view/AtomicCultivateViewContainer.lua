-- chunkname: @modules/logic/sp02/atomic/view/AtomicCultivateViewContainer.lua

module("modules.logic.sp02.atomic.view.AtomicCultivateViewContainer", package.seeall)

local AtomicCultivateViewContainer = class("AtomicCultivateViewContainer", BaseViewContainer)

function AtomicCultivateViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicCultivateView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/module4/scroll_skilllist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/module4/scroll_skilllist/viewport/content/#go_list"
	scrollParam.cellClass = AtomicCultivateRowNodeItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 820
	scrollParam.cellHeight = 150
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(AtomicTalentViewModel.instance, scrollParam))

	return views
end

function AtomicCultivateViewContainer:buildTabViews(tabContainerId)
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

function AtomicCultivateViewContainer:playOpenTransition(paramTable)
	paramTable = paramTable or {}
	paramTable.noBlock = true

	AtomicCultivateViewContainer.super.playOpenTransition(self, paramTable)
end

return AtomicCultivateViewContainer
