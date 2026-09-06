-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitSpecialElement.lua

module("logicscene.scene.unit.impl.UnitSpecialElement", package.seeall)

local UnitSpecialElement = class("UnitSpecialElement", SceneUnitBase)

function UnitSpecialElement:ctor(componetContainer, addParam)
	self._addParam = addParam

	UnitSpecialElement.super.ctor(self, componetContainer)
end

function UnitSpecialElement:getTag()
	return UnitTag.SceneElement
end

function UnitSpecialElement:getLayer()
	return SceneLayer.Unit_Value
end

function UnitSpecialElement:onUnitVisible(go)
	UnitSpecialElement.super.onUnitVisible(self, go)

	self._gameObject.name = CityUnitFactory.UnitSpecialElement .. self.id
end

function UnitSpecialElement:getAddParam()
	return self._addParam
end

return UnitSpecialElement
