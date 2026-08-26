-- chunkname: @modules/logic/fight/flow/FightViewHandCardParallelFlow.lua

module("modules.logic.fight.flow.FightViewHandCardParallelFlow", package.seeall)

local FightViewHandCardParallelFlow = class("FightViewHandCardParallelFlow", FlowParallel)

function FightViewHandCardParallelFlow:ctor(...)
	FightViewHandCardParallelFlow.super.ctor(self, ...)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowCreate, self)
end

function FightViewHandCardParallelFlow:start(context)
	FightViewHandCardParallelFlow.super.start(self, context)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowStart, self)
end

function FightViewHandCardParallelFlow:onDone(isSuccess)
	FightViewHandCardParallelFlow.super.onDone(self, isSuccess)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowEnd, self)
end

function FightViewHandCardParallelFlow:stop()
	FightViewHandCardParallelFlow.super.stop(self)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowEnd, self)
end

return FightViewHandCardParallelFlow
