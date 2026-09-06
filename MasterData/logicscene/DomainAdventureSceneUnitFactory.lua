-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/DomainAdventureSceneUnitFactory.lua

module("logicscene.scene.component.factory.DomainAdventureSceneUnitFactory", package.seeall)

local DomainAdventureSceneUnitFactory = class("DomainAdventureSceneUnitFactory", CityUnitFactory)

function DomainAdventureSceneUnitFactory:getUnitByLayer(layer, elementId)
	local tag = DomAdvEnum.TagsInLayer[layer]

	return self:getUnit(tag, elementId)
end

function DomainAdventureSceneUnitFactory:createUnitByLayer(layer, elementId, row, col)
	local unit

	return layer == DomAdvEnum.Layer_GroundDown and self:createGridUnit(elementId, row, col) or self:createGridElem(elementId, row, col)
end

function DomainAdventureSceneUnitFactory:createGridUnit(elementId, row, col)
	local gridId = DomAdvPathFindingDataModel.instance:grid2Id(row, col)
	local name = string.format("unitGrid_%s_%s_%s_%s", elementId, row, col, gridId)
	local unitGo = goutil.create(name, false)
	local unit = UnitDomAdvGrid.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.row = row
	unit.col = col
	unit.id = elementId

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function DomainAdventureSceneUnitFactory:createGridElem(elementId, row, col)
	local gridId = DomAdvPathFindingDataModel.instance:grid2Id(row, col)
	local name = string.format("elem_%s_%s_%s_%s", elementId, row, col, gridId)
	local unitGo = goutil.create(name, false)
	local unit = UnitDomAdvGridEle.New(unitGo)

	unit.scene = self._scene
	unit.radius = 1
	unit.id = elementId
	unit.row = row
	unit.col = col

	unit:Awake()
	self:addUnit(unit)

	return unit
end

return DomainAdventureSceneUnitFactory
