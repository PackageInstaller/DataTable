-- chunkname: @modules/logic/season/view1_6/Season1_6EquipSelfChoiceViewContainer.lua

module("modules.logic.season.view1_6.Season1_6EquipSelfChoiceViewContainer", package.seeall)

local Season1_6EquipSelfChoiceViewContainer = class("Season1_6EquipSelfChoiceViewContainer", BaseViewContainer)

function Season1_6EquipSelfChoiceViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_6EquipTagSelect.New()

	filterView:init(Activity104EquipSelfChoiceController.instance, "root/#drop_filter", "#433834")

	return {
		Season1_6EquipSelfChoiceView.New(),
		filterView,
		LuaListScrollView.New(Activity104SelfChoiceListModel.instance, scrollParam)
	}
end

function Season1_6EquipSelfChoiceViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/mask/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_6EquipSelfChoiceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 180
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 7.4
	scrollParam.cellSpaceV = 32.5
	scrollParam.startSpace = 56

	return scrollParam
end

return Season1_6EquipSelfChoiceViewContainer
