-- chunkname: @modules/logic/versionactivity2_4/dungeon/view/sudoku/VersionActivity2_4SudokuViewContainer.lua

module("modules.logic.versionactivity2_4.dungeon.view.sudoku.VersionActivity2_4SudokuViewContainer", package.seeall)

local VersionActivity2_4SudokuViewContainer = class("VersionActivity2_4SudokuViewContainer", BaseViewContainer)

function VersionActivity2_4SudokuViewContainer:buildViews()
	local views = {}

	table.insert(views, VersionActivity2_4SudokuView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function VersionActivity2_4SudokuViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateView:setOverrideClose(self._overrideCloseAction, self)

		return {
			self.navigateView
		}
	end
end

function VersionActivity2_4SudokuViewContainer:_overrideCloseAction()
	VersionActivity2_4SudokuController.instance:setStatResult("break")
	VersionActivity2_4SudokuController.instance:sendStat()
	self:closeThis()
end

return VersionActivity2_4SudokuViewContainer
