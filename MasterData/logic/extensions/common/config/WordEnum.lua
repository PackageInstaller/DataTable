-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/config/WordEnum.lua

module("logic.extensions.common.config.WordEnum", package.seeall)

local WordEnum = {}

WordEnum.WordType = {
	Tag = 2,
	Buff = 1,
	Proper = 3
}
WordEnum.NetRAM = "网络接入RAM"
WordEnum.LvLimit = "等级压制"

return WordEnum
