-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/buff/JFEmptyBuff.lua

module("logic.extensions.jumpfloor.view.buff.JFEmptyBuff", package.seeall)

local JFEmptyBuff = class("JFEmptyBuff", BaseJumpFloorBuff)

function JFEmptyBuff:ctor(baseJumpFloorGame)
	JFEmptyBuff.super.ctor(self, baseJumpFloorGame)
end

function JFEmptyBuff:excute()
	return
end

return JFEmptyBuff
