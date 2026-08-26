-- chunkname: @modules/logic/commonprop/view/CommonPropViewContainer.lua

module("modules.logic.commonprop.view.CommonPropViewContainer", package.seeall)

local CommonPropViewContainer = class("CommonPropViewContainer", BaseViewContainer)

function CommonPropViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = CommonPropListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 270
	scrollParam.cellHeight = 250
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 50
	scrollParam.startSpace = 35
	scrollParam.endSpace = 56

	table.insert(views, LuaListScrollView.New(CommonPropListModel.instance, scrollParam))
	table.insert(views, CommonPropView.New())
	table.insert(views, TabViewGroup.New(2))

	return views
end

function CommonPropViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 2 then
		self._useTipsView = CommonPropUseTipsView.New()

		return {
			self._useTipsView
		}
	end
end

function CommonPropViewContainer:getUseTipsView()
	return self._useTipsView
end

return CommonPropViewContainer
