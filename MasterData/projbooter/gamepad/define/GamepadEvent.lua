-- chunkname: @projbooter/gamepad/define/GamepadEvent.lua

module("projbooter.gamepad.define.GamepadEvent", package.seeall)

local GamepadEvent = _M

GamepadEvent.AxisChange = 1
GamepadEvent.KeyUp = 2
GamepadEvent.KeyDown = 3

return GamepadEvent
