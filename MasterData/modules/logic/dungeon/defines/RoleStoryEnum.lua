-- chunkname: @modules/logic/dungeon/defines/RoleStoryEnum.lua

module("modules.logic.dungeon.defines.RoleStoryEnum", package.seeall)

local RoleStoryEnum = _M

RoleStoryEnum.DispatchType = {
	Normal = 2,
	Story = 1
}
RoleStoryEnum.TalkType = {
	Special = 2,
	Normal = 1
}
RoleStoryEnum.DispatchState = {
	Locked = 5,
	Canget = 4,
	Finish = 1,
	Dispatching = 2,
	Normal = 3
}
RoleStoryEnum.EffectConditionType = {
	Career = 2,
	Heros = 1
}
RoleStoryEnum.RoleStoryType = {
	Old = 2,
	New = 1
}

return RoleStoryEnum
