-- chunkname: @modules/logic/equip/view/EquipChooseViewContainer.lua

module("modules.logic.equip.view.EquipChooseViewContainer", package.seeall)

local EquipChooseViewContainer = class("EquipChooseViewContainer", BaseViewContainer)

function EquipChooseViewContainer:buildViews()
	local equipScrollParam = ListScrollParam.New()

	equipScrollParam.scrollGOPath = "#scroll_equip"
	equipScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	equipScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	equipScrollParam.cellClass = EquipChooseItem
	equipScrollParam.scrollDir = ScrollEnum.ScrollDirV
	equipScrollParam.lineCount = 4
	equipScrollParam.cellWidth = 232
	equipScrollParam.cellHeight = 232
	equipScrollParam.cellSpaceH = 15
	equipScrollParam.cellSpaceV = 15
	equipScrollParam.startSpace = 60

	return {
		LuaListScrollView.New(EquipChooseListModel.instance, equipScrollParam),
		EquipChooseView.New()
	}
end

return EquipChooseViewContainer
