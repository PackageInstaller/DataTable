-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/domadv/UnitCompHudDomAdvGmTesstTips.lua

module("logicscene.scene.unit.component.domadv.UnitCompHudDomAdvGmTesstTips", package.seeall)

local UnitCompHudDomAdvGmTesstTips = class("UnitCompHudDomAdvGmTesstTips", UnitCompHudBase)

function UnitCompHudDomAdvGmTesstTips:_getResPath()
	return "ui/views/domainadventure/unithud/unitcomphuddomadvgmtessttips.prefab"
end

function UnitCompHudDomAdvGmTesstTips:onUnitVisible(go)
	return
end

function UnitCompHudDomAdvGmTesstTips:onUnitInVisible(go)
	return
end

function UnitCompHudDomAdvGmTesstTips:show()
	self:_setHud()
end

function UnitCompHudDomAdvGmTesstTips:hide()
	self:_recycleHud()
end

function UnitCompHudDomAdvGmTesstTips:_updateHudInfo(hudGo)
	local txtTips = goutil.findChildTextComponent(hudGo, "info/txtTips")

	txtTips.text = string.format("%s\n(%s, %s)", self._unit._gridId, self._unit.row, self._unit.col)
end

return UnitCompHudDomAdvGmTesstTips
