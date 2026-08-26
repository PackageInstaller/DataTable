-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicHeroGroupFightViewRule.lua

module("modules.logic.sp02.dungeonmap.view.AtomicHeroGroupFightViewRule", package.seeall)

local AtomicHeroGroupFightViewRule = class("AtomicHeroGroupFightViewRule", HeroGroupFightViewRule)

function AtomicHeroGroupFightViewRule:_getRuleList(episodeConfig)
	local battleCo = lua_battle.configDict[self._battleId]

	if battleCo then
		if not battleCo.additionRule then
			local additionRule = ""
			local ruleList = FightStrUtil.instance:getSplitString2Cache(additionRule, true, "|", "#") or {}
			local alarmRuleList = AtomicDungeonModel.instance:getAlarmRuleList()
			local isPolygonEpisode = AtomicDungeonConfig.instance:checkIsPolygonEpisode(episodeConfig.id)

			if alarmRuleList and #alarmRuleList > 0 and not isPolygonEpisode then
				tabletool.addValues(ruleList, alarmRuleList)
			end

			return ruleList
		end
	end
end

return AtomicHeroGroupFightViewRule
