-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameBulletBounceBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameBulletBounceBuff", package.seeall)

local OriMatGameBulletBounceBuff = class("OriMatGameBulletBounceBuff", OriMatGameChangeModeBuff)

function OriMatGameBulletBounceBuff:initComplete()
	OriMatGameBulletBounceBuff.super.initComplete(self)

	self._curHitCount = 0
	self._bounceCount = checknumber(self._tiggerParam[self:gPId()])
	self._boundRange = checknumber(self._tiggerParam[self:gPId()])
end

function OriMatGameBulletBounceBuff:onAdd(target)
	OriMatGameBulletBounceBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.changeMode, self._unit, OriMatGameEnum.BuffChangeMode.BulletBounce)
end

function OriMatGameBulletBounceBuff:onRemove(unit)
	OriMatGameBulletBounceBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.resetMode, self._unit, OriMatGameEnum.BuffChangeMode.BulletBounce)
end

function OriMatGameBulletBounceBuff:onHit(target)
	self._curHitCount = self._curHitCount + 1

	if self._curHitCount > self:getCurBounceCount() + 1 then
		OriMatGameGameController.instance:preReCycle(self._unit)
	else
		GameUtil.callBack(self._unit.bounceIgnoreTarget, self._unit, target, self._boundRange)
	end
end

function OriMatGameBulletBounceBuff:getCurBounceCount()
	return Mathf.Max(0, self._bounceCount + checknumber(self._unit:getCurAttrValue(OriMatGameEnum.UnitAttrName.AddBounceCount)))
end

return OriMatGameBulletBounceBuff
