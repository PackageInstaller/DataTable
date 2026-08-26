-- chunkname: @modules/logic/versionactivity2_5/challenge/view/result/Act183SettlementBossEpisodeHeroComp.lua

module("modules.logic.versionactivity2_5.challenge.view.result.Act183SettlementBossEpisodeHeroComp", package.seeall)

local Act183SettlementBossEpisodeHeroComp = class("Act183SettlementBossEpisodeHeroComp", Act183SettlementSubEpisodeHeroComp)

Act183SettlementBossEpisodeHeroComp.TeamLeaderPosition = {
	1,
	1,
	1,
	1,
	1
}

local HeroItemScale = 1

function Act183SettlementBossEpisodeHeroComp:refreshHeroPosition(heroItem, positionParams)
	transformhelper.setLocalScale(heroItem.transform, HeroItemScale, HeroItemScale, HeroItemScale)
end

return Act183SettlementBossEpisodeHeroComp
