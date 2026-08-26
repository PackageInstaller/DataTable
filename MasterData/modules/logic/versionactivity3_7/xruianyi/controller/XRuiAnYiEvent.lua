-- chunkname: @modules/logic/versionactivity3_7/xruianyi/controller/XRuiAnYiEvent.lua

module("modules.logic.versionactivity3_7.xruianyi.controller.XRuiAnYiEvent", package.seeall)

local XRuiAnYiEvent = _M
local _get = GameUtil.getUniqueTb()

XRuiAnYiEvent.EpisodeFinished = _get()
XRuiAnYiEvent.OnBackToLevel = _get()
XRuiAnYiEvent.OneClickClaimReward = _get()
XRuiAnYiEvent.GuideOnEnterEpisode = _get()

return XRuiAnYiEvent
