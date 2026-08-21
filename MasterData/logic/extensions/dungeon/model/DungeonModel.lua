-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/DungeonModel.lua

module("logic.extensions.dungeon.model.DungeonModel", package.seeall)

local M = class("DungeonModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._allDungeonUnlock = false
	self._dungeonAfflatusChooseList = {}
	self._dungeonPlotChooseList = {}
	self._dungeonMultiCountList = {}
	self._dungeonPassedList = {}
	self._dungeonEndStars = false
	self._lastBattleTeamList = {}
	self._isInBattle = false
	self._lastEnterDungeonCode = false
	self._dungeonMoList = {}
	self._firstPass = false
	self._recordLastTeamList = {}
end

function M:getDungeonMoById(dungeonId, showToast)
	if not dungeonId then
		return
	end

	local dungeonType = self:getDungeonTypeByCfg(dungeonId, showToast)

	if dungeonType == CommEnum.DungeonType.Mainline or dungeonType == CommEnum.DungeonType.Tacit or dungeonType == CommEnum.DungeonType.Branchline then
		return DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonId)
	elseif dungeonType == CommEnum.DungeonType.Material or dungeonType == CommEnum.DungeonType.Gold or dungeonType == CommEnum.DungeonType.Exp then
		return DungeonMaterialChapterModel.instance:getDungeonMoById(dungeonId)
	elseif dungeonType == CommEnum.DungeonType.Teaching then
		return DungeonTeachingChapterModel.instance:getDungeonMoById(dungeonId)
	elseif dungeonType == CommEnum.DungeonType.EquipExplore then
		return DungeonEquipExploreChapterModel.instance:getDungeonMoById(dungeonId)
	elseif dungeonType == CommEnum.DungeonType.LightTower then
		return ClimbingTowerModel.instance:getDungeonMoById(dungeonId)
	elseif dungeonType == CommEnum.DungeonType.DarkTower then
		return ClimbingTowerDarkModel.instance:getDungeonMoById(dungeonId)
	elseif dungeonType == CommEnum.DungeonType.ControlAction or dungeonType == CommEnum.DungeonType.ControlActionTeaching then
		return DungeonControlModel.instance:getDungeonMoById(dungeonId)
	else
		return self:_getCommonMoById(dungeonId)
	end
end

function M:_getCommonMoById(dungeonId)
	if self._dungeonMoList[dungeonId] then
		return self._dungeonMoList[dungeonId]
	end

	local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)
	local dungeonMo = DungeonMOBase.New()

	dungeonMo:initByConfig(dungeonCo)
	dungeonMo:initByData(self:getDungeonPassDataByDungeonId(dungeonId))

	self._dungeonMoList[dungeonId] = dungeonMo

	return dungeonMo
end

function M:getDungeonTypeByCfg(dungeonId, showToast)
	local cfg = DungeonConfig.instance:getDungeonCfgById(dungeonId)

	if not cfg then
		cfg = DungeonConfig.instance:getMainlinePlotDungeonCOByDungeonId(dungeonId)

		if cfg then
			return CommEnum.DungeonType.Mainline
		else
			if showToast then
				printError(string.format("无法从[t_%s]找到[%s]的配置", ConfigName.Dungeon, dungeonId))
			end

			return false
		end
	end

	local typ = cfg.type

	if typ == DungeonExtension_pb.DungeonType.MAINLINE then
		return CommEnum.DungeonType.Mainline
	elseif typ == DungeonExtension_pb.DungeonType.MATERIAL then
		return CommEnum.DungeonType.Material
	elseif typ == DungeonExtension_pb.DungeonType.GOLD then
		return CommEnum.DungeonType.Gold
	elseif typ == DungeonExtension_pb.DungeonType.EXP then
		return CommEnum.DungeonType.Exp
	elseif typ == DungeonExtension_pb.DungeonType.TRAINING then
		return CommEnum.DungeonType.Teaching
	elseif typ == DungeonExtension_pb.DungeonType.EQUIPMENT then
		return CommEnum.DungeonType.EquipExplore
	elseif typ == DungeonExtension_pb.DungeonType.LIGHT_TOWER then
		return CommEnum.DungeonType.LightTower
	elseif typ == DungeonExtension_pb.DungeonType.DARK_TOWER then
		return CommEnum.DungeonType.DarkTower
	elseif typ == DungeonExtension_pb.DungeonType.TACIT then
		return CommEnum.DungeonType.Tacit
	elseif typ == DungeonExtension_pb.DungeonType.BRANCHLINE then
		return CommEnum.DungeonType.Branchline
	elseif typ == DungeonExtension_pb.DungeonType.CONTROL_ACTION then
		return CommEnum.DungeonType.ControlAction
	elseif typ == DungeonExtension_pb.DungeonType.CONTROL_ACTION_GUIDE then
		return CommEnum.DungeonType.ControlActionTeaching
	elseif typ == DungeonExtension_pb.DungeonType.HERO_EARLY_ACCESS then
		return CommEnum.DungeonType.HeroEarlyAccess
	elseif typ == DungeonExtension_pb.DungeonType.POWER_CHALLENGE then
		return CommEnum.DungeonType.PowerChallenge
	end
end

function M:initDungeonPassData(agentData)
	local existCode = {}
	local deleteCode = {}

	for i, v in ipairs(agentData) do
		self._dungeonPassedList[v.code] = v
		existCode[v.code] = 1
	end

	for code, _ in pairs(self._dungeonPassedList or {}) do
		if not existCode[code] then
			table.insert(deleteCode, code)
		end
	end

	for _, code in ipairs(deleteCode) do
		self._dungeonPassedList[code] = nil
	end

	DungeonMainLineChapterModel.instance:initDungeonPassData()
end

function M:getDungeonPassDataByDungeonId(dungeonId)
	return self._dungeonPassedList[dungeonId]
end

function M:updateDungeonPassData(stars)
	local dungeonCode = self:getLastEnterDungeonCode()

	if not dungeonCode then
		if enableErrorLog then
			printError("The last enter dungeon code is nil")
		end

		return
	end

	local dungeonNo = {}

	dungeonNo.code = dungeonCode
	dungeonNo.stars = stars
	dungeonNo.hasRecord = true
	self._dungeonPassedList[dungeonNo.code] = dungeonNo

	local dungeonMo = self:getDungeonMoById(dungeonNo.code)
	local dungeonType

	if dungeonMo then
		dungeonMo:initByAgent(dungeonNo)

		dungeonType = dungeonMo:getType()
	else
		printError(string.format("无法更新dungeonMo,找不到:%s", dungeonNo.code))
	end

	if dungeonType == CommEnum.DungeonType.Mainline then
		DungeonMainLineChapterModel.instance:checkAllUnlockStatus()
	elseif dungeonType == CommEnum.DungeonType.DarkTower then
		local lastBattleDarkInfo = ClimbingTowerDarkModel.instance:getLastDungeonBattleInfo()
		local lastBattleDarkRound = lastBattleDarkInfo and lastBattleDarkInfo.darkRound or -1

		if ClimbingTowerDarkModel.instance:getDarkRound() ~= lastBattleDarkRound then
			self._dungeonPassedList[dungeonNo.code] = nil

			ClimbingTowerDarkModel.instance:clearDarkDungeonMo()
		end
	end
end

function M:cacheEndStars(currentStars, mergedStars)
	self:updateDungeonPassData(mergedStars)

	if not self._dungeonEndStars then
		self._dungeonEndStars = {}
	end

	self._dungeonEndStars.currentStars = {
		currentStars % 2 == 1,
		currentStars % 4 >= 2,
		currentStars % 8 >= 4
	}
	self._dungeonEndStars.mergedStars = {
		mergedStars % 2 == 1,
		mergedStars % 4 >= 2,
		mergedStars % 8 >= 4
	}
end

function M:getCacheEndStars()
	return self._dungeonEndStars
end

function M:clearCacheEndStars()
	table.clear(self._dungeonEndStars)

	self._dungeonEndStars = false
end

function M:setAfflatusChoose(dungeonId, status)
	self._dungeonAfflatusChooseList[dungeonId] = status
end

function M:getAfflatusChoose(dungeonId)
	if self._dungeonAfflatusChooseList[dungeonId] == nil then
		return true
	end

	return self._dungeonAfflatusChooseList[dungeonId]
end

function M:setPlotChoose(dungeonId, status)
	self._dungeonPlotChooseList[dungeonId] = status
end

function M:getPlotChoose(dungeonId)
	if self._dungeonPlotChooseList[dungeonId] == nil then
		return false
	end

	return self._dungeonPlotChooseList[dungeonId]
end

function M:setMultiCount(dungeonId, num)
	self._dungeonMultiCountList[dungeonId] = num
end

function M:getMultiCount(dungeonId)
	if self._dungeonMultiCountList[dungeonId] == nil then
		return 1
	end

	return self._dungeonMultiCountList[dungeonId]
end

function M:mergeAndSortRewardList(rewardList)
	local rewardNewList = {}
	local recordList = {}

	for i, v in ipairs(rewardList) do
		if not recordList[v.code] then
			recordList[v.code] = true

			table.insert(rewardNewList, v)
		end
	end

	table.sort(rewardNewList, function(reward1, reward2)
		local item1Co = BackpackConfig.instance:getItemInfoByItemId(reward1.code)
		local item2Co = BackpackConfig.instance:getItemInfoByItemId(reward2.code)

		return item1Co.quality > item2Co.quality
	end)

	return rewardNewList
end

function M:setAllDungeonUnlock(status)
	self._allDungeonUnlock = status

	DungeonDispatcher:dispatchEvent(DungeonEventType.DUNGEON_DATA_UPDATE)
end

function M:getAllDungeonUnlock()
	return self._allDungeonUnlock
end

function M:localStorageHasEnterDungeonId(dungeonId)
	local playerId = PlayerModel.instance:getId()
	local key = string.format("dungeonEntered%d%d", playerId, dungeonId)

	Astral.LocalStorage.Instance:SetInt(key, 1)
end

function M:getIfDungeonEntered(dungeonId)
	local playerId = PlayerModel.instance:getId()
	local key = string.format("dungeonEntered%d%d", playerId, dungeonId)
	local value = Astral.LocalStorage.Instance:GetInt(key, 0)

	return value == 1
end

function M:deleteLocalStorageEnterDungeon(dungeonId)
	local playerId = PlayerModel.instance:getId()
	local key = string.format("dungeonEntered%d%d", playerId, dungeonId)

	Astral.LocalStorage.Instance:DeleteKey(key)
end

function M:getNeedEnterSceneType()
	return self._needEnterSceneType
end

function M:setNeedEnterSceneType(type)
	self._needEnterSceneType = type
end

function M:getDungeonIndex(dungeonId)
	local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)
	local index = dungeonCo.index

	if not index then
		return 0
	end

	return index
end

function M:getDungeonScoreRate(dungeonId)
	local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)
	local dungeonScore = dungeonCo.strengthConsult

	if dungeonScore == 0 then
		return 0
	end

	local highestScore = 0
	local heroData = HeroDepotModel.instance:getHeroDepotData()
	local scoreList = {}

	for i, heroData in ipairs(heroData:getHeroDataList()) do
		table.insert(scoreList, heroData:getAttribute(BattleExtension_pb.Attribute.FIGHTING_CAPACITY))
	end

	table.sort(scoreList, function(a, b)
		return b < a
	end)

	for i = 1, 5 do
		if i <= #scoreList then
			highestScore = highestScore + scoreList[i]
		end
	end

	table.clear(scoreList)

	return highestScore / dungeonScore
end

function M:getHighestScoreHero()
	local heroList = {}
	local heroIdList = {}
	local heroData = HeroDepotModel.instance:getHeroDepotData()

	for i, heroData in ipairs(heroData:getHeroDataList()) do
		table.insert(heroList, heroData)
	end

	table.sort(heroList, function(a, b)
		return a:getAttribute(BattleExtension_pb.Attribute.FIGHTING_CAPACITY) > b:getAttribute(BattleExtension_pb.Attribute.FIGHTING_CAPACITY)
	end)

	for i = 1, 5 do
		if i <= #heroList then
			table.insert(heroIdList, heroList[i]:getId())
		end
	end

	table.clear(heroList)

	return heroIdList
end

function M:setLastBattleTeam(teamList)
	for i, v in ipairs(teamList) do
		self._lastBattleTeamList[v.type] = v.heroes
	end
end

function M:updateLastBattleTeam(team)
	self._lastBattleTeamList[team.type] = team.heroes
end

function M:getLastBattleTeam(type)
	return self._lastBattleTeamList[type]
end

function M:getIsInBattle()
	return self._isInBattle
end

function M:setIsInBattle(status)
	self._isInBattle = status
end

function M:setLastEnterDungeonCode(dungeonCode)
	self._lastEnterDungeonCode = dungeonCode
end

function M:getLastEnterDungeonCode()
	return self._lastEnterDungeonCode
end

function M:isInGameEarlyStage()
	local constCO = BattleConfig.instance:getBattleConstCO("earlyStageDungeonJudge")
	local dungeonId = constCO.numValue
	local dungeonMO = self:getDungeonMoById(dungeonId)

	if dungeonMO then
		return dungeonMO:hasPassed()
	else
		return false
	end
end

function M:setFirstPass(firstPass)
	self._firstPass = firstPass
end

function M:isFirstPassed()
	return self._firstPass
end

function M:setRecordLastTeam(dungeons)
	for _, dungeon in ipairs(dungeons) do
		if dungeon.recordTeam then
			local team = {}

			for _, heroId in ipairs(dungeon.recordTeam) do
				table.insert(team, heroId)
			end

			self._recordLastTeamList[dungeon.code] = team
		end
	end
end

function M:updateRecordLastTeam(record)
	local res = {}

	for _, heroId in ipairs(record.recordTeam) do
		table.insert(res, heroId)
	end

	self._recordLastTeamList[record.dungeonCode] = res
end

function M:getRecordLastTeam(dungeonId)
	return self._recordLastTeamList[dungeonId]
end

M.instance = M.New()

return M
