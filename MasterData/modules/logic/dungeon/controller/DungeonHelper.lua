-- chunkname: @modules/logic/dungeon/controller/DungeonHelper.lua

module("modules.logic.dungeon.controller.DungeonHelper", package.seeall)

local DungeonHelper = _M

function DungeonHelper.getEpisodeRecommendLevel(episodeId, isSimple)
	local battleId = DungeonConfig.instance:getEpisodeBattleId(episodeId)

	if not battleId then
		return 0
	end

	return DungeonHelper.getBattleRecommendLevel(battleId, isSimple)
end

function DungeonHelper.getBattleRecommendLevel(battleId, isSimple)
	local levelStr = isSimple and "levelEasy" or "level"
	local battleCo = lua_battle.configDict[battleId]

	if not battleCo then
		return 0
	end

	local enemyList = {}
	local enemyBossList = {}
	local bossId, monsterIdList

	for _, v in ipairs(string.splitToNumber(battleCo.monsterGroupIds, "#")) do
		for _, id in ipairs((string.splitToNumber(lua_monster_group.configDict[v].monster, "#"))) do
			if DungeonHelper.isBossId(lua_monster_group.configDict[v].bossId, id) then
				table.insert(enemyBossList, id)
			else
				table.insert(enemyList, id)
			end
		end
	end

	if #enemyBossList > 0 then
		return lua_monster.configDict[enemyBossList[1]][levelStr]
	elseif #enemyList > 0 then
		local level = 0

		for _, v in ipairs(enemyList) do
			level = level + lua_monster.configDict[v][levelStr]
		end

		return math.ceil(level / #enemyList)
	else
		return 0
	end
end

function DungeonHelper.isBossId(bossId, monsterId)
	local bossIds = string.splitToNumber(bossId, "#")

	for i, v in ipairs(bossIds) do
		if monsterId == v then
			return true
		end
	end
end

function DungeonHelper.getEpisodeName(episodeId)
	local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

	if episodeConfig then
		::label_4_0::

		local chapterConfig = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if not episodeConfig or not chapterConfig then
			return nil
		end

		local chapterIndex = chapterConfig.chapterIndex
		local episodeIndex, _ = DungeonConfig.instance:getChapterEpisodeIndexWithSP(chapterConfig.id, episodeConfig.id)

		return string.format("%s-%s", chapterIndex, episodeIndex)
	end
end

return DungeonHelper
