-- chunkname: @modules/logic/limited/controller/LimitedRoleEnum.lua

module("modules.logic.limited.controller.LimitedRoleEnum", package.seeall)

local LimitedRoleEnum = _M

LimitedRoleEnum.Stage = {
	FirstLogin = 1,
	SwitchRole = 5,
	MainVisibleClick = 3,
	SceneBack = 2,
	SummonGet = 4
}

return LimitedRoleEnum
