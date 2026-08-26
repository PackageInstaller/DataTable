-- chunkname: @modules/logic/versionactivity3_1/nationalgift/define/NationalGiftEnum.lua

module("modules.logic.versionactivity3_1.nationalgift.define.NationalGiftEnum", package.seeall)

local NationalGiftEnum = _M

NationalGiftEnum.Status = {
	HasGet = 2,
	NoGet = 0,
	CouldGet = 1
}

return NationalGiftEnum
