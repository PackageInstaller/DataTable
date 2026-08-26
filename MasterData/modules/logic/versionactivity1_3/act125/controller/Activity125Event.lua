-- chunkname: @modules/logic/versionactivity1_3/act125/controller/Activity125Event.lua

module("modules.logic.versionactivity1_3.act125.controller.Activity125Event", package.seeall)

local Activity125Event = {}
local _get = GameUtil.getUniqueTb()

Activity125Event.DataUpdate = _get()
Activity125Event.OnFMScrollValueChange = _get()
Activity125Event.OnChannelSelected = _get()
Activity125Event.OnChannelItemClick = _get()
Activity125Event.EpisodeFinished = _get()
Activity125Event.EpisodeUnlock = _get()
Activity125Event.SwitchEpisode = _get()
Activity125Event.OnClickFile = _get()
Activity125Event.OnGameFinished = _get()

return Activity125Event
