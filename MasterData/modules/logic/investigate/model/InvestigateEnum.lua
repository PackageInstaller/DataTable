-- chunkname: @modules/logic/investigate/model/InvestigateEnum.lua

module("modules.logic.investigate.model.InvestigateEnum", package.seeall)

local InvestigateEnum = _M

InvestigateEnum.OpinionStatus = {
	Locked = 1,
	Linked = 4,
	Unlinked = 2,
	UnlinkedExtend = 3,
	LinkedExtend = 5
}
InvestigateEnum.OpinionTab = {
	Extend = 2,
	Normal = 1
}
InvestigateEnum.OnceActionType = {
	ReddotClue = 4,
	StoryBtn = 3,
	InfoUnlock = 1,
	ClueUnlock = 2
}
InvestigateEnum.ExtendAnimName = {
	Right = "right",
	Middle = "middle",
	Left = "left"
}

return InvestigateEnum
