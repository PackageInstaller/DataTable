-- chunkname: @modules/logic/survival/view/shelter/SurvivalBootyChooseViewContainer.lua

module("modules.logic.survival.view.shelter.SurvivalBootyChooseViewContainer", package.seeall)

local SurvivalBootyChooseViewContainer = class("SurvivalBootyChooseViewContainer", BaseViewContainer)

function SurvivalBootyChooseViewContainer:buildViews()
	local scrollParam1 = ListScrollParam.New()

	scrollParam1.scrollGOPath = "Panel/#go_npcselect/#scroll_List"
	scrollParam1.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam1.prefabUrl = "Panel/#go_npcselect/#scroll_List/Viewport/Content/#go_SmallItem"
	scrollParam1.cellClass = SurvivalBootyChooseNpcItem
	scrollParam1.scrollDir = ScrollEnum.ScrollDirV
	scrollParam1.lineCount = 3
	scrollParam1.cellWidth = 200
	scrollParam1.cellHeight = 280
	scrollParam1.cellSpaceH = 0
	scrollParam1.cellSpaceV = 0
	scrollParam1.startSpace = 0
	self.scrollView = LuaListScrollViewWithAnimator.New(SurvivalShelterChooseNpcListModel.instance, scrollParam1)
	self._survivalBootyChooseView = SurvivalBootyChooseView.New()

	return {
		self._survivalBootyChooseView,
		self.scrollView
	}
end

function SurvivalBootyChooseViewContainer:refreshNpcChooseView()
	if self._survivalBootyChooseView then
		self._survivalBootyChooseView:_refreshNpcSelectPanel()
	end
end

return SurvivalBootyChooseViewContainer
