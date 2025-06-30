-- chunkname: @IQIGame\\Net\\NetFavorResponse.lua

function net_favor.triggerMessageResult(code)
	return
end

function net_favor.entryCompleteResult(code)
	return
end

function net_favor.entryOptionResult(code, optionCid, shows)
	EventDispatcher.Dispatch(EventID.NetFavorResponse_EntryOptionResultEvent, optionCid)
end

function net_favor.notifyEntry(heroCid, groupId, entryId)
	AffinityModule.NotifyEntry(heroCid, groupId, entryId)
end

function net_favor.notifyMessageFinish(finishMsgGroups)
	AffinityModule.NotifyMessageFinish(finishMsgGroups)
end
