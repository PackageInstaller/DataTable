-- chunkname: @modules/logic/versionactivity1_4/act136/view/Activity136ChoiceViewContainer.lua

module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceViewContainer", package.seeall)

local Activity136ChoiceViewContainer = class("Activity136ChoiceViewContainer", BaseViewContainer)

function Activity136ChoiceViewContainer:buildViews()
	local views = {}
	local listScrollParam = ListScrollParam.New()

	listScrollParam.scrollGOPath = "root/#scroll_item"
	listScrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	listScrollParam.prefabUrl = self._viewSetting.otherRes[1]
	listScrollParam.cellClass = Activity136ChoiceItem
	listScrollParam.scrollDir = ScrollEnum.ScrollDirV
	listScrollParam.lineCount = 6
	listScrollParam.cellWidth = 200
	listScrollParam.cellHeight = 225
	listScrollParam.cellSpaceH = 30
	listScrollParam.startSpace = 10

	table.insert(views, Activity136ChoiceView.New())
	table.insert(views, LuaListScrollView.New(Activity136ChoiceViewListModel.instance, listScrollParam))

	return views
end

function Activity136ChoiceViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return Activity136ChoiceViewContainer
