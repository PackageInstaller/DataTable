-- chunkname: @modules/logic/sp02/atomic/view/AtomicDataBaseViewContainer.lua

module("modules.logic.sp02.atomic.view.AtomicDataBaseViewContainer", package.seeall)

local AtomicDataBaseViewContainer = class("AtomicDataBaseViewContainer", BaseViewContainer)

function AtomicDataBaseViewContainer:buildViews()
	local views = {}

	table.insert(views, AtomicDataBaseView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll_cultural"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/#scroll_cultural/viewport/content/#go_culturalitem"
	scrollParam.cellClass = AtomicDataBaseItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1340
	scrollParam.cellHeight = 270
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 10
	scrollParam.startSpace = 20

	local delayTimes = {}

	for i = 1, 5 do
		table.insert(delayTimes, 0)
	end

	table.insert(views, LuaListScrollViewWithAnimator.New(AtomicDataBaseViewModel.instance, scrollParam, delayTimes))

	return views
end

function AtomicDataBaseViewContainer:buildTabViews(tabContainerId)
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

return AtomicDataBaseViewContainer
