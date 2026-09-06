-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/CutePetUnitFactory.lua

module("logicscene.scene.component.factory.CutePetUnitFactory", package.seeall)

local CutePetUnitFactory = class("CutePetUnitFactory", CityUnitFactory)

function CutePetUnitFactory:createAllBuilding()
	local buildingList = {}

	buildingList[CutePetBuildingType.Management] = self:_createPetZooBuilding(CutePetBuildingType.Management)
	buildingList[CutePetBuildingType.Shop] = self:_createPetZooBuilding(CutePetBuildingType.Shop)
	buildingList[CutePetBuildingType.Travel] = self:_createPetZooBuilding(CutePetBuildingType.Travel)
	buildingList[CutePetBuildingType.Guest] = self:_createPetZooBuilding(CutePetBuildingType.Guest)
	buildingList[CutePetBuildingType.Adventure] = self:_createPetZooBuilding(CutePetBuildingType.Adventure)

	return buildingList
end

function CutePetUnitFactory:_createPetZooBuilding(typeId)
	local unitGo = goutil.create("Building_" .. typeId, false)
	local unit

	if typeId == CutePetBuildingType.Management then
		unit = UnitCutePetBuildingBase.New(unitGo)
	elseif typeId == CutePetBuildingType.Travel then
		unit = UnitCutePetBuildingBase.New(unitGo)
	elseif typeId == CutePetBuildingType.Adventure then
		unit = UnitCutePetBuildingBase.New(unitGo)
	elseif typeId == CutePetBuildingType.Shop then
		unit = UnitCutePetBuildingBase.New(unitGo)
	elseif typeId == CutePetBuildingType.Guest then
		unit = UnitCutePetBuildingBase.New(unitGo)
	end

	goutil.addComponentOnce(unitGo, ComponentType.BoxCollider)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 1
	unit.id = -(1000 + typeId)
	unit.type = typeId

	self:addUnit(unit)

	return unit
end

function CutePetUnitFactory:destryZooBuilding(itemId)
	self:removeUnit(UnitTag.SceneElement, itemId)
end

function CutePetUnitFactory:createPetUnit(insId, itemId)
	local unitGo = goutil.create("UnitCutePet_" .. insId, false)

	goutil.addComponentOnce(unitGo, ComponentType.BoxCollider)
	GameUtil.setLocalRotation(unitGo, 0, 0, 0)

	local unit = UnitCutePet.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 1
	unit.id = insId
	unit.petId = itemId

	self:addUnit(unit)

	return unit
end

function CutePetUnitFactory:createTravelCutePet(insId, raceId)
	local unitGo = goutil.create("UnitTravelCutePet_" .. insId, false)

	GameUtil.setLocalRotation(unitGo, 0, 0, 0)

	local unit = UnitTravelCutePet.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 1
	unit.id = insId
	unit.petId = raceId

	self:addUnit(unit)

	return unit
end

return CutePetUnitFactory
