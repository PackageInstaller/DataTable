-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/PetZooSceneUnitFactory.lua

module("logicscene.scene.component.factory.PetZooSceneUnitFactory", package.seeall)

local PetZooSceneUnitFactory = class("PetZooSceneUnitFactory", CityUnitFactory)

function PetZooSceneUnitFactory:createPetZooUnit(itemId)
	local unitGo = goutil.create(UnitTag.SceneElement .. itemId, false)
	local unit = UnitPetZooElem.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 1
	unit.id = itemId

	self:addUnit(unit)

	return unit
end

function PetZooSceneUnitFactory:destryPetZooUnit(itemId)
	self:removeUnit(UnitTag.SceneElement, itemId)
end

function PetZooSceneUnitFactory:createPetZooBuilding(itemId)
	local buildingCo = ZooConfig.instance:getBuildingCo(itemId)

	if not buildingCo or buildingCo.buildingType == ZooBuildingType.None then
		return
	end

	local unitGo = goutil.create(UnitTag.SceneElement .. itemId, false)
	local unit

	if buildingCo.buildingType == ZooBuildingType.Main then
		unit = UnitZooBuildingMainCity.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.Restaurant then
		unit = UnitZooBuildingRestaurant.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.Shop then
		unit = UnitZooBuildingShop.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.Cafe then
		unit = UnitZooBuildingCafe.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.AmusementPark then
		unit = UnitZooBuildingAmusementPark.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.FossilQuarry then
		unit = UnitZooBuildingFossilQuarry.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.Tree then
		unit = UnitZooBuildingTree.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.EggsMachine then
		unit = UnitZooBuildingEggsMachine.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.TransPoint then
		unit = UnitZooBuildingTransPoint.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.Traveler then
		unit = UnitZooBuildingTraveler.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.Pool then
		unit = UnitZooBuildingPool.New(unitGo)
	elseif buildingCo.buildingType == ZooBuildingType.TransDoor then
		unit = UnitZooBuildingTransDoor.New(unitGo)
	end

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 1
	unit.id = itemId

	self:addUnit(unit)

	return unit
end

function PetZooSceneUnitFactory:destryZooBuilding(itemId)
	self:removeUnit(UnitTag.SceneElement, itemId)
end

return PetZooSceneUnitFactory
