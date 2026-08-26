-- chunkname: @modules/logic/lifecircle/view/LifeCircleRewardViewContainer.lua

module("modules.logic.lifecircle.view.LifeCircleRewardViewContainer", package.seeall)

local LifeCircleRewardViewContainer = class("LifeCircleRewardViewContainer", BaseViewContainer)

function LifeCircleRewardViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_Reward/#scroll_Reward"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = CommonPropListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 270
	scrollParam.cellHeight = 250
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 30
	scrollParam.startSpace = 0
	scrollParam.endSpace = 56

	return {
		LuaListScrollView.New(CommonPropListModel.instance, scrollParam),
		LifeCircleRewardView.New()
	}
end

return LifeCircleRewardViewContainer
