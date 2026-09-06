-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/model/building/ZooBuildingFactory.lua

module("logic.extensions.zoo.model.building.ZooBuildingFactory", package.seeall)

local ZooBuildingFactory = {}

function ZooBuildingFactory.createBuilding(zooMo, buildingType)
	local buiding

	if buildingType == ZooBuildingType.Main then
		buiding = ZooBuildingMainMO.New()
	elseif buildingType == ZooBuildingType.Restaurant then
		buiding = ZooBuildingRestaurantMO.New()
	elseif buildingType == ZooBuildingType.Shop then
		buiding = ZooBuildingShopMO.New()
	elseif buildingType == ZooBuildingType.Cafe then
		buiding = ZooBuildingCafeMO.New()
	elseif buildingType == ZooBuildingType.AmusementPark then
		buiding = ZooBuildingAmusementParkMO.New()
	elseif buildingType == ZooBuildingType.FossilQuarry then
		buiding = ZooBuildingFossilQuarryMO.New()
	elseif buildingType == ZooBuildingType.Tree then
		buiding = ZooBuildingTreeMO.New()
	elseif buildingType == ZooBuildingType.EggsMachine then
		buiding = ZooBuildingEggsMachineMO.New()
	elseif buildingType == ZooBuildingType.TransPoint then
		buiding = ZooBuildingTransPointMO.New()
	elseif buildingType == ZooBuildingType.Traveler then
		buiding = ZooBuildingTravelerMO.New()
	elseif buildingType == ZooBuildingType.Pool then
		buiding = ZooBuildingPoolMO.New()
	elseif buildingType == ZooBuildingType.TransDoor then
		buiding = ZooBuildingTransDoorMO.New()
	end

	buiding.buildingCo = ZooConfig.instance:getBuildingCoByBuildingType(buildingType)
	buiding.zooMo = zooMo

	return buiding
end

return ZooBuildingFactory
