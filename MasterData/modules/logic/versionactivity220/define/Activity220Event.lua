-- chunkname: @modules/logic/versionactivity220/define/Activity220Event.lua

module("modules.logic.versionactivity220.define.Activity220Event", package.seeall)

local Activity220Event = _M
local make = GameUtil.getUniqueTb()

Activity220Event.GetAct220InfoReply = make()
Activity220Event.SaveEpisodeProgressReply = make()
Activity220Event.FinishEpisodeReply = make()
Activity220Event.ChooseEpisodeBranchReply = make()
Activity220Event.EpisodePush = make()
Activity220Event.EpisodeFinished = make()
Activity220Event.ClientGameExit = make()

return Activity220Event
