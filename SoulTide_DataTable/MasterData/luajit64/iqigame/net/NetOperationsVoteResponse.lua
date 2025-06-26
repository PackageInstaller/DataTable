-- chunkname: @IQIGame\\Net\\NetOperationsVoteResponse.lua

function net_operationsVote.voteResult(code, eventId, voteId, getItems)
	ActiveVoteModule.VoteResult(eventId, voteId, getItems)
end
