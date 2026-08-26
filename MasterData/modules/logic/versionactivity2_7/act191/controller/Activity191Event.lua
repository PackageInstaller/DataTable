-- chunkname: @modules/logic/versionactivity2_7/act191/controller/Activity191Event.lua

module("modules.logic.versionactivity2_7.act191.controller.Activity191Event", package.seeall)

local Activity191Event = _M
local _get = GameUtil.getUniqueTb()

Activity191Event.GameInfoUpdatePush = _get()
Activity191Event.UpdateGameInfo = _get()
Activity191Event.UpdateBadgeMo = _get()
Activity191Event.EndGame = _get()
Activity191Event.UpdateTeamInfo = _get()
Activity191Event.ClickHeroEditItem = _get()
Activity191Event.ClickCollectionItem = _get()
Activity191Event.ZTrigger31501 = _get()
Activity191Event.ZTrigger31502 = _get()
Activity191Event.ZTrigger31503 = _get()
Activity191Event.ZTrigger31504 = _get()

return Activity191Event
