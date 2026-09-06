-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/season/UnitSeasonCustom.lua

module("logicscene.scene.unit.impl.season.UnitSeasonCustom", package.seeall)

local UnitSeasonCustom = class("UnitSeasonCustom", UnitSeasonGridElem)

function UnitSeasonCustom:getTag()
	return UnitTag.Untagged
end

function UnitSeasonCustom:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
end

function UnitSeasonCustom:onUnitVisible(go)
	UnitSeasonGridElem.super.onUnitVisible(self, go)
end

return UnitSeasonCustom
