-- chunkname: @modules/logic/scene/fight/FightSceneEvent.lua

module("modules.logic.scene.fight.FightSceneEvent", package.seeall)

local FightSceneEvent = _M

FightSceneEvent.OnAllEntityLoaded = 101
FightSceneEvent.OnPreloadFinish = 102
FightSceneEvent.OnPrepareFinish = 103

return FightSceneEvent
