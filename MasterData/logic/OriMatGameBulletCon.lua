-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/OriMatGameBulletCon.lua

module("logic.extensions.orimatgame.model.OriMatGameBulletCon", package.seeall)

local OriMatGameBulletCon = class("OriMatGameBulletCon", OriMatGameUnitCon)

function OriMatGameBulletCon:ctor(container)
	OriMatGameBulletCon.super.ctor(self, container)
end

function OriMatGameBulletCon:buildUI()
	OriMatGameBulletCon.super.buildUI(self)

	self._iconChange = goutil.findChildComponent(self.container, "icon", "UIImageSpriteChange")
	self._imgIcon = self._iconChange:GetComponent(goutil.Type_UIImage)
end

function OriMatGameBulletCon:updateUI()
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

function OriMatGameBulletCon:updateRotationZ()
	local locRZ = self._unit and self._unit:getLocRotationZ() or 0

	GameUtil.setLocalRotation(self.container, 0, 0, locRZ)
end

function OriMatGameBulletCon:updateRadius(radius)
	if self._imgIcon then
		goutil.setWidth(self._imgIcon.transform, 2 * radius)
		goutil.setHeight(self._imgIcon.transform, 2 * radius)
	end
end

function OriMatGameBulletCon:updateScale(size)
	if self._imgIcon then
		GameUtil.setLocalScale(self._imgIcon.gameObject, size, size, size)
	end
end

return OriMatGameBulletCon
