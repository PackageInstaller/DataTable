-- chunkname: @projbooter/gamepad/define/GamepadKeyMapEnum.lua

module("projbooter.gamepad.define.GamepadKeyMapEnum", package.seeall)

local GamepadKeyMapEnum = _M

GamepadKeyMapEnum.KeyMap = {
	BEITONG = {
		GamepadXBoxKey,
		GamepadXBoxKey_Android
	},
	XIAOM = {
		GamepadXBoxKey,
		GamepadXBoxKey_Android
	}
}

return GamepadKeyMapEnum
