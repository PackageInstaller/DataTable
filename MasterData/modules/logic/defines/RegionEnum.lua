-- chunkname: @modules/logic/defines/RegionEnum.lua

module("modules.logic.defines.RegionEnum", package.seeall)

local RegionEnum = _M

RegionEnum.en = 1
RegionEnum.jp = 2
RegionEnum.zh = 3
RegionEnum.tw = 4
RegionEnum.ko = 5
RegionEnum.shortcutTab = {
	[RegionEnum.en] = "en",
	[RegionEnum.jp] = "jp",
	[RegionEnum.zh] = "zh",
	[RegionEnum.tw] = "tw",
	[RegionEnum.ko] = "ko"
}
RegionEnum.utcOffset = {
	[RegionEnum.en] = -18000,
	[RegionEnum.jp] = 32400,
	[RegionEnum.zh] = 28800,
	[RegionEnum.tw] = 28800,
	[RegionEnum.ko] = 32400
}

return RegionEnum
