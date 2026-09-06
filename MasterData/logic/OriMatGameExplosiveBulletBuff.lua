-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameExplosiveBulletBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameExplosiveBulletBuff", package.seeall)

local OriMatGameExplosiveBulletBuff = class("OriMatGameExplosiveBulletBuff", OriMatGameBuffBase)

function OriMatGameExplosiveBulletBuff:initComplete()
	OriMatGameExplosiveBulletBuff.super.initComplete(self)

	self._newBulletId = checknumber(self._tiggerParam[self:gPId()])
	self._damRatio = checknumber(self._tiggerParam[self:gPId()])
end

function OriMatGameExplosiveBulletBuff:onAdd(target)
	if self._unit and self._unit:getType() ~= OriMatGameEnum.UnitType.Bullet then
		GameUtil.callBack(self._unit.removeBuff, self._unit, self)
	end
end

function OriMatGameExplosiveBulletBuff:onBuffTrigger()
	if self._unit and self._unit:getType() == OriMatGameEnum.UnitType.Bullet then
		local addExplosiveRate = self._unit:getCurAttrValue(OriMatGameEnum.UnitAttrName.AddExplosiveRate) or 0
		local weaponId = self._unit:getWeaponId()
		local ownerId = self._unit:getOwnerId()
		local atk = self._unit:getCurAttrValue(OriMatGameEnum.UnitAttrName.Attack) or 0

		OriMatGameGameController.instance:createBullet(self._unit.position.x, self._unit.position.y, self._newBulletId, weaponId, ownerId, 0, 0, atk * (self._damRatio + addExplosiveRate))
	end
end

return OriMatGameExplosiveBulletBuff
