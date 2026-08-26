-- chunkname: @modules/logic/versionactivity2_2/eliminate/model/EliminateLevelModel.lua

module("modules.logic.versionactivity2_2.eliminate.model.EliminateLevelModel", package.seeall)

local EliminateLevelModel = class("EliminateLevelModel", BaseModel)

function EliminateLevelModel:onInit()
	return
end

function EliminateLevelModel:reInit()
	return
end

function EliminateLevelModel:initLevel(levelId, warChessCharacterId, pieceIds)
	self._levelId = levelId
	self._warChessCharacterId = warChessCharacterId
	self._pieceIds = pieceIds
	self.curRoundType = EliminateEnum.RoundType.TeamChess

	local episodeConfig = EliminateConfig.instance:getEliminateEpisodeConfig(self._levelId)

	EliminateTeamChessModel.instance:initTeamChess(episodeConfig.warChessId)

	self.beginTime = Time.realtimeSinceStartup
end

function EliminateLevelModel:getCurLevelPieceIds()
	return self._pieceIds
end

function EliminateLevelModel:setCurRoundType(type)
	self.curRoundType = type
end

function EliminateLevelModel:getWarChessCharacterId()
	return self._warChessCharacterId
end

function EliminateLevelModel:setNeedChangeTeamToEliminate(state)
	self._needChangeTeamToEliminate = state
end

function EliminateLevelModel:getLevelId()
	return self._levelId
end

function EliminateLevelModel:getCurLevelConfig()
	return EliminateConfig.instance:getEliminateEpisodeConfig(self._levelId)
end

function EliminateLevelModel:getCurRoundType()
	return self.curRoundType
end

function EliminateLevelModel:getRoundNumber()
	local chessWar = EliminateTeamChessModel.instance:getServerTeamChessWar()

	return (chessWar or nil) and (chessWar.round or 1)
end

function EliminateLevelModel:needPlayShowView()
	return self:getRoundNumber() < 2
end

function EliminateLevelModel:getNeedChangeTeamToEliminate()
	return self._needChangeTeamToEliminate
end

function EliminateLevelModel:clear()
	self.curRoundType = nil
	self._needChangeTeamToEliminate = nil
	self.curRoundNumber = 1
	self._useSkillCount = 0
	self._star = 0
end

function EliminateLevelModel:mainCharacterSkillIsUnLock()
	local constValue = EliminateConfig.instance:getUnLockMainCharacterSkillConst()

	if constValue then
		return (EliminateOutsideModel.instance:hasPassedEpisode(constValue))
	end

	return false
end

function EliminateLevelModel:sellChessIsUnLock()
	local constValue = EliminateConfig.instance:getUnLockChessSellConst()

	if constValue then
		return (EliminateOutsideModel.instance:hasPassedEpisode(constValue))
	end

	return false
end

function EliminateLevelModel:selectSoliderIsUnLock()
	local constValue = EliminateConfig.instance:getUnLockSelectSoliderConst()

	constValue = tonumber(constValue)

	if constValue then
		return (EliminateOutsideModel.instance:hasPassedEpisode(constValue))
	end

	return false
end

function EliminateLevelModel:canReleaseSkill()
	local myInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()

	if myInfo == nil then
		return false
	end

	local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(myInfo.id)
	local character_skill = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.activeSkillIds)

	if not character_skill or string.nilorempty(character_skill.effect) then
		return false
	end

	return myInfo.power >= character_skill.cost
end

function EliminateLevelModel:setIsWatchTeamChess(state)
	self._isWatchTeamChess = state
end

function EliminateLevelModel:getIsWatchTeamChess()
	if self._isWatchTeamChess == nil then
		-- block empty
	end

	return self._isWatchTeamChess
end

function EliminateLevelModel.formatString(str, formatType)
	return (str:gsub("<(.-):(.-)>", function(tag, value)
		if formatType then
			if not formatType[value] then
				local data = EliminateTeamChessEnum.PreBattleFormatType[value]

				return data and string.format(data, tag) or tag
			end
		end
	end))
end

function EliminateLevelModel:getAllStrongHoldId()
	local ids = {}
	local strongholdList = EliminateTeamChessModel.instance:getStrongholds()

	for i = 1, #strongholdList do
		local stronghold = strongholdList[i]

		table.insert(ids, stronghold.id)
	end

	return ids
end

function EliminateLevelModel:getAllPieceName()
	local name = {}

	for i = 1, #self._pieceIds do
		local pieceConfig = EliminateConfig.instance:getSoldierChessConfig(self._pieceIds[i])

		table.insert(name, pieceConfig.name)
	end

	return name
end

function EliminateLevelModel:setStar(star)
	self._star = star
end

function EliminateLevelModel:getStar()
	return self._star or 0
end

function EliminateLevelModel:resourceIdToDict(diamonds)
	local resourceList = {}

	for resourceId, num in pairs(diamonds) do
		local data = {
			resources_colour = resourceId,
			resources_num = num
		}

		table.insert(resourceList, data)
	end

	return resourceList
end

function EliminateLevelModel:addMainUseSkillNum()
	self._useSkillCount = self._useSkillCount or self._useSkillCount + 1
end

function EliminateLevelModel:getMainUseSkillNum()
	return self._useSkillCount or 0
end

function EliminateLevelModel:sendStatData(result)
	local strongHolds = self:getAllStrongHoldId()
	local mainCharacterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(self._warChessCharacterId)
	local characterSkillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(mainCharacterConfig.activeSkillIds)
	local allPieceName = self:getAllPieceName()
	local star = self:getStar()
	local playerInfo = EliminateTeamChessModel.instance:getCurTeamMyInfo()
	local enemyInfo = EliminateTeamChessModel.instance:getCurTeamEnemyInfo()
	local playerHp = 0
	local enemyHp = 0
	local playerHarmed = 0
	local playerInjured = 0

	if playerInfo ~= nil then
		playerHp = playerInfo.hp
		playerInjured = playerInfo.hpInjury
	end

	if enemyInfo ~= nil then
		enemyHp = enemyInfo.hp
		playerHarmed = enemyInfo.hpInjury
	end

	local addList = self:resourceIdToDict(playerInfo.addDiamonds)
	local removeList = self:resourceIdToDict(playerInfo.removeDiamonds)
	local haveList = self:resourceIdToDict(playerInfo.diamonds)
	local useSkillNum = self:getMainUseSkillNum()

	StatController.instance:track(StatEnum.EventName.TeamchessSettlement, {
		[StatEnum.EventProperties.EpisodeId] = tostring(self._levelId),
		[StatEnum.EventProperties.StrongholdId] = strongHolds,
		[StatEnum.EventProperties.MainFighter] = mainCharacterConfig.name,
		[StatEnum.EventProperties.MainFighterSkill] = characterSkillConfig.name,
		[StatEnum.EventProperties.InitialChess] = allPieceName,
		[StatEnum.EventProperties.Result] = result,
		[StatEnum.EventProperties.Star] = star,
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime,
		[StatEnum.EventProperties.TotalRound] = self:getRoundNumber(),
		[StatEnum.EventProperties.OurRemainingHP] = playerHp,
		[StatEnum.EventProperties.EnemyRemainingHP] = enemyHp,
		[StatEnum.EventProperties.SettlementHarm] = playerHarmed,
		[StatEnum.EventProperties.SettlementInjury] = playerInjured,
		[StatEnum.EventProperties.GainResources] = addList,
		[StatEnum.EventProperties.ConsumeResources] = removeList,
		[StatEnum.EventProperties.ResidueResources] = haveList,
		[StatEnum.EventProperties.MainFighterSkillNum] = useSkillNum
	})
end

EliminateLevelModel.instance = EliminateLevelModel.New()

return EliminateLevelModel
