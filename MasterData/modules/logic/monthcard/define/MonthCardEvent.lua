-- chunkname: @modules/logic/monthcard/define/MonthCardEvent.lua

module("modules.logic.monthcard.define.MonthCardEvent", package.seeall)

local MonthCardEvent = _M

MonthCardEvent.onInfoChanged = GameUtil.getUniqueTb()
MonthCardEvent.onSignStateChanged = GameUtil.getUniqueTb()

return MonthCardEvent
