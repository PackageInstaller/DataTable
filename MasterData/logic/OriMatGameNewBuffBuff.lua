-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameNewBuffBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameNewBuffBuff", package.seeall)

local OriMatGameNewBuffBuff = class("OriMatGameNewBuffBuff", OriMatGameBuffBase)

function OriMatGameNewBuffBuff:initComplete()
	OriMatGameNewBuffBuff.super.initComplete(self)

	self._newAddBuffId = checknumber(self._tiggerParam[self:gPId()])
	self._targetStr = tostring(self._tiggerParam[self:gPId()])
end

function OriMatGameNewBuffBuff:onBuffTrigger()
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

return OriMatGameNewBuffBuff
