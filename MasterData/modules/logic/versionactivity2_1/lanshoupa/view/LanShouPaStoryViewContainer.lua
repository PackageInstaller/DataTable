-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaStoryViewContainer.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaStoryViewContainer", package.seeall)

local LanShouPaStoryViewContainer = class("LanShouPaStoryViewContainer", BaseViewContainer)

function LanShouPaStoryViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_ChapterList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = LanShouPaStoryViewItem.prefabPath
	scrollParam.cellClass = LanShouPaStoryViewItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 500
	scrollParam.cellHeight = 720
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(LanShouPaStoryListModel.instance, scrollParam))
	table.insert(views, LanShouPaStoryView.New())

	return views
end

function LanShouPaStoryViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function LanShouPaStoryViewContainer:buildTabViews(tabContainerId)
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

return LanShouPaStoryViewContainer
