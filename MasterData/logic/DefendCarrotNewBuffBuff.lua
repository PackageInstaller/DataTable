-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotNewBuffBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotNewBuffBuff", package.seeall)

local DefendCarrotNewBuffBuff = class("DefendCarrotNewBuffBuff", DefendCarrotBuffBase)

function DefendCarrotNewBuffBuff:initComplete()
	DefendCarrotNewBuffBuff.super.initComplete(self)

	self._newAddBuffId = checknumber(self._tiggerParam[self:gPId()])
	self._targetStr = tostring(self._tiggerParam[self:gPId()])
end

function DefendCarrotNewBuffBuff:onBuffTrigger()
	local unit = self._unit

	if self._targetStr == "target" then
		unit = self._target

		self._target:addBuffByBuffId(self._newAddBuffId, self._unit)
	elseif self._targetStr == "owner" then
		-- block empty
	elseif self._targetStr == "self" then
		unit:addBuffByBuffId(self._newAddBuffId, self._unit)
	end
end

return DefendCarrotNewBuffBuff
