-- chunkname: @modules/logic/fight/controller/replay/FightReplayWorkWaitRoundEnd.lua

module("modules.logic.fight.controller.replay.FightReplayWorkWaitRoundEnd", package.seeall)

local FightReplayWorkWaitRoundEnd = class("FightReplayWorkWaitRoundEnd", BaseWork)

function FightReplayWorkWaitRoundEnd:ctor()
	return
end

function FightReplayWorkWaitRoundEnd:onStart()
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, self._onRoundEnd, self)
end

function FightReplayWorkWaitRoundEnd:_onRoundEnd()
	self:onDone(true)
end

function FightReplayWorkWaitRoundEnd:clearWork()
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, self._onRoundEnd, self)
end

return FightReplayWorkWaitRoundEnd
