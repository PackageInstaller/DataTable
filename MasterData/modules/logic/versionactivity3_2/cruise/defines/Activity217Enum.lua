-- chunkname: @modules/logic/versionactivity3_2/cruise/defines/Activity217Enum.lua

module("modules.logic.versionactivity3_2.cruise.defines.Activity217Enum", package.seeall)

local Activity217Enum = _M

Activity217Enum.ActType = {
	MultiCoin = 2,
	MultiExp = 1
}
Activity217Enum.DungeonChapter = {
	[Activity217Enum.ActType.MultiExp] = DungeonEnum.ChapterId.ResourceExp,
	[Activity217Enum.ActType.MultiCoin] = DungeonEnum.ChapterId.ResourceGold
}

return Activity217Enum
