-- chunkname: @modules/logic/weekwalk/view/WeekWalkRespawnViewContainer.lua

module("modules.logic.weekwalk.view.WeekWalkRespawnViewContainer", package.seeall)

local WeekWalkRespawnViewContainer = class("WeekWalkRespawnViewContainer", BaseViewContainer)

function WeekWalkRespawnViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_rolecontainer/#scroll_card"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = HeroGroupEditItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 290
	scrollParam.cellHeight = 550
	scrollParam.cellSpaceH = 48
	scrollParam.cellSpaceV = 30
	scrollParam.startSpace = 25

	return {
		LuaListScrollView.New(WeekWalkRespawnModel.instance, scrollParam),
		WeekWalkRespawnView.New()
	}
end

function WeekWalkRespawnViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return WeekWalkRespawnViewContainer
