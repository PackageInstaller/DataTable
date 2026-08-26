-- chunkname: @modules/logic/season/view1_4/Season1_4EquipSelfChoiceViewContainer.lua

module("modules.logic.season.view1_4.Season1_4EquipSelfChoiceViewContainer", package.seeall)

local Season1_4EquipSelfChoiceViewContainer = class("Season1_4EquipSelfChoiceViewContainer", BaseViewContainer)

function Season1_4EquipSelfChoiceViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()
	local filterView = Season1_4EquipTagSelect.New()

	filterView:init(Activity104EquipSelfChoiceController.instance, "root/#drop_filter", "#433834")

	return {
		Season1_4EquipSelfChoiceView.New(),
		filterView,
		LuaListScrollView.New(Activity104SelfChoiceListModel.instance, scrollParam)
	}
end

function Season1_4EquipSelfChoiceViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/mask/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Season1_4EquipSelfChoiceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 5
	scrollParam.cellWidth = 180
	scrollParam.cellHeight = 235
	scrollParam.cellSpaceH = 7.4
	scrollParam.cellSpaceV = 32.5
	scrollParam.startSpace = 56

	return scrollParam
end

return Season1_4EquipSelfChoiceViewContainer
