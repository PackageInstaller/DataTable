-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/factory/ElementSparkUnitFactory.lua

module("logicscene.scene.component.factory.ElementSparkUnitFactory", package.seeall)

local ElementSparkUnitFactory = class("ElementSparkUnitFactory", CityUnitFactory)

function ElementSparkUnitFactory:createCommonObjectUnit(tag, insId, itemId, usrData)
	if tag == UnitTag.TilingSceneElem then
		return self:_createElementSparkElement(insId, itemId, usrData)
	elseif tag == UnitTag.SceneElement then
		if itemId > 0 then
			return self:_createLevelElement(insId, itemId, usrData)
		else
			return self:_createBackGroundElement(insId, itemId, usrData)
		end
	end
end

function ElementSparkUnitFactory:_createLevelElement(insId, itemId, params)
	local name = UnitTag.SceneElement .. tostring(insId)
	local unitGo = goutil.create(name, false)
	local unit = UnitElementSparkSceneLevel.New(unitGo, params)

	unit.scene = self._scene
	unit.id = insId
	unit.chunkId = itemId

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function ElementSparkUnitFactory:_createBackGroundElement(insId, itemId, params)
	local name = UnitTag.SceneElement .. tostring(insId)
	local unitGo = goutil.create(name, false)
	local unit = UnitElementSparkBackGround.New(unitGo, params)

	unit.scene = self._scene
	unit.id = insId
	unit.bgId = itemId

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function ElementSparkUnitFactory:_createElementSparkElement(insId, itemId, usrData)
	local name = UnitTag.TilingSceneElem .. "_" .. tostring(insId)
	local unitGo = goutil.create(name, false)
	local unit = UnitElementSparkElem.New(unitGo)

	unit.scene = self._scene
	unit.id = insId
	unit.chunkId = itemId

	unit:Awake()
	self:addUnit(unit)

	return unit
end

function ElementSparkUnitFactory:createElementSparkElem(elemDataCo)
	local insId = self:generateObjectInstanceId()
	local resPath = elemDataCo.assetPath
	local boundsX = elemDataCo.boundsX
	local boundsY = elemDataCo.boundsY
	local pos = elemDataCo.position

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.TilingSceneElem, insId, elemDataCo.id, resPath, pos.x, pos.y, boundsX, boundsY, 1, false, nil, elemDataCo.layer, elemDataCo.offset)

	local unit = self:getUnit(UnitTag.TilingSceneElem, insId)

	unit.elemDataCo = elemDataCo

	return unit
end

function ElementSparkUnitFactory:createBackGroundElem(elemDataCo)
	local insId = self:generateObjectInstanceId()
	local resPath = elemDataCo.assetPath
	local boundsX = elemDataCo.boundsX
	local boundsY = elemDataCo.boundsY
	local pos = elemDataCo.position

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.SceneElement, insId, elemDataCo.id, resPath, pos.x, pos.y, boundsX, boundsY, 1, false, nil, elemDataCo.layer, elemDataCo.offset)

	return unit
end

function ElementSparkUnitFactory:updateAllEle()
	local units = self:getUnits(UnitTag.TilingSceneElem)

	if units then
		for k, unit in pairs(units) do
			if unit:isVisible() and unit.updateHud then
				unit:updateHud()
			end
		end
	end

	local units = self:getUnits(UnitTag.SceneElement)

	if units then
		for k, unit in pairs(units) do
			if unit:isVisible() and unit.updateLevel then
				unit:updateLevel()
			end
		end
	end
end

function ElementSparkUnitFactory:createLevelElem(elemDataCo)
	local insId = self:generateObjectInstanceId()
	local resPath = elemDataCo.assetPath
	local boundsX = elemDataCo.boundsX
	local boundsY = elemDataCo.boundsY
	local pos = elemDataCo.position

	self._scene.stage.wholeScene:CreateCommonObject(UnitTag.SceneElement, insId, elemDataCo.id, resPath, pos.x, pos.y, boundsX, boundsY, 1, false, nil, elemDataCo.layer, elemDataCo.offset)

	return unit
end

return ElementSparkUnitFactory
