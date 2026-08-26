-- chunkname: @modules/logic/skin/view/SkinOffsetAdjustViewContainer.lua

module("modules.logic.skin.view.SkinOffsetAdjustViewContainer", package.seeall)

local SkinOffsetAdjustViewContainer = class("SkinOffsetAdjustViewContainer", BaseViewContainer)

function SkinOffsetAdjustViewContainer:buildViews()
	local views = {}

	self.skinOffsetAdjustView = SkinOffsetAdjustView.New()

	table.insert(views, self.skinOffsetAdjustView)

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_container/component/#go_skincontainer/#scroll_skin"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SkinOffsetSkinItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 512
	scrollParam.cellHeight = 40
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 2
	scrollParam.startSpace = 8

	table.insert(views, LuaListScrollView.New(SkinOffsetSkinListModel.instance, scrollParam))

	return views
end

return SkinOffsetAdjustViewContainer
