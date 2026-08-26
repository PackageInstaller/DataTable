-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6LevelViewContainer.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6LevelViewContainer", package.seeall)

local LengZhou6LevelViewContainer = class("LengZhou6LevelViewContainer", BaseViewContainer)

function LengZhou6LevelViewContainer:buildViews()
	return {
		LengZhou6LevelView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function LengZhou6LevelViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigationView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigationView:setOverrideClose(self._overrideClose, self)

		return {
			self.navigationView
		}
	end
end

return LengZhou6LevelViewContainer
