-- chunkname: @modules/logic/ressplit/work/ResSplitChapterWork.lua

module("modules.logic.ressplit.work.ResSplitChapterWork", package.seeall)

local ResSplitChapterWork = class("ResSplitChapterWork", BaseWork)

function ResSplitChapterWork:onStart(context)
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
			else
				ResSplitModel.instance:addIncludeStory(v.beforeStory)

				local sp = string.split(v.story, "#")

				if #sp == 3 then
					ResSplitModel.instance:addIncludeStory(tonumber(sp[3]))
				end

				ResSplitModel.instance:addIncludeStory(v.afterStory)

				if battleCo then
					self:_getBattleMonsterSkins(battleCo)
				end
			end

			self:_addMapRes(v, isExcludeChapter)

			if not ResSplitEnum.SplitAllScene and battleCo then
				for n, levelId in pairs(levelIds) do
					self:_addSceneRes(levelId, isExcludeChapter)
				end
			end
		end
	end

	self:onDone(true)
end

function ResSplitChapterWork:_addSceneRes(levelId, exclude)
	local levelCO = lua_scene_level.configDict[levelId]

	ResSplitHelper.checkConfigEmpty(string.format("levelId:%d", levelId), "resName", levelCO.resName)

	local path = ResUrl.getSceneRes(levelCO.resName)

	if exclude then
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, path, true)
	else
		ResSplitModel.instance:setExclude(ResSplitEnum.InnerSceneAB, path, true)
		ResSplitModel.instance:setExclude(ResSplitEnum.OutSceneAB, path, false)
	end

	local bgm = levelCO.bgm
	local audioInfo = ResSplitModel.instance.audioDic[bgm]

	if audioInfo then
		ResSplitModel.instance:setExclude(ResSplitEnum.CommonAudioBank, audioInfo.bankName, exclude)
	end
end

function ResSplitChapterWork:_getBattleMonsterSkins(battleCO)
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

function ResSplitChapterWork:_buildMapData()
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

	local allFragment = lua_chapter_map_fragment.configDict

	for id, config in pairs(allFragment) do
		if not string.nilorempty(config.res) then
			local fragmentPath = ResUrl.getDungeonFragmentIcon(config.res)

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, fragmentPath, true)
		end
	end
end

function ResSplitChapterWork:_addMapRes(episodeConfig, exclude)
	local mapConfig = DungeonMapEpisodeItem.getMap(episodeConfig)

	if mapConfig then
		local path = ResUrl.getDungeonMapRes(mapConfig.res)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, exclude)
		self:_addDependRes(path, exclude, mapConfig.id)

		local elementResList = self._mapElementResDic[mapConfig.id]

		if elementResList then
			for i, v in ipairs(elementResList) do
				ResSplitModel.instance:setExclude(ResSplitEnum.Path, v, exclude)
				self:_addDependRes(v, exclude, mapConfig.id)
			end
		end

		local fragmentIdDic = self._mapElementFragmentDic[mapConfig.id]

		if fragmentIdDic then
			for fragmentId, v in pairs(fragmentIdDic) do
				local fragmentConfig = lua_chapter_map_fragment.configDict[fragmentId]

				if not string.nilorempty(fragmentConfig.res) then
					local fragmentPath = ResUrl.getDungeonFragmentIcon(fragmentConfig.res)

					ResSplitModel.instance:setExclude(ResSplitEnum.Path, fragmentPath, exclude)
				end
			end
		end
	end
end

local _DependResExtDic = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	mat = true
}

function ResSplitChapterWork:_addDependRes(path, exclude, mapId)
	path = SLFramework.FrameworkSettings.GetEditorResPath(path)

	local dependencies = ZProj.AssetDatabaseHelper.GetDependencies(path, true)

	for i = 0, dependencies.Length - 1 do
		local dependPath = dependencies[i]
		local extension = string.match(dependPath, ".+%.(%w+)$")

		if string.find(dependPath, "_hddt") and _DependResExtDic[extension] then
			dependPath = string.gsub(dependPath, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, dependPath, exclude)
		end
	end
end

return ResSplitChapterWork
