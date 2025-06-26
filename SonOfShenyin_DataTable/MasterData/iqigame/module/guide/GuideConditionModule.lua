-- chunkname: @IQIGame\\Module\\Guide\\GuideConditionModule.lua

GuideConditionModule = {}

function GuideConditionModule.CheckGuideCondition(conditionData, cfgGuide)
	local checkResult = false
	local conditionType = conditionData[1]

	if conditionType == Constant.GuideConditionConstant.CheckPlayerLv then
		checkResult = GuideConditionModule.ComparisonValue(PlayerModule.PlayerInfo.baseInfo.pLv, tonumber(conditionData[3]), conditionData[2])
	elseif conditionType == Constant.GuideConditionConstant.CheckGuideFinished then
		checkResult = GuideConditionModule.CheckGuideFinish(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckGuideNoFinished then
		checkResult = GuideConditionModule.CheckGuideNoFinished(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckChapterFinished then
		checkResult = GuideConditionModule.CheckChapterFinished(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckChapterNoFinished then
		checkResult = not GuideConditionModule.CheckChapterFinished(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckMonsterTeamID then
		checkResult = GuideConditionModule.CheckMonsterTeamID(tonumber(conditionData[2]))
	elseif conditionType == Constant.GuideConditionConstant.CheckActiveOpen then
		local activityPod = ActivityModule.GetActivityPodByID(tonumber(conditionData[2]))

		checkResult = activityPod and activityPod.stage ~= 0 or false
	elseif conditionType == Constant.GuideConditionConstant.CheckDate then
		local timeStamp = cfgDateTimeToTimeStamp(conditionData[2], PlayerModule.TimeZone)

		checkResult = tonumber(timeStamp) >= PlayerModule.GetServerTime()
	elseif conditionType == Constant.GuideConditionConstant.CheckTaskState then
		local task = TaskSystemModule.GetTaskByConfig(tonumber(conditionData[2]))

		if task then
			checkResult = GuideConditionModule.ComparisonValue(task.status, tonumber(conditionData[4]), conditionData[3])
		else
			checkResult = false
		end
	elseif conditionType == Constant.GuideConditionConstant.CheckPlayerInRoom then
		local roomId = HomeModule.GetCurrentRoomCid()

		if roomId then
			checkResult = roomId == tonumber(conditionData[2])
		else
			checkResult = false
		end
	end

	if checkResult == false then
		local str = ""

		for i = 1, #conditionData do
			str = str .. conditionData[i] .. " "
		end

		log(string.format("新手引导 id = %s 检测条件失败 %s", cfgGuide.Id, str))
	end

	return checkResult
end

function GuideConditionModule.CheckGuideFinish(guideID)
	return GuideModule.finishGuide[guideID] ~= nil
end

function GuideConditionModule.CheckInactivatedGuide(guideID)
	if GuideConditionModule.CheckGuideFinish(guideID) then
		return false
	end

	if GuideModule.currentGuide ~= nil and GuideModule.currentGuide.Id == guideID then
		return false
	end

	if GuideModule.recoveryGuideID == guideID then
		return false
	end

	return true
end

function GuideConditionModule.CheckItemNum(cid, num)
	local have = WarehouseModule.GetItemNumByCfgID(cid)

	if num <= have then
		return true
	end

	return false
end

function GuideConditionModule.CheckChapterFinished(stageId)
	return MapModule.GetIsFinishByStageID(stageId)
end

function GuideConditionModule.CheckGuideNoFinished(guideID)
	return GuideModule.finishGuide[guideID] == nil
end

function GuideConditionModule.CheckMonsterTeamID(monsterTeamID)
	if not BattleModule.battleData or not BattleModule.battleData.fightPOD then
		return false
	end

	return BattleModule.battleData.fightPOD.MonsterTeamID == monsterTeamID
end

function GuideConditionModule.CheckNoFinishChapter(chapterID)
	return true
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
		logError(string.format("不支持的运算符类型 %s,value = %s,targetValue = %s", comparison, value, targetValue))
	end

	return false
end
