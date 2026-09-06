-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotWeaponCon.lua

module("logic.extensions.defendcarrot.model.DefendCarrotWeaponCon", package.seeall)

local DefendCarrotWeaponCon = class("DefendCarrotWeaponCon", DefendCarrotUnitCon)

function DefendCarrotWeaponCon:ctor(container)
	DefendCarrotWeaponCon.super.ctor(self, container)
end

function DefendCarrotWeaponCon:buildUI()
	DefendCarrotWeaponCon.super.buildUI(self)

	self._iconChange = goutil.findChildComponent(self.container, "icon", "UIImageSpriteChange")
	self._imgIcon = self._iconChange:GetComponent(goutil.Type_UIImage)
	self._txtLv = goutil.findChildTextComponent(self.container, "lv/txt")
end

function DefendCarrotWeaponCon:updateUI()
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

function DefendCarrotWeaponCon:updateRotationZ()
	local locRZ = self._unit and self._unit:getLocRotationZ() or 0

	GameUtil.setLocalRotation(self._imgIcon.gameObject, 0, 0, locRZ)
end

return DefendCarrotWeaponCon
