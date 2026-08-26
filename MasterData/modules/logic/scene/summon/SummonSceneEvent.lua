-- chunkname: @modules/logic/scene/summon/SummonSceneEvent.lua

module("modules.logic.scene.summon.SummonSceneEvent", package.seeall)

local SummonSceneEvent = _M

SummonSceneEvent.OnPreloadFinish = 1
SummonSceneEvent.OnPreloadFinishAtScene = 5
SummonSceneEvent.OnViewFinish = 10
SummonSceneEvent.OnSceneGOInited = 20
SummonSceneEvent.OnSceneAllGOInited = 30
SummonSceneEvent.OnEnterScene = 40

return SummonSceneEvent
