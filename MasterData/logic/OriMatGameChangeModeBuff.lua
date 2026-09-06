-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameChangeModeBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameChangeModeBuff", package.seeall)

local OriMatGameChangeModeBuff = class("OriMatGameChangeModeBuff", OriMatGameBuffBase)

function OriMatGameChangeModeBuff:initComplete()
	OriMatGameChangeModeBuff.super.initComplete(self)

	self._modeName = tostring(self._tiggerParam[self:gPId()])
end

function OriMatGameChangeModeBuff:onAdd(target)
	OriMatGameChangeModeBuff.super.onAdd(self, target)
end

function OriMatGameChangeModeBuff:onRemove(unit)
	OriMatGameChangeModeBuff.super.onRemove(self, unit)
end

return OriMatGameChangeModeBuff
