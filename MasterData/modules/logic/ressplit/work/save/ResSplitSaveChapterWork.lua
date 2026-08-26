-- chunkname: @modules/logic/ressplit/work/save/ResSplitSaveChapterWork.lua

module("modules.logic.ressplit.work.save.ResSplitSaveChapterWork", package.seeall)

local ResSplitSaveChapterWork = class("ResSplitSaveChapterWork", BaseWork)

function ResSplitSaveChapterWork:onStart(context)
	local allEpisode = DungeonConfig.instance._episodeConfig.configDict

	self:_buildMapData()

	for i, v in pairs(allEpisode) do
		if v.type == DungeonEnum.EpisodeType.WeekWalk then
			-- block empty
		else
			local battleCo = DungeonConfig.instance:getBattleCo(v.id)
			local levelIds = {}

			if battleCo then
				ResSplitHelper.checkConfigEmpty(string.format("Character:%d", battleCo.id), "sceneIds", battleCo.sceneIds)

				local sceneIds = string.splitToNumber(battleCo.sceneIds, "#")

				for _, sceneId in ipairs(sceneIds) do
					local levelCOs = SceneConfig.instance:getSceneLevelCOs(sceneId)

					if levelCOs then
						local levelId = levelCOs[1].id

						table.insert(levelIds, levelId)
					end
				end
			end

			local isExcludeChapter = ResSplitModel.instance:isExcludeChapter(v.chapterId)

			if isExcludeChapter then
				-- block empty
			elseif battleCo then
				self:_getBattleMonsterSkins(battleCo)
			end
		end
	end

	self:onDone(true)
end

function ResSplitSaveChapterWork:_getBattleMonsterSkins(battleCO)
	if battleCO then
		local monsterGroupIds = string.splitToNumber(battleCO.monsterGroupIds, "#")

		for _, monsterGroupId in ipairs(monsterGroupIds) do
			local monsterGroupCO = lua_monster_group.configDict[monsterGroupId]

			if monsterGroupCO then
				local monsterIds = string.splitToNumber(monsterGroupCO.monster, "#")

				for _, monsterId in ipairs(monsterIds) do
					local monsterConfig = monsterId and lua_monster.configDict[monsterId]

					if monsterConfig then
						ResSplitModel.instance:addIncludeSkin(monsterConfig.skinId)

						local skillArr = FightHelper.buildSkills(monsterId)

						for i, v in ipairs(skillArr) do
							ResSplitModel.instance:addIncludeSkill(v)
						end
					else
						logError(string.format("怪物不存在 battle_%d monsterGroup_%d monster_%d", battleCO.id, monsterGroupId, monsterId))
					end
				end
			end
		end

		for _, monsterId in ipairs((not string.nilorempty(battleCO.aid) or nil) and string.splitToNumber(battleCO.aid, "#")) do
			local monsterConfig = monsterId and lua_monster.configDict[monsterId]

			ResSplitModel.instance:addIncludeSkin(monsterConfig.skinId)

			local skillArr = FightHelper.buildSkills(monsterId)

			for i, v in ipairs(skillArr) do
				ResSplitModel.instance:addIncludeSkill(v)
			end
		end
	end
end

function ResSplitSaveChapterWork:_buildMapData()
	local allMapElement = lua_chapter_map_element.configDict

	self._mapElementResDic = {}
	self._mapElementFragmentDic = {}

	for id, config in pairs(allMapElement) do
		if self._mapElementResDic[config.mapId] == nil then
			self._mapElementResDic[config.mapId] = {}
		end

		if string.nilorempty(config.res) == false then
			table.insert(self._mapElementResDic[config.mapId], config.res)
		end

		if string.nilorempty(config.effect) == false then
			table.insert(self._mapElementResDic[config.mapId], config.effect)
		end

		if config.fragment > 0 then
			if self._mapElementFragmentDic[config.mapId] == nil then
				self._mapElementFragmentDic[config.mapId] = {}
			end

			self._mapElementFragmentDic[config.mapId][config.fragment] = true
		end
	end
end

return ResSplitSaveChapterWork
