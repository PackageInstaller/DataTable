-- chunkname: @modules/logic/character/view/CharacterTalentChessFilterViewContainer.lua

module("modules.logic.character.view.CharacterTalentChessFilterViewContainer", package.seeall)

local CharacterTalentChessFilterViewContainer = class("CharacterTalentChessFilterViewContainer", BaseViewContainer)

function CharacterTalentChessFilterViewContainer:buildViews()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "container/Scroll View"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "container/Scroll View/Viewport/Content/#go_item"
	scrollParam.cellClass = CharacterTalentChessFilterItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 646
	scrollParam.cellHeight = 162
	scrollParam.cellSpaceV = 0

	local scrollView = LuaListScrollView.New(TalentStyleListModel.instance, scrollParam)

	return {
		scrollView,
		CharacterTalentChessFilterView.New()
	}
end

return CharacterTalentChessFilterViewContainer
