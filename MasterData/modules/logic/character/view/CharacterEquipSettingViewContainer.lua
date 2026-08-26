-- chunkname: @modules/logic/character/view/CharacterEquipSettingViewContainer.lua

module("modules.logic.character.view.CharacterEquipSettingViewContainer", package.seeall)

local CharacterEquipSettingViewContainer = class("CharacterEquipSettingViewContainer", BaseViewContainer)

function CharacterEquipSettingViewContainer:buildViews()
	local views = {}
	local equipScrollParam = ListScrollParam.New()

	equipScrollParam.scrollGOPath = "#scroll_equip"
	equipScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	equipScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	equipScrollParam.cellClass = CharacterEquipSettingItem
	equipScrollParam.scrollDir = ScrollEnum.ScrollDirV
	equipScrollParam.lineCount = 3
	equipScrollParam.cellWidth = 228
	equipScrollParam.cellHeight = 218
	equipScrollParam.cellSpaceH = 0
	equipScrollParam.cellSpaceV = 2.22
	equipScrollParam.startSpace = 0

	table.insert(views, CharacterEquipSettingView.New())
	table.insert(views, LuaListScrollView.New(CharacterEquipSettingListModel.instance, equipScrollParam))

	return views
end

function CharacterEquipSettingViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return CharacterEquipSettingViewContainer
