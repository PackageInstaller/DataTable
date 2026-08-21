-- chunkname: @IQIGame\\Module\\ActiveCupVoting\\ActiveCupVotingModule.lua

local m = {}

function m.Reload()
	m.AddListeners()
end

function m.AddListeners()
	return
end

function m.RemoveListeners()
	return
end

function m.CheckAllCupVotingRedPoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_Cup_Voting then
				local top = m.CheckCupVotingRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function m.CheckCupVotingRedPoint(operateEventID)
	local count = m.GetCupVotingTickets(operateEventID)

	return count > 0
end

function m.GetCfgGlobalData(operateEventID)
	local operationEventPOD = ActiveOperationEventModule.GetActiveOperationData(operateEventID)

	if operationEventPOD then
		return CfgCupMatchVoteGlobalTable[operationEventPOD.dataCfgId]
	end

	return nil
end

function m.GetCupVotingTickets(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD and operationEventDataPOD.cupMatchVoteDataPOD then
		return operationEventDataPOD.cupMatchVoteDataPOD.tickets
	end

	return 0
end

function m.GetMemberNoteNum(cid)
	local num = 0

	if m.centerCupMatchVoteDataPOD and m.centerCupMatchVoteDataPOD.votes then
		num = m.centerCupMatchVoteDataPOD.votes[cid]
	end

	num = num == nil and 0 or num

	return num
end

function m.GetMemberLastVoteTime(cid)
	local num = 0

	if m.centerCupMatchVoteDataPOD and m.centerCupMatchVoteDataPOD.lastVoteTime then
		num = m.centerCupMatchVoteDataPOD.lastVoteTime[cid]
	end

	num = num == nil and 0 or num

	return num
end

function m.GetGroupName(operateEventID, groupNum)
	local operationEventPOD = ActiveOperationEventModule.GetActiveOperationData(operateEventID)

	if operationEventPOD then
		local cfgGlobalData = CfgCupMatchVoteGlobalTable[operationEventPOD.dataCfgId]

		if m.centerCupMatchVoteDataPOD then
			if m.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_GroupStage then
				return cfgGlobalData.GroupName[groupNum]
			else
				return cfgGlobalData.KnockoutGroupName[groupNum]
			end
		end
	end

	return ""
end

function m.GetCupVoteTeamData(operateEventID)
	local tab = {}

	if m.centerCupMatchVoteDataPOD then
		if m.centerCupMatchVoteDataPOD.stage == Constant.CupVotingStage.CupVoting_GroupStage then
			local operationEventDataPOD = ActiveOperationEventModule.GetActiveOperationData(operateEventID)

			if operationEventDataPOD then
				for i, v in pairsCfg(CfgCupMatchVoteGroupTable) do
					if v.Group == operationEventDataPOD.dataCfgId then
						if tab[v.GroupNum] == nil then
							tab[v.GroupNum] = {}
						end

						table.insert(tab[v.GroupNum], v.Id)
					end
				end
			end
		else
			for id, group in pairs(m.centerCupMatchVoteDataPOD.group) do
				if tab[group] == nil then
					tab[group] = {}
				end

				table.insert(tab[group], id)
			end
		end
	end

	return tab
end

function m.Shutdown()
	m.centerCupMatchVoteDataPOD = nil

	m.RemoveListeners()
end

function m.Vote(eventId, voteId)
	net_operationsCupMatchVote.vote(eventId, voteId)
end

function m.GetVoteInfo(eventId)
	net_centerEventCupMatchVote.getVoteInfo(eventId)
end

function m.VoteResult(eventId, voteId, getItems)
	NoticeModule.ShowNotice(21045038)

	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end

	m.GetVoteInfo(eventId)
end

function m.GetVoteInfoResult(centerCupMatchVoteDataPOD)
	m.centerCupMatchVoteDataPOD = centerCupMatchVoteDataPOD

	EventDispatcher.Dispatch(EventID.UpdateCupVoteEvent)
end

ActiveCupVotingModule = m
