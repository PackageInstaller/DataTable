-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/defendcarrot/model/buff/DefendCarrotTimedDestructionBuff.lua

module("logic.extensions.defendcarrot.model.buff.DefendCarrotTimedDestructionBuff", package.seeall)

local DefendCarrotTimedDestructionBuff = class("DefendCarrotTimedDestructionBuff", DefendCarrotDotBuff)

function DefendCarrotTimedDestructionBuff:onRemove(unit)
	DefendCarrotTimedDestructionBuff.super.onRemove(self, unit)
	DefendCarrotGameController.instance:preReCycle(self._unit)
end

return DefendCarrotTimedDestructionBuff
