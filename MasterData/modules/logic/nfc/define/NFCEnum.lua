-- chunkname: @modules/logic/nfc/define/NFCEnum.lua

module("modules.logic.nfc.define.NFCEnum", package.seeall)

local NFCEnum = _M

NFCEnum.NFCVersion = {
	OpenFunction = 1
}
NFCEnum.NFCVersionDic = {
	[NFCEnum.NFCVersion.OpenFunction] = 1
}
NFCEnum.NFCVFunctionType = {
	PlayerCard = 81,
	BGMSwitch = 76
}

return NFCEnum
