-- chunkname: @modules/logic/fight/flow/FightViewHandCardSequenceFlow.lua

module("modules.logic.fight.flow.FightViewHandCardSequenceFlow", package.seeall)

local FightViewHandCardSequenceFlow = class("FightViewHandCardSequenceFlow", FlowSequence)

function FightViewHandCardSequenceFlow:ctor(name, ...)
	self.name = name

	FightViewHandCardSequenceFlow.super.ctor(self, ...)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowCreate, self)
end

function FightViewHandCardSequenceFlow:start(context)
	FightViewHandCardSequenceFlow.super.start(self, context)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowStart, self)
end

function FightViewHandCardSequenceFlow:onDone(isSuccess)
	FightViewHandCardSequenceFlow.super.onDone(self, isSuccess)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowEnd, self)
end

function FightViewHandCardSequenceFlow:stop()
	FightViewHandCardSequenceFlow.super.stop(self)
	FightController.instance:dispatchEvent(FightEvent.OnHandCardFlowEnd, self)
end

return FightViewHandCardSequenceFlow
