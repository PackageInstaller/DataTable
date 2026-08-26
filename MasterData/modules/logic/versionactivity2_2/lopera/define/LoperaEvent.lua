-- chunkname: @modules/logic/versionactivity2_2/lopera/define/LoperaEvent.lua

module("modules.logic.versionactivity2_2.lopera.define.LoperaEvent", package.seeall)

local LoperaEvent = _M
local _get = GameUtil.getUniqueTb()

LoperaEvent.EpisodeClick = _get()
LoperaEvent.ClickOtherEpisode = _get()
LoperaEvent.GoodItemClick = _get()
LoperaEvent.BeforeEnterEpisode = _get()
LoperaEvent.EnterEpisode = _get()
LoperaEvent.EpisodeMove = _get()
LoperaEvent.SelectOption = _get()
LoperaEvent.EpisodeUpdate = _get()
LoperaEvent.EpisodeFinish = _get()
LoperaEvent.ComposeDone = _get()
LoperaEvent.OneClickClaimReward = _get()
LoperaEvent.ExitGame = _get()
LoperaEvent.EndlessUnlock = _get()

return LoperaEvent
