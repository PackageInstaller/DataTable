-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessStoryViewContainer.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryViewContainer", package.seeall)

local Activity1_3ChessStoryViewContainer = class("Activity1_3ChessStoryViewContainer", BaseViewContainer)

function Activity1_3ChessStoryViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_ChapterList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = Activity1_3ChessStoryViewItem.prefabPath
	scrollParam.cellClass = Activity1_3ChessStoryViewItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 500
	scrollParam.cellHeight = 720
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(Activity122StoryListModel.instance, scrollParam))
	table.insert(views, Activity1_3ChessStoryView.New())

	self._storyReviewScene = Va3ChessStoryReviewScene.New()

	table.insert(views, self._storyReviewScene)

	return views
end

function Activity1_3ChessStoryViewContainer:onContainerInit()
	Activity1_3ChessController.instance:setReviewStory(true)
end

function Activity1_3ChessStoryViewContainer:onContainerClose()
	Activity1_3ChessController.instance:setReviewStory(false)
end

function Activity1_3ChessStoryViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function Activity1_3ChessStoryViewContainer:buildTabViews(tabContainerId)
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

function Activity1_3ChessStoryViewContainer:_setVisible(isVisible)
	Activity1_3ChessStoryViewContainer.super._setVisible(self, isVisible)

	if self._storyReviewScene and self._storyReviewSceneVisible ~= isVisible then
		self._storyReviewSceneVisible = isVisible

		if isVisible then
			self._storyReviewScene:resetOpenAnim()
		end
	end
end

return Activity1_3ChessStoryViewContainer
