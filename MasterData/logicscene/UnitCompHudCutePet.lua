-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/cutepet/UnitCompHudCutePet.lua

module("logicscene.scene.unit.component.cutepet.UnitCompHudCutePet", package.seeall)

local UnitCompHudCutePet = class("UnitCompHudCutePet", UnitCompHudBase)

function UnitCompHudCutePet:_getResPath()
	return "ui/views/cutepet/unithud/cutepethudpetinfo.prefab"
end

function UnitCompHudCutePet:_updateHudInfo(hudGo)
	local info = goutil.findChild(hudGo, "info")

	GameUtil.setAnchoredPos(info, 0, 110)

	local txtName = goutil.findChildTextComponent(hudGo, "info/tips")

	txtName.text = self._unit:getUnitName()
end

function UnitCompHudCutePet:refreshHudView()
	if self._hudGameObject then
		self:_updateHudInfo(self._hudGameObject)
	end
end

return UnitCompHudCutePet
