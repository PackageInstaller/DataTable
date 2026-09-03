-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/BattleLoader.lua

BattleLoader = BattleLoader or {}

function BattleLoader:getBulletSetting(bulletBattleType)
	local bulletTimeEnabled = ConfigReader:getDataByNameIdAndKey("ConfigValue", bulletBattleType, "content")

	return bulletTimeEnabled and (bulletTimeEnabled == 1 or bulletTimeEnabled == true) or false
end

function BattleLoader:_collectResData(data)
	if data == nil then
		return
	end

	local modelIdsMap = {}
	local mcClibIdsMap = {}

	local function insertModel(model, priority)
		local prePriority = modelIdsMap[model]

		if prePriority and prePriority <= priority then
			return
		end

		modelIdsMap[model] = priority
	end

	local function insertMClib(surfaceId)
		if surfaceId then
			local animeList = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "AnimeList")

			for k, v in pairs(animeList or {}) do
				mcClibIdsMap[v] = true
			end
		end
	end

	local function collectPlayerData(player)
		if player.waves then
			local waveData = player.waves[1]

			if waveData then
				local master = waveData.master

				if master then
					insertModel(master.modelId, 1)
					insertMClib(master.surfaceId)
				end

				local heros = waveData.heros

				if heros then
					for _, hero in ipairs(heros) do
						insertModel(hero.modelId, 1)
						insertMClib(hero.surfaceId)
					end
				end
			end

			local cards = player.cards

			if cards then
				for _, card in ipairs(cards) do
					local hero = card.hero

					insertModel(hero.modelId, 2)
					insertMClib(hero.surfaceId)
				end
			end

			if player.summon then
				for _, summonInfo in ipairs(player.summon) do
					insertModel(summonInfo.modelId, 2)
				end
			end
		end
	end

	local battleData = data.battleData
	local battleRecords = data.battleRecords

	if battleData then
		if battleData.playerData then
			if battleData.playerData[1] then
				if not battleData.playerData then
					do
						local playerData = {
							battleData.playerData
						}

						for _, player in ipairs(playerData) do
							collectPlayerData(player)
						end
					end

					if battleData.enemyData then
						if battleData.enemyData[1] then
							if not battleData.enemyData then
								local enemyData = {
									battleData.enemyData
								}

								for _, player in ipairs(enemyData) do
									collectPlayerData(player)
								end
							end
						end
					end
				end
			end
		end
	elseif battleRecords and battleRecords.timelines then
		local timelines = battleRecords.timelines

		for _, timeline in pairs(timelines) do
			local keyframes = timeline.keyframes
			local firstFrame = keyframes and keyframes[1]

			if firstFrame then
				local evt = firstFrame.evts[1]
				local frame = firstFrame.f
				local e = evt.e

				if e == "SpawnUnit" or e == "CallUnit" then
					local model = evt.d.model

					insertModel(model, frame < 30 and 1 or 2)
				end
			end
		end
	end

	local modelIdsPriorityList = {
		{},
		{}
	}

	for model, priority in pairs(modelIdsMap) do
		local list = modelIdsPriorityList[priority]

		list[#list + 1] = {
			type = "spine",
			model = model
		}
	end

	for k, v in pairs(mcClibIdsMap) do
		local list = modelIdsPriorityList[1]

		list[#list + 1] = {
			type = "mclibObj",
			id = k
		}
	end

	return modelIdsPriorityList
end

function BattleLoader:_collectAudioData(data)
	local SpecialSoundMap = {
		down = "_30",
		hurt = "_29",
		die = "_32"
	}
	local audioList = {}

	for priority, list in ipairs(data) do
		for i, info in ipairs(list) do
			if info.type == "spine" then
				local modelId = info.model
				local hero = ConfigReader:getDataByNameIdAndKey("RoleModel", modelId, "Hero")

				if hero and hero ~= nil then
					for t, n in pairs(SpecialSoundMap) do
						audioList[#audioList + 1] = "Voice_" .. hero .. n
					end
				end
			end
		end
	end

	return audioList
end

function BattleLoader:_resourceListByBattle(list, background, battleType)
	local priorityList = list or {
		{},
		{}
	}

	local function insertRes(info, priority)
		priority = priority or 1

		local list = priorityList[priority]

		list[#list + 1] = info
	end

	if background then
		insertRes({
			type = "image",
			file = "asset/scene/" .. background
		})
	end

	return priorityList
end

function BattleLoader:pushBattleView(dispatcher, data, forceNoScene, isPvP)
	local dispatcher = DmGame:getInstance()

	local function cleanFunc()
		app.clearCurrentPool()
		sp.SkeletonAnimationCache:getInstance():removeUnusedSkeletonDataExtends()
		display.removeUnusedSpriteFrames()
		cc.Director:getInstance():getTextureCache():disableAutoGC()

		local textureCache = cc.Director:getInstance():getTextureCache()
	end

	local injector = dispatcher:getInjector()
	local modelList = self:_collectResData(data)
	local resList = modelList
	local audioList = self:_collectAudioData(modelList)

	local function preloadPriorityRes(info, priority)
		if info.type == "spine" then
			local modelId = info.model
			local config = ConfigReader:getRecordById("RoleModel", modelId)
			local animationResId = config.Model
			local spineName = tostring(animationResId) .. ".skel"

			if priority == 1 then
				MemCacheUtils:registSpineCache(spineName, "battle")

				if fileName then
					MemCacheUtils:asyncAddTexture(fileName, "battle")
				end
			else
				MemCacheUtils:asyncAddSpine(spineName, "battle")

				if fileName then
					MemCacheUtils:asyncAddTexture(fileName, "battle")
				end
			end
		elseif info.type == "plist" then
			local plistName = info.plist

			if priority == 0 then
				MemCacheUtils:addPlist(plistName, "battle")
			else
				MemCacheUtils:asyncAddPlist(plistName, "battle")
			end
		elseif info.type == "mclib" then
			local fileName = "asset/anim/" .. info.file

			cc.MCLibrary:getInstance():loadDefinitionsFromFile(fileName, 1)
		elseif info.type == "image" then
			local fileName = info.file

			if priority == 0 then
				MemCacheUtils:addTexture(fileName, "battle")
			else
				MemCacheUtils:asyncAddTexture(fileName, "battle")
			end
		elseif info.type == "mclibObj" then
			MemCacheUtils:addMovieClip(info.id, "battle")
		end
	end

	local function preloadAudio(audioId)
		local info = ConfigReader:requireRecordById("Sound", audioId)
		local audioIdList = {}
		local includem = info.IncludeMusic

		if includem and #includem > 0 then
			for __, id in pairs(includem) do
				audioIdList[#audioIdList + 1] = id
			end
		else
			audioIdList[#audioIdList + 1] = audioId
		end

		local fileUtils = cc.FileUtils:getInstance()

		for _, id in pairs(audioIdList) do
			local record = ConfigReader:getRecordById("Sound", id)

			if record and record.PkgName and record.PkgName ~= "" then
				local filePath = table.concat({
					"sound/",
					record.PkgName,
					".acb"
				}, "")

				if fileUtils:isFileExist(filePath) then
					MemCacheUtils:addAudio(record.PkgName, "battle")
				end
			end
		end
	end

	local loadFunc = (forceNoScene or GameConfigs.CloseBattleLoading) and false and function(dispatcher, injector, data, completeCallback)
		local taskBuilder = timesharding.TaskBuilder:new()
		local task = taskBuilder:buildSequencialTask(function()
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				delayCallByTime(0, function()
					task:finish()
				end)
			end))
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				cleanFunc()
				task:finish()
			end))
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				for priority, list in ipairs(resList) do
					for i, info in ipairs(list) do
						preloadPriorityRes(info, priority)
					end
				end

				MemCacheUtils:updateSpineCache("battle")
				task:finish()
			end))
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				for __, audioId in ipairs(audioList) do
					preloadAudio(audioId)
				end

				task:finish()
			end))
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				delayCallByTime(500, function()
					task:finish()
				end)
			end))
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				delayCallByTime(500, function()
					task:finish()
				end)
			end))
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				delayCallByTime(500, function()
					task:finish()
				end)
			end))
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				delayCallByTime(500, function()
					task:finish()
				end)
			end))
			ADD_TASK(1, timesharding.CustomTask:new(function(task)
				delayCallByTime(500, function()
					task:finish()
				end)
			end))
		end)
		local view = injector:getInstance("enterLoadingView")
		local widget = CommonLoadingWidget

		dispatcher:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			loadingId = data.loadingId,
			loadingType = data.loadingType,
			loadingTask = task,
			loadingWidget = injector:injectInto(widget:new(config)),
			onCompleted = function()
				completeCallback(dispatcher, injector, data, EVT_SWITCH_VIEW)
			end
		}))
	end or function(dispatcher, injector, data, completeCallback)
		cleanFunc()

		for priority, list in ipairs(resList) do
			for i, info in ipairs(list) do
				preloadPriorityRes(info, priority)
			end
		end

		MemCacheUtils:updateSpineCache("battle")
		completeCallback(dispatcher, injector, data)
	end

	local function enterFunc(dispatcher, injector, data, event)
		local gameContext = injector:getInstance("GameContext")
		local viewMap = gameContext:getViewMap()
		local mediatorMap = gameContext:getMediatorMap()
		local viewConfig = data and data.viewConfig

		if viewConfig and viewConfig.opPanelRes ~= nil then
			viewMap:mapViewToRes("battleUILayer", viewConfig.opPanelRes)
		else
			viewMap:mapViewToRes("battleUILayer", "asset/ui/battleUILayer.csb")
		end

		if viewConfig and viewConfig.opPanelClazz ~= nil then
			mediatorMap:mapView("battleUILayer", viewConfig.opPanelClazz)
		else
			mediatorMap:mapView("battleUILayer", "BattleUIMediator")
		end

		if not viewConfig.mainView then
			local mainView = "battlePlayer"

			dispatcher:dispatch(ViewEvent:new(event or EVT_PUSH_VIEW, injector:getInstance(mainView), nil, data))
		end
	end

	if GameConfigs and GameConfigs.battleSceneMode then
		dispatcher:dispatch(Event:new(EVT_RELEASE_VIEW_MEMORY))
	end

	loadFunc(dispatcher, injector, data, enterFunc)
end

function BattleLoader:popBattleView(dispatcher, data, viewName, viewData)
	local dispatcher = DmGame:getInstance()

	MemCacheUtils:clearHolder("battle")
	sp.SkeletonAnimationCache:getInstance():removeUnusedSkeletonDataExtends()
	cc.Director:getInstance():getTextureCache():enableAutoGC()
	display.removeUnusedSpriteFrames()

	local injector = dispatcher:getInjector()

	if viewName then
		local view = injector:getInstance(viewName)

		dispatcher:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, viewData))
	elseif data and data.viewName then
		dispatcher:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
			viewName = data.viewName,
			viewData = data
		}))
	else
		dispatcher:dispatch(ViewEvent:new(EVT_POP_VIEW, nil, nil, nil))
	end

	local gameContext = injector:getInstance("GameContext")
	local viewMap = gameContext:getViewMap()
	local mediatorMap = gameContext:getMediatorMap()

	viewMap:unmapView("battleUILayer")
	mediatorMap:unmapView("battleUILayer")
end

function BattleLoader:popGuideBattleView(dispatcher)
	MemCacheUtils:clearHolder("battle")
	sp.SkeletonAnimationCache:getInstance():removeUnusedSkeletonDataExtends()
	cc.Director:getInstance():getTextureCache():enableAutoGC()

	if dispatcher.dispatchEvent then
		dispatcher:dispatchEvent(ViewEvent:new(EVT_POP_VIEW, nil, nil, nil))
	else
		dispatcher:dispatch(ViewEvent:new(EVT_POP_VIEW, nil, nil, nil))
	end

	cc.Director:getInstance():getTextureCache():runTextureGC(1)
end

local function loadMclib(mclib)
	cc.MCLibrary:getInstance():loadDefinitionsFromFile("asset/anim/" .. mclib .. ".mclib", 1)
end

function BattleLoader:preloadBattleCache()
	MemCacheUtils:asyncAddTexture("asset/ui/battle_battleRes.png")
	MemCacheUtils:asyncAddTexture("asset/ui/battle_lang.png")
	MemCacheUtils:asyncAddTexture("asset/ui/battle_cell.png")
	MemCacheUtils:asyncAddTexture("asset/anim/battleanim_xinkaizhan.png")
	MemCacheUtils:addMovieClip("xkz_xinkaizhan")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_jinenganniu.png")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_jinenganniu2.png")
	loadMclib("jinenganniu")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_nlt.png")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_nltm.png")
	loadMclib("shuijingtiao")
	loadMclib("shuijingtiaoman")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_xitonganniu.png")
	loadMclib("xitonganniu")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_xuetiao.png")
	loadMclib("xuetiao")
	loadMclib("daojishi")
	loadMclib("shuzi")
	loadMclib("zhandoushuzi")
	loadMclib("ziyuandiaoluo")
	loadMclib("bufftexiao")
	loadMclib("buff")
	loadMclib("ziyuandiaoluo")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_ziyuandiaoluo.png")
	loadMclib("mannu")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_mannu.png")
	loadMclib("battle_xjnts")
	MemCacheUtils:asyncAddTexture("asset/anim/battle_ziyuandiaoluo.png")
end

function BattleLoader:preloadBattleDataConfig()
	return
end
