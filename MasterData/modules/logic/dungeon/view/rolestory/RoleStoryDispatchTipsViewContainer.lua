-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchTipsViewContainer.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTipsViewContainer", package.seeall)

local RoleStoryDispatchTipsViewContainer = class("RoleStoryDispatchTipsViewContainer", BaseViewContainer)

function RoleStoryDispatchTipsViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Layout/left/#go_herocontainer/Mask/#scroll_hero"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "Layout/left/#go_herocontainer/Mask/#scroll_hero/Viewport/Content/#go_heroitem"
	scrollParam1.cellClass = RoleStoryDispatchLeftHeroItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 4
	scrollParam1.cellWidth = 130
	scrollParam1.cellHeight = 130
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 12
	self.scrollView = LuaListScrollViewWithAnimator.New(RoleStoryDispatchHeroListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, RoleStoryDispatchTipsView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topright"))

	return views
end

function RoleStoryDispatchTipsViewContainer:buildTabViews(tabContainerId)
	local currencyParam = {
		{
			isIcon = true,
			type = MaterialEnum.MaterialType.Item,
			id = CommonConfig.instance:getConstNum(ConstEnum.RoleStoryActivityItemId)
		}
	}

	self.currencyView = CurrencyView.New(currencyParam)
	self.currencyView.foreHideBtn = true

	return {
		self.currencyView
	}
end

return RoleStoryDispatchTipsViewContainer
