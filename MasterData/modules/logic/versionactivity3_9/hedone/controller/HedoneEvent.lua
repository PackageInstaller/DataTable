-- chunkname: @modules/logic/versionactivity3_9/hedone/controller/HedoneEvent.lua

module("modules.logic.versionactivity3_9.hedone.controller.HedoneEvent", package.seeall)

local HedoneEvent = _M
local _get = GameUtil.getUniqueTb()

HedoneEvent.OnGameReset = _get()
HedoneEvent.RefreshGameView = _get()
HedoneEvent.OnAddEntity = _get()
HedoneEvent.OnAddEntities = _get()
HedoneEvent.OnEntityTakeDamage = _get()
HedoneEvent.OnRemoveEntity = _get()
HedoneEvent.RefreshEntityMove = _get()
HedoneEvent.OnStartNewMonsterWave = _get()
HedoneEvent.EntityPlayEffect = _get()
HedoneEvent.EntityPlayAnim = _get()
HedoneEvent.ShowVisualEffect = _get()
HedoneEvent.RefreshSkillCDProgress = _get()
HedoneEvent.OnSecondRefresh = _get()
HedoneEvent.OnEntityAttributeChange = _get()
HedoneEvent.OnPlayerExpChange = _get()
HedoneEvent.OnPlayerAddSkill = _get()
HedoneEvent.GuideOpenGameView = _get()
HedoneEvent.GuideOpenSkillGet = _get()

return HedoneEvent
