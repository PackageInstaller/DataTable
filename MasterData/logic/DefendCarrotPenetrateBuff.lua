-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotPenetrateBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotPenetrateBuff", package.seeall)

local DefendCarrotPenetrateBuff = class("DefendCarrotPenetrateBuff", DefendCarrotChangeModeBuff)

function DefendCarrotPenetrateBuff:onAdd(target)
	DefendCarrotPenetrateBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.changeMode, self._unit, DefendCarrotEnum.BuffChangeMode.Penetrate)
end

function DefendCarrotPenetrateBuff:onRemove(unit)
	DefendCarrotPenetrateBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.resetMode, self._unit, DefendCarrotEnum.BuffChangeMode.Penetrate)
end

return DefendCarrotPenetrateBuff
