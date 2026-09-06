-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameTimedDestructionBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameTimedDestructionBuff", package.seeall)

local OriMatGameTimedDestructionBuff = class("OriMatGameTimedDestructionBuff", OriMatGameDotBuff)

function OriMatGameTimedDestructionBuff:onRemove(unit)
	OriMatGameTimedDestructionBuff.super.onRemove(self, unit)
	OriMatGameGameController.instance:preReCycle(self._unit)
end

return OriMatGameTimedDestructionBuff
