-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/Role37PuzzleViewContainer.lua

module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleViewContainer", package.seeall)

local Role37PuzzleViewContainer = class("Role37PuzzleViewContainer", BaseViewContainer)

function Role37PuzzleViewContainer:buildViews()
	local views = {}
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "Record/#scroll_record"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "Record/#scroll_record/Viewport/Content/RecordItem"
	scrollParam.cellClass = PuzzleRecordItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV

	table.insert(views, LuaMixScrollView.New(PuzzleRecordMixListModel.instance, scrollParam))
	table.insert(views, Role37PuzzleView.New())
	table.insert(views, TabViewGroup.New(1, "top_left"))

	return views
end

function Role37PuzzleViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			true
		})

		self._navigateButtonView:setOverrideClose(self.overrideCloseFunc, self)
		self._navigateButtonView:setHelpId(HelpEnum.HelpId.Role37PuzzleViewHelp)

		return {
			self._navigateButtonView
		}
	end
end

function Role37PuzzleViewContainer:overrideCloseFunc()
	GameFacade.showMessageBox(MessageBoxIdDefine.Activity130PuzzleExit, MsgBoxEnum.BoxType.Yes_No, self.closeFunc, nil, nil, self)
end

function Role37PuzzleViewContainer:closeFunc()
	self:closeThis()
end

function Role37PuzzleViewContainer:onContainerInit()
	Activity130Rpc.instance:addGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
end

return Role37PuzzleViewContainer
