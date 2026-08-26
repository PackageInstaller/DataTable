-- chunkname: @projbooter/gamepad/define/GamepadEnum.lua

module("projbooter.gamepad.define.GamepadEnum", package.seeall)

local GamepadEnum = _M

GamepadEnum.KeyCode = {
	LT = "LT",
	LeftStickHorizontal = "LeftStickHorizontal",
	RT = "RT",
	RB = "RB",
	LB = "LB",
	LeftStickVertical = "LeftStickVertical",
	A = "A",
	RightStickVertical = "RightStickVertical",
	RightStickHorizontal = "RightStickHorizontal",
	B = "B"
}

return GamepadEnum
