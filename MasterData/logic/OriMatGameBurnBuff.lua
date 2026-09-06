-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameBurnBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameBurnBuff", package.seeall)

local OriMatGameBurnBuff = class("OriMatGameBurnBuff", OriMatGameCreateStatusBuff)

function OriMatGameBurnBuff:initComplete()
	OriMatGameBurnBuff.super.initComplete(self)

	self._burnDamage = checknumber(self._tiggerParam[self:gPId()])
	self._damageSource = nil
	self._timeMultiplier = 1
end

function OriMatGameBurnBuff:onAdd(target)
	OriMatGameBurnBuff.super.onAdd(self, target)

	self._damageSource = target
	self._timeMultiplier = target:getCurAttrValue(OriMatGameEnum.UnitAttrName.BurningTimeMultiplier) or 1
end

function OriMatGameBurnBuff:onBuffTrigger()
	GameUtil.callBack(self._unit.beDamage, self._unit, self._damageSource, checknumber(self._burnDamage))
end

function OriMatGameBurnBuff:onRemove(unit)
	OriMatGameBurnBuff.super.onRemove(self, unit)

	self._damageSource = nil
end

function OriMatGameBurnBuff:getMaxLifeTime()
	return checknumber(self._totalLifeTime) * checknumber(self._timeMultiplier)
end

return OriMatGameBurnBuff
