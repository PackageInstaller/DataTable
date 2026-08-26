-- chunkname: @modules/logic/versionactivity1_6/dungeon/model/VersionActivity1_6DungeonBossModel.lua

module("modules.logic.versionactivity1_6.dungeon.model.VersionActivity1_6DungeonBossModel", package.seeall)

local VersionActivity1_6DungeonBossModel = class("VersionActivity1_6DungeonBossModel", Activity149Model)
local ScorePlayerPrefsKey = VersionActivity1_6Enum.ActivityId.DungeonBossRush .. "Score"

function VersionActivity1_6DungeonBossModel:onInit()
	VersionActivity1_6DungeonBossModel.super.onInit(self)

	self._receivedMsgInit = false
end

function VersionActivity1_6DungeonBossModel:reInit()
	VersionActivity1_6DungeonBossModel.super.reInit(self)
end

function VersionActivity1_6DungeonBossModel:isInBossFight()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		return false
	end

	return self:checkBattleEpisodeType(DungeonEnum.EpisodeType.Act1_6DungeonBoss)
end

function VersionActivity1_6DungeonBossModel:checkBattleEpisodeType(episodeType)
	local episodeId = DungeonModel.instance.curSendEpisodeId

	if not episodeId then
		return false
	end

	local episodeCfg = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCfg then
		return false
	end

	return episodeCfg.type == episodeType
end

function VersionActivity1_6DungeonBossModel:onReceiveInfos(msg)
	VersionActivity1_6DungeonBossModel.super.onReceiveInfos(self, msg)

	if not self._receivedMsgInit then
		self:applyPreScoreToCurScore()

		self._receivedMsgInit = true
	end
end

function VersionActivity1_6DungeonBossModel:getScorePrefValue()
	local key = PlayerModel.instance:getPlayerPrefsKey(ScorePlayerPrefsKey)
	local localScore = PlayerPrefsHelper.getNumber(key)

	return localScore or 0
end

function VersionActivity1_6DungeonBossModel:setScorePrefValue(score)
	local key = PlayerModel.instance:getPlayerPrefsKey(ScorePlayerPrefsKey)

	PlayerPrefsHelper.setNumber(key, score)
end

function VersionActivity1_6DungeonBossModel:SetOpenBossViewWithDailyBonus(getDailyBonus)
	self._getDailyBonus = getDailyBonus
end

function VersionActivity1_6DungeonBossModel:GetOpenBossViewWithDailyBonus()
	return self._getDailyBonus
end

VersionActivity1_6DungeonBossModel.instance = VersionActivity1_6DungeonBossModel.New()

return VersionActivity1_6DungeonBossModel
