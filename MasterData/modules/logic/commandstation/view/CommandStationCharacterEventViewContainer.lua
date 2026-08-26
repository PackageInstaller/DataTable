-- chunkname: @modules/logic/commandstation/view/CommandStationCharacterEventViewContainer.lua

module("modules.logic.commandstation.view.CommandStationCharacterEventViewContainer", package.seeall)

local CommandStationCharacterEventViewContainer = class("CommandStationCharacterEventViewContainer", BaseViewContainer)

function CommandStationCharacterEventViewContainer:buildViews()
	local views = {}

	self._mainView = CommandStationCharacterEventView.New()

	table.insert(views, self._mainView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	return views
end

function CommandStationCharacterEventViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		self.navigateView:setOverrideClose(self._navigateClose, self)

		return {
			self.navigateView
		}
	end
end

function CommandStationCharacterEventViewContainer:_navigateClose()
	self._mainView:checkClose()
end

return CommandStationCharacterEventViewContainer
