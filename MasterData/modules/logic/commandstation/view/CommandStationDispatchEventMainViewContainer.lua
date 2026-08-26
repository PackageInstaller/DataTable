-- chunkname: @modules/logic/commandstation/view/CommandStationDispatchEventMainViewContainer.lua

module("modules.logic.commandstation.view.CommandStationDispatchEventMainViewContainer", package.seeall)

local CommandStationDispatchEventMainViewContainer = class("CommandStationDispatchEventMainViewContainer", BaseViewContainer)

function CommandStationDispatchEventMainViewContainer:buildViews()
	local views = {}

	self._mainView = CommandStationDispatchEventMainView.New()

	table.insert(views, self._mainView)
	table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	table.insert(views, TabViewGroupFit.New(2, "#go_child"))

	return views
end

function CommandStationDispatchEventMainViewContainer:buildTabViews(tabContainerId)
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

	if tabContainerId == 2 then
		local t = {}

		t[CommandStationEnum.DispatchTabView.Normal] = CommandStationDispatchEventNormalView.New()

		local scrollParam = ListScrollParam.New()

		scrollParam.scrollGOPath = "#go_DispatchEvent/#go_DispatchPanel/Layout/left/#go_herocontainer/Mask/#scroll_hero"
		scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		scrollParam.prefabUrl = self._viewSetting.otherRes[1]
		scrollParam.cellClass = CommandStationDispatchEventProcessHeroItem
		scrollParam.scrollDir = ScrollEnum.ScrollDirV
		scrollParam.lineCount = 3
		scrollParam.cellWidth = 150
		scrollParam.cellHeight = 150
		scrollParam.cellSpaceH = 8
		scrollParam.cellSpaceV = 1
		scrollParam.startSpace = 20
		t[CommandStationEnum.DispatchTabView.Process] = MultiView.New({
			CommandStationDispatchEventProcessView.New(),
			LuaListScrollView.New(CommandStationHeroListModel.instance, scrollParam)
		})

		return t
	end
end

function CommandStationDispatchEventMainViewContainer:getCurrentEventConfig()
	return self._eventConfig
end

function CommandStationDispatchEventMainViewContainer:switchTab(tabId, eventConfig)
	self._eventConfig = eventConfig

	self:dispatchEvent(ViewEvent.ToSwitchTab, 2, tabId)
end

function CommandStationDispatchEventMainViewContainer:_navigateClose()
	self._mainView:checkClose()
end

return CommandStationDispatchEventMainViewContainer
