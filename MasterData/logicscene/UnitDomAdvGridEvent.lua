-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/domainadventure/UnitDomAdvGridEvent.lua

module("logicscene.scene.unit.impl.domainadventure.UnitDomAdvGridEvent", package.seeall)

local UnitDomAdvGridEvent = class("UnitDomAdvGridEvent", UnitDomAdvGridEle)

function UnitDomAdvGridEvent:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("gridEvent", UnitCompDomAdvEvent)
end

function UnitDomAdvGridEvent:getIconSprite()
	return self.gridEvent:getIconSprite()
end

return UnitDomAdvGridEvent
