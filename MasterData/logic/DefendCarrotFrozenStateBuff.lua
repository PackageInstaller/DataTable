-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotFrozenStateBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotFrozenStateBuff", package.seeall)

local DefendCarrotFrozenStateBuff = class("DefendCarrotFrozenStateBuff", DefendCarrotCreateStatusBuff)

function DefendCarrotFrozenStateBuff:initComplete()
	DefendCarrotFrozenStateBuff.super.initComplete(self)

	self._timeMultiplier = 1
end

function DefendCarrotFrozenStateBuff:onAdd(target)
	DefendCarrotFrozenStateBuff.super.onAdd(self, target)

	self._timeMultiplier = target:getCurAttrValue(DefendCarrotEnum.UnitAttrName.FrozenTimeMultiplier) or 1
end

function DefendCarrotFrozenStateBuff:getMaxLifeTime()
	return checknumber(self._totalLifeTime) * checknumber(self._timeMultiplier)
end

return DefendCarrotFrozenStateBuff
