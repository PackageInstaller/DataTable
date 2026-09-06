-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGamePenetrateBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGamePenetrateBuff", package.seeall)

local OriMatGamePenetrateBuff = class("OriMatGamePenetrateBuff", OriMatGameChangeModeBuff)

function OriMatGamePenetrateBuff:onAdd(target)
	OriMatGamePenetrateBuff.super.onAdd(self, target)
	GameUtil.callBack(self._unit.changeMode, self._unit, OriMatGameEnum.BuffChangeMode.Penetrate)
end

function OriMatGamePenetrateBuff:onRemove(unit)
	OriMatGamePenetrateBuff.super.onRemove(self, unit)
	GameUtil.callBack(self._unit.resetMode, self._unit, OriMatGameEnum.BuffChangeMode.Penetrate)
end

return OriMatGamePenetrateBuff
