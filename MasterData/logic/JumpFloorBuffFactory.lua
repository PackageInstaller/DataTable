-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/buff/JumpFloorBuffFactory.lua

module("logic.extensions.jumpfloor.view.buff.JumpFloorBuffFactory", package.seeall)

local JumpFloorBuffFactory = class("JumpFloorBuffFactory")

function JumpFloorBuffFactory:ctor()
	return
end

function JumpFloorBuffFactory.create(buffType, baseJumpFloorGame)
	if buffType == JumpFloorCellData.ECellType.Trap then
		return JFTrapBuff.New(baseJumpFloorGame)
	elseif buffType == JumpFloorCellData.ECellType.Shield then
		return JFShieldBuff.New(baseJumpFloorGame)
	elseif buffType == JumpFloorCellData.ECellType.SkipCell then
		return JFSkipCellBuff.New(baseJumpFloorGame)
	else
		return JFEmptyBuff.New(baseJumpFloorGame)
	end
end

return JumpFloorBuffFactory
