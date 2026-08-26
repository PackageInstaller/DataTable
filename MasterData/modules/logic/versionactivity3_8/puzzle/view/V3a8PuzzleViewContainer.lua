-- chunkname: @modules/logic/versionactivity3_8/puzzle/view/V3a8PuzzleViewContainer.lua

module("modules.logic.versionactivity3_8.puzzle.view.V3a8PuzzleViewContainer", package.seeall)

local V3a8PuzzleViewContainer = class("V3a8PuzzleViewContainer", BaseViewContainer)

function V3a8PuzzleViewContainer:buildViews()
	local views = {}

	self._puzzleView = V3a8PuzzleView.New()

	table.insert(views, self._puzzleView)
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))
	table.insert(views, TabViewGroup.New(2, "#go_contentroot"))

	return views
end

function V3a8PuzzleViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self.overrideCloseFunc, self)

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

function V3a8PuzzleViewContainer:overrideCloseFunc()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	self._animPlayer:Play("close", self.closeThis, self)
end

function V3a8PuzzleViewContainer:initDialogFinish()
	if self._puzzleView.initDialogFinish then
		self._puzzleView:initDialogFinish()
	end
end

function V3a8PuzzleViewContainer:startDialog(groupId)
	self._characterDialogComp:startDialog(groupId)
end

function V3a8PuzzleViewContainer:finishDialog(groupId)
	if self._puzzleView.finishDialog then
		self._puzzleView:finishDialog(groupId)
	end
end

return V3a8PuzzleViewContainer
