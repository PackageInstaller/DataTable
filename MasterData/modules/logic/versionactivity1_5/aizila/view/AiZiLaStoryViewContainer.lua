-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaStoryViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaStoryViewContainer", package.seeall)

local AiZiLaStoryViewContainer = class("AiZiLaStoryViewContainer", BaseViewContainer)

function AiZiLaStoryViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_ChapterList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = AiZiLaStoryItem.prefabPath
	scrollParam.cellClass = AiZiLaStoryItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 500
	scrollParam.cellHeight = 720
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(AiZiLaStoryListModel.instance, scrollParam))
	table.insert(views, AiZiLaStoryView.New())

	return views
end

function AiZiLaStoryViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function AiZiLaStoryViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return AiZiLaStoryViewContainer
