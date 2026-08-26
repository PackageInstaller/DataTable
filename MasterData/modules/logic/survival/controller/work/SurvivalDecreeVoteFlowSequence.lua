-- chunkname: @modules/logic/survival/controller/work/SurvivalDecreeVoteFlowSequence.lua

module("modules.logic.survival.controller.work.SurvivalDecreeVoteFlowSequence", package.seeall)

local SurvivalDecreeVoteFlowSequence = class("SurvivalDecreeVoteFlowSequence", FlowSequence)

function SurvivalDecreeVoteFlowSequence:isFlowDone()
	return self.status == WorkStatus.Done
end

function SurvivalDecreeVoteFlowSequence:tryJumpNextWork()
	local currWork = self._workList[self._curIndex]

	if not currWork then
		return
	end

	if currWork and currWork.canJump then
		currWork:onDone(true)
	end
end

return SurvivalDecreeVoteFlowSequence
