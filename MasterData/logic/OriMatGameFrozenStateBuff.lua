-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameFrozenStateBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameFrozenStateBuff", package.seeall)

local OriMatGameFrozenStateBuff = class("OriMatGameFrozenStateBuff", OriMatGameCreateStatusBuff)

function OriMatGameFrozenStateBuff:initComplete()
	OriMatGameFrozenStateBuff.super.initComplete(self)

	self._timeMultiplier = 1
end

function OriMatGameFrozenStateBuff:onAdd(target)
	OriMatGameFrozenStateBuff.super.onAdd(self, target)

	self._timeMultiplier = target:getCurAttrValue(OriMatGameEnum.UnitAttrName.FrozenTimeMultiplier) or 1
end

function OriMatGameFrozenStateBuff:getMaxLifeTime()
	return checknumber(self._totalLifeTime) * checknumber(self._timeMultiplier)
end

return OriMatGameFrozenStateBuff
