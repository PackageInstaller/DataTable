-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureBuildingViewContainer.lua

module("modules.logic.room.view.manufacture.RoomManufactureBuildingViewContainer", package.seeall)

local RoomManufactureBuildingViewContainer = class("RoomManufactureBuildingViewContainer", BaseViewContainer)

function RoomManufactureBuildingViewContainer:buildViews()
	local views = {}

	table.insert(views, RoomManufactureBuildingView.New())
	table.insert(views, TabViewGroup.New(1, "#go_BackBtns"))
	table.insert(views, TabViewGroup.New(2, "go_detailBanner"))

	return views
end

function RoomManufactureBuildingViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		}, nil, self._closeCallback, nil, nil, self)

		return {
			self.navigateView
		}
	elseif tabContainerId == 2 then
		self.detailBanner = RoomManufactureBuildingDetailBanner.New()

		return {
			self.detailBanner
		}
	end
end

function RoomManufactureBuildingViewContainer:_closeCallback()
	ManufactureController.instance:resetCameraOnCloseView()
end

function RoomManufactureBuildingViewContainer:onContainerInit()
	self:setContainerViewBuildingUid()
end

function RoomManufactureBuildingViewContainer:onContainerClose()
	self:setContainerViewBuildingUid()
end

function RoomManufactureBuildingViewContainer:setContainerViewBuildingUid(buildingUid)
	self._viewBuildingUid = buildingUid
end

function RoomManufactureBuildingViewContainer:getContainerViewBuilding(nilError)
	local viewBuildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._viewBuildingUid)

	if not viewBuildingMO and nilError then
		logError(string.format("RoomManufactureBuildingViewContainer:getContainerViewBuilding error, buildingMO is nil, uid:%s", self._viewBuildingUid))
	end

	return self._viewBuildingUid, viewBuildingMO
end

return RoomManufactureBuildingViewContainer
