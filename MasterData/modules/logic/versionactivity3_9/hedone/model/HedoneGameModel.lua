-- chunkname: @modules/logic/versionactivity3_9/hedone/model/HedoneGameModel.lua

module("modules.logic.versionactivity3_9.hedone.model.HedoneGameModel", package.seeall)

local HedoneGameModel = class("HedoneGameModel", BaseModel)

function HedoneGameModel:onInit()
	self:clearAllData()
end

function HedoneGameModel:reInit()
	self:clearAllData()
end

function HedoneGameModel:clearAllData()
	self._genUid = 0
	self._isGameEnd = false
	self._gameTime = 0
	self._monsterKillCount = 0
	self._lastWaveTime = 0
	self._cdSkillDamageDict = {}

	self:_clearAllEntityMO(true)
	self:_setGameEpisodeId()
	self:_setGameId()

	self._stopSourceDict = {}
	self._gameStartTime = nil
end

function HedoneGameModel:_generateUid()
	self._genUid = self._genUid + 1

	return self._genUid
end

local LogToggle = {
	Disable = 0,
	Enable = 1
}

function HedoneGameModel:onEnterGame(episodeId, gameId)
	self:clearAllData()
	math.randomseed(os.time())
	self:_setGameEpisodeId(episodeId)
	self:_setGameId(gameId)

	local toggle = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMHedoneViewLogToggle, LogToggle.Disable)

	self._isLogDamage = toggle == LogToggle.Enable

	local playerType = HedoneGameEnum.EntityType.Player
	local playerUid = HedoneGameEnum.Const.PlayerUid
	local playerPos = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.PlayerXY, false, true, "#")

	self._playerMO = HedonePlayerMO.New({
		uid = playerUid,
		id = playerUid,
		entityType = playerType,
		posX = playerPos[1],
		posY = playerPos[2]
	})
	self._entityType2UidList[playerType] = {
		playerUid
	}
	self._gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function HedoneGameModel:addEntityMOByList(moDataList)
	if not moDataList then
		return
	end

	local uidList = {}

	for _, moData in ipairs(moDataList) do
		local mo = self:addEntityMO(moData)

		if mo then
			uidList[#uidList + 1] = mo:getUid()
		end
	end

	return uidList
end

function HedoneGameModel:addEntityMO(moData)
	if not moData then
		return
	end

	local entityType = moData.entityType
	local moCls = HedoneGameHelper.getEntityMOCls(entityType)

	if not moCls then
		return
	end

	local uid = self:_generateUid()

	moData.uid = uid

	local mo = moCls.New(moData)

	self._uid2EntityMODict[uid] = mo

	local uidList = GameUtil.tabletool_checkDictTable(self._entityType2UidList, entityType)

	uidList[#uidList + 1] = uid

	return mo
end

function HedoneGameModel:removeEntityMO(uid)
	local mo = self:getEntityMO(uid)

	if not mo then
		return
	end

	self._uid2EntityMODict[uid] = nil

	local entityType = mo:getEntityType()
	local uidList = self._entityType2UidList[entityType]

	if uidList then
		tabletool.removeValue(uidList, uid)
	end
end

function HedoneGameModel:_clearAllEntityMO(includePlayer)
	if includePlayer then
		self._playerMO = nil
	end

	self._uid2EntityMODict = {}
	self._entityType2UidList = {}
end

function HedoneGameModel:_setGameEpisodeId(episodeId)
	self._gameEpisodeId = episodeId
end

function HedoneGameModel:_setGameId(gameId)
	self._gameId = gameId
	self._curWaveIndex = 1
	self._monsterWaveDataList = self._gameId and HedoneConfig.instance:getHedoneGameLevelWaves(gameId) or {}
end

function HedoneGameModel:requestStopGame(sourceKey)
	if self._stopSourceDict[sourceKey] then
		return
	end

	self._stopSourceDict[sourceKey] = true
end

function HedoneGameModel:requestResumeGame(sourceKey)
	if not self._stopSourceDict[sourceKey] then
		return
	end

	self._stopSourceDict[sourceKey] = nil
end

function HedoneGameModel:setGameEnd()
	self._isGameEnd = true
end

function HedoneGameModel:addGameTime()
	self._gameTime = (self._gameTime or 0) + TimeUtil.OneSecond

	return self._gameTime
end

function HedoneGameModel:addMonsterKillCount()
	self._monsterKillCount = (self._monsterKillCount or 0) + 1
end

function HedoneGameModel:addCurWaveIndex()
	self._curWaveIndex = self._curWaveIndex + 1
end

function HedoneGameModel:recordGenerateWaveTime()
	self._lastWaveTime = self:getGameTime()
end

function HedoneGameModel:recordSkillDamage(effectGroup, damage)
	damage = tonumber(damage)

	if not damage or damage <= 0 then
		return
	end

	local skillId = HedoneConfig.instance:getCDSKillIdByType(effectGroup)

	self:tryInitCDSkillDamageData(skillId)

	local damageData = self._cdSkillDamageDict[skillId]

	if not damageData then
		return
	end

	damageData.damage = damageData.damage + damage
end

function HedoneGameModel:tryInitCDSkillDamageData(skillId)
	if skillId then
		::label_20_0::

		local skillCD = HedoneConfig.instance:getHedoneSkillCd(skillId)
		local isCDSkill = skillCD and skillCD > 0

		if not isCDSkill then
			return
		end

		local damageData = self._cdSkillDamageDict[skillId]

		if damageData then
			return
		end

		self._cdSkillDamageDict[skillId] = {
			percent = 0,
			damage = 0,
			skillId = skillId
		}
	end
end

function HedoneGameModel:setIsLogDamage(isLog)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMHedoneViewLogToggle, (isLog or nil) and (LogToggle.Enable or LogToggle.Disable))

	self._isLogDamage = isLog
end

function HedoneGameModel:getGameEpisodeId()
	return self._gameEpisodeId
end

function HedoneGameModel:getGameId()
	return self._gameId
end

function HedoneGameModel:getGameStartTime()
	return self._gameStartTime or 0
end

function HedoneGameModel:getPlayerMO()
	return self._playerMO
end

function HedoneGameModel:getEntityMO(uid, targetEntityType)
	if not uid then
		return
	end

	local mo = uid == HedoneGameEnum.Const.PlayerUid and self:getPlayerMO() or self._uid2EntityMODict[uid]

	if not mo then
		return
	end

	if targetEntityType then
		local entityType = mo:getEntityType()

		if entityType ~= targetEntityType then
			return
		end
	end

	return mo
end

function HedoneGameModel:getEntityTypeUidList(entityType)
	return self._entityType2UidList[entityType]
end

function HedoneGameModel:getIsStopGame()
	return next(self._stopSourceDict) ~= nil
end

function HedoneGameModel:getIsGameEnd()
	return self._isGameEnd or ViewMgr.instance:isOpen(ViewName.HedoneResultView)
end

function HedoneGameModel:getGameTime()
	return self._gameTime or 0
end

function HedoneGameModel:getCurWaveData()
	if not self._monsterWaveDataList then
		return
	end

	return self._monsterWaveDataList[self._curWaveIndex]
end

function HedoneGameModel:getMonsterDifficultFactorWithTime()
	local gameId = self:getGameId()
	local gameTime = self:getGameTime()
	local targetTime = HedoneConfig.instance:getHedoneGameTargetTime(gameId)
	local endlessDifficultData = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.EndlessLevelDifficult, false, true, "#")

	return (endlessDifficultData and targetTime < 0 and gameTime >= endlessDifficultData[1] and endlessDifficultData[2] or HedoneConfig.instance:getHedoneGameMonsterGrowPerSecond(gameId)) * gameTime
end

function HedoneGameModel:getMonsterKillCount()
	return self._monsterKillCount or 0
end

function HedoneGameModel:getLastGenerateWaveTime()
	return self._lastWaveTime or 0
end

function HedoneGameModel:getCDSkillRecordDamageDataList()
	local result = {}
	local totalDamage = 0

	for _, damageData in pairs(self._cdSkillDamageDict) do
		damageData.percent = 0
		totalDamage = totalDamage + damageData.damage
		result[#result + 1] = damageData
	end

	if totalDamage > 0 then
		for _, data in ipairs(result) do
			data.percent = data.damage / totalDamage
		end
	end

	table.sort(result, function(a, b)
		if a.percent ~= b.percent then
			return a.percent > b.percent
		end

		return a.skillId < b.skillId
	end)

	return result
end

function HedoneGameModel:getIsLogDamage()
	return self._isLogDamage
end

HedoneGameModel.instance = HedoneGameModel.New()

return HedoneGameModel
