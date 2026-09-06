-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/TreasureRaiderSceneUnitFactory.lua

module("logicscene.scene.component.factory.TreasureRaiderSceneUnitFactory", package.seeall)

local TreasureRaiderSceneUnitFactory = class("TreasureRaiderSceneUnitFactory", CityUnitFactory)

function TreasureRaiderSceneUnitFactory:createPlayer(data, posx, posy, speed)
	local insId = self:generateObjectInstanceId()
	local resPath = UnitTreasureRaiderPlayer.DefaultPlayerResPath

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.Player, insId, 1, resPath, posx, posy, 2, 2, 1, speed > 0, "trs_player", 0)

	local unit = self:getUnit(UnitTag.Player, insId)

	unit.data = data

	unit.transform:setMoveSpeed(speed)

	return unit
end

function TreasureRaiderSceneUnitFactory:createCustomUnit(itemId, resPath, posx, posy)
	local insId = self:generateObjectInstanceId()

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.Untagged, insId, itemId, resPath, posx, posy, 2, 2, 1, false, "trs_common_unit", 0)

	local unit = self:getUnit(UnitTag.Untagged, insId)

	unit.itemId = itemId

	unit.transform:setMoveSpeed(0)

	return unit
end

function TreasureRaiderSceneUnitFactory:createCommonObjectUnit(tag, insId, itemId, usrData)
	if usrData == "trs_player" then
		local unitGo = goutil.create("player_" .. insId, false)
		local unit = UnitTreasureRaiderPlayer.New(unitGo)

		unit.scene = self._scene
		unit.radius = 1
		unit.id = insId
		unit.userData = usrData

		unit:Awake()
		self:addUnit(unit)

		return unit
	elseif string.find(usrData, "trs_produce_") then
		local array = string.split(usrData, "_")
		local unitGo = goutil.create("produce_" .. insId, false)
		local unit = UnitTreasureRaiderProduce.New(unitGo)

		unit.scene = self._scene
		unit.radius = 1
		unit.id = insId
		unit.userData = usrData
		unit.elementId = checknumber(array[3])
		unit.row = checknumber(array[4])
		unit.col = checknumber(array[5])

		unit:Awake()
		self:addUnit(unit)

		return unit
	elseif usrData == "trs_common_unit" then
		local unitGo = goutil.create("custom_" .. insId, false)
		local unit = UnitTreasureRaiderCustom.New(unitGo)

		unit.scene = self._scene
		unit.radius = 1
		unit.id = insId

		unit:Awake()
		self:addUnit(unit)

		return unit
	end

	return TreasureRaiderSceneUnitFactory.super.createCommonObjectUnit(self, tag, insId, itemId, usrData)
end

function TreasureRaiderSceneUnitFactory:createGridUnit(elementId, row, col)
	local unitGo = goutil.create("grid_unit_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitTreasureRaiderGrid.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.row = row
	unit.col = col
	unit.id = elementId

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function TreasureRaiderSceneUnitFactory:generateGridElem(elementId, row, col)
	local unitGo = goutil.create("grid_elem_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitTreasureRaiderGridElem.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = elementId
	unit.row = row
	unit.col = col

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function TreasureRaiderSceneUnitFactory:generateGridBuilding(elementId, row, col)
	local unitGo = goutil.create("grid_building_" .. elementId .. "_" .. row .. "_" .. col, false)
	local unit = UnitTreasureRaiderGridBuilding.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = elementId
	unit.row = row
	unit.col = col

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function TreasureRaiderSceneUnitFactory:generateGridProduce(elementId, row, col, posx, posy, speed)
	local insId = self:generateObjectInstanceId()
	local resPath = UnitTreasureRaiderProduce.ProduceResPath

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.TilingSceneElem, insId, 1, resPath, posx, posy, 2, 2, 1, speed > 0, string.format("trs_produce_%s_%s_%s", elementId, row, col), 0)

	local unit = self:getUnit(UnitTag.TilingSceneElem, insId)

	unit.transform:setMoveSpeed(speed)

	return unit
end

function TreasureRaiderSceneUnitFactory:showUnit(tag, id, show)
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

function TreasureRaiderSceneUnitFactory:showUnits(show)
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

return TreasureRaiderSceneUnitFactory
