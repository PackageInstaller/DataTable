-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBackpackViewContainer.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBackpackViewContainer", package.seeall)

local AssassinBackpackViewContainer = class("AssassinBackpackViewContainer", BaseViewContainer)

function AssassinBackpackViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "root/#scroll_item/viewport/content/#go_item"
	scrollParam.cellClass = AssassinBackpackItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 230
	scrollParam.cellHeight = 230
	scrollParam.cellSpaceV = 40
	scrollParam.cellSpaceH = 40

	table.insert(views, LuaListScrollView.New(AssassinBackpackListModel.instance, scrollParam))
	table.insert(views, AssassinBackpackView.New())
	table.insert(views, TabViewGroup.New(1, "root/#go_topleft"))

	return views
end

function AssassinBackpackViewContainer:buildTabViews(tabContainerId)
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

return AssassinBackpackViewContainer
