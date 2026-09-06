-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotCreateStatusBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotCreateStatusBuff", package.seeall)

local DefendCarrotCreateStatusBuff = class("DefendCarrotCreateStatusBuff", DefendCarrotDotBuff)

function DefendCarrotCreateStatusBuff:initComplete()
	DefendCarrotCreateStatusBuff.super.initComplete(self)

	self._status = self._tiggerParam[self:gPId()]
end

function DefendCarrotCreateStatusBuff:onAdd(target)
	DefendCarrotCreateStatusBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.addNewStatus, self._unit, self._status)
end

function DefendCarrotCreateStatusBuff:onRemove(unit)
	DefendCarrotCreateStatusBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.removeStatus, self._unit, self._status)
end

function DefendCarrotCreateStatusBuff:onBuffTrigger()
	return
end

return DefendCarrotCreateStatusBuff
