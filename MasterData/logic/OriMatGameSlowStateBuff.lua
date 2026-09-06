-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameSlowStateBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameSlowStateBuff", package.seeall)

local OriMatGameSlowStateBuff = class("OriMatGameSlowStateBuff", OriMatGameCreateStatusBuff)

function OriMatGameSlowStateBuff:initComplete()
	OriMatGameSlowStateBuff.super.initComplete(self)

	self._slowPercent = checknumber(self._tiggerParam[self:gPId()])
	self._timeMultiplier = 1
end

function OriMatGameSlowStateBuff:onAdd(target)
	OriMatGameSlowStateBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.updateAttr, self._unit, OriMatGameEnum.UnitAttrName.MoveRate, -self._slowPercent)

	self._timeMultiplier = target:getCurAttrValue(OriMatGameEnum.UnitAttrName.SlowDownTimeMultiplier) or 1
end

function OriMatGameSlowStateBuff:onRemove(unit)
	OriMatGameSlowStateBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.updateAttr, self._unit, OriMatGameEnum.UnitAttrName.MoveRate, self._slowPercent)
end

function OriMatGameSlowStateBuff:getMaxLifeTime()
	return checknumber(self._totalLifeTime) * checknumber(self._timeMultiplier)
end

return OriMatGameSlowStateBuff
