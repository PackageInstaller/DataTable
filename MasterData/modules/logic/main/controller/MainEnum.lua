-- chunkname: @modules/logic/main/controller/MainEnum.lua

module("modules.logic.main.controller.MainEnum", package.seeall)

local MainEnum = _M

MainEnum.SwitchType = {
	FightUI = 3,
	Scene = 2,
	Character = 1
}
MainEnum.MaxLockCount = 10

return MainEnum
