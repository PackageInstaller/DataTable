-- chunkname: @modules/logic/equip/view/EquipSkillTipViewContainer.lua

module("modules.logic.equip.view.EquipSkillTipViewContainer", package.seeall)

local EquipSkillTipViewContainer = class("EquipSkillTipViewContainer", BaseViewContainer)

function EquipSkillTipViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_character/#scroll_character"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = EquipSkillCharacterItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 150
	scrollParam.cellHeight = 190
	scrollParam.cellSpaceH = 24.1
	scrollParam.cellSpaceV = 19.5
	scrollParam.startSpace = 0

	return {
		LuaListScrollView.New(EquipSkillCharacterListModel.instance, scrollParam),
		EquipSkillTipView.New()
	}
end

return EquipSkillTipViewContainer
