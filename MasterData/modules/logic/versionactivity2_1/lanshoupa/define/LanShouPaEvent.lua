-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/define/LanShouPaEvent.lua

module("modules.logic.versionactivity2_1.lanshoupa.define.LanShouPaEvent", package.seeall)

local LanShouPaEvent = _M
local _get = GameUtil.getUniqueTb()

LanShouPaEvent.StartEnterGameView = _get()
LanShouPaEvent.SetScenePos = _get()
LanShouPaEvent.EpisodeClick = _get()
LanShouPaEvent.OnEpisodeFinish = _get()
LanShouPaEvent.OneClickClaimReward = _get()

return LanShouPaEvent
