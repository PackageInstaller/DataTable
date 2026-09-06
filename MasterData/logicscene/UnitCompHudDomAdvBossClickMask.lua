-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/domadv/UnitCompHudDomAdvBossClickMask.lua

module("logicscene.scene.unit.component.domadv.UnitCompHudDomAdvBossClickMask", package.seeall)

local UnitCompHudDomAdvBossClickMask = class("UnitCompHudDomAdvBossClickMask", UnitCompHudBase)

function UnitCompHudDomAdvBossClickMask:_getResPath()
	return "ui/views/domainadventure/unithud/unitcomphuddomadvbossclickmask.prefab"
end

function UnitCompHudDomAdvBossClickMask:_recycleHud()
	local hudGo = self._hudGameObject

	if not goutil.isNil(hudGo) then
		local img = goutil.findChild(hudGo, "info/img")

		GameUtil.rmClickHandler(img)
	end

	UnitCompHudDomAdvBossClickMask.super._recycleHud(self)
end

function UnitCompHudDomAdvBossClickMask:_updateHudInfo(hudGo)
	local img = goutil.findChild(hudGo, "info/img")

	GameUtil.addClickHandler(img, function()
		self._unit.scene.picker:enabled(false)
		GlobalDispatcher:dispatch(GlobalNotify.DomainAdventureSceneClickGrid, self._unit._gridId)
		self._unit.scene.picker:enabled(true)
	end, self)
end

return UnitCompHudDomAdvBossClickMask
