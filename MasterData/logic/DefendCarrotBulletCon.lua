-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/DefendCarrotBulletCon.lua

module("logic.extensions.defendcarrot.model.DefendCarrotBulletCon", package.seeall)

local DefendCarrotBulletCon = class("DefendCarrotBulletCon", DefendCarrotUnitCon)

function DefendCarrotBulletCon:ctor(container)
	DefendCarrotBulletCon.super.ctor(self, container)
end

function DefendCarrotBulletCon:buildUI()
	DefendCarrotBulletCon.super.buildUI(self)

	self._iconChange = goutil.findChildComponent(self.container, "icon", "UIImageSpriteChange")
	self._imgIcon = self._iconChange:GetComponent(goutil.Type_UIImage)
end

function DefendCarrotBulletCon:updateUI()
	self:updateScale(1)

	if self._unit then
		self:updatePosition(self._unit.position.x, self._unit.position.y)

		local cfg = self._unit:getBulletCfg()

		if cfg then
			if not GameUtil.isEmptyString(cfg.resPath) then
				self._iconChange:ChangeSprite(cfg.resPath)

				if self._unit:isIncreaseRadius() then
					self:updateRadius(self._unit:getRadius())
				else
					self._imgIcon:SetNativeSize()
				end
			end

			if not cfg.localPos then
				local locPos = {
					0,
					0
				}

				GameUtil.setAnchoredPos(self._iconChange.gameObject, locPos[1], locPos[2])
			end
		end

		self:updateRotationZ()
		goutil.setActive(self.container, true)
	else
		self:reset()
	end
end

function DefendCarrotBulletCon:updateRotationZ()
	local locRZ = self._unit and self._unit:getLocRotationZ() or 0

	GameUtil.setLocalRotation(self.container, 0, 0, locRZ)
end

function DefendCarrotBulletCon:updateRadius(radius)
	if self._imgIcon then
		goutil.setWidth(self._imgIcon.transform, 2 * radius)
		goutil.setHeight(self._imgIcon.transform, 2 * radius)
	end
end

function DefendCarrotBulletCon:updateScale(size)
	if self._imgIcon then
		GameUtil.setLocalScale(self._imgIcon.gameObject, size, size, size)
	end
end

return DefendCarrotBulletCon
