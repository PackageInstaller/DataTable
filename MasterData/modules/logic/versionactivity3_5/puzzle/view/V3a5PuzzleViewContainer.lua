-- chunkname: @modules/logic/versionactivity3_5/puzzle/view/V3a5PuzzleViewContainer.lua

module("modules.logic.versionactivity3_5.puzzle.view.V3a5PuzzleViewContainer", package.seeall)

local V3a5PuzzleViewContainer = class("V3a5PuzzleViewContainer", BaseViewContainer)

function V3a5PuzzleViewContainer:buildViews()
	local views = {}

	self._puzzleView = V3a5PuzzleView.New()
	self._puzzleDialogView = V3a5PuzzleDialogView.New()

	table.insert(views, self._puzzleView)
	table.insert(views, self._puzzleDialogView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function V3a5PuzzleViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function V3a5PuzzleViewContainer:getPuzzleView()
	return self._puzzleView
end

function V3a5PuzzleViewContainer:getPuzzleDialogView()
	return self._puzzleDialogView
end

return V3a5PuzzleViewContainer
