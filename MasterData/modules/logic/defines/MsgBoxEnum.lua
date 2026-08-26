-- chunkname: @modules/logic/defines/MsgBoxEnum.lua

module("modules.logic.defines.MsgBoxEnum", package.seeall)

local MsgBoxEnum = _M

MsgBoxEnum.BoxType = {
	Yes = 2,
	NO = 3,
	Yes_No = 1
}
MsgBoxEnum.CloseType = {
	Yes = 1,
	Close = 0,
	No = -1
}
MsgBoxEnum.optionType = {
	NotShow = 2,
	Daily = 1
}

return MsgBoxEnum
