-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/petzoo/UnitCompHudZooBuildingBase.lua

module("logicscene.scene.unit.component.hud.petzoo.UnitCompHudZooBuildingBase", package.seeall)

local UnitCompHudZooBuildingBase = class("UnitCompHudZooBuildingBase", UnitCompHudBase)

function UnitCompHudZooBuildingBase:_getResPath()
	return "ui/views/zoo/zoohudbuildinglocked.prefab"
end

function UnitCompHudZooBuildingBase:_updateHudInfo(hudGo)
	self._isLocked_ui = goutil.findChild(hudGo, "isLocked")
	self._lockTips_ui = goutil.findChildTextComponent(hudGo, "isLocked/tips")
	self._lockState_ui = goutil.findChild(hudGo, "isLocked/locked")
	self._unlockable_ui = goutil.findChild(hudGo, "isLocked/unlockabled")

	self:updateBuildingHud()
end

function UnitCompHudZooBuildingBase:updateBuildingHud()
	if not self._hudGameObject then
		return
	end

	local buildingMO = self._unit:getBuildingMO()

	if not buildingMO then
		self:setIsLocked(true)
		self:setLockedTips(lang("petzoo_building_locktips"))
	else
		self:setIsLocked(not buildingMO.isUnlocked)

		if buildingMO.isUnlocked then
			return
		end

		if buildingMO:isUnlockable() then
			self._unlockable_ui:SetActive(true)
		else
			self._lockState_ui:SetActive(false)
		end

		self:setLockedTips(string.format(lang("petzoo_building_unlock_level"), buildingMO:getUnlockNeedMainLv()))
	end
end

function UnitCompHudZooBuildingBase:setIsLocked(locked)
	if self._hudGameObject then
		self._hudGameObject:SetActive(locked or false)
	end
end

function UnitCompHudZooBuildingBase:setLockedTips(tips)
	if self._lockTips_ui then
		self._lockTips_ui.text = tips
	end
end

function UnitCompHudZooBuildingBase:_recycleHud()
	UnitCompHudZooBuildingBase.super._recycleHud(self)

	self._isLocked_ui = nil
	self._lockTips_ui = nil
end

return UnitCompHudZooBuildingBase
