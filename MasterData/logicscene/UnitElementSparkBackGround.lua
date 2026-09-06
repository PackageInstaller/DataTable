-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/elementspark/UnitElementSparkBackGround.lua

module("logicscene.scene.unit.impl.elementspark.UnitElementSparkBackGround", package.seeall)

local UnitElementSparkBackGround = class("UnitElementSparkBackGround", SceneUnitBase)

function UnitElementSparkBackGround:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
end

function UnitElementSparkBackGround:getTag()
	return UnitTag.SceneElement
end

function UnitElementSparkBackGround:getLayer()
	return SceneLayer.Ground_Value
end

function UnitElementSparkBackGround:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)
end

function UnitElementSparkBackGround:onUnitVisible(go)
	UnitElementSparkBackGround.super.onUnitVisible(self, go)
	GoUtil.SetSortingOrder(self._gameObject, math.abs(self.bgId) - 2000)
end

return UnitElementSparkBackGround
