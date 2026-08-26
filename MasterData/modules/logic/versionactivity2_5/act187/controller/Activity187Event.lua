-- chunkname: @modules/logic/versionactivity2_5/act187/controller/Activity187Event.lua

module("modules.logic.versionactivity2_5.act187.controller.Activity187Event", package.seeall)

local Activity187Event = _M
local _get = GameUtil.getUniqueTb()

Activity187Event.GetAct187Info = _get()
Activity187Event.FinishPainting = _get()
Activity187Event.GetAccrueReward = _get()
Activity187Event.RefreshAccrueReward = _get()
Activity187Event.PaintViewDisplayChange = _get()

return Activity187Event
