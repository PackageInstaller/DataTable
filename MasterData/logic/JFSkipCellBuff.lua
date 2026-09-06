-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/buff/JFSkipCellBuff.lua

module("logic.extensions.jumpfloor.view.buff.JFSkipCellBuff", package.seeall)

local JFSkipCellBuff = class("JFSkipCellBuff", BaseJumpFloorBuff)

function JFSkipCellBuff:excute()
	printInfo("test JFSkipCellBuff:excute JFSkipCellBuff")
	JFSkipCellBuff.super.excute(self)
	self._baseJumpFloorGame:skipCell()
end

return JFSkipCellBuff
