-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/FamilyUnitFactory.lua

module("logicscene.scene.component.factory.FamilyUnitFactory", package.seeall)

local FamilyUnitFactory = class("FamilyUnitFactory", CityUnitFactory)

function FamilyUnitFactory:createAllBuilding()
	local buildingList = {}

	buildingList[FamilyBuildingType.Welfare] = self:_createFamilyBuilding(FamilyBuildingType.Welfare)
	buildingList[FamilyBuildingType.Activities] = self:_createFamilyBuilding(FamilyBuildingType.Activities)
	buildingList[FamilyBuildingType.Transaction] = self:_createFamilyBuilding(FamilyBuildingType.Transaction)

	return buildingList
end

function FamilyUnitFactory:_createFamilyBuilding(buildingType)
	local unitGo = goutil.create("Building_" .. buildingType, false)
	local unit

	if buildingType == FamilyBuildingType.Welfare then
		unit = FamilyBuildingSceneUnit.New(unitGo)

		unit:setBoxColliderParam(Vector3.New(25, 25, 2), Vector3.New(-3, 12, 0))
	elseif buildingType == FamilyBuildingType.Activities then
		unit = FamilyBuildingSceneUnit.New(unitGo)

		unit:setBoxColliderParam(Vector3.New(50, 30, 2), Vector3.New(-8, -2, -5))
	elseif buildingType == FamilyBuildingType.Transaction then
		unit = FamilyBuildingSceneUnit.New(unitGo)

		unit:setBoxColliderParam(Vector3.New(20, 30, 2), Vector3.New(0, 3, 0))
	end

	goutil.addComponentOnce(unitGo, ComponentType.BoxCollider)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 1
	unit.id = -(1000 + buildingType)
	unit.type = buildingType

	self:addUnit(unit)

	return unit
end

function FamilyUnitFactory:createOtherPlayer(mo)
	local unitPlayer = self:getUnit(UnitTag.Player, mo.id)

	if not unitPlayer then
		self._scene.stage.wholeScene:CreatePlayer(mo.id, nil, mo.x, mo.z, mo.scale or FamilySceneMainPlayer.localScale, mo.boundX or 3, mo.boundY or 5)
	end
end

function FamilyUnitFactory:createOtherPlayerUnit(userId)
	local unitGo = goutil.create("Player_" .. userId, false)
	local unit = FamilyUnitOtherPlayer.New(unitGo)

	unit.scene = self._scene

	unit:Awake()

	unit.radius = 0.3
	unit.id = userId

	self:addUnit(unit)

	return unit
end

function FamilyUnitFactory:destroyOtherPlayer(playerId)
	self._scene.stage.wholeScene:DestroyPlayer(playerId)
end

return FamilyUnitFactory
