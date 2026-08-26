-- chunkname: @modules/logic/sp01/act205/define/Act205Event.lua

module("modules.logic.sp01.act205.define.Act205Event", package.seeall)

local Act205Event = _M
local _get = GameUtil.getUniqueTb()

Act205Event.OnInfoUpdate = _get()
Act205Event.OnDailyRefresh = _get()
Act205Event.OnFinishGame = _get()
Act205Event.PlayerSelectCard = _get()

return Act205Event
