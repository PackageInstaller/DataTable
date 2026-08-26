-- chunkname: @modules/logic/versionactivity2_7/coopergarland/controller/CooperGarlandEvent.lua

module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandEvent", package.seeall)

local CooperGarlandEvent = _M
local _get = GameUtil.getUniqueTb()

CooperGarlandEvent.OnAct192InfoUpdate = _get()
CooperGarlandEvent.OnClickEpisode = _get()
CooperGarlandEvent.OneClickClaimReward = _get()
CooperGarlandEvent.ChangePanelAngle = _get()
CooperGarlandEvent.ResetJoystick = _get()
CooperGarlandEvent.OnRemoveModeChange = _get()
CooperGarlandEvent.OnRemoveComponent = _get()
CooperGarlandEvent.OnBallKeyChange = _get()
CooperGarlandEvent.OnChangeControlMode = _get()
CooperGarlandEvent.PlayFinishEpisodeStarVX = _get()
CooperGarlandEvent.FirstFinishEpisode = _get()
CooperGarlandEvent.PlayEnterNextRoundAnim = _get()
CooperGarlandEvent.OnEnterNextRound = _get()
CooperGarlandEvent.OnResetGame = _get()
CooperGarlandEvent.OnGameStopChange = _get()
CooperGarlandEvent.GuideOnEnterMap = _get()
CooperGarlandEvent.triggerGuideDialogue = _get()

return CooperGarlandEvent
