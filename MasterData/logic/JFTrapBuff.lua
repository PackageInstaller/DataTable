-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/buff/JFTrapBuff.lua

module("logic.extensions.jumpfloor.view.buff.JFTrapBuff", package.seeall)

local JFTrapBuff = class("JFTrapBuff", BaseJumpFloorBuff)

function JFTrapBuff:excute()
	printInfo("test JFTrapBuff:excute JFTrapBuff")
	JFTrapBuff.super.excute(self)
	self._baseJumpFloorGame:triggerTrap()
end

return JFTrapBuff
