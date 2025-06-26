-- chunkname: @IQIGame\\Module\\GlobalBuff\\GlobalBuffModule.lua

GlobalBuffModule = {}

function GlobalBuffModule.Initialize()
	return
end

function GlobalBuffModule.Reload(globalBuffs)
	GlobalBuffModule.__globalBuffs = globalBuffs
end

function GlobalBuffModule.ShutDown()
	GlobalBuffModule.__globalBuffs = nil
end

function GlobalBuffModule.OnGlobalBuffChange(globalBuffs)
	local addBuffTable = {}
	local removeBuffTable = {}

	ForPairs(globalBuffs, function(_buffCid, _buffPOD)
		if _buffPOD.status == Constant.GlobalBuffStatus.Remove then
			GlobalBuffModule.__globalBuffs[_buffCid] = nil

			table.insert(removeBuffTable, _buffCid)

			return
		end

		local lastData = GlobalBuffModule.__globalBuffs[_buffCid]

		if lastData ~= nil then
			if lastData.StackCount < _buffPOD.StackCount then
				table.insert(addBuffTable, _buffCid)
			end
		else
			table.insert(addBuffTable, _buffCid)
		end

		GlobalBuffModule.__globalBuffs[_buffCid] = _buffPOD
	end)
	EventDispatcher.Dispatch(EventID.NotifyGlobalBuffChange, addBuffTable, removeBuffTable)
end

function GlobalBuffModule.GetBuffIDList(effectType)
	return GlobalBuffModule.__GetBuffList(effectType, true)
end

function GlobalBuffModule.GetBuffPODList(effectType)
	return GlobalBuffModule.__GetBuffList(effectType, false)
end

function GlobalBuffModule.__GetBuffList(effectType, isIDList)
	local result = {}

	ForPairs(GlobalBuffModule.__globalBuffs, function(_buffCid, _buffPOD)
		if effectType ~= 0 then
			local cfg = GlobalBuffModule.GetBuffCfg(_buffCid)

			if cfg.TriggerType ~= effectType then
				return
			end
		end

		if isIDList then
			table.insert(result, _buffCid)
		else
			table.insert(result, _buffPOD)
		end
	end)

	return result
end

function GlobalBuffModule.GetBuffPODData(buffCid)
	return GlobalBuffModule.__globalBuffs[buffCid]
end

function GlobalBuffModule.ForPairs(func)
	ForPairs(GlobalBuffModule.__globalBuffs, func)
end

function GlobalBuffModule.GetBuffCfg(buffCid)
	return CfgGlobalBuffTable[buffCid]
end

function GlobalBuffModule.GetBuffDurationTime(buffCfg, buffData)
	if buffCfg.DurationTime <= 0 then
		return 0
	end

	return buffCfg.DurationTime * buffData.StackCount
end

function GlobalBuffModule.GetBuffTriggerCount(buffCfg, buffData)
	return buffCfg.TriggerMaxNumber * buffData.StackCount - buffData.triggerCount
end

function GlobalBuffModule.SetConditionData_CURRENT_FIGHT(chapterType, chapterCid, stageCid, monsterTeamCid)
	GlobalBuffModule.__FightConditionData = {}
	GlobalBuffModule.__FightConditionData.chapterType = TryToNumber(chapterType, 0)
	GlobalBuffModule.__FightConditionData.chapterCid = TryToNumber(chapterCid, 0)
	GlobalBuffModule.__FightConditionData.stageCid = TryToNumber(stageCid, 0)

	local monsterCfg = CfgMonsterTeamTable[monsterTeamCid]

	GlobalBuffModule.__FightConditionData.monsterTag = TryToTable(monsterTag, false, monsterCfg.DailyDupTag)
end

function GlobalBuffModule.GetConditionValue_CURRENT_FIGHT(params)
	if GlobalBuffModule.__FightConditionData == nil then
		return 0
	end

	local chapterType = params[1]

	if chapterType ~= -1 and chapterType ~= GlobalBuffModule.__FightConditionData.chapterType then
		return 0
	end

	local chapterCid = params[2]

	if chapterCid ~= -1 and chapterCid ~= GlobalBuffModule.__FightConditionData.chapterCid then
		return 0
	end

	local stageCid = params[3]

	if stageCid ~= -1 and stageCid ~= GlobalBuffModule.__FightConditionData.stageCid then
		return 0
	end

	local monsterTag = params[5]

	if monsterTag ~= -1 then
		local isIn, _ = ValueInArray(GlobalBuffModule.__FightConditionData.monsterTag, monsterTag)

		if not isIn then
			return 0
		end
	end

	return 1
end

function GlobalBuffModule.ClearConditionData_CURRENT_FIGHT()
	GlobalBuffModule.__FightConditionData = {}
end
