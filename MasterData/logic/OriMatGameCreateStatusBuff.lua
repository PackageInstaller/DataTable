-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameCreateStatusBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameCreateStatusBuff", package.seeall)

local OriMatGameCreateStatusBuff = class("OriMatGameCreateStatusBuff", OriMatGameDotBuff)

function OriMatGameCreateStatusBuff:initComplete()
	OriMatGameCreateStatusBuff.super.initComplete(self)

	self._status = self._tiggerParam[self:gPId()]
end

function OriMatGameCreateStatusBuff:onAdd(target)
	OriMatGameCreateStatusBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.addNewStatus, self._unit, self._status)
end

function OriMatGameCreateStatusBuff:onRemove(unit)
	OriMatGameCreateStatusBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.removeStatus, self._unit, self._status)
end

function OriMatGameCreateStatusBuff:onBuffTrigger()
	return
end

return OriMatGameCreateStatusBuff
