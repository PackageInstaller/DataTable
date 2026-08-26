-- chunkname: @modules/logic/ressplit/controller/ResSplitHelper.lua

module("modules.logic.ressplit.controller.ResSplitHelper", package.seeall)

local ResSplitHelper = _M

function ResSplitHelper.init()
	return
end

function ResSplitHelper.createExcludeConfig()
	local dic = ResSplitConfig.instance:getAppIncludeConfig()
	local characterIdDic = {}
	local chapterIdDic = {}
	local storyIdDic = {}
	local guideIdDic = {}
	local videoDic = {}
	local pathDic = {}
	local seasonDic = {}

	for i, v in pairs(dic) do
		for n, m in pairs(v.character) do
			characterIdDic[m] = true
		end

		for n, m in pairs(v.chapter) do
			chapterIdDic[m] = true
		end

		for n, m in pairs(v.story) do
			storyIdDic[m] = true
		end

		for n, m in pairs(v.guide) do
			guideIdDic[m] = true
		end

		for n, m in pairs(v.video) do
			videoDic[m] = true
		end

		for n, m in pairs(v.path) do
			pathDic[m] = true
		end

		for n, m in pairs(v.seasonIds) do
			seasonDic[m] = true
		end
	end

	local allAudioDic = AudioConfig.instance:getAudioCO()

	ResSplitHelper._buildMapData()
	ResSplitModel.instance:init(characterIdDic, chapterIdDic, allAudioDic, storyIdDic, guideIdDic, videoDic, pathDic, seasonDic)

	local flow = FlowSequence.New()

	flow:addWork(ResSplitUIWork.New())
	flow:addWork(ResSplitSeasonWork.New())
	flow:addWork(ResSplitRoleStoryWork.New())
	flow:addWork(ResSplitChapterWork.New())
	flow:addWork(ResSplitWeekWalkWork.New())
	flow:addWork(ResSplitCharacterWork.New())
	flow:addWork(ResSplitStoryWork.New())
	flow:addWork(ResSplitRoomWork.New())
	flow:addWork(ResSplitSceneWork.New())
	flow:addWork(ResSplitSkillWork.New())
	flow:addWork(ResSplitAudioWemWork.New())
	flow:addWork(ResSplitSpecialWork.New())
	flow:addWork(ResSplitExportWork.New())
	flow:start()
end

function ResSplitHelper.checkConfigEmpty(mainKey, configKey, config)
	if string.nilorempty(config) then
		logError("config Empty", mainKey, configKey)
	end
end

function ResSplitHelper.addEpisodeRes(id)
	local v = DungeonConfig.instance._episodeConfig.configDict[id]

	if v then
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

		local isExcludeChapter = false

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
				ResSplitHelper.addBattleMonsterSkins(battleCo)
			end
		end

		ResSplitHelper.addMapRes(v, isExcludeChapter)

		if not ResSplitEnum.SplitAllScene and battleCo then
			for n, levelId in pairs(levelIds) do
				ResSplitHelper.addSceneRes(levelId, isExcludeChapter)
			end
		end
	end
end

function ResSplitHelper.addMapRes(episodeConfig, exclude)
	local mapConfig = DungeonMapEpisodeItem.getMap(episodeConfig)

	if mapConfig then
		local path = ResUrl.getDungeonMapRes(mapConfig.res)

		ResSplitModel.instance:setExclude(ResSplitEnum.Path, path, exclude)
		ResSplitHelper._addDependRes(path, exclude, mapConfig.id)

		local elementResList = ResSplitHelper._mapElementResDic[mapConfig.id]

		if elementResList then
			for i, v in ipairs(elementResList) do
				ResSplitModel.instance:setExclude(ResSplitEnum.Path, v, exclude)
				ResSplitHelper._addDependRes(v, exclude, mapConfig.id)
			end
		end

		local fragmentIdDic = ResSplitHelper._mapElementFragmentDic[mapConfig.id]

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

function ResSplitHelper.addSceneRes(levelId, exclude)
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

function ResSplitHelper.addBattleMonsterSkins(battleCO)
	if battleCO then
		local monsterGroupIds = string.splitToNumber(battleCO.monsterGroupIds, "#")

		for _, monsterGroupId in ipairs(monsterGroupIds) do
			local monsterGroupCO = lua_monster_group.configDict[monsterGroupId]
			local monsterIds = string.splitToNumber(monsterGroupCO.monster, "#")

			for _, monsterId in ipairs(monsterIds) do
				local monsterConfig = monsterId and lua_monster.configDict[monsterId]

				ResSplitModel.instance:addIncludeSkin(monsterConfig.skinId)

				local skillArr = FightHelper.buildSkills(monsterId)

				for i, v in ipairs(skillArr) do
					ResSplitModel.instance:addIncludeSkill(v)
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

ResSplitHelper._DependResExtDic = {
	tga = true,
	prefab = true,
	controller = true,
	asset = true,
	png = true,
	mat = true
}

function ResSplitHelper._addDependRes(path, exclude, mapId)
	path = SLFramework.FrameworkSettings.GetEditorResPath(path)

	local dependencies = ZProj.AssetDatabaseHelper.GetDependencies(path, true)

	for i = 0, dependencies.Length - 1 do
		local dependPath = dependencies[i]
		local extension = string.match(dependPath, ".+%.(%w+)$")

		if string.find(dependPath, "scenes/m_s08_hddt/") and ResSplitHelper._DependResExtDic[extension] then
			dependPath = string.gsub(dependPath, SLFramework.FrameworkSettings.AssetRootDir .. "/", "")

			ResSplitModel.instance:setExclude(ResSplitEnum.Path, dependPath, exclude)
		end
	end
end

function ResSplitHelper._buildMapData()
	local allMapElement = lua_chapter_map_element.configDict

	ResSplitHelper._mapElementResDic = {}
	ResSplitHelper._mapElementFragmentDic = {}

	for id, config in pairs(allMapElement) do
		if ResSplitHelper._mapElementResDic[config.mapId] == nil then
			ResSplitHelper._mapElementResDic[config.mapId] = {}
		end

		if string.nilorempty(config.res) == false then
			table.insert(ResSplitHelper._mapElementResDic[config.mapId], config.res)
		end

		if string.nilorempty(config.effect) == false then
			table.insert(ResSplitHelper._mapElementResDic[config.mapId], config.effect)
		end

		if config.fragment > 0 then
			if ResSplitHelper._mapElementFragmentDic[config.mapId] == nil then
				ResSplitHelper._mapElementFragmentDic[config.mapId] = {}
			end

			ResSplitHelper._mapElementFragmentDic[config.mapId][config.fragment] = true
		end
	end
end

return ResSplitHelper
