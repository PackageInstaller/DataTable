-- chunkname: @IQIGame\\Net\\NetOperationsCupMatchViteResponse.lua

function net_operationsCupMatchVote.voteResult(code, eventID, voteId, getItems)
	ActiveCupVotingModule.VoteResult(eventID, voteId, getItems)
end
