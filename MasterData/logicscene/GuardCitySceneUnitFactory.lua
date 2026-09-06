-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/GuardCitySceneUnitFactory.lua

module("logicscene.scene.component.factory.GuardCitySceneUnitFactory", package.seeall)

local GuardCitySceneUnitFactory = class("GuardCitySceneUnitFactory", CityUnitFactory)

function GuardCitySceneUnitFactory:createCustomUnit(itemId, resPath, posx, posy)
	local insId = self:generateObjectInstanceId()

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.Untagged, insId, itemId, resPath, posx, posy, 2, 2, 1, false, "common_unit", 0)

	local unit = self:getUnit(UnitTag.Untagged, insId)

	unit.itemId = itemId

	unit.transform:setMoveSpeed(0)

	return unit
end

function GuardCitySceneUnitFactory:createCommonObjectUnit(tag, insId, itemId, usrData)
	if usrData == "common_unit" then
		local unitGo = goutil.create("custom_" .. insId, false)
		local unit = UnitTreasureRaiderCustom.New(unitGo)

		unit.scene = self._scene
		unit.radius = 1
		unit.id = insId

		unit:Awake()
		self:addUnit(unit)

		return unit
	end

	return GuardCitySceneUnitFactory.super.createCommonObjectUnit(self, tag, insId, itemId, usrData)
end

function GuardCitySceneUnitFactory:createGridUnit(elementId, row, col)
	local unitGo = goutil.create("grid_unit_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitGuardCityGrid.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.row = row
	unit.col = col
	unit.id = elementId

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function GuardCitySceneUnitFactory:generateGridElem(elementId, row, col)
	local unitGo = goutil.create("grid_elem_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitGuardCityGridElem.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = elementId
	unit.row = row
	unit.col = col

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function GuardCitySceneUnitFactory:generateGridMyCityElem(elementId, row, col)
	local unitGo = goutil.create("grid_city_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitGuardCityMyCity.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = elementId
	unit.row = row
	unit.col = col

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function GuardCitySceneUnitFactory:showUnit(tag, id, show)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	local sameUnits = self._units[tag]

	if sameUnits then
		local unit = sameUnits[id]

		if unit then
			local bMyPet = unit:getTag() == UnitTag.Pet and unit:getOwner() == mainPlayer

			if bMyPet then
				unit:setVisible(false)
			else
				unit:setVisible(show)
			end
		end
	end
end

function GuardCitySceneUnitFactory:showUnits(show)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	for k, v in pairs(self._units) do
		local sameUnits = v

		for k2, v2 in pairs(sameUnits) do
			local bMyPet = v2:getTag() == UnitTag.Pet and v2:getOwner() == mainPlayer
			local bProduce = string.find(v2.userData or "", "trs_produce_")

			if bMyPet then
				v2:setVisible(false)
			elseif not bProduce then
				v2:setVisible(show)
			end
		end
	end
end

return GuardCitySceneUnitFactory
