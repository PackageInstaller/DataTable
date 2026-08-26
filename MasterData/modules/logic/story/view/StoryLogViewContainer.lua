-- chunkname: @modules/logic/story/view/StoryLogViewContainer.lua

module("modules.logic.story.view.StoryLogViewContainer", package.seeall)

local StoryLogViewContainer = class("StoryLogViewContainer", BaseViewContainer)

function StoryLogViewContainer:buildViews()
	local views = {}
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_log"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = StoryLogItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(StoryLogListModel.instance, scrollParam))
	table.insert(views, StoryLogView.New())

	return views
end

return StoryLogViewContainer
