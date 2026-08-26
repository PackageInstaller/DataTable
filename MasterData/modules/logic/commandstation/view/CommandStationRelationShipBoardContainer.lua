-- chunkname: @modules/logic/commandstation/view/CommandStationRelationShipBoardContainer.lua

module("modules.logic.commandstation.view.CommandStationRelationShipBoardContainer", package.seeall)

local CommandStationRelationShipBoardContainer = class("CommandStationRelationShipBoardContainer", BaseViewContainer)

function CommandStationRelationShipBoardContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationRelationShipBoard.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	local fit = TabViewGroupFit.New(2, "#go_page")

	fit:keepCloseVisible(true)
	table.insert(views, fit)

	return views
end

function CommandStationRelationShipBoardContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self.navigateView
		}
	end

	if tabContainerId == 2 then
		return {
			CommandStationRelationShipBoardPage.New(CommandStationEnum.RelationShipBoardPage.Default),
			CommandStationRelationShipBoardPage2.New(CommandStationEnum.RelationShipBoardPage.Chapter13)
		}
	end
end

function CommandStationRelationShipBoardContainer:changePage(index)
	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, index)
end

return CommandStationRelationShipBoardContainer
