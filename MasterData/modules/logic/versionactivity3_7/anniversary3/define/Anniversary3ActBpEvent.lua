-- chunkname: @modules/logic/versionactivity3_7/anniversary3/define/Anniversary3ActBpEvent.lua

module("modules.logic.versionactivity3_7.anniversary3.define.Anniversary3ActBpEvent", package.seeall)

local Anniversary3ActBpEvent = _M

Anniversary3ActBpEvent.OnGetInfo = GameUtil.getUniqueTb()
Anniversary3ActBpEvent.OnGetBonus = GameUtil.getUniqueTb()
Anniversary3ActBpEvent.OnUpdateScore = GameUtil.getUniqueTb()
Anniversary3ActBpEvent.OnBuySuccess = GameUtil.getUniqueTb()
Anniversary3ActBpEvent.OnSelectTaskTab = GameUtil.getUniqueTb()

return Anniversary3ActBpEvent
