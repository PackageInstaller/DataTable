-- chunkname: @IQIGame\\Module\\Maze\\MazeModule.lua

local MazeScene = require("IQIGame/Scene/Maze/MazeScene")
local CommonModuleTimerController = require("IQIGame/Util/CommonModuleTimerController")

MazeModule = {
	enterRoomType = false,
	MazeEventLinkIsEnd = false,
	enterRoomCid = 0,
	isEventInProgress = false,
	isNeedPlayMazeEndAnim = false,
	previousLastRoomCid = 0,
	isClickChangeRoom = false,
	needWaitServerPerformanceEnd = false,
	RoomIsEntering = false,
	IsShowFinishNotice = false,
	InTheMaze = false,
	showMazeRoomList = {}
}

function MazeModule.Shutdown()
	MazeModule.SelectOptionsCid = nil
	MazeModule.SelectOptionsNextCid = nil
	MazeModule.BuffList = nil
	MazeModule.previousLastRoomCid = 0
	MazeModule.isEventInProgress = false
	MazeModule.RoomIsEntering = false
	MazeModule.isNeedPlayMazeEndAnim = false
	MazeModule.isClickChangeRoom = false
	MazeModule.activeSenroTalentCid = nil
end

function MazeModule.log(message, ...)
	log("[Maze] " .. message, ...)
end

MazeModule.enterMazeSceneComplete = false
MazeModule.__mazeScene = nil
MazeModule.__timerController = nil
MazeModule.waitingForProcessingStage = false
MazeModule.RoomIsEntering = false
MazeModule.isNeedPlayMazeEndAnim = false
MazeModule.isClickChangeRoom = false

function MazeModule.InitLabyrinthDataPOD(labyrinthDataPOD)
	MazeModule.__labyrinthDataPOD = labyrinthDataPOD
	MazeModule.waitingForProcessingStage = false

	if MazeModule.__labyrinthDataPOD == nil then
		return
	end

	MazeModule.log("迷宫开启状态：{0}", MazeModule.__labyrinthDataPOD.state)

	if MazeModule.__labyrinthDataPOD.curDifficulty > 0 then
		MazeModule.waitingForProcessingStage = true
	end
end

function MazeModule.ProcessingLeaveStage()
	MazeModule.waitingForProcessingStage = false

	local labyrinthStagePOD = MazeModule.GetLabyrinthStagePOD(MazeModule.__labyrinthDataPOD.curDifficulty)

	if labyrinthStagePOD == nil then
		return
	end

	if labyrinthStagePOD.exploreFlg == Constant.MazeStageExploreState.HerosDeath then
		MazeModule.log("主动结算迷宫->角色全部死亡")
		MazeModule.OnExitStage(labyrinthStagePOD.difficulty, Constant.MazeStageExploreState.HerosDeath)

		return
	end

	if labyrinthStagePOD.exploreFlg == Constant.MazeStageExploreState.TimeOut then
		MazeModule.log("主动结算迷宫->时间过期")
		MazeModule.OnExitStage(labyrinthStagePOD.difficulty, Constant.MazeStageExploreState.TimeOut)

		return
	end

	NoticeModule.ShowNoticeByType(5, "当前有探索关卡未结算,是否返回关卡？", function()
		MazeModule.OnEnterStage(labyrinthStagePOD.difficulty)
	end, function()
		MazeModule.OnExitStage(labyrinthStagePOD.difficulty, Constant.MazeStageExploreState.HerosDeath)
	end)
end

function MazeModule.ShowExploreCompleteNotice(callback)
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD.exploreFlg == 1 then
		NoticeModule.ShowNoticeByType(4, "角色全部死亡,迷宫探索结束", function()
			MazeModule.OnExitStage(labyrinthStagePOD.difficulty, Constant.MazeStageExploreState.HerosDeath)
		end)

		return
	end

	if labyrinthStagePOD.exploreFlg == 2 then
		NoticeModule.ShowNoticeByType(4, "迷宫探索时间已达上限,迷宫探索结束", function()
			MazeModule.OnExitStage(labyrinthStagePOD.difficulty, Constant.MazeStageExploreState.TimeOut)
		end)

		return
	end

	if MazeModule.IsShowFinishNotice then
		return
	end

	NoticeModule.ShowNoticeByType(5, "当前有探索关卡已经探索完成,是否结算？", function()
		MazeModule.IsShowFinishNotice = false

		MazeModule.OnExitStage(labyrinthStagePOD.difficulty, Constant.MazeStageExploreState.NormalSettle)
	end, function()
		MazeModule.IsShowFinishNotice = true

		if callback ~= nil then
			callback()
		end
	end)
end

function MazeModule.EnterMazeScene(labyrinthStagePOD)
	MazeModule.__labyrinthDataPOD.curDifficulty = labyrinthStagePOD.difficulty

	MazeModule.__UpdateStagePOD(labyrinthStagePOD)
	MazeModule.__InitMazeExData()
	MazeModule.__UpdateBuffListPOD(labyrinthStagePOD.mapBuffs)

	local userData = MazeScene.CreateUserData(MazeModule.__fightingHeroData)

	MazeModule.__DoEnterMazeScene(userData)
end

function MazeModule.ExitMazeScene()
	if MazeModule.__timerController ~= nil then
		MazeModule.__timerController:Dispose()

		MazeModule.__timerController = nil
	end

	if MazeModule.__mazeScene == nil then
		return
	end

	MazeModule.__mazeScene:Dispose()
end

function MazeModule.BattleBackToMaze()
	local userData = MazeScene.CreateUserData(MazeModule.__fightingHeroData)

	userData.lastFightingHero = MazeModule.__lastFightingHeroData
	MazeModule.__lastFightingHeroData = nil

	MazeModule.__DoEnterMazeScene(userData)
end

function MazeModule.ExitMazeSceneToBattle()
	MazeModule.__lastFightingHeroData = MazeModule.GetMazeFightingHeroData()

	MazeModule.ExitMazeScene()
end

function MazeModule.__DoEnterMazeScene(userData)
	MazeModule.enterMazeSceneComplete = false
	MazeModule.__timerController = CommonModuleTimerController.New(Constant.ModuleTimerName.MazeBattle)
	MazeModule.__mazeScene = MazeScene.New(MazeModule.__OnMazeSceneReady, userData)
end

function MazeModule.__InitMazeExData()
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	MazeModule.heroDataEx = {}

	local heroPODData = labyrinthStagePOD.heros
	local heroPODCloneData = labyrinthStagePOD.heroAttrClone
	local labyrinthBarrierData = MazeModule.GetMazeStageCfg(labyrinthStagePOD.difficulty)

	MazeModule.__StageMindData = {}
	MazeModule.__StageMindData.itemCid = labyrinthBarrierData.MaxMind[1]
	MazeModule.__StageMindData.maxValue = labyrinthBarrierData.MaxMind[2]
	MazeModule.__StageMindData.costValue = labyrinthBarrierData.MoveCost[2]

	ForPairs(heroPODData, function(_heroCid, _heroPOD)
		local heroExData = {}

		heroExData.maxEnergy = WarlockModule.GetHeroMaxEnergyByHeroPOD(_heroPOD)
		heroExData.maxHP = heroPODCloneData[_heroCid].attr[1]
		MazeModule.heroDataEx[_heroCid] = heroExData
	end)
	MazeModule.__RefreshMazeFightHeroData(false)
end

function MazeModule.__RefreshMazeFightHeroData(notifyChange)
	local function action(_newData, tempAttackOrderData, _notifyChange)
		local isChange = false

		if MazeModule.__fightingHeroData == nil or MazeModule.__fightingAttackOrderHeroData == nil then
			isChange = true
		else
			local len_1 = getTableLength(_newData)
			local len_2 = getTableLength(MazeModule.__fightingHeroData)

			if len_1 == len_2 then
				for _heroCid, _position in pairs(MazeModule.__fightingHeroData) do
					local _tempPos = _newData[_heroCid]

					isChange = _tempPos ~= _position

					if isChange then
						break
					end
				end
			else
				isChange = true
			end

			if not isChange then
				local orderLen_1 = getTableLength(tempAttackOrderData)
				local orderLen_2 = getTableLength(MazeModule.__fightingAttackOrderHeroData)

				if orderLen_1 == orderLen_2 then
					for _heroCid, _position in pairs(MazeModule.__fightingAttackOrderHeroData) do
						local _tempPos = tempAttackOrderData[_heroCid]

						isChange = _tempPos ~= _position

						if isChange then
							break
						end
					end
				else
					isChange = true
				end
			end
		end

		if not isChange then
			return
		end

		MazeModule.__fightingHeroData = _newData
		MazeModule.__fightingAttackOrderHeroData = tempAttackOrderData

		if not _notifyChange then
			return
		end

		EventDispatcher.Dispatch(EventID.MazeFormationChange)
	end

	local tempData = {}
	local tempAttackOrderData = {}
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD == nil then
		return action(tempData, tempAttackOrderData, notifyChange)
	end

	if labyrinthStagePOD.formationPOD == nil then
		action(tempData, tempAttackOrderData, notifyChange)
	end

	ForPairs(labyrinthStagePOD.formationPOD.heros, function(_pos, _heroCid)
		tempData[_heroCid] = _pos
	end)

	tempAttackOrderData = labyrinthStagePOD.formationPOD.attackOrder

	action(tempData, tempAttackOrderData, notifyChange)
end

function MazeModule.__OnMazeSceneReady()
	MazeModule.enterMazeSceneComplete = true
end

function MazeModule.GetMazeStageCfg(difficulty)
	local seasonId = MazeModule.GetMazeSeason()

	for k, v in pairsCfg(CfgLabyrinthBarrierTable) do
		if v.SeasonID == seasonId and v.Type == difficulty then
			return v
		end
	end

	return nil
end

function MazeModule.GetHeroExData(heroCid)
	return MazeModule.heroDataEx[heroCid]
end

function MazeModule.GetLabyrinthData()
	return MazeModule.__labyrinthDataPOD
end

function MazeModule.GetLabyrinthWarehouse()
	if MazeModule.__labyrinthDataPOD == nil then
		return {}
	end

	return MazeModule.__labyrinthDataPOD.labyrinthWarehouse
end

function MazeModule.GetMazeFightingBagItems()
	local result = {}
	local labyrinthWarehouseData = MazeModule.GetLabyrinthWarehouse()

	if labyrinthWarehouseData == nil then
		return result
	end

	for _itemCid, _itemNum in pairs(labyrinthWarehouseData) do
		local itemCfg = CfgItemTable[_itemCid]

		table.insert(result, _itemCid)
	end

	return result
end

function MazeModule.GetMazeWarehouseItemCount(itemCid)
	local labyrinthWarehouseData = MazeModule.GetLabyrinthWarehouse()

	if labyrinthWarehouseData == nil then
		return 0
	end

	local itemCount = labyrinthWarehouseData[itemCid]

	if itemCount == nil then
		return 0
	end

	return itemCount
end

function MazeModule.GetMazeStageWarehouseItemCount(_itemCid)
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD == nil then
		return 0
	end

	local itemCount = labyrinthStagePOD.stageWarehouse[_itemCid]

	if itemCount == nil then
		return 0
	end

	return itemCount
end

function MazeModule.GetRoomStageMapData(roomCid)
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD == nil then
		return nil
	end

	if labyrinthStagePOD.stageMapPODs == nil then
		return nil
	end

	return labyrinthStagePOD.stageMapPODs[roomCid]
end

function MazeModule.GetStageEventData(eventId)
	local stageMapPOD = MazeModule.GetRoomStageMapData(MazeModule.GetCurStagePOD().curRoomId)

	return stageMapPOD.stageEvents[eventId]
end

function MazeModule.GetMazeFightingHeroData()
	return MazeModule.__fightingHeroData
end

function MazeModule.GetMazeSceneSize()
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD == nil then
		return 0, 0
	end

	local stageCfg = CfgLabyrinthBarrierPoolTable[labyrinthStagePOD.poolId]

	if stageCfg.BarrierType == 1 then
		return 5, 5
	elseif stageCfg.BarrierType == 2 then
		return 6, 6
	elseif stageCfg.BarrierType == 3 then
		return 7, 7
	elseif stageCfg.BarrierType == 4 then
		return 8, 8
	else
		return 0, 0
	end
end

function MazeModule.GetCurStagePOD()
	return MazeModule.GetLabyrinthStagePOD(MazeModule.__labyrinthDataPOD.curDifficulty)
end

function MazeModule.__UpdateStagePOD(stagePOD)
	for k, v in pairs(MazeModule.__labyrinthDataPOD.labyrinthStagePODs) do
		if v.difficulty == stagePOD.difficulty then
			MazeModule.__labyrinthDataPOD.labyrinthStagePODs[k] = stagePOD
		end
	end
end

function MazeModule.__UpdateBuffListPOD(buffList)
	MazeModule.BuffList = buffList

	if MazeModule.BuffList == nil then
		MazeModule.BuffList = {}
	end

	local stagePod = MazeModule.GetCurStagePOD()

	if MazeModule.BuffList[Constant.MazeBuffType.MazeBuff] == nil then
		local stageCfg = MazeModule.GetMazeStageCfg(stagePod.difficulty)

		MazeModule.BuffList[Constant.MazeBuffType.MazeBuff] = {}
		MazeModule.BuffList[Constant.MazeBuffType.MazeBuff].buffs = stageCfg.BuffGroup
	else
		local stageCfg = MazeModule.GetMazeStageCfg(stagePod.difficulty)

		for k, v in ipairs(stageCfg.BuffGroup) do
			table.insert(MazeModule.BuffList[Constant.MazeBuffType.MazeBuff].buffs, v)
		end
	end
end

function MazeModule.GetBuffList()
	return MazeModule.BuffList
end

function MazeModule.GetLabyrinthStagePOD(curDifficulty)
	for k, v in pairs(MazeModule.__labyrinthDataPOD.labyrinthStagePODs) do
		if v.difficulty == curDifficulty then
			return v
		end
	end

	return nil
end

function MazeModule.GetLabyrinthStageDifficulty(labyrinthStagePOD)
	return labyrinthStagePOD.difficulty
end

function MazeModule.GetLabyrinthStageDifficultyByStageId(stageId)
	for k, v in pairs(MazeModule.__labyrinthDataPOD.labyrinthStagePODs) do
		if v.stageId == stageId then
			return k
		end
	end

	return 1
end

function MazeModule.GetHeroData(heroCid)
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	return labyrinthStagePOD.heros[heroCid]
end

function MazeModule.GetTimeController()
	return MazeModule.__timerController
end

function MazeModule.GetIdleHeroList()
	local heroIDList = {}
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	ForPairs(labyrinthStagePOD.preHeros, function(_position, _heroCid)
		local heroData = MazeModule.GetHeroData(_heroCid)

		if WarlockModule.CheckHeroIsDieByHeroPOD(heroData) then
			return
		end

		if MazeModule.__fightingHeroData[_heroCid] ~= nil then
			return
		end

		table.insert(heroIDList, _heroCid)
	end)
	ForPairs(labyrinthStagePOD.replaceHeros, function(_, _heroCid)
		local heroData = MazeModule.GetHeroData(_heroCid)

		if WarlockModule.CheckHeroIsDieByHeroPOD(heroData) then
			return
		end

		if MazeModule.__fightingHeroData[_heroCid] ~= nil then
			return
		end

		table.insert(heroIDList, _heroCid)
	end)

	return heroIDList
end

function MazeModule.IsAllHeroDie()
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD == nil then
		return true
	end

	for _heroCid, _heroPOD in pairs(labyrinthStagePOD.heros) do
		if not WarlockModule.CheckHeroIsDieByHeroPOD(_heroPOD) then
			return false
		end
	end

	return true
end

function MazeModule.GetShopLevel()
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	return MazeModule.__labyrinthDataPOD.blackMarketPOD.level
end

function MazeModule.GetMazeOpeningTime()
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	local serverTime = PlayerModule.GetServerTimeByMs()
	local durationTime = serverTime - MazeModule.__labyrinthDataPOD.startTime

	return durationTime
end

function MazeModule.GetMazeOpeningTime_Day()
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	local startTime_s = MazeModule.__labyrinthDataPOD.startTime / 1000
	local serverTime_s = PlayerModule.GetServerTime()

	return getDateTimeDiffDay(serverTime_s, startTime_s)
end

function MazeModule.GetMazeStageExploreTime()
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	return MazeModule.__labyrinthDataPOD.exploreTime
end

function MazeModule.GetMazeFinishEventCountByType(eventType)
	local cnt = 0

	if MazeModule.__labyrinthDataPOD == nil then
		return cnt
	end

	ForPairs(MazeModule.__labyrinthDataPOD.finishEvents, function(_eventCid, _finishCount)
		local cfg = CfgLabyrinthEventTable[_eventCid]

		if cfg.Type ~= eventType then
			return
		end

		cnt = cnt + _finishCount
	end)

	return cnt
end

function MazeModule.GetMazeFinishEventCountByCid(eventCid)
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	local cnt = MazeModule.__labyrinthDataPOD.finishEvents[eventCid]

	if cnt == nil then
		return 0
	end

	return cnt
end

function MazeModule.GetMazeStageMindData()
	return MazeModule.__StageMindData
end

function MazeModule.GetMazeStageInternalBagItemNum(itemCid)
	local result = 0
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD == nil then
		return 0
	end

	result = labyrinthStagePOD.stageWarehouse[itemCid]

	if result == nil then
		result = 0
	end

	return result
end

function MazeModule.GetSenroTalentList()
	local result = {}

	if MazeModule.__labyrinthDataPOD == nil then
		return result
	end

	local senroTalentMap = MazeModule.__labyrinthDataPOD.senroPOD.senroTalents

	ForPairs(senroTalentMap, function(_, _senroTalentPOD)
		table.insert(result, _senroTalentPOD)
	end)

	return result
end

function MazeModule.GetMazeSeason()
	return MazeModule.__labyrinthDataPOD.seasonId
end

function MazeModule.GetSenroTalentData(senroTalentCid)
	if MazeModule.__labyrinthDataPOD == nil then
		return nil
	end

	return MazeModule.__labyrinthDataPOD.senroPOD.senroTalents[senroTalentCid]
end

function MazeModule.__UpdateSenroPOD(senroPOD)
	if MazeModule.__labyrinthDataPOD == nil then
		return
	end

	MazeModule.__labyrinthDataPOD.senroPOD = senroPOD

	EventDispatcher.Dispatch(EventID.MazeSenroTalentDataChange)
end

function MazeModule.__UpdateSenroTalentPOD(SenroTalentPOD)
	if MazeModule.__labyrinthDataPOD == nil then
		return
	end

	MazeModule.__labyrinthDataPOD.senroPOD.senroTalents[SenroTalentPOD.id] = SenroTalentPOD

	EventDispatcher.Dispatch(EventID.MazeSenroTalentDataChange)
end

function MazeModule.GetSenroTalentLevel()
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	return MazeModule.__labyrinthDataPOD.senroPOD.level
end

function MazeModule.GetSenroTalentState(talentCid)
	local talentData = MazeModule.GetSenroTalentData(talentCid)

	if talentData == nil then
		if MazeModule.__TalentCanUnLock(talentCid) then
			return Constant.MazeSenroTalenState.CanUnlock
		end

		return Constant.MazeSenroTalenState.Locked
	end

	local canLevelUp, maxLevel = MazeModule.__TalentCanUpgrade(talentData)

	if canLevelUp then
		return Constant.MazeSenroTalenState.CanLevelUp
	end

	if maxLevel > 0 then
		return Constant.MazeSenroTalenState.MaxLevel
	end

	return Constant.MazeSenroTalenState.Active
end

function MazeModule.GetSenroDataByEffectType(effectType)
	local senroTalentData
	local senroTalents = MazeModule.__labyrinthDataPOD.senroPOD.senroTalents

	for k, v in pairs(senroTalents) do
		local senroTalentCfg = CfgLabyrinthSenrotalentTable[v.id]

		if senroTalentCfg.EffectType == effectType then
			senroTalentData = v

			return senroTalentData
		end
	end

	return senroTalentData
end

function MazeModule.GetGoodsIsDiscount(id)
	local stagePod = MazeModule.GetCurStagePOD()

	if stagePod == nil then
		return false
	end

	local stageMapPOD = MazeModule.GetRoomStageMapData(stagePod.curRoomId)

	if stageMapPOD == nil or stageMapPOD.eventLinkPod.randomGoodsIds == nil then
		return false
	end

	return table.indexOf(stageMapPOD.eventLinkPod.randomGoodsIds, id) ~= -1
end

function MazeModule.GetSortedGoodsData(buyGoodsNum)
	local itemDataList = {}
	local tempGoods = {}

	ForPairs(buyGoodsNum, function(Id, buyNum)
		table.insert(tempGoods, {
			Id = Id,
			buyNum = buyNum
		})
	end)
	table.sort(tempGoods, function(a, b)
		local aIndex = MazeModule.GetGoodsIsDiscount(a.Id) and 1 or 0
		local bIndex = MazeModule.GetGoodsIsDiscount(b.Id) and 1 or 0

		if aIndex == bIndex then
			return CfgLabyrinthBuffPoolTable[a.Id].Quality > CfgLabyrinthBuffPoolTable[b.Id].Quality
		end

		return bIndex < aIndex
	end)
	ForArray(tempGoods, function(_, data)
		local buffPoolCfg = CfgLabyrinthBuffPoolTable[data.Id]
		local shopItemData = {}

		shopItemData.Id = buffPoolCfg.Id
		shopItemData.itemCid = buffPoolCfg.ItemId
		shopItemData.buffID = buffPoolCfg.BuffID
		shopItemData.costCid = buffPoolCfg.Cost[1]
		shopItemData.costNum = buffPoolCfg.Cost[2]
		shopItemData.limitNum = data.buyNum

		table.insert(itemDataList, shopItemData)
	end)

	return itemDataList
end

function MazeModule.TalentCanUnLock(talentCid)
	return MazeModule.__TalentCanUnLock(talentCid)
end

function MazeModule.__TalentCanUnLock(talentCid)
	local talentCfg = CfgLabyrinthSenrotalentTable[talentCid]
	local result = true

	ForArray(talentCfg.UnlockConditionIds, function(_, _conditionCid)
		result = ConditionModule.Check(_conditionCid)

		if not result then
			return true
		end
	end)

	return result
end

function MazeModule.__TalentCanUpgrade(talentData)
	local talentCfg = CfgLabyrinthSenrotalentTable[talentData.id]

	return talentData.level < talentCfg.MaxLevel, talentCfg.MaxLevel
end

function MazeModule.GetKillMonsterNum(monsterCid)
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	local count = MazeModule.__labyrinthDataPOD.killMonsterTime[monsterCid]

	if count == nil then
		count = 0
	end

	return count
end

function MazeModule.GetKillMonsterTypeNum(monsterType)
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	local count = 0

	ForPairs(MazeModule.__labyrinthDataPOD.killMonsterTime, function(_monsterCid, _num)
		local monsterCfg = CfgMonsterTable[_monsterCid]

		if monsterCfg.MonsterType == monsterType then
			count = count + _num
		end
	end)

	return count
end

function MazeModule.SetSelectOptionsData(optionCid, nextIDIndex)
	MazeModule.SelectOptionsCid = optionCid
	MazeModule.SelectOptionsNextIDIndex = nextIDIndex
end

function MazeModule.GetHasBuffByCid(itemCid)
	local hasBuff = false
	local buffCid = CfgItemTable[itemCid].ActionParams[1]
	local stagePod = MazeModule.GetCurStagePOD()

	if stagePod == nil or stagePod.buffs == nil then
		return false
	end

	table.search(stagePod.buffs, function(k, v)
		if v == buffCid then
			hasBuff = true

			return true
		end
	end)

	return hasBuff
end

function MazeModule.UpdateHeroEntitys(heroEntity)
	MazeModule.heroEntity = heroEntity
end

function MazeModule.UpdatePlayerEntity(playerEntity)
	MazeModule.playerEntity = playerEntity
end

function MazeModule.GetStageClearanceNum(difficulty)
	local count = 0

	if MazeModule.__labyrinthDataPOD.diffcultyTime == nil or table.len(MazeModule.__labyrinthDataPOD.diffcultyTime) == 0 then
		return count
	end

	local clearanceNum = MazeModule.__labyrinthDataPOD.diffcultyTime[difficulty]

	if clearanceNum == nil then
		return count
	end

	return clearanceNum
end

function MazeModule.GetPortalConditionPassed(eventCfg)
	if eventCfg.GuaranteeNum == 0 then
		return true
	end

	local taskDatas = TaskSystemModule.GetMazeTaskData()
	local stagePassCount = MazeModule.GetStageClearanceNum(MazeModule.__labyrinthDataPOD.curDifficulty)
	local curSeasonTaskDatas = taskDatas[MazeModule.GetMazeSeason()]

	if stagePassCount == 0 then
		return false
	end

	local taskFinishCount = 0

	ForPairs(curSeasonTaskDatas.Data, function(_, mazeTaskData)
		ForPairs(mazeTaskData.childData, function(_, taskData)
			if taskData.status == Constant.TaskStatus.hasDone or taskData.status == Constant.TaskStatus.hadGot then
				taskFinishCount = taskFinishCount + 1
			end
		end)

		if mazeTaskData.mainData.status == Constant.TaskStatus.hasDone or mazeTaskData.mainData.status == Constant.TaskStatus.hadGot then
			taskFinishCount = taskFinishCount + 1
		end
	end)

	return Mathf.Floor(taskFinishCount / stagePassCount) >= eventCfg.GuaranteeNum
end

function MazeModule.GetFormationAttackOrder()
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD == nil then
		return {}
	end

	return labyrinthStagePOD.formationPOD.attackOrder
end

function MazeModule.GetCurSeasonMemoryDataList(seasonId)
	local memoryDatas = MazeModule.GetLabyrinthData().memoryEvent[seasonId]
	local eventIds = {}

	if memoryDatas ~= nil then
		eventIds = memoryDatas.events
	end

	return eventIds
end

function MazeModule.GetMazeUseItemCount(itemCid)
	if MazeModule.__labyrinthDataPOD == nil then
		return 0
	end

	local useCount = 0

	useCount = MazeModule.__labyrinthDataPOD.useItemMap[itemCid]

	if useCount == nil then
		useCount = 0
	end

	return useCount
end

function MazeModule.GetMazeCanInteractive()
	if MazeModule.RoomIsEntering or MazeModule.isEventInProgress then
		return false
	end

	return true
end

function MazeModule.GetSectionBuff()
	local labyrinthBarrierCfg = MazeModule.GetMazeStageCfg(MazeModule.__labyrinthDataPOD.curDifficulty)
	local foundIndex = MazeModule.GetSectionBuffIndex()

	if foundIndex == 0 then
		return nil
	end

	return labyrinthBarrierCfg.PunishBuff[foundIndex]
end

function MazeModule.GetSectionBuffIndex()
	local mindData = MazeModule.GetMazeStageMindData()
	local curMindValue = MazeModule.GetMazeStageInternalBagItemNum(mindData.itemCid)
	local labyrinthBarrierCfg = MazeModule.GetMazeStageCfg(MazeModule.__labyrinthDataPOD.curDifficulty)
	local foundIndex = 0

	for i, v in ipairs(labyrinthBarrierCfg.PunishSeparate) do
		if curMindValue <= v then
			foundIndex = i
		end
	end

	return foundIndex
end

function MazeModule.GetBuffCfg(buffCid)
	for k, v in pairsCfg(CfgLabyrinthBuffPoolTable) do
		if v.BuffID == buffCid then
			return v
		end
	end

	logError("未在LabyrinthBuffPool找到buff:{0}的配置", buffCid)

	return nil
end

function MazeModule.GetBuffItemCfg(buffCid)
	local buffItemCfg

	for k, v in pairsCfg(CfgItemTable) do
		if v.ActionParams[1] == buffCid then
			buffItemCfg = v

			break
		end
	end

	if buffItemCfg == nil then
		logError("BuffID-->{0} 在Item表找不到", buffCid)
	end

	return buffItemCfg
end

function MazeModule.GetEventIsSpecial(stageEventPOD)
	local eventCfg = CfgLabyrinthEventTable[stageEventPOD.eventId]

	if eventCfg.Type == Constant.MazeEventType.Video and eventCfg.EventTrigType == 1 then
		return true
	end

	return false
end

function MazeModule.GetIsShopEvent(eventLinkPod)
	return eventLinkPod.buyGoodsNum ~= nil and table.len(eventLinkPod.buyGoodsNum) > 0
end

function MazeModule.GetIsVideoEvent(eventLinkPod)
	local isVideoEvent = false
	local eventId = 0
	local eventLinkTable = CfgLabyrinthEventLinkTable[eventLinkPod.eventLinkId]

	ForPairs(eventLinkTable.EventLink, function(_, eventID)
		local eventTable = CfgLabyrinthEventTable[eventID]

		if eventTable.Type == Constant.MazeEventType.Video then
			isVideoEvent = true
			eventId = eventID

			return true
		end
	end)

	return isVideoEvent, eventId
end

function MazeModule.GetMazeClientDataByType(eventLinkPOD, type)
	local clientData = {}

	if eventLinkPOD == nil or type == nil or eventLinkPOD.clientData == nil or eventLinkPOD.clientData[type] == nil or eventLinkPOD.clientData[type].clientData == nil then
		return clientData
	end

	return eventLinkPOD.clientData[type].clientData
end

function MazeModule.GetEventAlreadyStarted(eventLinkPOD)
	local isStarted = false

	ForPairs(eventLinkPOD.stageEvents, function(_, stageEventPOD)
		if stageEventPOD.eventState == true then
			isStarted = true

			return true
		end
	end)

	return isStarted
end

function MazeModule.GetActivitedBuffByGroupId(groupId)
	local buffIdList = {}
	local hasBuffs = MazeModule.GetBuffList()

	ForPairs(hasBuffs[1].buffs, function(_, buffCid)
		local buffPoolCfg = MazeModule.GetBuffCfg(buffCid)

		if buffPoolCfg ~= nil and buffPoolCfg.BuffGroup == groupId then
			table.insert(buffIdList, buffCid)
		end
	end)

	return buffIdList
end

function MazeModule.GetBuffGroupData(buffPoolId)
	local buffPoolCfg = CfgLabyrinthBuffPoolTable[buffPoolId]
	local activedBuffList = MazeModule.GetActivitedBuffByGroupId(buffPoolCfg.BuffGroup)

	return MazeModule.CreateBuffGroupData(buffPoolCfg.BuffGroup, activedBuffList)
end

function MazeModule.CreateBuffGroupData(buffGroupId, activedBuffList)
	local buffGroupDataList = {}
	local activedNum = #activedBuffList
	local buffGroupCfg = CfgLabyrinthBuffGroupTable[buffGroupId]

	ForArray(buffGroupCfg.SpecialBuff, function(_index, specialBuff)
		if table.len(specialBuff) == 0 then
			return
		end

		local buffGroupData = {}
		local buffGroupItemData = {}

		buffGroupData.buffGroupId = buffGroupId
		buffGroupData.mazeBuffGroupItemData = buffGroupItemData
		buffGroupItemData.buffCid = specialBuff[2]
		buffGroupItemData.needNum = specialBuff[1]
		buffGroupItemData.index = _index

		if specialBuff[1] <= activedNum then
			buffGroupItemData.isActived = true
		else
			buffGroupItemData.isActived = false
		end

		table.insert(buffGroupDataList, buffGroupData)
	end)

	return buffGroupDataList
end

function MazeModule.GetBuffCanCombination(buffPoolId)
	local buffPoolCfg = CfgLabyrinthBuffPoolTable[buffPoolId]

	return buffPoolCfg.BuffGroup ~= 0
end

function MazeModule.GetMazeBuffGroupActivedNumByBuffPoolId(buffPoolId)
	local buffPoolCfg = CfgLabyrinthBuffPoolTable[buffPoolId]
	local groupId = buffPoolCfg.BuffGroup
	local allBuffNum = 0
	local curActivedNum = 0
	local buffGroupCfg

	if groupId > 0 then
		local activedBuffList = MazeModule.GetActivitedBuffByGroupId(groupId)

		buffGroupCfg = CfgLabyrinthBuffGroupTable[groupId]

		ForArray(buffGroupCfg.SpecialBuff, function(_, specialBuffData)
			if #specialBuffData == 0 then
				return
			end

			allBuffNum = math.max(allBuffNum, specialBuffData[1])
		end)

		curActivedNum = #activedBuffList
	end

	local buffGroupActivedData = {}

	buffGroupActivedData.activedNum = curActivedNum
	buffGroupActivedData.allNum = allBuffNum
	buffGroupActivedData.buffGroupCfg = buffGroupCfg

	return buffGroupActivedData
end

function MazeModule.GetActivedBuffGroupIdList()
	local poolIdList = {}
	local buffList = MazeModule.GetBuffList()[Constant.MazeBuffType.BattleBuff].buffs

	ForArray(buffList, function(_, buffId)
		local buffPoolCfg = MazeModule.GetBuffCfg(buffId)

		if buffPoolCfg ~= nil and buffPoolCfg.BuffGroup ~= 0 and poolIdList[buffPoolCfg.BuffGroup] == nil then
			poolIdList[buffPoolCfg.BuffGroup] = buffPoolCfg.Id
		end
	end)

	return poolIdList
end

function MazeModule.OnEnterStage(stageCid)
	net_labyrinth.enterStage(stageCid)
end

function MazeModule.OnExitStage(difficulty, type)
	local tempDifficulty = difficulty

	if tempDifficulty == nil then
		tempDifficulty = MazeModule.GetCurStagePOD().difficulty
	end

	net_labyrinth.exitStage(tempDifficulty, type)
end

function MazeModule.OnStartEnterRoom(roomCid, isMapEnter, jumpCount)
	MazeModule.enterRoomType = isMapEnter

	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	MazeModule.log("开始进入房间 当前房间id" .. roomCid)
	net_labyrinth.startEnterRoom(labyrinthStagePOD.difficulty, roomCid, isMapEnter, jumpCount ~= nil and jumpCount or 0)
end

function MazeModule.OnEnterCurrentRoomFinish()
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	MazeModule.log("进入房间完成 当前房间id" .. MazeModule.enterRoomCid)
	net_labyrinth.enterRoomFinish(labyrinthStagePOD.difficulty, MazeModule.enterRoomCid, MazeModule.enterRoomType)
end

function MazeModule.OnEncounterMonsterEvent(storyBattleId)
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()
	local roomStageMapPOD = MazeModule.GetRoomStageMapData(labyrinthStagePOD.curRoomId)

	MazeModule.OnSubmitEvent(roomStageMapPOD.eventLinkPod.curEventId)
end

function MazeModule.OnMerchantBuyEvent(itemCid, buyNum)
	MazeModule.needWaitServerPerformanceEnd = true

	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	net_labyrinth.merchantBuyEvent(labyrinthStagePOD.difficulty, labyrinthStagePOD.curRoomId, itemCid, buyNum)
end

function MazeModule.OnTranslateEvent(difficulty, roomId)
	net_labyrinth.translateEvent(difficulty, roomId)
end

function MazeModule.OnChangeFormationPOD(formationPOD)
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	net_labyrinth.chageFormationPOD(labyrinthStagePOD.difficulty, formationPOD)
end

function MazeModule.OnBlackMarketUpgrade()
	net_labyrinth.blackMarketUpgrade()
end

function MazeModule.OnUseLabyrinthItem(itemMap)
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	net_labyrinth.useLabyrinthItem(labyrinthStagePOD.difficulty, itemMap)
end

function MazeModule.OnUpgradeSenro()
	net_labyrinth.upgradeSenro()
end

function MazeModule.OnResetSenro()
	net_labyrinth.resetSenro()
end

function MazeModule.OnActiveSenroTalent(talentCid)
	MazeModule.activeSenroTalentCid = talentCid

	net_labyrinth.activeSenroTalent(talentCid)
end

function MazeModule.OnUpgradeSenroTalent(talentCid)
	MazeModule.activeSenroTalentCid = talentCid

	net_labyrinth.upgradeSenroTalent(talentCid)
end

function MazeModule.OnRefreshStage()
	net_labyrinth.freshStage()
end

function MazeModule.OnUpdateRoomAfterAnimation(roomCid)
	net_labyrinth.playAnimation(MazeModule.__labyrinthDataPOD.curDifficulty, roomCid)
end

function MazeModule.SetFormation(formationHeros, replaceHeros)
	net_labyrinth.setFormation(formationHeros, replaceHeros)
end

function MazeModule.OnRefreshEvent()
	local curStagePod = MazeModule.GetCurStagePOD()

	net_labyrinth.freshEvent(MazeModule.__labyrinthDataPOD.curDifficulty, curStagePod.curRoomId)
end

function MazeModule.OnHoldEvent()
	local curStagePod = MazeModule.GetCurStagePOD()

	net_labyrinth.holdEvent(MazeModule.__labyrinthDataPOD.curDifficulty, curStagePod.curRoomId)
end

function MazeModule.OnSubmitEvent(curEventId, curOptionId, merchantId, num, clientData)
	MazeModule.log("提交事件:{0} OptionId:{1} 道具Id:{2} 道具数量：{3}", curEventId, curOptionId, merchantId, num)

	if MazeModule.PerformanceClientData ~= nil then
		if clientData == nil then
			clientData = {}
		end

		local tempClientData = {}

		tempClientData.clientData = MazeModule.PerformanceClientData
		clientData[Constant.MazeClientDataType.Performance] = tempClientData
	end

	local curStagePod = MazeModule.GetCurStagePOD()

	net_labyrinth.submitEvent(MazeModule.__labyrinthDataPOD.curDifficulty, curStagePod.curRoomId, curEventId, curOptionId, merchantId, num, clientData)
end

function MazeModule.OnRefreshBuff()
	local curStagePod = MazeModule.GetCurStagePOD()

	net_labyrinth.freshBuff(MazeModule.__labyrinthDataPOD.curDifficulty, curStagePod.curRoomId)
end

function MazeModule.OnEnterStageResult(labyrinthStagePOD)
	GameChapterModule.SetupCurChapterType(Constant.ChapterPassType.TYPE_Maze)

	MazeModule.IsShowFinishNotice = false

	SceneTransferModule.HomeToMaze({
		LabyrinthStagePOD = labyrinthStagePOD
	})
end

function MazeModule.OnStartEnterRoomResult(stageMapPOD)
	MazeModule.log("OnStartEnterRoomResult ------> roomID:" .. stageMapPOD.roomId)

	MazeModule.RoomIsEntering = true
	MazeModule.enterRoomCid = stageMapPOD.roomId

	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	labyrinthStagePOD.stageMapPODs[stageMapPOD.roomId] = stageMapPOD
	labyrinthStagePOD.curRoomId = stageMapPOD.roomId

	if MazeModule.__mazeScene == nil then
		return
	end

	MazeModule.RefreshShowMazeRoomData(stageMapPOD.roomId)
	EventDispatcher.Dispatch(EventID.EnterMapRoomResult, stageMapPOD)
	MazeModule.__mazeScene:OnStartEnterRoom(stageMapPOD)
end

function MazeModule.OnEnterRoomFinishResult(stageMapPOD, animation)
	MazeModule.log("OnEnterRoomFinishResult ------> roomID:" .. stageMapPOD.roomId)

	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	labyrinthStagePOD.stageMapPODs[stageMapPOD.roomId] = stageMapPOD

	if animation ~= nil then
		MazeModule.__labyrinthDataPOD.animation = animation
	end

	if MazeModule.__mazeScene == nil then
		return
	end

	MazeModule.__mazeScene:OnEnterRoomFinish(stageMapPOD)
	EventDispatcher.Dispatch(EventID.EnterMapRoomResult, stageMapPOD)
end

function MazeModule.OnUpdateLabyrinthDataPOD(labyrinthDataPOD)
	if MazeModule.__labyrinthDataPOD == nil then
		MazeModule.log("迷宫开启状态：{0}", labyrinthDataPOD.__labyrinthDataPOD.state)
	end

	MazeModule.__labyrinthDataPOD = labyrinthDataPOD

	MazeModule.log("OnUpdateLabyrinthDataPOD -->>")
end

function MazeModule.OnUpdateLabyrinthStagePOD(labyrinthStagePOD)
	MazeModule.__UpdateStagePOD(labyrinthStagePOD)
	MazeModule.log("OnUpdateLabyrinthStagePOD -->>")
	EventDispatcher.Dispatch(EventID.MazeStagePODChange, labyrinthStagePOD.difficulty)
	MazeModule.__RefreshMazeFightHeroData(true)
end

function MazeModule.OnEventFinishResult(stageMapPOD)
	MazeModule.log("OnEventFinishResult ------> ")
	MazeModule.__OnMazeStageMapPODChange(stageMapPOD)
end

function MazeModule.OnNotifyStageExit(stageId)
	MazeModule.log("OnNotifyStageExit ------> ")

	if SceneTransferModule.CurScene ~= SceneTransferModule.SceneName.Maze then
		return
	end

	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD.exploreFlg == 3 then
		MazeModule.isNeedPlayMazeEndAnim = true
	end
end

function MazeModule.OnExitStageResult(difficulty, itemShows)
	MazeModule.log("OnExitStageResult -->>")
	UIModule.Open(Constant.UIControllerName.MazeSettlementUI, Constant.UILayer.UI, {
		itemShows = itemShows,
		difficulty = difficulty,
		mazeStageId = MazeModule.GetMazeStageCfg(difficulty).Id,
		callback = function()
			if SceneTransferModule.CurScene == SceneTransferModule.SceneName.Maze then
				SceneTransferModule.MazeToHome()
			end
		end
	})

	MazeModule.previousLastRoomCid = 0

	MazeModule.ClearMazeRoomDataPlayerPrefs(difficulty)
	PlayerPrefsUtil.DeleteKey(PlayerModule.PlayerInfo.baseInfo.guid, Constant.PlayerPrefsConst.MazeLastRoomCid .. MazeModule.GetMazeStageCfg(difficulty).Id)
end

function MazeModule.OnChangeFormationPODResult()
	MazeModule.log("OnChangeFormationPODResult ------> ")
	EventDispatcher.Dispatch(EventID.GoIntoBattleSuccessEvent)
end

function MazeModule.OnSelectBuffResult(stageEventPOD)
	MazeModule.needWaitServerPerformanceEnd = false

	MazeModule.log("OnSelectBuffResult ------> ")
	EventDispatcher.Dispatch(EventID.MazeSelectBuffComplete)

	local labyrinthStagePOD = MazeModule.GetCurStagePOD()
	local stageMapData = MazeModule.GetRoomStageMapData(labyrinthStagePOD.curRoomId)

	stageMapData.eventPod = stageEventPOD

	MazeModule.__OnMazeStageMapPODChange(stageMapData)
end

function MazeModule.OnUpdateStageMapPOD(stageMapPOD)
	MazeModule.log("OnUpdateStageMapPOD ------> ")
	MazeModule.__OnMazeStageMapPODChange(stageMapPOD)
end

function MazeModule.__OnMazeStageMapPODChange(stageMapPOD)
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	labyrinthStagePOD.stageMapPODs[stageMapPOD.roomId] = stageMapPOD

	EventDispatcher.Dispatch(EventID.MazeStageMapPODChange, stageMapPOD.roomId)
end

function MazeModule.OnUpdateLabyrinthWarehouse(itemList)
	MazeModule.log("OnUpdateLabyrinthWarehouse ------> ")
	MazeModule.__OnUpdateLabyrinthWarehouse(itemList)
end

function MazeModule.OnUpdateLabyrinthWarehouse(itemList)
	MazeModule.log("OnUpdateLabyrinthWarehouse ------> ")
	MazeModule.__OnUpdateLabyrinthWarehouse(itemList)
end

function MazeModule.__OnUpdateLabyrinthWarehouse(itemList)
	local labyrinthWarehouseData = MazeModule.GetLabyrinthWarehouse()

	for _itemId, _itemNum in pairs(itemList) do
		labyrinthWarehouseData[_itemId] = _itemNum
	end

	EventDispatcher.Dispatch(EventID.MazeBagItemChange)
end

function MazeModule.OnRemoveLabyrinthWarehouse(idList)
	MazeModule.log("OnRemoveLabyrinthWarehouse ------> ")

	local labyrinthWarehouseData = MazeModule.GetLabyrinthWarehouse()

	for _, _itemId in pairs(idList) do
		labyrinthWarehouseData[_itemId] = nil
	end

	EventDispatcher.Dispatch(EventID.MazeBagItemChange)
end

function MazeModule.OnBlackMarketUpgradeResult(level)
	MazeModule.log("OnBlackMarketUpgradeResult ------> ")

	MazeModule.__labyrinthDataPOD.blackMarketPOD.level = level

	ShopModule.SetCurShopDataData(Constant.ShopType.MazeShop.ShopCid)
	EventDispatcher.Dispatch(EventID.MazeShopLevelChange)
end

function MazeModule.OnUpdateStageWarehouse(updateItems)
	MazeModule.log("OnUpdateStageWarehouse ------> ")

	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD == nil then
		return
	end

	for _itemCid, _itemCount in pairs(updateItems) do
		labyrinthStagePOD.stageWarehouse[_itemCid] = _itemCount
	end

	EventDispatcher.Dispatch(EventID.MazeStageWarehouseChange)
end

function MazeModule.OnNotifySeasonOver(seasonId, itemShows)
	MazeModule.log("OnNotifySeasonOver ------> ")

	MazeModule.needShowSeasonOver = true
	MazeModule.SeasonOverData = {}
	MazeModule.SeasonOverData.SeasonId = seasonId
	MazeModule.SeasonOverData.ItemShows = itemShows
end

function MazeModule.OnUseLabyrinthItemResult(itemShows)
	MazeModule.log("-----OnUseLabyrinthItemResult--------->>{0}", #itemShows)

	MazeModule.needWaitServerPerformanceEnd = false
end

function MazeModule.OnUpgradeSenroResult(senroPOD, itemShows)
	MazeModule.log("-----OnUpgradeSenroResult--------->>")

	if MazeModule.__labyrinthDataPOD == nil then
		return
	end

	MazeModule.__labyrinthDataPOD.senroPOD = senroPOD

	if getTableLength(itemShows) > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end

	EventDispatcher.Dispatch(EventID.MazeSenroDataChange)
end

function MazeModule.OnResetSenroResult(senroPOD, itemShows)
	MazeModule.log("-----OnResetSenroResult--------->>")
	MazeModule.__UpdateSenroPOD(senroPOD)

	if getTableLength(itemShows) > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end
end

function MazeModule.OnActiveSenroTalentResult(senroPOD)
	MazeModule.log("-----OnActiveSenroTalentResult--------->>")
	EventDispatcher.Dispatch(EventID.OnActiveSenroTalentResult)
	MazeModule.__UpdateSenroPOD(senroPOD)
end

function MazeModule.OnUpgradeSenroTalentResult(senroTalentPOD)
	MazeModule.log("-----OnUpgradeSenroTalentResult--------->>")
	EventDispatcher.Dispatch(EventID.OnActiveSenroTalentResult)
	MazeModule.__UpdateSenroTalentPOD(senroTalentPOD)
end

function MazeModule.OnUpdateLabyrinthHerosAndFormation(heroPods, formationPOD)
	local hpIsRecoverType = Constant.MazeHpChangeState.Unchanged
	local isChange = false
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()

	if labyrinthStagePOD ~= nil then
		for _, heroPod in pairs(heroPods) do
			if labyrinthStagePOD.heros[heroPod.hcid] ~= nil then
				for attrKey, attrValue in pairs(heroPod.attr) do
					if attrKey == Constant.Attribute.TYPE_HP and not isChange then
						local changeValue = attrValue - labyrinthStagePOD.heros[heroPod.hcid].attr[attrKey]

						if changeValue > 0 then
							isChange = true
							hpIsRecoverType = Constant.MazeHpChangeState.Add
						elseif changeValue < 0 then
							isChange = true
							hpIsRecoverType = Constant.MazeHpChangeState.Reduce
						end

						if isChange then
							EventDispatcher.Dispatch(EventID.MazeHpChangeEvent, hpIsRecoverType)
						end
					end

					labyrinthStagePOD.heros[heroPod.hcid].attr[attrKey] = attrValue
				end
			end

			labyrinthStagePOD.formationPOD = formationPOD
		end
	end

	EventDispatcher.Dispatch(EventID.MazeUpdateLabyrinthHerosAndFormationEvent)
end

function MazeModule.OnRefreshStageResult(labyrinthDataPOD)
	MazeModule.__labyrinthDataPOD = labyrinthDataPOD

	EventDispatcher.Dispatch(EventID.OnRefreshMazeStageEvent)
end

function MazeModule.OnUpdateLabyrinthBuff(mapBuffs)
	MazeModule.__UpdateBuffListPOD(mapBuffs)
end

function MazeModule.OnTranslateItemResult(itemShows)
	if getTableLength(itemShows) > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows)
	end
end

function MazeModule.SetFormationResult(labyrinthDataPOD)
	MazeModule.__labyrinthDataPOD = labyrinthDataPOD
end

function MazeModule.OnRefreshEventResult()
	EventDispatcher.Dispatch(EventID.MazeRefreshEvent)
end

function MazeModule.OnHoldEventResult(stageEventPOD, curEventIndex, curOptionIndex, subOptionIndex)
	EventDispatcher.Dispatch(EventID.OnHoldEventResult, stageEventPOD, curEventIndex, curOptionIndex, subOptionIndex)
end

function MazeModule.OnSubmitEventResult(itemShows)
	MazeModule.log("提交事件返回成功 包含奖励?{0}", tostring(itemShows ~= nil and table.len(itemShows) > 0))

	if itemShows ~= nil and table.len(itemShows) > 0 then
		if table.len(itemShows) == 1 and itemShows[1].cid == Constant.ItemCid.MAZE_POWER then
			EventDispatcher.Dispatch(EventID.OnSubmitEventResult)

			return
		end

		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShows, Constant.GetPanelType.Maze, function()
			EventDispatcher.Dispatch(EventID.OnSubmitEventResult)
		end)

		return
	end

	EventDispatcher.Dispatch(EventID.OnSubmitEventResult)
end

function MazeModule.OnUpdateStageEventLinkResult(stageEventLinkPOD)
	local stageMapPOD = MazeModule.GetRoomStageMapData(MazeModule.GetCurStagePOD().curRoomId)

	stageMapPOD.eventLinkPod = stageEventLinkPOD

	EventDispatcher.Dispatch(EventID.OnUpdateStageEventLinkResult)
end

function MazeModule.OnTranslateEventResult(curRoomId, nextRoomId)
	MazeModule.OnStartEnterRoom(nextRoomId, false)
end

function MazeModule.OnRefreshBuffResult(buffFreshTime, buffs)
	local stagePOD = MazeModule.GetCurStagePOD()

	stagePOD.buffFreshTime = buffFreshTime

	local stageMapPOD = MazeModule.GetRoomStageMapData(stagePOD.curRoomId)

	stageMapPOD.eventLinkPod.buffs = buffs

	EventDispatcher.Dispatch(EventID.OnRefreshBuffResult)
end

function MazeModule.GetLabyrinthEventCfgByStageEventPOD(stageEventPOD)
	if stageEventPOD == nil then
		return nil
	end

	if stageEventPOD.eventId == 0 then
		return nil
	end

	return CfgLabyrinthEventTable[stageEventPOD.eventId]
end

function MazeModule.CheckEventLoopTime(stageEventPOD, labyrinthEventCfg)
	return labyrinthEventCfg.LoopTime > 1
end

function MazeModule.AnalysisBattleEvent(stageEventPOD)
	if stageEventPOD == nil then
		return Constant.MazeStageEventState.None
	end

	if stageEventPOD.eventId == 0 then
		return Constant.MazeStageEventState.None
	end

	if not stageEventPOD.eventState then
		return Constant.MazeStageEventState.EventState
	end

	return Constant.MazeStageEventState.Success
end

function MazeModule.ExecuteBattleEvent(storyBattleId)
	local userData = {}

	userData.StoryBattleId = storyBattleId
	userData.OpenType = Constant.FormationOpenType.Maze
	userData.ChapterType = Constant.ChapterPassType.TYPE_Maze
	userData.IsActiveHomeBtn = false
	userData.IsActiveReturnBtn = false
	userData.IsActiveCultivateBtn = false

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function MazeModule.OpenFormationUIForFormationOnly()
	local userData = {}

	userData.OpenType = Constant.FormationOpenType.Maze
	userData.IsActiveHomeBtn = false
	userData.IsActiveReturnBtn = false
	userData.IsActiveCultivateBtn = false
	userData.OnlyFormation = true

	UIModule.Open(Constant.UIControllerName.FormationUI, Constant.UILayer.UI, userData)
end

function MazeModule.NotifyServerSelectOptionsEvent()
	if MazeModule.SelectOptionsCid == nil or MazeModule.SelectOptionsNextIDIndex == nil then
		return
	end

	MazeModule.OnMazeMutualEvent(MazeModule.SelectOptionsCid, MazeModule.SelectOptionsNextIDIndex)

	MazeModule.SelectOptionsCid = nil
	MazeModule.SelectOptionsNextIDIndex = nil
end

function MazeModule.ExecutePortal(eventSubTypeID)
	local portalCfg = CfgLabyrinthEventPortalTable[eventSubTypeID]
	local labyrinthStagePOD = MazeModule.GetCurStagePOD()
	local curRoomId = labyrinthStagePOD.curRoomId
	local index = table.indexOf(portalCfg.PortalRotation, curRoomId)

	if index == -1 then
		MazeModule.log("传送门配置中未找打对应房间{0}", curRoomId)

		return
	end

	MazeModule.OnTranslateEvent(labyrinthStagePOD.difficulty, curRoomId)
end

function MazeModule.GetAdjacentRooms(roomNumber)
	local adjacentRooms = {}
	local roomIds = MazeModule.GetRoomStageMapData(roomNumber).roomids
	local rows, columns = MazeModule.GetMazeSceneSize()
	local row = math.floor((roomNumber - 1) / columns)
	local col = (roomNumber - 1) % columns

	table.insert(adjacentRooms, roomNumber)

	local directions = {
		{
			0,
			-1
		},
		{
			0,
			1
		},
		{
			-1,
			0
		},
		{
			1,
			0
		}
	}

	for _, direction in ipairs(directions) do
		local dRow = direction[1]
		local dCol = direction[2]
		local newRow = row + dRow
		local newCol = col + dCol

		if newRow >= 0 and newRow < rows and newCol >= 0 and newCol < columns then
			local adjacentRoom = newRow * columns + newCol + 1

			if table.indexOf(roomIds, adjacentRoom) ~= -1 then
				table.insert(adjacentRooms, adjacentRoom)
			end
		end
	end

	return adjacentRooms
end

function MazeModule.GetShowMazeRoomDataList()
	local roomCids = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.guid, MazeModule.GetMazeStageCfg(MazeModule.__labyrinthDataPOD.curDifficulty).Id)

	return roomCids ~= nil and roomCids or {}
end

function MazeModule.RefreshShowMazeRoomData(roomCid)
	local adjacentRooms = MazeModule.GetAdjacentRooms(roomCid)
	local showMazeRoomList = MazeModule.GetShowMazeRoomDataList()
	local tempTable = {}

	for k, v in pairs(showMazeRoomList) do
		tempTable[tonumber(k)] = v
	end

	for k, v in pairs(adjacentRooms) do
		if table.indexOf(tempTable, v) == -1 then
			table.insert(tempTable, v)
		end
	end

	PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.guid, MazeModule.GetMazeStageCfg(MazeModule.__labyrinthDataPOD.curDifficulty).Id, tempTable)
	PlayerPrefsUtil.Save()
end

function MazeModule.ClearMazeRoomDataPlayerPrefs(difficulty)
	PlayerPrefsUtil.DeleteKey(PlayerModule.PlayerInfo.baseInfo.guid, MazeModule.GetMazeStageCfg(difficulty).Id)
end

function MazeModule.Generate_graph(rows, cols)
	local graph = {}

	for i = 1, rows do
		for j = 1, cols do
			local current = (i - 1) * cols + j

			graph[current] = {}

			if i > 1 then
				table.insert(graph[current], (i - 2) * cols + j)
			end

			if i < rows then
				table.insert(graph[current], i * cols + j)
			end

			if j > 1 then
				table.insert(graph[current], (i - 1) * cols + j - 1)
			end

			if j < cols then
				table.insert(graph[current], (i - 1) * cols + j + 1)
			end
		end
	end

	return graph
end

function MazeModule.FindPath(curRoomId, jumpRoomId)
	local rows, columns = MazeModule.GetMazeSceneSize()
	local graph = MazeModule.Generate_graph(rows, columns)
	local path = MazeModule.FindShortestPath(graph, curRoomId, jumpRoomId)

	MazeModule.log("最短路径" .. table.len(path) - 1)

	local length = table.len(path) - 1

	return length <= 0 and 1 or length
end

function MazeModule.FindShortestPath(graph, start_node, end_node)
	local queue = {}

	table.insert(queue, {
		start_node
	})

	local visited = {}

	visited[start_node] = true

	local roomStagePod

	while #queue > 0 do
		local path = table.remove(queue, 1)
		local current_node = path[#path]

		if current_node == end_node then
			return path
		end

		local curNodeRoomStagePod = MazeModule.GetRoomStageMapData(current_node)

		for _, neighbor in ipairs(graph[current_node] or {}) do
			roomStagePod = MazeModule.GetRoomStageMapData(neighbor)

			if roomStagePod ~= nil and roomStagePod.state == true and table.indexOf(curNodeRoomStagePod.roomids, neighbor) ~= -1 and not visited[neighbor] then
				visited[neighbor] = true

				local new_path = {
					unpack(path)
				}

				table.insert(new_path, neighbor)
				table.insert(queue, new_path)
			end
		end
	end

	return {}
end

function MazeModule.CreateAttackOrderData(heroDic)
	local sortedHeroes = {}

	for heroCid, pos in pairs(heroDic) do
		table.insert(sortedHeroes, {
			heroCid = heroCid,
			pos = pos
		})
	end

	table.sort(sortedHeroes, function(a, b)
		return a.pos < b.pos
	end)

	local newHeroDic = {}

	for index, heros in ipairs(sortedHeroes) do
		newHeroDic[heros.heroCid] = index
	end

	return newHeroDic
end

function MazeModule.CreateHeroCidData(heroDic)
	local sortedHeroes = {}

	for heroCid, pos in pairs(heroDic) do
		table.insert(sortedHeroes, {
			heroCid = heroCid,
			pos = pos
		})
	end

	table.sort(sortedHeroes, function(a, b)
		return a.pos < b.pos
	end)

	local newHeroDic = {}

	for index, heros in ipairs(sortedHeroes) do
		newHeroDic[index] = heros.heroCid
	end

	return newHeroDic
end

function MazeModule.GetMeetTheCondition(conditionId)
	local conditionCfg = CfgConditionTable[conditionId]
	local curProgress = 0
	local needProgress = 0

	if conditionCfg.Type[1] == 1 and conditionCfg.SubType[1] == 35 then
		local finishType = conditionCfg.Params[1][1]

		if finishType == Constant.MazeSettlementType.AfterRoom then
			needProgress, curProgress = MazeModule.GetFinishRoomProgerss()
		elseif finishType == Constant.MazeSettlementType.ArriveExit then
			needProgress, curProgress = MazeModule.GetArriveExitProgress()
		elseif finishType == Constant.MazeSettlementType.KillMonster then
			needProgress, curProgress = MazeModule.GetKillMonsterProgress(conditionCfg)
		elseif finishType == Constant.MazeSettlementType.GetItem then
			needProgress, curProgress = MazeModule.GetMazeStageWarehouseItemCount(conditionCfg.Value[1])
		end
	end

	return needProgress, curProgress, needProgress <= curProgress
end

function MazeModule.GetFinishRoomProgerss()
	local stageMapPods = MazeModule.GetCurStagePOD().stageMapPODs
	local allRoomNum = 0
	local afterRoomNum = 0

	for k, v in pairs(stageMapPods) do
		if v.state == true then
			afterRoomNum = afterRoomNum + 1
		end

		allRoomNum = allRoomNum + 1
	end

	return allRoomNum, afterRoomNum
end

function MazeModule.GetArriveExitProgress()
	local stageMapPods = MazeModule.GetCurStagePOD().stageMapPODs
	local allRoomNum = 1
	local afterRoomNum = 0

	for k, v in pairs(stageMapPods) do
		if v.entrance == -1 and v.state == true and v.eventLinkPod.eventLinkState == true then
			afterRoomNum = 1

			break
		end
	end

	return allRoomNum, afterRoomNum
end

function MazeModule.GetKillMonsterProgress(conditionCfg)
	local stageMapPods = MazeModule.GetCurStagePOD().stageMapPODs
	local allRoomNum = 1
	local afterRoomNum = 0
	local count = MazeModule.GetKillMonsterTypeNum(conditionCfg.Value[1])

	for k, v in pairs(stageMapPods) do
		if v.entrance == -1 and v.state == true and count > 0 and v.eventLinkPod.eventLinkState == true then
			afterRoomNum = 1

			break
		end
	end

	return allRoomNum, afterRoomNum
end

function MazeModule.GetAppointItemProgress(itemCid)
	local needProgress = 1
	local curProgress = MazeModule.GetMazeStageWarehouseItemCount(itemCid)

	return needProgress, curProgress
end
