-- chunkname: @modules/logic/versionactivity3_0/karong/controller/KaRongDrawEvent.lua

module("modules.logic.versionactivity3_0.karong.controller.KaRongDrawEvent", package.seeall)

local KaRongDrawEvent = _M
local _get = GameUtil.getUniqueTb()

KaRongDrawEvent.InitGameDone = _get()
KaRongDrawEvent.OnBeginDragPawn = _get()
KaRongDrawEvent.OnEndDragPawn = _get()
KaRongDrawEvent.SwitchLineState = _get()
KaRongDrawEvent.OnGameFinished = _get()
KaRongDrawEvent.OnStartDialog = _get()
KaRongDrawEvent.OnFinishDialog = _get()
KaRongDrawEvent.GuideStart = _get()
KaRongDrawEvent.OnTriggerEffectDone = _get()
KaRongDrawEvent.EnableTriggerEffect = _get()
KaRongDrawEvent.UpdateAvatarPos = _get()
KaRongDrawEvent.UsingSkill = _get()
KaRongDrawEvent.SkillCntChange = _get()

return KaRongDrawEvent
