-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaStoryViewContainer.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaStoryViewContainer", package.seeall)

local JiaLaBoNaStoryViewContainer = class("JiaLaBoNaStoryViewContainer", BaseViewContainer)

function JiaLaBoNaStoryViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_ChapterList"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = JiaLaBoNaStoryViewItem.prefabPath
	scrollParam.cellClass = JiaLaBoNaStoryViewItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 500
	scrollParam.cellHeight = 720
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(JiaLaBoNaStoryListModel.instance, scrollParam))
	table.insert(views, JiaLaBoNaStoryView.New())

	self._storyReviewScene = Va3ChessStoryReviewScene.New()

	table.insert(views, self._storyReviewScene)

	return views
end

function JiaLaBoNaStoryViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

function JiaLaBoNaStoryViewContainer:buildTabViews(tabContainerId)
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

function JiaLaBoNaStoryViewContainer:_setVisible(isVisible)
	JiaLaBoNaStoryViewContainer.super._setVisible(self, isVisible)

	if self._storyReviewScene and self._storyReviewSceneVisible ~= isVisible then
		self._storyReviewSceneVisible = isVisible

		if isVisible then
			self._storyReviewScene:resetOpenAnim()
		end
	end
end

return JiaLaBoNaStoryViewContainer
