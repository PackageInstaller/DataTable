-- chunkname: @modules/logic/assist/define/AssistEnum.lua

module("modules.logic.assist.define.AssistEnum", package.seeall)

local AssistEnum = _M

AssistEnum.MaxWearCount = 3
AssistEnum.BadgeStatus = {
	Finish = 3,
	Unstart = 1,
	Processing = 2
}
AssistEnum.DungeonType = {
	Tower = 2,
	Activity128General = 3,
	TowerCompose = 1,
	Activity229 = 4
}

return AssistEnum
