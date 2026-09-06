-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotBurnBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotBurnBuff", package.seeall)

local DefendCarrotBurnBuff = class("DefendCarrotBurnBuff", DefendCarrotCreateStatusBuff)

function DefendCarrotBurnBuff:initComplete()
	DefendCarrotBurnBuff.super.initComplete(self)

	self._burnDamage = checknumber(self._tiggerParam[self:gPId()])
	self._damageSource = nil
	self._timeMultiplier = 1
end

function DefendCarrotBurnBuff:onAdd(target)
	DefendCarrotBurnBuff.super.onAdd(self, target)

	self._damageSource = target
	self._timeMultiplier = target:getCurAttrValue(DefendCarrotEnum.UnitAttrName.BurningTimeMultiplier) or 1
end

function DefendCarrotBurnBuff:onBuffTrigger()
	GameUtil.callBack(self._unit.beDamage, self._unit, self._damageSource, checknumber(self._burnDamage))
end

function DefendCarrotBurnBuff:onRemove(unit)
	DefendCarrotBurnBuff.super.onRemove(self, unit)

	self._damageSource = nil
end

function DefendCarrotBurnBuff:getMaxLifeTime()
	return checknumber(self._totalLifeTime) * checknumber(self._timeMultiplier)
end

return DefendCarrotBurnBuff
