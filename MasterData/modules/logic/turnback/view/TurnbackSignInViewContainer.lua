-- chunkname: @modules/logic/turnback/view/TurnbackSignInViewContainer.lua

module("modules.logic.turnback.view.TurnbackSignInViewContainer", package.seeall)

local TurnbackSignInViewContainer = class("TurnbackSignInViewContainer", BaseViewContainer)

function TurnbackSignInViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_daylist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TurnbackSignInItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 600
	scrollParam.cellSpaceH = 5
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.frameUpdateMs = 100
	self._scrollView = LuaListScrollView.New(TurnbackSignInModel.instance, scrollParam)
	self._scrollParam = scrollParam

	return {
		self._scrollView,
		TurnbackSignInView.New()
	}
end

return TurnbackSignInViewContainer
