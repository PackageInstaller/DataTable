-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/miniparty/define/MiniPartyEnum.lua

module("modules.logic.versionactivity3_4.laplaceforum.miniparty.define.MiniPartyEnum", package.seeall)

local MiniPartyEnum = _M

MiniPartyEnum.InviteType = {
	Friend = 2,
	Code = 1,
	Check = 3
}
MiniPartyEnum.TaskItemType = {
	GetAll = 1,
	Waiting = 2,
	Normal = 0
}
MiniPartyEnum.TaskType = {
	SelfTask = 0,
	GroupTask = 1
}
MiniPartyEnum.FriendType = {
	Normal = 1,
	None = 0
}
MiniPartyEnum.ConstId = {
	LucyRainTasks = 2,
	FriendLimitCount = 1
}

return MiniPartyEnum
