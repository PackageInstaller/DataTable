-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotExplosiveBulletBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotExplosiveBulletBuff", package.seeall)

local DefendCarrotExplosiveBulletBuff = class("DefendCarrotExplosiveBulletBuff", DefendCarrotBuffBase)

function DefendCarrotExplosiveBulletBuff:initComplete()
	DefendCarrotExplosiveBulletBuff.super.initComplete(self)

	self._newBulletId = checknumber(self._tiggerParam[self:gPId()])
	self._damRatio = checknumber(self._tiggerParam[self:gPId()])
end

function DefendCarrotExplosiveBulletBuff:onAdd(target)
	if self._unit and self._unit:getType() ~= DefendCarrotEnum.UnitType.Bullet then
		GameUtil.callBack(self._unit.removeBuff, self._unit, self)
	end
end

function DefendCarrotExplosiveBulletBuff:onBuffTrigger()
	if self._unit and self._unit:getType() == DefendCarrotEnum.UnitType.Bullet then
		local addExplosiveRate = self._unit:getCurAttrValue(DefendCarrotEnum.UnitAttrName.AddExplosiveRate) or 0
		local weaponId = self._unit:getWeaponId()
		local ownerId = self._unit:getOwnerId()
		local atk = self._unit:getCurAttrValue(DefendCarrotEnum.UnitAttrName.Attack) or 0

		DefendCarrotGameController.instance:createBullet(self._unit.position.x, self._unit.position.y, self._newBulletId, weaponId, ownerId, 0, 0, atk * (self._damRatio + addExplosiveRate))
	end
end

return DefendCarrotExplosiveBulletBuff
