-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/buff/JFShieldBuff.lua

module("logic.extensions.jumpfloor.view.buff.JFShieldBuff", package.seeall)

local JFShieldBuff = class("JFShieldBuff", BaseJumpFloorBuff)

function JFShieldBuff:excute()
	printInfo("test JFSkipCellBuff:excute JFShieldBuff")
	JFShieldBuff.super.excute(self)
	self._baseJumpFloorGame:addShield()
end

return JFShieldBuff
