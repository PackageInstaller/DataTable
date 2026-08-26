-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRevivalViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalViewContainer", package.seeall)

local V1a6_CachotRoleRevivalViewContainer = class("V1a6_CachotRoleRevivalViewContainer", BaseViewContainer)

function V1a6_CachotRoleRevivalViewContainer:buildViews()
	return {
		V1a6_CachotRoleRevivalView.New(),
		LuaListScrollView.New(V1a6_CachotRoleRevivalPrepareListModel.instance, self:_getPrepareListParam())
	}
end

function V1a6_CachotRoleRevivalViewContainer:_getPrepareListParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_tipswindow/scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[2]
	scrollParam.cellClass = V1a6_CachotRoleRevivalPrepareItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 4
	scrollParam.cellWidth = 624
	scrollParam.cellHeight = 192
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0
	scrollParam.endSpace = 0
	scrollParam.minUpdateCountInFrame = 100

	return scrollParam
end

return V1a6_CachotRoleRevivalViewContainer
