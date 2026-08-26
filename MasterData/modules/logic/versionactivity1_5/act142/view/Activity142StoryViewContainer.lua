-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142StoryViewContainer.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142StoryViewContainer", package.seeall)

local Activity142StoryViewContainer = class("Activity142StoryViewContainer", BaseViewContainer)

function Activity142StoryViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#simage_blackbg/#scroll_storylist"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#simage_blackbg/#go_storyitem"
	scrollParam.cellClass = Activity142StoryItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.cellWidth = 690
	scrollParam.cellHeight = 750
	scrollParam.cellSpaceH = 178

	table.insert(views, LuaListScrollView.New(Activity142StoryListModel.instance, scrollParam))
	table.insert(views, Activity142StoryView.New())

	return views
end

function Activity142StoryViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function Activity142StoryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

return Activity142StoryViewContainer
