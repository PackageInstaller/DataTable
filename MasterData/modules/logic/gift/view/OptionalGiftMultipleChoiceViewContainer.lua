-- chunkname: @modules/logic/gift/view/OptionalGiftMultipleChoiceViewContainer.lua

module("modules.logic.gift.view.OptionalGiftMultipleChoiceViewContainer", package.seeall)

local OptionalGiftMultipleChoiceViewContainer = class("OptionalGiftMultipleChoiceViewContainer", BaseViewContainer)

function OptionalGiftMultipleChoiceViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "root/#scroll_item"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = GiftMultipleChoiceListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 6
	scrollParam.cellWidth = 200
	scrollParam.cellHeight = 275
	scrollParam.cellSpaceH = 41
	scrollParam.cellSpaceV = 56
	scrollParam.startSpace = 11

	table.insert(views, LuaListScrollView.New(GiftMultipleChoiceListModel.instance, scrollParam))
	table.insert(views, OptionalGiftMultipleChoiceView.New())

	return views
end

return OptionalGiftMultipleChoiceViewContainer
