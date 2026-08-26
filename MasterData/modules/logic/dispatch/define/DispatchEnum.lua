-- chunkname: @modules/logic/dispatch/define/DispatchEnum.lua

module("modules.logic.dispatch.define.DispatchEnum", package.seeall)

local DispatchEnum = _M

DispatchEnum.DispatchStatus = {
	Finished = 3,
	NotDispatch = 1,
	Dispatching = 2
}
DispatchEnum.DispatchShortedType = {
	Career = 1,
	HeroId = 2
}
DispatchEnum.ActId2View = {
	[VersionActivity1_8Enum.ActivityId.Dungeon] = ViewName.VersionActivity1_8DispatchView
}

return DispatchEnum
