-- chunkname: @modules/logic/survival/view/shelter/SurvivalHardViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalHardViewContainer", package.seeall)

local SurvivalHardViewContainer = class("SurvivalHardViewContainer", BaseViewContainer)

function SurvivalHardViewContainer:buildViews()
	local views = {}
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Panel/Right/#scroll_List"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "Panel/Right/#scroll_List/Viewport/Content/#go_Item"
	scrollParam1.cellClass = SurvivalHardItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 1
	scrollParam1.cellWidth = 740
	scrollParam1.cellHeight = 150
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 0
	self.scrollView = LuaListScrollViewWithAnimator.New(SurvivalDifficultyModel.instance, scrollParam1)

	table.insert(views, self.scrollView)
	table.insert(views, SurvivalHardView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function SurvivalHardViewContainer:buildTabViews(tabContainerId)
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

return SurvivalHardViewContainer
