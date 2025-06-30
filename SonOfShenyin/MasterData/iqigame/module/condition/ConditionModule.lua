-- chunkname: @IQIGame\\Module\\Condition\\ConditionModule.lua

ConditionModule = {}

function ConditionModule.CheckMultipleCondition(conditionCidList)
	local result = true

	ForArray(conditionCidList, function(_, _conditionCid)
		result = ConditionModule.Check(_conditionCid)

		return not result
	end)

	return result
end

function ConditionModule.CheckMultiple(conditionCids)
	local results = {}

	for i = 1, #conditionCids do
		local result = ConditionModule.Check(conditionCids[i])

		table.insert(results, result)
	end

	return results
end

function ConditionModule.CheckConditionIsAllPass(conditionIds)
	return ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(conditionIds))
end

function ConditionModule.CheckMultipleAllIsPass(results)
	for k, v in pairs(results) do
		if v == false then
			return false
		end
	end

	return true
end

function ConditionModule.CheckOneOfMultipleIsPass(results)
	for k, v in pairs(results) do
		if v == true then
			return true
		end
	end

	return false
end

function ConditionModule.Check(conditionCid)
	if conditionCid == 0 then
		return true, nil
	end

	if conditionCid < 0 then
		return false, nil
	end

	local cfgConditionData = CfgConditionTable[conditionCid]

	if cfgConditionData == nil then
		logError("检查条件失败，Condition 配置表找不到对应条件ID：{0}", conditionCid)

		return false, {}
	end

	local results = {}
	local failedReasons = {}
	local result, failedReason

	for i = 1, #cfgConditionData.Type do
		if cfgConditionData.Type[i] > 0 then
			if cfgConditionData.EffectiveArea == Constant.ConditionConstant.AREA_MAZE then
				-- block empty
			else
				result, failedReason = ConditionModule.__CheckInner(cfgConditionData.Type[i], cfgConditionData.SubType[i], cfgConditionData.Params[i], cfgConditionData.ComparisonOP[i], cfgConditionData.Value[i], userData)
			end

			table.insert(results, result)
			table.insert(failedReasons, failedReason)
		end
	end

	result = results[1]
	failedReason = failedReasons[1]

	for i = 1, #cfgConditionData.LogicalOP do
		if string.lower(cfgConditionData.LogicalOP[i]) == "and" then
			failedReason = result and failedReasons[i + 1] or failedReason
			result = result and results[i + 1]
		elseif string.lower(cfgConditionData.LogicalOP[i]) == "or" then
			failedReason = result and failedReason or failedReasons[i + 1]
			result = result or results[i + 1]
		end
	end

	return result, failedReason
end

function ConditionModule.__CheckInner(type, subType, params, comparison, targetValue)
	if type == Constant.ConditionConstant.TYPE_FAIL then
		return false, ""
	end

	local checkResult = false
	local checkFailedReasonType

	if type == Constant.ConditionConstant.TYPE_PLAYER_ATT then
		if subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_LV then
			checkResult = ConditionModule.ComparisonValue(PlayerModule.PlayerInfo.baseInfo.pLv or 1, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PASS_LEVEL then
			if params[1] == Constant.ChapterPassType.TYPE_MAINLINE then
				checkResult = ConditionModule.ComparisonValueIn(StoryChapterModule.FinishDupList, targetValue, comparison)
			elseif params[1] == Constant.ChapterPassType.TYPE_RESOURCES then
				checkResult = ConditionModule.ComparisonValueIn(ResourceChapterModule.FinishDupList, targetValue, comparison)
			elseif params[1] == Constant.ChapterPassType.TYPE_EQUIP then
				checkResult = ConditionModule.ComparisonValueIn(EquipChapterModule.FinishDupList, targetValue, comparison)
			elseif params[1] == Constant.ChapterPassType.TYPE_BOSS then
				checkResult = ConditionModule.ComparisonValueIn(BossChapterModule.FinishDupList, targetValue, comparison)
			elseif params[1] == Constant.ChapterPassType.TYPE_CLIMB_TOWER then
				checkResult = ConditionModule.ComparisonValueIn(TowerChapterModule.FinishDupList, targetValue, comparison)
			elseif params[1] == Constant.ChapterPassType.TYPE_Challenge then
				checkResult = MapModule.CheckChallengeIsAllPass(targetValue)
			elseif params[1] == Constant.ChapterPassType.TYPE_BattleActivity then
				checkResult = ActivityDungeonModule.GetStageIsPass(targetValue)
			elseif params[1] == Constant.ChapterPassType.TYPE_SummerActivity then
				checkResult = ConditionModule.ComparisonValueIn(StoryChapterModule.FinishDupList, targetValue, comparison)
			end
		elseif subType == Constant.ConditionConstant.SUB_TYPE_FINISH_QUEST then
			checkResult = ConditionModule.ComparisonValueIn(TaskSystemModule.hasFinishTaskListValueByTaskID, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_FINISH_OPENFUNC then
			checkResult = UnlockFunctionModule.IsUnlock(targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_UNLOCKMAP then
			if params[1] == 1 then
				checkResult = true
			elseif params[1] == 2 then
				-- block empty
			end
		elseif subType == Constant.ConditionConstant.SUB_TYPE_TALENT then
			checkResult = UserInfoModule.GetTalentIsActive(targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_HASHERO then
			checkResult = ConditionModule.ComparisonValueIn(WarlockModule.WarlockDataList, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.Favor then
			local heroData = WarlockModule.GetHeroData(params[1])

			checkResult = heroData and targetValue <= heroData.favorabilityLevel or false
		elseif subType == Constant.ConditionConstant.ShopLevel then
			local lv = ShopModule.GetShopDataWithShopID(params[1]).level

			checkResult = targetValue <= lv
		elseif subType == Constant.ConditionConstant.SUB_TYPE_ACTIVITY_OPEN then
			if params[1] == -1 then
				checkResult = ActivityModule.IsOpenByTime(params[2])
			else
				local activityPods = ActivityModule.GetActivityPodByActivityType({
					params[1]
				})

				checkResult = #activityPods > 0
			end
		elseif subType == Constant.ConditionConstant.SUB_TYPE_TASK_EXIST then
			local taskData = TaskSystemModule.GetTaskDataByCid(targetValue)

			checkResult = taskData ~= nil
		elseif subType == Constant.ConditionConstant.SUB_TYPE_ActivityPassLv then
			checkResult = ConditionModule.ComparisonValue(ActivityPassModule.passLevel, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MonthCardDayRemain then
			checkResult = ConditionModule.ComparisonValue(tonumber(MonthCardModule.MonthCardEndTime) / 1000 - tonumber(MonthCardModule.MonthCardStartTime) / 1000, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PurchasedItem then
			local buyRecordData = PlayerModule.PlayerInfo.commodityBuyRecords[targetValue]

			checkResult = buyRecordData ~= nil and buyRecordData > 0
		elseif subType == Constant.ConditionConstant.SUB_TYPE_HaveItem then
			checkResult = WarehouseModule.DoesItExistItem(comparison, targetValue, false)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_Activity_State then
			local activityPod = ActivityModule.GetActivityPodByID(params[1])
			local state = activityPod ~= nil and activityPod.stage or 0

			checkResult = ConditionModule.ComparisonValue(state, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.Maze_Explore_Condition then
			local conditionType = params[1]

			if conditionType == 3 then
				local shopLevel = MazeModule.GetShopLevel()

				checkResult = ConditionModule.ComparisonValue(shopLevel, targetValue, comparison)
			elseif conditionType == 1 then
				local dayNum = MazeModule.GetMazeOpeningTime_Day()

				checkResult = ConditionModule.ComparisonValue(dayNum, targetValue, comparison)
			elseif conditionType == 2 then
				local exploreTime = MazeModule.GetMazeStageExploreTime()

				checkResult = ConditionModule.ComparisonValue(exploreTime, targetValue, comparison)
			else
				logError("迷宫条件子类型未实现逻辑,Condition params[1] ---> {0}", conditionType)
			end
		elseif subType == Constant.ConditionConstant.Maze_Event_Condition then
			local eventType = params[1]
			local totalCnt = MazeModule.GetMazeFinishEventCountByType(eventType)

			checkResult = ConditionModule.ComparisonValue(totalCnt, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.Maze_Special_Event_Condition then
			local eventCid = params[1]
			local totalCnt = MazeModule.GetMazeFinishEventCountByCid(eventCid)

			checkResult = ConditionModule.ComparisonValue(totalCnt, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.Maze_Talent_Condition then
			local talentData = MazeModule.GetSenroTalentData(targetValue)

			checkResult = talentData ~= nil
		elseif subType == Constant.ConditionConstant.Maze_Talent_Level_Condition then
			local talentCid = params[1]
			local talentData = MazeModule.GetSenroTalentData(talentCid)
			local level = 0

			if talentData ~= nil then
				level = talentData.level
			end

			checkResult = ConditionModule.ComparisonValue(level, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.Maze_Kill_Monster_Type then
			local monsterType = params[1]
			local killCount = MazeModule.GetKillMonsterTypeNum(monsterType)

			checkResult = ConditionModule.ComparisonValue(killCount, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.Maze_Senro_Level_Condition then
			checkResult = ConditionModule.ComparisonValue(MazeModule.GetSenroTalentLevel(), targetValue, comparison)
		elseif subType == Constant.ConditionConstant.TRIGGER_MAP_ACTION then
			local actionCid = params[1]
			local count = PlayerModule.GetSceneMapFinishActionsPod()[actionCid]

			count = count or 0

			if table.len(params) > 2 then
				if params[2] == 0 then
					count = count % params[3]
				elseif params[2] == 1 then
					count = count + params[3]
				elseif params[2] == 2 then
					count = count - params[3]
				elseif params[2] == 3 then
					count = count * params[2]
				elseif params[2] == 4 then
					count = count / params[3]
				end
			end

			checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.CHECK_TIME_SPAN then
			checkResult = WorldMapModule.GetTimeState() == targetValue
		elseif subType == Constant.ConditionConstant.CHECK_CURRENT_RPG_MAIN_TASK then
			local mainTask = WorldMapModule.GetCurrentMainTask()
			local mainTaskCid = 0
			local mainTaskCid = 0

			if mainTask then
				mainTaskCid = WorldMapModule.GetCurrentMainTask().cid
			end

			checkResult = ConditionModule.ComparisonValue(mainTaskCid, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.Maze_Clearance_Number then
			local diffcultyTime = MazeModule.__labyrinthDataPOD.diffcultyTime

			if diffcultyTime == nil or table.len(diffcultyTime) == 0 then
				checkResult = false
			else
				local passCount = MazeModule.GetStageClearanceNum(params[1])

				checkResult = ConditionModule.ComparisonValue(passCount, targetValue, comparison)
			end
		elseif subType == Constant.ConditionConstant.LABYRINTH_TAKE then
			-- block empty
		elseif subType == Constant.ConditionConstant.Check_AreaHasTriggerAction then
			checkResult = WorldMapModule.GetAreaHaveActiveAction(targetValue)
		elseif subType == Constant.ConditionConstant.Check_RegularState then
			if targetValue == 1 then
				checkResult = WorldMapModule.isRegularOn == true
			elseif targetValue == 2 then
				checkResult = WorldMapModule.isRegularOn == false
			end
		elseif subType == Constant.ConditionConstant.CHECK_RUNNING_TASK_TYPE then
			local len = #params
			local extendType = {}

			for i = 2, len do
				table.insert(extendType, params[i])
			end

			local count = #TaskSystemModule.GetSortForTypeDataList(params[1], extendType, TaskSystemModule.sortType.Id, true, true)

			checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.Check_Target_ActionCount then
			checkResult = false

			if params[1] == 1 then
				local room = WorldMapModule.GetRoomDataWithRoomID(params[2])

				if room then
					checkResult = ConditionModule.ComparisonValue(room:GetActionCount(), targetValue, comparison)
				end
			elseif params[1] == 2 then
				local component = WorldMapModule.GetComponentDataWithId(params[2])

				if component then
					checkResult = ConditionModule.ComparisonValue(component:GetActionCount(), targetValue, comparison)
				end
			end
		elseif subType == Constant.ConditionConstant.Check_RoomHasPlot then
			checkResult = false

			if params[1] == 1 then
				local area = WorldMapModule.GetAreaDataWithID(params[2])

				if area then
					local roomArray = area:GetUnlockRoomArray()

					for i = 1, #roomArray do
						if roomArray[i].currentPlot ~= 0 then
							checkResult = true

							break
						end
					end
				end
			elseif params[1] == 2 then
				local room = WorldMapModule.GetRoomDataWithRoomID(params[2])

				if room then
					checkResult = room.currentPlot ~= 0
				end
			else
				logError(string.format("【条件】区域或者房间拥有剧情条件 type = %s，没有目标类型 = %s", type, params[1]))
			end
		elseif subType == Constant.ConditionConstant.Check_TaskPickUp then
			local taskData = TaskSystemModule.GetTaskByPlayer(params[1])

			checkResult = taskData ~= nil
		elseif subType == Constant.ConditionConstant.Check_TaskState then
			local taskData = TaskSystemModule.GetTaskByPlayer(params[1])

			if taskData == nil then
				checkResult = false
			else
				checkResult = ConditionModule.ComparisonValue(taskData.status, targetValue, comparison)
			end
		elseif subType == Constant.ConditionConstant.Check_Time then
			local value = 0
			local type = params[1]
			local start = params[2]
			local theEnd = params[3]
			local now = os.date("*t", PlayerModule.GetServerTime())

			if type == 1 then
				local crrYearDay = tonumber(os.date("%j", PlayerModule.GetServerTime()))

				value = start <= crrYearDay and crrYearDay <= theEnd and 1 or 0
			elseif type == 2 then
				local currentMonthDay = now.day

				value = start <= currentMonthDay and currentMonthDay <= theEnd and 1 or 0
			elseif type == 3 then
				local currentWeekDay = now.wday

				currentWeekDay = currentWeekDay == 1 and 7 or currentWeekDay - 1
				value = start <= currentWeekDay and currentWeekDay <= theEnd and 1 or 0
			elseif type == 4 then
				local currentHour = now.hour

				value = start <= currentHour and currentHour <= theEnd and 1 or 0
			else
				error("【条件】检查时间--未知参数类型 type = " .. type)
			end

			return ConditionModule.ComparisonValue(value, targetValue, comparison)
		else
			warning("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.TYPE_ITEM then
		if subType == Constant.ConditionConstant.SUB_TYPE_ITEM_ID then
			checkResult = ConditionModule.ComparisonValue(WarehouseModule.GetItemNumByCfgID(params[1]), targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_USE_NOT_ENOUGH_ITEM, CfgItemTable[params[1]].Name)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_HAS_ITEM then
			local itemType = params[1]
			local itemSubType = params[2]

			for i = 1, #WarehouseModule.AllItems do
				if WarehouseModule.AllItems[i].Type == itemType and WarehouseModule.AllItems[i].SubType == itemSubType then
					checkResult = true

					break
				end
			end
		else
			warning("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.CURRENT_FIGHT then
		local value = GlobalBuffModule.GetConditionValue_CURRENT_FIGHT(params)

		checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
	else
		warning("error condition type : " .. type)
	end

	return checkResult, checkFailedReasonType
end

function ConditionModule.ComparisonValue(value, targetValue, comparison)
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

function ConditionModule.ComparisonValueIn(dict, targetValue, comparison, compareKey)
	if dict == nil then
		return false
	end

	if comparison == "==" then
		for i, v in pairs(dict) do
			if v == targetValue then
				return true
			end
		end

		return false
	elseif comparison == "!=" then
		for i, v in pairs(dict) do
			if compareKey then
				if i == targetValue then
					return false
				end
			elseif v == targetValue then
				return false
			end
		end

		return true
	else
		logError("Unsupported comparison : " .. comparison)
	end

	return false
end

function ConditionModule.GetDesc(conditionCid)
	local cfgConditionData = CfgConditionTable[conditionCid]

	return cfgConditionData.Name
end
