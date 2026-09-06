-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/jump/JumpRightCell.lua

module("logic.extensions.material.proxy.jump.JumpRightCell", package.seeall)

local JumpRightCell = class("JumpRightCell", JumpCell)

function JumpRightCell:ctor(target)
	JumpRightCell.super.ctor(self, target)
end

return JumpRightCell
