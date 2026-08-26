-- chunkname: @modules/logic/versionactivity2_8/molideer/controller/MoLiDeErEvent.lua

module("modules.logic.versionactivity2_8.molideer.controller.MoLiDeErEvent", package.seeall)

local MoLiDeErEvent = _M
local _get = GameUtil.getUniqueTb()

MoLiDeErEvent.OnFinishEpisode = _get()
MoLiDeErEvent.OneClickClaimReward = _get()
MoLiDeErEvent.OnReceiveEpisodeInfo = _get()
MoLiDeErEvent.OnClickEpisodeItem = _get()
MoLiDeErEvent.GameExit = _get()
MoLiDeErEvent.GameReset = _get()
MoLiDeErEvent.GameSkip = _get()
MoLiDeErEvent.GameInfoUpdate = _get()
MoLiDeErEvent.GameDispatchTeam = _get()
MoLiDeErEvent.GameUseItem = _get()
MoLiDeErEvent.GameFinishEventShowEnd = _get()
MoLiDeErEvent.GameUIRefresh = _get()
MoLiDeErEvent.GameWithdrawTeam = _get()
MoLiDeErEvent.GameTipRecycle = _get()
MoLiDeErEvent.GameItemSelect = _get()
MoLiDeErEvent.GameTeamSelect = _get()
MoLiDeErEvent.GameOptionSelect = _get()
MoLiDeErEvent.GameEventSelect = _get()
MoLiDeErEvent.GuideNewEvent = _get()
MoLiDeErEvent.UIWithDrawTeam = _get()
MoLiDeErEvent.UIDispatchTeam = _get()

return MoLiDeErEvent
