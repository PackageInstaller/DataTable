-- chunkname: @IQIGame\\Module\\Guide\\GuideConditionModule.lua

GuideConditionModule = {}

function GuideConditionModule.CheckGuideCondition(conditionData)
	local checkResult = false
	local conditionType = conditionData[1]

	if conditionType == Constant.GuideConditionConstant.CheckTask then
		checkResult = GuideConditionModule.GetTaskSteps(tonumber(conditionData[2]), tonumber(conditionData[3]))
	elseif conditionType == Constant.GuideConditionConstant.CheckPlayerLv then
		checkResult = GuideConditionModule.ComparisonValue(PlayerModule.PlayerInfo.baseInfo.pLv, tonumber(conditionData[3]), conditionData[2])
	elseif conditionType == Constant.GuideConditionConstant.CheckGuideID then
		checkResult = GuideConditionModule.CheckGuideFinish(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CustomsClearance then
		checkResult = GuideConditionModule.CustomsClearance(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckNewStoryId then
		checkResult = GuideConditionModule.CheckNewStoryId(tonumber(conditionData[2]), tonumber(conditionData[3]))
	elseif conditionType == Constant.GuideConditionConstant.CheckSoulLv then
		checkResult = GuideConditionModule.CheckSoulLv(tonumber(conditionData[2]), tonumber(conditionData[3]))
	elseif conditionType == Constant.GuideConditionConstant.CheckItemNum then
		checkResult = GuideConditionModule.CheckItemNum(tonumber(conditionData[2]), tonumber(conditionData[3]))
	elseif conditionType == Constant.GuideConditionConstant.CheckSoulPrefab then
		checkResult = GuideConditionModule.CheckSoulPrefab(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckInactivatedGuide then
		checkResult = GuideConditionModule.CheckInactivatedGuide(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckIsMyHomeLand then
		checkResult = GuideConditionModule.CheckIsMyHomeLand(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckHomelandRoomUnlock then
		checkResult = GuideConditionModule.CheckHomelandRoomUnlock(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckIsEnterMaze then
		checkResult = GuideConditionModule.CheckIsEnterMaze(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckHaveSoul then
		checkResult = GuideConditionModule.CheckHaveSoul(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckTownPlotEvent then
		checkResult = GuideConditionModule.CheckTownPlotEvent(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckTalentUnlock then
		checkResult = GuideConditionModule.CheckTalentUnlock(tonumber(conditionData[2]), tonumber(conditionData[3]))
	elseif conditionType == Constant.GuideConditionConstant.CheckDailyDupOpen then
		checkResult = GuideConditionModule.CheckDailyDupOpen(tonumber(conditionData[2]))
	end

	if checkResult == false then
		local str = ""

		for i = 1, #conditionData do
			str = str .. conditionData[i] .. " "
		end

		if GameEntry.Base.DevMode then
			log("新手引导条件检测失败.." .. str)
		end
	end

	return checkResult
end

function GuideConditionModule.CheckDailyDupOpen(cfgID)
	local isOpen = DailyDupModule.IsFunctionOpen(cfgID)
	local isOpenTime = DailyDupModule.IsOpenTime(cfgID)

	return isOpen and isOpenTime
end

function GuideConditionModule.CheckTalentUnlock(soulID, talentID)
	local soulData = SoulModule.GetSoulData(soulID)
	local unlock = table.indexOf(soulData.talentCids, talentID) == -1

	return unlock
end

function GuideConditionModule.CheckTownPlotEvent(eventID)
	local result = TownModule.IsHaveFunctionPlotByID(eventID)

	return result
end

function GuideConditionModule.CheckHaveSoul(soulID)
	local soulData = SoulModule.GetSoulData(soulID)

	return soulData.isUnlock
end

function GuideConditionModule.CheckIsEnterMaze(value)
	return PlayerModule.PlayerInfo.quickChallenge[value] == nil
end

function GuideConditionModule.CheckHomelandRoomUnlock(value)
	local roomData = HomeLandLuaModule.GetRoomDataByID(value)
	local cfgRoom = CfgHomeLandRoomTable[value]

	if cfgRoom.IsOpen == false and roomData == nil then
		return true
	end

	return false
end

function GuideConditionModule.CheckIsMyHomeLand(value)
	return not HomeLandLuaModule.isVisitHome
end

function GuideConditionModule.CheckGuideFinish(guideID)
	return GuideModule.CheckGuideFinish(guideID)
end

function GuideConditionModule.CheckInactivatedGuide(guideID)
	return GuideModule.CheckInactivatedGuide(guideID)
end

function GuideConditionModule.CheckSoulPrefab(cid)
	local isUnlock = SoulPrefabModule.CheckPrefabIsUnlock(cid)

	return not isUnlock
end

function GuideConditionModule.CheckItemNum(cid, num)
	local have = WarehouseModule.GetItemNumByCfgID(cid)

	if num <= have then
		return true
	end

	return false
end

function GuideConditionModule.CheckSoulLv(soulCid, lv)
	local soulData = SoulModule.GetSoulData(soulCid)

	if soulData and lv <= soulData.lv then
		return true
	end

	return false
end

function GuideConditionModule.CheckNewStoryId(cfgId, index)
	local memoryStoryInfo = MemoryNewModule.dictMemoryStoryInfo[cfgId]

	if memoryStoryInfo then
		local openNum, totalNum = memoryStoryInfo:GetChapterData()

		if index <= openNum then
			return true
		end
	end

	return false
end

function GuideConditionModule.CustomsClearance(mazeCid)
	return PlayerModule.IsMazeFinished(mazeCid)
end

function GuideConditionModule.GetTaskSteps(taskID, step)
	local result = false
	local taskState = 0
	local taskData = TaskModule.GetProcessingTaskByCid(taskID)

	if TaskModule.FinishTasksTable[taskID] ~= nil then
		taskState = 3
	elseif taskData ~= nil then
		taskState = 1

		if taskData.finNum >= taskData.tgtNum then
			taskState = 2
		end
	end

	if taskState == step then
		result = true
	else
		logError("任务状态不匹配.." .. taskID .. " 当前状态 = " .. taskState .. " 配置状态 = " .. step)
	end

	return result
end

function GuideConditionModule.ComparisonValue(value, targetValue, comparison)
	if comparison == ">=" then
		return targetValue <= value
	elseif comparison == "<=" then
		return value <= targetValue
	elseif comparison == ">" then
		return targetValue < value
	elseif comparison == "<" then
		return value < targetValue
	elseif comparison == "!=" then
		return value ~= targetValue
	elseif comparison == "==" then
		return value == targetValue
	else
		logError("Unsupported comparison : " .. comparison)
	end

	return false
end
