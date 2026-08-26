-- chunkname: @modules/logic/rouge/view/RougeHeroGroupFightViewLevel.lua

module("modules.logic.rouge.view.RougeHeroGroupFightViewLevel", package.seeall)

local RougeHeroGroupFightViewLevel = class("RougeHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function RougeHeroGroupFightViewLevel:_btnenemyOnClick()
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self._episodeId)

	if episodeConfig.type == DungeonEnum.EpisodeType.WeekWalk then
		local mapId = WeekWalkModel.instance:getCurMapId()

		EnemyInfoController.instance:openWeekWalkEnemyInfoView(mapId, self._battleId)

		return
	elseif episodeConfig.type == DungeonEnum.EpisodeType.Cachot then
		-- block empty
	elseif episodeConfig.type == DungeonEnum.EpisodeType.BossRush then
		local actId = BossRushConfig.instance:getActivityId()
		local stage, layer = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(self._episodeId)

		EnemyInfoController.instance:openBossRushEnemyInfoView(actId, stage, layer)

		return
	end

	if self._fixHpRate then
		EnemyInfoController.instance:openRougeEnemyInfoView(self._battleId, 1 + tonumber(self._fixHpRate))

		return
	end

	local season = RougeConfig1.instance:season()

	RougeRpc.instance:sendRougeMonsterFixAttrRequest(season, self._onGetFixAttrRequest, self)
end

function RougeHeroGroupFightViewLevel:_onGetFixAttrRequest(req, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._fixHpRate = msg.fixHpRate

	EnemyInfoController.instance:openRougeEnemyInfoView(self._battleId, 1 + tonumber(self._fixHpRate))
end

return RougeHeroGroupFightViewLevel
