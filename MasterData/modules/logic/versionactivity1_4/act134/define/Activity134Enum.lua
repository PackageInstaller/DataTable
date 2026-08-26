-- chunkname: @modules/logic/versionactivity1_4/act134/define/Activity134Enum.lua

module("modules.logic.versionactivity1_4.act134.define.Activity134Enum", package.seeall)

local Activity134Enum = _M

Activity134Enum.StroyStatus = {
	Finish = 1,
	Orgin = 2
}
Activity134Enum.AnimName = {
	CutRight = "switch_right",
	CutLeft = "switch_left",
	Open = "open"
}

return Activity134Enum
