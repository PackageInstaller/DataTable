-- chunkname: @modules/logic/summonsimulationpick/event/SummonSimulationEvent.lua

module("modules.logic.summonsimulationpick.event.SummonSimulationEvent", package.seeall)

local SummonSimulationEvent = _M

SummonSimulationEvent.onGetSummonInfo = 0
SummonSimulationEvent.onSummonSimulation = 1
SummonSimulationEvent.onSaveResult = 2
SummonSimulationEvent.onSelectResult = 3
SummonSimulationEvent.onSelectItem = 4

return SummonSimulationEvent
