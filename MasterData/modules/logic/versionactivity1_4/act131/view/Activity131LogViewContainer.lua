-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131LogViewContainer.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131LogViewContainer", package.seeall)

local Activity131LogViewContainer = class("Activity131LogViewContainer", BaseViewContainer)

function Activity131LogViewContainer:buildViews()
	local views = {}
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_log"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = Activity131LogItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(Activity131LogListModel.instance, scrollParam))
	table.insert(views, Activity131LogView.New())

	return views
end

return Activity131LogViewContainer
