-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/domadv/UnitCompHudDomAdvSolveFormTips.lua

module("logicscene.scene.unit.component.domadv.UnitCompHudDomAdvSolveFormTips", package.seeall)

local UnitCompHudDomAdvSolveFormTips = class("UnitCompHudDomAdvSolveFormTips", UnitCompHudBase)

function UnitCompHudDomAdvSolveFormTips:_getResPath()
	return "ui/views/domainadventure/unithud/unitcomphuddomadvsolveformtips.prefab"
end

function UnitCompHudDomAdvSolveFormTips:onUnitVisible(go)
	return
end

function UnitCompHudDomAdvSolveFormTips:onUnitInVisible(go)
	return
end

function UnitCompHudDomAdvSolveFormTips:show()
	self:_setHud()
end

function UnitCompHudDomAdvSolveFormTips:hide()
	self:_recycleHud()
end

return UnitCompHudDomAdvSolveFormTips
