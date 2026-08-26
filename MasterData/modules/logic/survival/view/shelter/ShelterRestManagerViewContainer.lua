-- chunkname: @modules/logic/survival/view/shelter/ShelterRestManagerViewContainer.lua

module("modules.logic.survival.view.shelter.ShelterRestManagerViewContainer", package.seeall)

local ShelterRestManagerViewContainer = class("ShelterRestManagerViewContainer", BaseViewContainer)

function ShelterRestManagerViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Panel/Right/#go_Rest/Scroll View"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam1.prefabUrl = self._viewSetting.otherRes.itemRes
	scrollParam1.cellClass = ShelterRestHeroItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirH
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 240
	scrollParam1.cellHeight = 600
	scrollParam1.cellSpaceH = 30
	scrollParam1.startSpace = 10
	self.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterRestListModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, ShelterRestManagerView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, ShelterCurrencyView.New({
		SurvivalEnum.CurrencyType.Build
	}, "Panel/#go_topright"))

	return views
end

function ShelterRestManagerViewContainer:buildTabViews(tabContainerId)
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

return ShelterRestManagerViewContainer
