-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/petzoo/UnitCompHudZooAnimal.lua

module("logicscene.scene.unit.component.hud.petzoo.UnitCompHudZooAnimal", package.seeall)

local UnitCompHudZooAnimal = class("UnitCompHudZooAnimal", UnitCompHudBase)

function UnitCompHudZooAnimal:_getResPath()
	return "scene/misc/prefabs/hudzooanimal.prefab"
end

function UnitCompHudZooAnimal:_updateHudInfo(hudGo)
	local name = goutil.findChild(hudGo, "Name"):GetComponent("Text")
	local nameBg = goutil.findChild(hudGo, "NameBg"):GetComponent("RectTransform")

	name.text = self._unit:getUnitName()

	local sizeDelta = nameBg.sizeDelta

	sizeDelta.x = name.preferredWidth + 50
	nameBg.sizeDelta = sizeDelta
end

return UnitCompHudZooAnimal
