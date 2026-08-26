-- chunkname: @modules/logic/commandstation/view/CommandStationDispatchEventProcessViewContainer.lua

module("modules.logic.commandstation.view.CommandStationDispatchEventProcessViewContainer", package.seeall)

local CommandStationDispatchEventProcessViewContainer = class("CommandStationDispatchEventProcessViewContainer", BaseViewContainer)

function CommandStationDispatchEventProcessViewContainer:buildViews()
	local views = {}

	table.insert(views, CommandStationDispatchEventProcessView.New())
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer/Mask/#scroll_hero"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = CommandStationDispatchEventProcessHeroItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 3
	scrollParam.cellWidth = 136
	scrollParam.cellHeight = 136
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 0

	table.insert(views, LuaListScrollView.New(CommandStationHeroListModel.instance, scrollParam))

	return views
end

function CommandStationDispatchEventProcessViewContainer:buildTabViews(tabContainerId)
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
end

return CommandStationDispatchEventProcessViewContainer
