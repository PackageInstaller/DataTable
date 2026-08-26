-- chunkname: @modules/logic/versionactivity3_6/puzzle/view/V3a6PuzzleViewContainer.lua

module("modules.logic.versionactivity3_6.puzzle.view.V3a6PuzzleViewContainer", package.seeall)

local V3a6PuzzleViewContainer = class("V3a6PuzzleViewContainer", BaseViewContainer)

function V3a6PuzzleViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a6PuzzleView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_contentroot"))

	return views
end

function V3a6PuzzleViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	else
		self._characterDialogComp = CharacterDialogComp.New()

		return {
			self._characterDialogComp
		}
	end
end

function V3a6PuzzleViewContainer:startDialog(groupId)
	self._characterDialogComp:startDialog(groupId)
end

function V3a6PuzzleViewContainer:finishDialog(groupId)
	return
end

return V3a6PuzzleViewContainer
