-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/family/UnitCompHudFamilyBuilding.lua

module("logicscene.scene.unit.component.family.UnitCompHudFamilyBuilding", package.seeall)

local UnitCompHudFamilyBuilding = class("UnitCompHudFamilyBuilding", UnitCompHudBase)

function UnitCompHudFamilyBuilding:_getResPath()
	return "ui/views/familyscene/unithud/familyhudbuildinginfo.prefab"
end

function UnitCompHudFamilyBuilding:_updateHudInfo(hudGo)
	local info = goutil.findChild(hudGo, "info")

	GameUtil.setAnchoredPos(info, 0, 110)

	local txtName = goutil.findChildTextComponent(hudGo, "info/node/txtName")
	local redPoint = goutil.findChild(hudGo, "info/redpoint")

	GameUtil.SetActive(redPoint, false)
	GameUtil.SetActive(info, not self._hudHide)

	if self._unit.type == FamilyBuildingType.Welfare then
		txtName.text = lang("家族福利")

		GameUtil.setAnchoredPos(info, 0, 150)
	elseif self._unit.type == FamilyBuildingType.Activities then
		txtName.text = lang("家族活动")

		GameUtil.setAnchoredPos(info, -130, 0)
	elseif self._unit.type == FamilyBuildingType.Transaction then
		txtName.text = lang("家族事务")

		GameUtil.setAnchoredPos(info, 5, 80)
	end
end

function UnitCompHudFamilyBuilding:onUnitInVisible(go)
	UnitCompHudFamilyBuilding.super.onUnitInVisible(self, go)
end

function UnitCompHudFamilyBuilding:getInfoGoPos()
	local pos = {
		x = 0,
		y = 0
	}

	if self._hudGameObject then
		pos = GameUtil.getAnchoredPos(self._hudGameObject)

		local info = goutil.findChild(self._hudGameObject, "info")

		pos = pos + GameUtil.getAnchoredPos(info)
	end

	return pos
end

function UnitCompHudFamilyBuilding:setHudHide(bool)
	self._hudHide = bool

	self:_updateHudInfo(self._hudGameObject)
end

return UnitCompHudFamilyBuilding
