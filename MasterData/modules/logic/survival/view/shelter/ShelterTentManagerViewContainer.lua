-- chunkname: @modules/logic/survival/view/shelter/ShelterTentManagerViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterTentManagerViewContainer", package.seeall)

local ShelterTentManagerViewContainer = class("ShelterTentManagerViewContainer", BaseViewContainer)

function ShelterTentManagerViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Panel/#go_SelectPanel/#scroll_List"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "Panel/#go_SelectPanel/#scroll_List/Viewport/Content/#go_SmallItem"
	scrollParam1.cellClass = ShelterTentManagerNpcItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 3
	scrollParam1.cellWidth = 200
	scrollParam1.cellHeight = 280
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 0
	self.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterTentListModel.instance, scrollParam1)
	self.managerView = ShelterTentManagerView.New()

	table.insert(views, self.scrollView)
	table.insert(views, self.managerView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, ShelterCurrencyView.New({
		SurvivalEnum.CurrencyType.Build
	}, "Panel/#go_topright"))

	return views
end

function ShelterTentManagerViewContainer:refreshManagerSelectPanel()
	if not self.managerView then
		return
	end

	self.managerView:refreshSelectPanel()
end

function ShelterTentManagerViewContainer:buildTabViews(tabContainerId)
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

return ShelterTentManagerViewContainer
