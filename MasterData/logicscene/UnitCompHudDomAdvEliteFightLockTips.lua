-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/domadv/UnitCompHudDomAdvEliteFightLockTips.lua

module("logicscene.scene.unit.component.domadv.UnitCompHudDomAdvEliteFightLockTips", package.seeall)

local UnitCompHudDomAdvEliteFightLockTips = class("UnitCompHudDomAdvEliteFightLockTips", UnitCompHudBase)

function UnitCompHudDomAdvEliteFightLockTips:_getResPath()
	return "ui/views/domainadventure/unithud/unitcomphuddomadvelitefightlocktips.prefab"
end

function UnitCompHudDomAdvEliteFightLockTips:onUnitVisible(go)
	return
end

function UnitCompHudDomAdvEliteFightLockTips:onUnitInVisible(go)
	return
end

function UnitCompHudDomAdvEliteFightLockTips:show()
	self:_setHud()
end

function UnitCompHudDomAdvEliteFightLockTips:hide()
	self:_recycleHud()
end

return UnitCompHudDomAdvEliteFightLockTips
