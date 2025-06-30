-- chunkname: @IQIGame\\Module\\Condition\\ConditionModule.lua

ConditionModule = {}
ConditionModule.Maze = require("IQIGame.Module.Condition.Maze.MazeConditionModule")
ConditionModule.MemoryStory = require("IQIGame.Module.Condition.MemoryStory.MemoryStoryConditionModule")

function ConditionModule.Check(conditionCid)
	if conditionCid <= 0 then
		return true, nil
	end

	local cfgConditionData = CfgConditionTable[conditionCid]
	local results = {}
	local failedReasons = {}
	local result, failedReason

	for i = 1, #cfgConditionData.Type do
		if cfgConditionData.Type[i] > 0 then
			if cfgConditionData.EffectiveArea == Constant.ConditionConstant.AREA_MAZE then
				result, failedReason = ConditionModule.Maze.__CheckInner(cfgConditionData.Type[i], cfgConditionData.SubType[i], cfgConditionData.Params[i], cfgConditionData.ComparisonOP[i], cfgConditionData.Value[i])
			elseif cfgConditionData.EffectiveArea == Constant.ConditionConstant.MEMORY_STORY then
				result, failedReason = ConditionModule.MemoryStory.__CheckInner(cfgConditionData.Type[i], cfgConditionData.SubType[i], cfgConditionData.Params[i], cfgConditionData.ComparisonOP[i], cfgConditionData.Value[i])
			else
				result, failedReason = ConditionModule.__CheckInner(cfgConditionData.Type[i], cfgConditionData.SubType[i], cfgConditionData.Params[i], cfgConditionData.ComparisonOP[i], cfgConditionData.Value[i])
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
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_USE_LV_TOO_LOW, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_ENERGY then
			checkResult = ConditionModule.ComparisonValue(PlayerModule.GetNumAttrValue(Constant.ItemID.ENERGY), targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_USE_NOT_ENOUGH_ENERGY, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PASS_LEVEL then
			checkResult = ConditionModule.ComparisonValueIn(PlayerModule.PlayerInfo.quickChallenge, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_MAZE_NOT_PASS, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_FINISH_QUEST then
			checkResult = ConditionModule.ComparisonValueIn(TaskModule.FinishTasksTable, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_NOT_FIND_FINISH_QUEST, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_FINISH_TARGET_QUEST then
			local targetFinishedQuests = {}

			for cid, serverTaskData in pairs(TaskModule.CurrentTasksTable) do
				if serverTaskData.finNum >= serverTaskData.tgtNum then
					table.insert(targetFinishedQuests, cid)
				end
			end

			checkResult = ConditionModule.ComparisonValueIn(targetFinishedQuests, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_NOT_FIND_FINISH_QUEST, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_FUNCTION_TYPE then
			checkResult = ConditionModule.ComparisonValueIn(PlayerModule.PlayerInfo.functionTypes, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "condition check fail"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_HSA_DRESS then
			local unlockDress = {}

			for k, v in pairs(DressModule.dressDataDic) do
				if v.hasOwned then
					table.insert(unlockDress, k)
				end
			end

			checkResult = ConditionModule.ComparisonValueIn(unlockDress, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "condition check fail"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_REFUNDS_GIFT then
			local unlockId = {}

			for k, v in pairs(PlayerModule.PlayerInfo.refundsGiftPacks) do
				table.insert(unlockId, k)
			end

			checkResult = ConditionModule.ComparisonValueIn(unlockId, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "condition check fail"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_EQUIP_SKINS then
			local unlockId = {}

			for k, v in pairs(PlayerModule.PlayerInfo.equipSkins) do
				table.insert(unlockId, k)
			end

			checkResult = ConditionModule.ComparisonValueIn(unlockId, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "condition check fail"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_TOWER_MAX_FLOOR then
			checkResult = ConditionModule.ComparisonValue(ChallengeTowerModule.towerDailyPOD.towerPOD.nowLayer, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "condition check fail"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_UNLOCK_SOUL then
			local unlockSouls = {}

			for k, v in pairs(SoulModule.GetUnlockSoulDataDic()) do
				table.insert(unlockSouls, k)
			end

			checkResult = ConditionModule.ComparisonValueIn(unlockSouls, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_CONDITION_UNLOCK_SOUL, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_HAS_QUEST then
			local hasTask = {}

			for k, v in pairs(TaskModule.CurrentTasksTable) do
				if not v.IsFail and v.finNum < v.tgtNum then
					table.insert(hasTask, k)
				end
			end

			checkResult = ConditionModule.ComparisonValueIn(hasTask, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_NOT_FIND_HAS_QUEST, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_UNLOCK_EVENT then
			checkResult = ConditionModule.ComparisonValueIn(PlayerModule.PlayerInfo.unlockedEvents, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_NOT_FIND_UNLOCK_EVENT, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_TOWN_STORY then
			checkResult = ConditionModule.ComparisonValueIn(PlayerModule.PlayerInfo.unlockTownEvents, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_NOT_FIND_UNLOCK_EVENT, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_SOUL_WHISPER then
			checkResult = ConditionModule.ComparisonValueIn(PlayerModule.PlayerInfo.unlockSoulWhispers, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_SOUL_LV_LACK_OF_RANK, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_FISHING_SPECIMEN_COUNT then
			local value = getTableLength(FishingModule.specimenData)

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "Params is not fit , value = " .. value .. ", targetValue=" .. targetValue .. ", comparison=" .. comparison
		elseif subType == Constant.ConditionConstant.SUB_SOUL_LEVEL then
			local soulData = SoulModule.GetSoulData(params[1])
			local lv = soulData.lv

			checkResult = ConditionModule.ComparisonValue(lv, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_SOUL_LV_LACK_OF_RANK, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_SOUL_FAVOR then
			local soulData = SoulModule.GetSoulData(params[1])
			local lv = soulData.favorLv

			checkResult = ConditionModule.ComparisonValue(lv, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_SOUL_LV_LACK_OF_RANK, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_SOUL_OATH then
			local soulData = SoulModule.GetSoulData(params[1])
			local oathActivation = soulData.oathActivation and 1 or 0

			checkResult = ConditionModule.ComparisonValue(oathActivation, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_SOUL_LV_LACK_OF_RANK, targetValue)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_PARAMS then
			local value = 0

			for i = 1, #params do
				if PlayerModule.PlayerInfo.playerParams[params[i]] == nil then
					value = value + CfgPlayerParamTable[params[i]].Value
				else
					value = value + PlayerModule.PlayerInfo.playerParams[params[i]]
				end
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "Params is not fit , value = " .. value .. ", targetValue=" .. targetValue .. ", comparison=" .. comparison
		elseif subType == Constant.ConditionConstant.SUB_TYPE_DATING_PARAMS then
			logError("客户端不参与判断条件类型：1-14")
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_MAZE_SCORE then
			local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[params[1]]
			local value = 0

			if mazeInfoPOD ~= nil then
				value = mazeInfoPOD.score
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_LOTTERY_SHOW_COUNT then
			local lotteryShowPOD = LotteryModule.GetLotteryShowPOD(params[1])

			checkResult = ConditionModule.ComparisonValue(lotteryShowPOD.drawCount, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_MALL_BUY_COUNT then
			local count = PlayerModule.PlayerInfo.mallBuyCountHistory[params[1]] or 0

			checkResult = ConditionModule.ComparisonValue(count, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_ATT_SUM_PAY then
			checkResult = ConditionModule.ComparisonValue(PlayerModule.PlayerInfo.baseInfo.sumPay, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_PLAYER_HEAD then
			local unlockHead = PlayerModule.PlayerInfo.unlockHeadIcons

			checkResult = ConditionModule.ComparisonValueIn(unlockHead, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "condition check fail unlockHead"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_PLAYER_PLAYER_MAZE then
			checkResult = ConditionModule.ComparisonValueIn(PlayerModule.PlayerInfo.finishMazes, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_MAZE_NOT_PASS, targetValue)
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
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

			checkFailedReasonType = checkResult and "" or getTipText(Constant.TipConst.TIP_USE_NOT_ENOUGH_ITEM, CfgItemTable[params[1]].Name)
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.TYPE_TIME then
		local timeStamp = PlayerModule.GetServerTime()
		local dateTable = getDateTimeTable(timeStamp)

		if subType == Constant.ConditionConstant.SUB_TYPE_TIME_DAY then
			checkResult = ConditionModule.ComparisonValue(dateTable.day, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "time is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_TIME_HOUR then
			checkResult = ConditionModule.ComparisonValue(dateTable.hour, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "time is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_TIME_MINUTE then
			checkResult = ConditionModule.ComparisonValue(dateTable.min, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "time is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_TIME_MONTH then
			checkResult = ConditionModule.ComparisonValue(dateTable.month, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "time is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_TIME_WEEK then
			dateTable = getDateTimeTable(timeStamp - 14400)

			local wday = dateTable.wday

			wday = wday == 1 and 7 or wday - 1
			checkResult = ConditionModule.ComparisonValue(wday, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "time is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_TIME_YEAR then
			checkResult = ConditionModule.ComparisonValue(dateTable.year, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "time is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_TIME_TIMESTAMP then
			checkResult = ConditionModule.ComparisonValue(timeStamp, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "time is not in specified range"
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.TYPE_WEATHER then
		if subType == Constant.ConditionConstant.SUB_TYPE_WEATHER then
			checkResult = ConditionModule.ComparisonValue(WeatherModule.currentWeatherCid, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "weather is not matched"
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.TYPE_REGISTERED_TIME then
		if subType == Constant.ConditionConstant.SUB_TYPE_REGISTERED_TIME_STAMP_SEC then
			checkResult = ConditionModule.ComparisonValue(PlayerModule.PlayerInfo.baseInfo.createTime, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "time is not in specified range"
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.TYPE_MONSTER_ACADEMY then
		if subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_TIME_DAY_AT then
			local day_type = params[1]
			local cfgTime = MonsterAcademyModule.GetCfgGalGameDataByDayNum(MonsterAcademyModule.SaveDataDetailPOD.basePOD.day)

			if day_type == Constant.ConditionConstant.CONDITION_TYPE_DAY then
				checkResult = ConditionModule.ComparisonValue(cfgTime.DayNum, targetValue, comparison)
				checkFailedReasonType = checkResult and "" or "CONDITION_TYPE_DAY is not in specified range"
			elseif day_type == Constant.ConditionConstant.CONDITION_TYPE_WEEK then
				checkResult = ConditionModule.ComparisonValue(cfgTime.WeekNum, targetValue, comparison)
				checkFailedReasonType = checkResult and "" or "CONDITION_TYPE_WEEK is not in specified range"
			elseif day_type == Constant.ConditionConstant.CONDITION_TYPE_MONTH then
				checkResult = ConditionModule.ComparisonValue(cfgTime.Month, targetValue, comparison)
				checkFailedReasonType = checkResult and "" or "CONDITION_TYPE_MONTH is not in specified range"
			elseif day_type == Constant.ConditionConstant.CONDITION_TYPE_YEAR then
				checkResult = ConditionModule.ComparisonValue(cfgTime.Year, targetValue, comparison)
				checkFailedReasonType = checkResult and "" or "CONDITION_TYPE_YEAR is not in specified range"
			elseif day_type == Constant.ConditionConstant.CONDITION_TYPE_DAY_OF_WEEK then
				checkResult = ConditionModule.ComparisonValue(cfgTime.Week, targetValue, comparison)
				checkFailedReasonType = checkResult and "" or "CONDITION_TYPE_DAY_OF_WEEK is not in specified range"
			elseif day_type == Constant.ConditionConstant.CONDITION_TYPE_DAY_OF_MONTH then
				checkResult = ConditionModule.ComparisonValue(cfgTime.Day, targetValue, comparison)
				checkFailedReasonType = checkResult and "" or "CONDITION_TYPE_DAY_OF_MONTH is not in specified range"
			end
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_TIME_PHASE_OF_DAY then
			checkResult = ConditionModule.ComparisonValue(MonsterAcademyModule.SaveDataDetailPOD.basePOD.dayOfPhase, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_MONSTER_ACADEMY_TIME_PHASE_OF_DAY is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_TIME_TRIGGER_COUNT then
			local value = 0
			local eventType = params[1]
			local eventID = params[2]
			local MiniGalGameCountPOD = MonsterAcademyModule.SaveDataDetailPOD.triggeredCount[eventID]

			if MiniGalGameCountPOD then
				if eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_DAY then
					value = MiniGalGameCountPOD.recordCountOfDay
				elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_WEEK then
					value = MiniGalGameCountPOD.recordCountOfWeek
				elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_MONTH then
					value = MiniGalGameCountPOD.recordCountOfMonth
				elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_YEAR then
					value = MiniGalGameCountPOD.recordCountOfYear
				elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_ALL then
					value = MiniGalGameCountPOD.recordCountOfTotal
				end
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_MONSTER_ACADEMY_TIME_TRIGGER_COUNT is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_ROLE_PROPERTIES then
			local value = 0

			if MonsterAcademyModule.SaveDataDetailPOD.basePOD.baseProps[params[1]] ~= nil then
				value = MonsterAcademyModule.SaveDataDetailPOD.basePOD.baseProps[params[1]]
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_GIRLS_FAVOR then
			local value = 0
			local monsterAcademyGirlData = MonsterAcademyModule.girlDic[params[1]]

			if monsterAcademyGirlData then
				value = monsterAcademyGirlData.girlDataPOD.favorAbility
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_MONSTER_ACADEMY_GIRLS_FAVOR is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_GIRLS_CONTACT then
			local value = 0
			local monsterAcademyGirlData = MonsterAcademyModule.girlDic[params[1]]

			if monsterAcademyGirlData then
				value = monsterAcademyGirlData.girlDataPOD.phoneLock
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_MONSTER_ACADEMY_GIRLS_CONTACT is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_ITEM then
			local value = MonsterAcademyModule.GetItemNum(params[1])

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_MONSTER_ACADEMY_ITEM is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_FINISHED_TASK then
			checkResult = ConditionModule.ComparisonValueIn(MonsterAcademyModule.SaveDataDetailPOD.taskList, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "condition check fail"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_CALLBACK_COUNT then
			local value = 0
			local monsterAcademyGirlData = MonsterAcademyModule.girlDic[params[1]]

			if monsterAcademyGirlData then
				value = monsterAcademyGirlData.girlDataPOD.callCount
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_MONSTER_ACADEMY_CALLBACK_COUNT is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_MONSTER_ACADEMY_CANCEL_DATING_COUNT then
			local value = 0
			local monsterAcademyGirlData = MonsterAcademyModule.girlDic[params[1]]

			if monsterAcademyGirlData then
				value = monsterAcademyGirlData.girlDataPOD.noShow
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_MONSTER_ACADEMY_CANCEL_DATING_COUNT is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_GAL_GAME_PLAY_THROUGH_COUNT then
			local value = MonsterAcademyModule.SaveDataDetailPOD.playthrough

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_GAL_GAME_PLAY_THROUGH_COUNT is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_GAL_GAME_GIRL_REJECT_COUNT then
			local value = 0
			local monsterAcademyGirlData = MonsterAcademyModule.girlDic[params[1]]

			if monsterAcademyGirlData then
				value = monsterAcademyGirlData.girlDataPOD.rejectCount
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_GAL_GAME_GIRL_REJECT_COUNT is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_GAL_GAME_SCHEDULE then
			local value = 0

			if MonsterAcademyModule.SaveDataDetailPOD then
				for i, v in pairs(MonsterAcademyModule.SaveDataDetailPOD.scheduleList) do
					if v.status == 0 and v.functionId == params[1] then
						value = value + 1
					end
				end
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_GAL_GAME_SCHEDULE is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_GAL_GAME_USE_ITEM_COUNT then
			local value = 0
			local eventType = params[1]
			local itemID = params[2]
			local MiniGalGameCountPOD = MonsterAcademyModule.SaveDataDetailPOD.itemUsedCount[itemID]

			if MiniGalGameCountPOD then
				if eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_DAY then
					value = MiniGalGameCountPOD.recordCountOfDay
				elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_WEEK then
					value = MiniGalGameCountPOD.recordCountOfWeek
				elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_MONTH then
					value = MiniGalGameCountPOD.recordCountOfMonth
				elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_YEAR then
					value = MiniGalGameCountPOD.recordCountOfYear
				elseif eventType == Constant.ConditionConstant.CONDITION_TYPE_COUNT_OF_ALL then
					value = MiniGalGameCountPOD.recordCountOfTotal
				end
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_GAL_GAME_USE_ITEM_COUNT is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_GAL_GAME_ACHIEVEMENT then
			local value = 0
			local eventType = params[1]
			local achievementDataID = params[2]

			if eventType == 1 then
				local achievementData = MonsterAcademyModule.DailyDupPOD.miniGalGameDataPOD.achievementData

				value = achievementData[achievementDataID]
			elseif eventType == 2 then
				local localAchievementData = MonsterAcademyModule.SaveDataDetailPOD.localAchievementData

				value = localAchievementData[achievementDataID]
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_GAL_GAME_ACHIEVEMENT is not in specified range"
		elseif subType == Constant.ConditionConstant.SUB_TYPE_GAL_GAME_MESSAGE_GROUP_COUNT then
			local eventType = params[1]
			local messageID = params[2]
			local value = MonsterAcademyModule.GetMessageCount(messageID, eventType)

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "SUB_TYPE_GAL_GAME_MESSAGE_GROUP_COUNT is not in specified range"
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.TYPE_DAILY_DUP then
		local value = 0
		local dailyDupId = params[1]

		if subType == Constant.ConditionConstant.SUB_TYPE_DAILY_DUP_STATUS then
			local dailyDupPod = DailyDupModule.GetDailyDupPOD(dailyDupId)

			if dailyDupPod and dailyDupPod.common then
				value = dailyDupPod.common.status
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "dailyDup is not matched"
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.TYPE_OPERATION_EVENT then
		local value = 3
		local operateEventID = params[1]

		if subType == Constant.ConditionConstant.SUB_TYPE_OPERATION_EVENT_STATUS then
			local eventPOD = ActiveOperationEventModule.GetActiveOperationData(operateEventID)

			if eventPOD then
				value = eventPOD.status
			end

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "operateEvent is not matched"
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
		end
	elseif type == Constant.ConditionConstant.TYPE_HORIZONTAL_RPG then
		if subType == Constant.ConditionConstant.SUB_TYPE_HORIZONTAL_RPG_DAY then
			local weather = 0

			if HorizontalRPGModule.dailyDupPOD and HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD then
				weather = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.weather
			end

			local value = params[1]

			checkResult = ConditionModule.ComparisonValue(value, targetValue, comparison)
			checkFailedReasonType = checkResult and "" or "operateEvent is not matched"
		else
			logError("error condition type : " .. type .. ", subType : " .. subType)
		end
	else
		logError("error condition type : " .. type)
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

function ConditionModule.ComparisonValueIn(dict, targetValue, comparison)
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
			if v == targetValue then
				return false
			end
		end

		return true
	else
		logError("Unsupported comparison : " .. comparison)
	end

	return false
end

function ConditionModule.GetDesc(cfgConditionData, success)
	if success == nil then
		success = ConditionModule.Check(cfgConditionData.Id)
	end

	if success then
		return cfgConditionData.FitName
	else
		return cfgConditionData.Name
	end
end
