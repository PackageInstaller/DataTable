-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/treasureraider/UnitTreasureRaiderCustom.lua

module("logicscene.scene.unit.impl.treasureraider.UnitTreasureRaiderCustom", package.seeall)

local UnitTreasureRaiderCustom = class("UnitTreasureRaiderCustom", UnitTreasureRaiderGridElem)

function UnitTreasureRaiderCustom:getTag()
	return UnitTag.Untagged
end

function UnitTreasureRaiderCustom:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
end

function UnitTreasureRaiderCustom:onUnitVisible(go)
	UnitTreasureRaiderCustom.super.onUnitVisible(self, go)
end

return UnitTreasureRaiderCustom
