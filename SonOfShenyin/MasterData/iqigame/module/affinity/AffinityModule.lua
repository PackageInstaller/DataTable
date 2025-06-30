-- chunkname: @IQIGame\\Module\\Affinity\\AffinityModule.lua

AffinityModule = {}

local this = AffinityModule

function this.Initialize()
	return
end

function this.ShutDown()
	return
end

function this.GetSortFavorArray(data)
	local favorData = {}

	for _, v in pairs(data) do
		if v.cid == 0 then
			table.insert(favorData, v)
		else
			local cfgGroup = CfgUtil.GetCfgFavorMessageGroupDataWithID(v.cid)

			if cfgGroup.HideCondition == 0 or not ConditionModule.Check(cfgGroup.HideCondition) then
				table.insert(favorData, v)
			end
		end
	end

	if #favorData > 1 then
		table.sort(favorData, function(a, b)
			return a.cid < b.cid
		end)
	end

	return favorData
end

function this.GetEntryOptionArray(entryId)
	local array = {}

	for _, v in pairsCfg(CfgFavorMessageOptionTable) do
		if v.EntryID == entryId then
			table.insert(array, v)
		end
	end

	table.sort(array, function(a, b)
		return a.Sort < b.Sort
	end)

	return array
end

function this.GetFavorText(entryId)
	local cfgEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(entryId)

	if not cfgEntry then
		return
	end

	if PlayerModule.GetSex() == Constant.PlayerSex.WoMen then
		return cfgEntry.ContextFemale
	else
		return cfgEntry.ContextMale
	end
end

function this.GetFavorIcon(entryId)
	local cfgEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(entryId)

	if not cfgEntry then
		return
	end

	if PlayerModule.GetSex() == Constant.PlayerSex.WoMen then
		return cfgEntry.IconFemale
	else
		return cfgEntry.IconMale
	end
end

function this.GetActiveArray(heroCid)
	local data = {}

	for _, v in pairs(CfgFavorMessageGroupTable) do
		if v.MessageType == 2 and v.HeroID == heroCid then
			table.insert(data, v)
		end
	end

	return data
end

function this.GetHeroHaveActive(heroCid)
	local activeArray = this.GetActiveArray(heroCid)
	local len = #activeArray

	if len == 0 then
		return false
	end

	for i = 1, len do
		if not PlayerModule.GetFinishedMessageGroup(activeArray[i].Id) then
			return true
		end
	end

	return false
end

function this.GetGroupStageCondition(heroCid)
	local condition
	local activeArray = this.GetActiveArray(heroCid)
	local len = #activeArray

	if len == 0 then
		return condition
	end

	table.sort(activeArray, function(a, b)
		return a.MessageStage < b.MessageStage
	end)

	for i = 1, len do
		if not PlayerModule.GetFinishedMessageGroup(activeArray[i].Id) then
			condition = activeArray[i].UnlockCondition

			break
		end
	end

	return condition
end

function this.GetEventIsNew(favorMsgGroupPod)
	local len = #favorMsgGroupPod.entrys

	if len == 0 then
		return
	end

	local lastEntryId = favorMsgGroupPod.entrys[len]
	local cfgLastEntry = CfgUtil.GetCfgFavorMessageEntryDataWithID(lastEntryId)

	return cfgLastEntry.IsLastEntry == -1
end

function this.GetAffinityHaveNew()
	local warlockList = WarlockModule.GetWarlockList()

	for _, warlockData in pairs(warlockList) do
		if warlockData.favor then
			for _, v in pairs(warlockData.favor) do
				if this.GetEventIsNew(v) then
					return true
				end
			end
		end
	end
end

function this.EntryOption(entryId, index)
	net_favor.entryOption(entryId, index)
end

function this.EntryComplete(entryId)
	net_favor.entryComplete(entryId)
end

function this.TriggerMessage(heroCid)
	net_favor.triggerMessage(heroCid)
end

function this.NotifyEntry(heroCid, groupId, entryId)
	WarlockModule.NotifyHeroFavor(heroCid, groupId, entryId)
	EventDispatcher.Dispatch(EventID.NetFavorResponse_NotifyEntry, heroCid, groupId, entryId)
end

function this.NotifyMessageFinish(finishMsgGroups)
	for i, v in pairs(finishMsgGroups) do
		PlayerModule.PlayerInfo.finishMsgGroups[i] = v
	end

	EventDispatcher.Dispatch(EventID.NetFavorResponse_NotifyMessageFinish)
end
