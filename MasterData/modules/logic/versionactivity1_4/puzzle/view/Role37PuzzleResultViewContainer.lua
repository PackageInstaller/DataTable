-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/Role37PuzzleResultViewContainer.lua

module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleResultViewContainer", package.seeall)

local Role37PuzzleResultViewContainer = class("Role37PuzzleResultViewContainer", BaseViewContainer)

function Role37PuzzleResultViewContainer:buildViews()
	local views = {}

	table.insert(views, Role37PuzzleResultView.New())

	return views
end

function Role37PuzzleResultViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return Role37PuzzleResultViewContainer
