-- chunkname: @modules/logic/reactivity/define/ReactivityEnum.lua

module("modules.logic.reactivity.define.ReactivityEnum", package.seeall)

local ReactivityEnum = _M

ReactivityEnum.ActivityDefine = {
	[VersionActivity3_9Enum.ActivityId.Reactivity] = {
		storeCurrency = CurrencyEnum.CurrencyType.V3a2Dungeon,
		storeActId = VersionActivity3_9Enum.ActivityId.ReactivityStore
	}
}

return ReactivityEnum
