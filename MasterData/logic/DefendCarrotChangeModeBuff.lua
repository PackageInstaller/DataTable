-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotChangeModeBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotChangeModeBuff", package.seeall)

local DefendCarrotChangeModeBuff = class("DefendCarrotChangeModeBuff", DefendCarrotBuffBase)

function DefendCarrotChangeModeBuff:initComplete()
	DefendCarrotChangeModeBuff.super.initComplete(self)

	self._modeName = tostring(self._tiggerParam[self:gPId()])
end

function DefendCarrotChangeModeBuff:onAdd(target)
	DefendCarrotChangeModeBuff.super.onAdd(self, target)
end

function DefendCarrotChangeModeBuff:onRemove(unit)
	DefendCarrotChangeModeBuff.super.onRemove(self, unit)
end

return DefendCarrotChangeModeBuff
