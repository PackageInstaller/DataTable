-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotBulletBounceBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotBulletBounceBuff", package.seeall)

local DefendCarrotBulletBounceBuff = class("DefendCarrotBulletBounceBuff", DefendCarrotChangeModeBuff)

function DefendCarrotBulletBounceBuff:initComplete()
	DefendCarrotBulletBounceBuff.super.initComplete(self)

	self._curHitCount = 0
	self._bounceCount = checknumber(self._tiggerParam[self:gPId()])
	self._boundRange = checknumber(self._tiggerParam[self:gPId()])
end

function DefendCarrotBulletBounceBuff:onAdd(target)
	DefendCarrotBulletBounceBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.changeMode, self._unit, DefendCarrotEnum.BuffChangeMode.BulletBounce)
end

function DefendCarrotBulletBounceBuff:onRemove(unit)
	DefendCarrotBulletBounceBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.resetMode, self._unit, DefendCarrotEnum.BuffChangeMode.BulletBounce)
end

function DefendCarrotBulletBounceBuff:onHit(target)
	self._curHitCount = self._curHitCount + 1

	if self._curHitCount > self:getCurBounceCount() + 1 then
		DefendCarrotGameController.instance:preReCycle(self._unit)
	else
		GameUtil.callBack(self._unit.bounceIgnoreTarget, self._unit, target, self._boundRange)
	end
end

function DefendCarrotBulletBounceBuff:getCurBounceCount()
	return Mathf.Max(0, self._bounceCount + checknumber(self._unit:getCurAttrValue(DefendCarrotEnum.UnitAttrName.AddBounceCount)))
end

return DefendCarrotBulletBounceBuff
