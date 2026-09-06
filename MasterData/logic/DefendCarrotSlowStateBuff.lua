-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotSlowStateBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotSlowStateBuff", package.seeall)

local DefendCarrotSlowStateBuff = class("DefendCarrotSlowStateBuff", DefendCarrotCreateStatusBuff)

function DefendCarrotSlowStateBuff:initComplete()
	DefendCarrotSlowStateBuff.super.initComplete(self)

	self._slowPercent = checknumber(self._tiggerParam[self:gPId()])
	self._timeMultiplier = 1
end

function DefendCarrotSlowStateBuff:onAdd(target)
	DefendCarrotSlowStateBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.updateAttr, self._unit, DefendCarrotEnum.UnitAttrName.MoveRate, -self._slowPercent)

	self._timeMultiplier = target:getCurAttrValue(DefendCarrotEnum.UnitAttrName.SlowDownTimeMultiplier) or 1
end

function DefendCarrotSlowStateBuff:onRemove(unit)
	DefendCarrotSlowStateBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.updateAttr, self._unit, DefendCarrotEnum.UnitAttrName.MoveRate, self._slowPercent)
end

function DefendCarrotSlowStateBuff:getMaxLifeTime()
	return checknumber(self._totalLifeTime) * checknumber(self._timeMultiplier)
end

return DefendCarrotSlowStateBuff
