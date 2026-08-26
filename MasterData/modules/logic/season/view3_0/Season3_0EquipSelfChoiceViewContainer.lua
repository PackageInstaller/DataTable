-- chunkname: @modules/logic/season/view3_0/Season3_0EquipSelfChoiceViewContainer.lua

module("modules.logic.season.view3_0.Season3_0EquipSelfChoiceViewContainer", package.seeall)

local Season3_0EquipSelfChoiceViewContainer = class("Season3_0EquipSelfChoiceViewContainer", BaseViewContainer)

function Season3_0EquipSelfChoiceViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season3_0EquipTagSelect.New()

	filterView:init(Activity104EquipSelfChoiceController.instance, "root/#drop_filter", "#433834")

	return {
		Season3_0EquipSelfChoiceView.New(),
		filterView,
		LuaListScrollView.New(Activity104SelfChoiceListModel.instance, scrollParam)
	}
end

function Season3_0EquipSelfChoiceViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/mask/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season3_0EquipSelfChoiceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 180
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 7.4
	scrollParam.cellSpaceV = 32.5
	scrollParam.startSpace = 56

	return scrollParam
end

return Season3_0EquipSelfChoiceViewContainer
