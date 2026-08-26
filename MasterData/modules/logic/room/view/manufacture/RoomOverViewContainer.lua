-- chunkname: @modules/logic/room/view/manufacture/RoomOverViewContainer.lua

module("modules.logic.room.view.manufacture.RoomOverViewContainer", package.seeall)

local RoomOverViewContainer = class("RoomOverViewContainer", BaseViewContainer)
local TabGroup = {
	Navigate = 1,
	SubView = 2
}

RoomOverViewContainer.SubViewTabId = {
	Manufacture = 1,
	Transport = 2
}

function RoomOverViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomOverView.New())
	table.insert(views, TabViewGroup.New(TabGroup.Navigate, "#go_BackBtns"))
	table.insert(views, TabViewGroup.New(TabGroup.SubView, "#go_subView"))

	return views
end

function RoomOverViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == TabGroup.Navigate then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	elseif tabContainerId == TabGroup.SubView then
		local manufactureOverView = RoomManufactureOverView.New()

		return {
			manufactureOverView,
			RoomTransportOverView.New()
		}
	end
end

function RoomOverViewContainer:onContainerInit()
	if not self.viewParam then
		return
	end

	self.viewParam.defaultTabIds = {}
	self.viewParam.defaultTabIds[TabGroup.SubView] = self:getDefaultSelectedTab()

	self:setContainerViewBuildingUid()
end

function RoomOverViewContainer:getDefaultSelectedTab()
	if self.viewParam then
		local paramTabId = self.viewParam.defaultTab
		local checkResult = self:checkTabId(paramTabId)

		return (checkResult or nil) and paramTabId
	end
end

function RoomOverViewContainer:checkTabId(argsTabId)
	local result = false

	if argsTabId then
		for _, tabId in pairs(RoomCritterBuildingViewContainer.SubViewTabId) do
			if tabId == argsTabId then
				result = true

				break
			end
		end
	end

	return result
end

function RoomOverViewContainer:switchTab(tabId)
	local checkResult = self:checkTabId(tabId)

	if not checkResult then
		return
	end

	self:dispatchEvent(ViewEvent.ToSwitchTab, TabGroup.SubView, tabId)
end

function RoomOverViewContainer:setContainerViewBuildingUid(buildingUid)
	self._viewBuildingUid = buildingUid
end

function RoomOverViewContainer:getContainerViewBuilding(nilError)
	local viewBuildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._viewBuildingUid)

	if not viewBuildingMO and nilError then
		logError(string.format("RoomOverViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", self._viewBuildingUid))
	end

	return self._viewBuildingUid, viewBuildingMO
end

function RoomOverViewContainer:onContainerClose()
	self:setContainerViewBuildingUid()
end

return RoomOverViewContainer
