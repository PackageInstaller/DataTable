-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameWeaponCon.lua

module("logic.extensions.orimatgame.model.OriMatGameWeaponCon", package.seeall)

local OriMatGameWeaponCon = class("OriMatGameWeaponCon", OriMatGameUnitCon)

function OriMatGameWeaponCon:ctor(container)
	OriMatGameWeaponCon.super.ctor(self, container)
end

function OriMatGameWeaponCon:buildUI()
	OriMatGameWeaponCon.super.buildUI(self)

	self._iconChange = goutil.findChildComponent(self.container, "icon", "UIImageSpriteChange")
	self._imgIcon = self._iconChange:GetComponent(goutil.Type_UIImage)
	self._txtLv = goutil.findChildTextComponent(self.container, "lv/txt")
	self._upgradeFlag = goutil.findChild(self.container, "upgradeFlag")

	goutil.setActive(self._upgradeFlag, false)
end

function OriMatGameWeaponCon:updateUI()
	if self._unit then
		self:updatePosition(self._unit.position.x, self._unit.position.y)

		local cfg = self._unit:getWeaponCfg()

		if cfg then
			self._iconChange:ChangeSprite(cfg.resPath)
			self._imgIcon:SetNativeSize()

			self._txtLv.text = cfg.level
		end

		self:updateRotationZ()
		goutil.setActive(self.container, true)
	else
		self:reset()
	end
end

function OriMatGameWeaponCon:updateRotationZ()
	local locRZ = self._unit and self._unit:getLocRotationZ() or 0

	GameUtil.setLocalRotation(self._imgIcon.gameObject, 0, 0, locRZ)
end

function OriMatGameWeaponCon:updateUpgradeFlag(curCoin)
	if goutil.isNil(self._upgradeFlag) or self._unit == nil then
		return
	end

	curCoin = checknumber(curCoin)

	local canUpgrade = not self._unit:isMaxLevel() and curCoin >= self._unit:getUpgradeCost()

	goutil.setActive(self._upgradeFlag, canUpgrade)
end

return OriMatGameWeaponCon
