-- chunkname: @modules/logic/teach/view/TeachNoteViewContainer.lua

module("modules.logic.teach.view.TeachNoteViewContainer", package.seeall)

local TeachNoteViewContainer = class("TeachNoteViewContainer", BaseViewContainer)

function TeachNoteViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_reward/#scroll_rewarditem"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = TeachNoteRewardListItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 620
	scrollParam.cellHeight = 81
	scrollParam.cellSpaceH = 50
	scrollParam.cellSpaceV = 0
	scrollParam.minUpdateCountInFrame = 10

	table.insert(views, LuaListScrollView.New(TeachNoteRewardListModel.instance, scrollParam))
	table.insert(views, TabViewGroup.New(1, "#go_btns"))
	table.insert(views, TeachNoteView.New())

	return views
end

function TeachNoteViewContainer:buildTabViews(tabContainerId)
	self.navigationView = NavigateButtonsView.New({
		true,
		false,
		true
	}, 116, self._closeCallback, nil, nil, self)

	return {
		self.navigationView
	}
end

function TeachNoteViewContainer:_closeCallback()
	TeachNoteModel.instance:setJumpEpisodeId(nil)

	JumpModel.instance.jumpFromFightSceneParam = nil

	TeachNoteModel.instance:setJumpEnter(false)
end

function TeachNoteViewContainer:onContainerOpenFinish()
	self.navigationView:resetOnCloseViewAudio(AudioEnum.TeachNote.play_ui_closehouse)
end

return TeachNoteViewContainer
