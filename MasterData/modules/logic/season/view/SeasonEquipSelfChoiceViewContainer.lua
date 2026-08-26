-- chunkname: @modules/logic/season/view/SeasonEquipSelfChoiceViewContainer.lua

module("modules.logic.season.view.SeasonEquipSelfChoiceViewContainer", package.seeall)

local SeasonEquipSelfChoiceViewContainer = class("SeasonEquipSelfChoiceViewContainer", BaseViewContainer)

function SeasonEquipSelfChoiceViewContainer:buildViews()
	local scrollParam = self:createEquipItemsParam()

	return {
		SeasonEquipSelfChoiceView.New(),
		LuaListScrollView.New(Activity104SelfChoiceListModel.instance, scrollParam)
	}
end

function SeasonEquipSelfChoiceViewContainer:createEquipItemsParam()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/mask/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = SeasonEquipSelfChoiceItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 7
	scrollParam.cellWidth = 197
	scrollParam.cellHeight = 272
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 1.67

	return scrollParam
end

return SeasonEquipSelfChoiceViewContainer
