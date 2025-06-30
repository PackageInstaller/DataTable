-- chunkname: @IQIGame\\Module\\ActiveVote\\ActiveVoteModule.lua

local m = {}

function m.Reload()
	return
end

function m.CheckAllVotePoint()
	if ActiveOperationEventModule.opEventsStatus then
		for i, v in pairs(ActiveOperationEventModule.opEventsStatus) do
			local cfg = CfgOperateEventsControlTable[v.eventCfgId]

			if cfg.Type == Constant.Activity_Operation_Type.Activity_Vote then
				local top = m.CheckVoteRedPoint(v.eventCfgId)

				if top then
					return true
				end
			end
		end
	end

	return false
end

function m.CheckVoteRedPoint(operateEventID)
	local operationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(operateEventID)

	if operationEventDataPOD then
		local have = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.PANDA_VOTE)

		if have > 0 then
			return true
		end
	end

	return false
end

function m.GetMostPopularData()
	local num = 0
	local id = 0

	if m.centerVoteDataPOD then
		for i, v in pairs(m.centerVoteDataPOD.votes) do
			if num <= v then
				num = v
				id = i
			end
		end
	end

	return id, num
end

function m.Shutdown()
	return
end

function m.GetVoteInfo(eventId)
	net_centerEventVote.getVoteInfo(eventId)
end

function m.Vote(eventId, voteId)
	net_operationsVote.vote(eventId, voteId)
end

function m.GetVoteInfoResult(centerVoteDataPOD)
	m.centerVoteDataPOD = centerVoteDataPOD

	EventDispatcher.Dispatch(EventID.UpdateVoteEvent)
end

function m.VoteResult(eventId, voteId, getItems)
	if #getItems > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, getItems)
	end

	NoticeModule.ShowNotice(21045038)
	m.GetVoteInfo(eventId)
end

ActiveVoteModule = m
