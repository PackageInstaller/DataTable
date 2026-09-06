-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/model/PinBallEnum.lua

module("logic.extensions.pinball.model.PinBallEnum", package.seeall)

local PinBallEnum = {}

PinBallEnum.ReBoundDirect = {
	Left = 3,
	Up = 2,
	Right = 1
}
PinBallEnum.BrickSide = {
	Down = 8,
	Up = 2,
	Right = 1,
	UpRight = 3,
	UpLeft = 4,
	DownRight = 7,
	Left = 5,
	DownLeft = 6
}
PinBallEnum.BrickType = {
	Default = 1,
	Wall = 3,
	Line = 2
}
PinBallEnum.PropType = {
	AddBall = 1,
	GetPrize = 3,
	AddBoardLen = 2,
	None = 0
}

return PinBallEnum
