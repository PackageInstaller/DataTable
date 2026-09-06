-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/season/UnitSeasonGridEvent.lua

module("logicscene.scene.unit.impl.season.UnitSeasonGridEvent", package.seeall)

local UnitSeasonGridEvent = class("UnitSeasonGridEvent", UnitSeasonGridElem)

function UnitSeasonGridEvent:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("gridEvent", UnitCompSeasonEvent)
end

function UnitSeasonGridEvent:getIconSprite()
	return self.gridEvent:getIconSprite()
end

return UnitSeasonGridEvent
