-- chunkname: @modules/logic/survival/view/shelter/ShelterNpcManagerViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterNpcManagerViewContainer", package.seeall)

local ShelterNpcManagerViewContainer = class("ShelterNpcManagerViewContainer", BaseViewContainer)

function ShelterNpcManagerViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Panel/Left/#scroll_List"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "Panel/Left/#scroll_List/Viewport/Content/#go_Item"
	scrollParam1.cellClass = ShelterNpcManagerItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 1120
	scrollParam1.cellHeight = 300
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 0
	self.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterNpcListModel.instance, scrollParam1)
	self.managerView = ShelterNpcManagerView.New()

	table.insert(views, self.scrollView)
	table.insert(views, self.managerView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, ShelterCurrencyView.New({
		SurvivalEnum.CurrencyType.Food
	}, "Panel/#go_topright"))

	return views
end

function ShelterNpcManagerViewContainer:refreshManagerView()
	if not self.managerView then
		return
	end

	self.managerView:refreshView()
end

function ShelterNpcManagerViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			navView
		}
	end
end

return ShelterNpcManagerViewContainer
