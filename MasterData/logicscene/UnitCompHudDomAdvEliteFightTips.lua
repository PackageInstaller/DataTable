-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/domadv/UnitCompHudDomAdvEliteFightTips.lua

module("logicscene.scene.unit.component.domadv.UnitCompHudDomAdvEliteFightTips", package.seeall)

local UnitCompHudDomAdvEliteFightTips = class("UnitCompHudDomAdvEliteFightTips", UnitCompHudBase)

function UnitCompHudDomAdvEliteFightTips:_getResPath()
	return "ui/views/domainadventure/unithud/unitcomphuddomadvelitefighttips.prefab"
end

function UnitCompHudDomAdvEliteFightTips:onUnitVisible(go)
	return
end

function UnitCompHudDomAdvEliteFightTips:onUnitInVisible(go)
	return
end

function UnitCompHudDomAdvEliteFightTips:show()
	self:_setHud()
end

function UnitCompHudDomAdvEliteFightTips:hide()
	self:_recycleHud()
end

return UnitCompHudDomAdvEliteFightTips
