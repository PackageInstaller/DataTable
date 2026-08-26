-- chunkname: @modules/setting/module_views_preloader.lua

local module_views_preloader = {}

function module_views_preloader.DungeonView(allResPath)
	table.insert(allResPath, "ui/spriteassets/dungeon.asset")
	table.insert(allResPath, "singlebg/dungeon/full/bg1.png")
end

function module_views_preloader.DungeonMapView(allResPath)
	DungeonModel.instance.jumpEpisodeId = nil
end

function module_views_preloader.VersionActivityDungeonMapView(allResPath)
	DungeonModel.instance.jumpEpisodeId = nil
end

function module_views_preloader.SeasonMainView(allResPath)
	return
end

function module_views_preloader.V3a8EchoSongGameView(allResPath)
	local path = V3a8EchoSongController.instance:getScenePath()

	table.insert(allResPath, path)
end

function module_views_preloader.VersionActivity2_8BossStoryEyeView(allResPath)
	local path = FightHelper.getCameraAniPath(VersionActivity2_8BossStoryEyeView.camerControllerPath)

	table.insert(allResPath, path)
end

function module_views_preloader.DungeonViewPreload(callback)
	local allResPath = {}

	table.insert(allResPath, "ui/viewres/dungeon/dungeonview.prefab")
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.VersionActivity2_8BossStoryEnterView(allResPath)
	local map = VersionActivity2_8BossStorySceneView.getMap()

	table.insert(allResPath, string.format("scenes/%s.prefab", map.res))
end

function module_views_preloader.VersionActivity2_8BossActEnterView(allResPath)
	local map = VersionActivity2_8BossActSceneView.getMap()

	table.insert(allResPath, string.format("scenes/%s.prefab", map.res))
end

function module_views_preloader.WeekWalkLayerViewPreload(callback)
	local allResPath = module_views_preloader._getResPathList(ViewName.WeekWalkLayerView)
	local info = WeekWalkModel.instance:getInfo()
	local map, index = info:getNotFinishedMap()

	if map.id <= 105 then
		table.insert(allResPath, ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_1"))
	elseif map.id <= 205 then
		table.insert(allResPath, ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_2"))
	else
		table.insert(allResPath, ResUrl.getWeekWalkLayerIcon("full/bg_choose_deep"))
	end

	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.WeekWalk_2HeartLayerViewPreload(callback)
	local allResPath = module_views_preloader._getResPathList(ViewName.WeekWalk_2HeartLayerView)

	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.CommandStationTaskView(allResPath)
	local list = module_views_preloader._getResPathList(ViewName.CommandStationPaperView)

	tabletool.addValues(allResPath, list)
end

function module_views_preloader.CommandStationMapDisplayView(allResPath)
	local param = CommandStationController.instance:getMapDisplayViewParam()
	local scenePath = CommandStationMapDisplayView.getScenePath(param)

	if not scenePath then
		return
	end

	table.insert(allResPath, scenePath)
end

function module_views_preloader.StoreViewPreload(callback)
	local allResPath = {}

	table.insert(allResPath, module_views.StoreView.mainRes)
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.TaskView(allResPath)
	for _, v in pairs(module_views.TaskView.tabRes[2]) do
		table.insert(allResPath, v[1])
	end
end

function module_views_preloader.DungeonViewGold(callback)
	local allResPath = {}

	table.insert(allResPath, "singlebg/dungeon/full/bg123.png")
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.DungeonViewBreak(callback)
	local allResPath = {}

	table.insert(allResPath, "singlebg/dungeon/full/bg123.png")
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.DungeonViewWeekWalk(callback)
	local allResPath = {}

	table.insert(allResPath, "ui/viewres/dungeon/dungeonweekwalkview.prefab")
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.DungeonViewExplore(callback)
	local allResPath = {}

	table.insert(allResPath, DungeonEnum.dungeonexploreviewPath)
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.ExploreArchivesView(allResPath)
	local container = ViewMgr.instance:getContainer(ViewName.ExploreArchivesView)

	table.insert(allResPath, string.format("ui/viewres/explore/explorearchivechapter%d.prefab", (container and container.viewParam or nil) and container.viewParam.id))
end

function module_views_preloader.preloadMultiView(callback, callbackTarget, viewList, prefabList)
	local allResPath = {}

	for i, v in ipairs(viewList) do
		local resPathList = module_views_preloader._getResPathList(v)

		for _, resPath in ipairs(resPathList) do
			table.insert(allResPath, resPath)
		end
	end

	if prefabList then
		for _, resPath in ipairs(prefabList) do
			table.insert(allResPath, resPath)
		end
	end

	module_views_preloader._startLoad(allResPath, callback, callbackTarget)
end

function module_views_preloader.DungeonChapterAndLevelView(callback, chapterId, levelViewName)
	local allResPath = {}
	local chapterViewResPathList = module_views_preloader._getResPathList(ViewName.DungeonMapView)

	for _, resPath in ipairs(chapterViewResPathList) do
		table.insert(allResPath, resPath)
	end

	if levelViewName then
		local levelViewResPathList = module_views_preloader._getResPathList(levelViewName)

		for _, resPath in ipairs(levelViewResPathList) do
			table.insert(allResPath, resPath)
		end
	end

	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.CharacterDataVoiceView(callback)
	local allResPath = {}

	table.insert(allResPath, ResUrl.getCharacterDataIcon("full/bg_di_004.png"))
	table.insert(allResPath, "ui/viewres/character/characterdata/characterdatavoiceview.prefab")
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.CharacterDataItemView(callback)
	local allResPath = {}

	table.insert(allResPath, ResUrl.getCharacterDataIcon("full/bg_tingyongdi_006.png"))
	table.insert(allResPath, "ui/viewres/character/characterdata/characterdataitemview.prefab")
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.CharacterDataCultureView(callback)
	local allResPath = {}

	table.insert(allResPath, ResUrl.getCharacterDataIcon("full/bg_di_004.png"))
	table.insert(allResPath, "ui/viewres/character/characterdata/characterdatacultureview.prefab")
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.CharacterBackpackView(allResPath)
	table.insert(allResPath, "ui/viewres/common/item/commonheroitemnew.prefab")
end

function module_views_preloader.FightLoadingView(callback)
	local allResPath = {}

	table.insert(allResPath, "ui/viewres/fight/fightloadingview.prefab")
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.BpViewPreLoad(callback)
	local allResPath = {}

	if BpModel.instance.firstShow then
		table.insert(allResPath, "ui/viewres/battlepass/bpvideoview.prefab")
	end

	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.BpView(allResPath)
	local bpCo = BpConfig.instance:getBpCO(BpModel.instance.id)

	if bpCo and bpCo.isSp then
		local viewSetting = ViewMgr.instance:getSetting(ViewName.BpSPView)

		if viewSetting then
			if viewSetting.mainRes then
				table.insert(allResPath, viewSetting.mainRes)
			end

			if viewSetting.otherRes then
				for k, v in pairs(viewSetting.otherRes) do
					table.insert(allResPath, v)
				end
			end
		end
	end
end

function module_views_preloader.BpSPView(allResPath)
	local viewSetting = ViewMgr.instance:getSetting(ViewName.BpView)

	if viewSetting then
		if viewSetting.mainRes then
			table.insert(allResPath, viewSetting.mainRes)
		end

		if viewSetting.otherRes then
			for k, v in pairs(viewSetting.otherRes) do
				table.insert(allResPath, v)
			end
		end
	end
end

function module_views_preloader.SummonADView(allResPath)
	local resAppendList = SummonMainController.instance:getCurPoolPreloadRes()

	if #resAppendList > 0 then
		for _, resPath in ipairs(resAppendList) do
			table.insert(allResPath, resPath)
		end
	end
end

function module_views_preloader.EliminateLevelView(allResPath)
	local resAppendList = EliminateLevelController.instance:getCurLevelNeedPreloadRes()

	if #resAppendList > 0 then
		for _, resPath in ipairs(resAppendList) do
			table.insert(allResPath, resPath)
		end
	end
end

function module_views_preloader.V1a4_BossRushLevelDetail(allResPath)
	local container = ViewMgr.instance:getContainer(ViewName.V1a4_BossRushLevelDetail)
	local viewParam = container and container.viewParam

	if not viewParam then
		return
	end

	local stage = viewParam.stage
	local resPathList = BossRushConfig.instance:getMonsterResPathList(stage)

	for _, v in ipairs(resPathList) do
		table.insert(allResPath, v)
	end

	table.insert(allResPath, BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(stage))
end

function module_views_preloader.V3a2_BossRush_LevelDetailView(allResPath)
	local container = ViewMgr.instance:getContainer(ViewName.V3a2_BossRush_LevelDetailView)
	local viewParam = container and container.viewParam

	if not viewParam then
		return
	end

	local stage = viewParam.stage
	local resPathList = BossRushConfig.instance:getMonsterResPathList(stage)

	for _, v in ipairs(resPathList) do
		table.insert(allResPath, v)
	end

	table.insert(allResPath, BossRushConfig.instance:getBossDetailFullPath(stage))
end

function module_views_preloader.V3a9_BossRush_LevelDetailView(allResPath)
	local container = ViewMgr.instance:getContainer(ViewName.V3a9_BossRush_LevelDetailView)
	local viewParam = container and container.viewParam

	if not viewParam then
		return
	end

	local stage = viewParam.stage
	local actId = viewParam.actId
	local resPathList = BossRushConfig.instance:getMonsterResPathList(stage, actId)

	for _, v in ipairs(resPathList) do
		table.insert(allResPath, v)
	end

	table.insert(allResPath, BossRushConfig.instance:getBossDetailFullPath(stage, actId))
end

function module_views_preloader.VersionActivity2_7DungeonMapView(allResPath)
	local spaceScenePath = VersionActivity2_7DungeonEnum.SpaceScene

	table.insert(allResPath, spaceScenePath)
end

function module_views_preloader.OptionalChargeView(callback)
	local allResPath = {
		"ui/viewres/store/optionalgiftview.prefab"
	}

	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.CommandStationMapView(allResPath)
	return
end

function module_views_preloader.CommandStationMapViewPreload(callback)
	CommandStationMapModel.instance:initTimeId()

	local sceneConfig = CommandStationMapModel.instance:getCurTimeIdScene()

	if not sceneConfig then
		return
	end

	local allResPath = module_views_preloader._getResPathList(ViewName.CommandStationMapView)

	table.insert(allResPath, sceneConfig.scene)
	module_views_preloader._startLoad(allResPath, callback)
end

function module_views_preloader.Season166MainView(allResPath)
	local actId = Season166Model.instance:getCurSeasonId()
	local sceneUrl = Season166Config.instance:getSeasonConstStr(actId, Season166Enum.MainSceneUrl)

	if sceneUrl then
		table.insert(allResPath, sceneUrl)
	end
end

function module_views_preloader.V2a3_WarmUp(allResPath)
	local c = ViewMgr.instance:getContainer(ViewName.V2a3_WarmUp)

	if not c then
		return
	end

	local n = c:getEpisodeCount()

	for i = 1, n do
		local resUrl = c:getImgResUrl(i)

		table.insert(allResPath, resUrl)
	end
end

function module_views_preloader.MainUISwitchInfoBlurMaskView()
	local allResPath = {}

	table.insert(allResPath, "ui/viewres/mainsceneswitch/mainuiswitchblurmaskview.prefab")
end

function module_views_preloader.MainUISwitchInfoView()
	local allResPath = {}

	table.insert(allResPath, "ui/viewres/mainsceneswitch/mainsuiswitchinfoview.prefab")
	table.insert(allResPath, "ui/viewres/mainsceneswitch/mainuiswitchblurmask.prefab")
	table.insert(allResPath, "ui/viewres/main/mainview.prefab")
end

local loaderDict = {}

function module_views_preloader._startLoad(allResPath, callback, callbackTarget)
	local loader = MultiAbLoader.New()

	loaderDict[loader] = true

	UIBlockMgr.instance:startBlock("ui_preload")
	loader:setPathList(allResPath)
	loader:startLoad(function()
		loaderDict[loader] = nil

		UIBlockMgr.instance:endBlock("ui_preload")
		loader:dispose()
		callback(callbackTarget)
	end)
end

function module_views_preloader.stopPreload()
	for loader, _ in pairs(loaderDict) do
		loader:dispose()
		logNormal("module_views_preloader dispose loader")
	end

	loaderDict = {}
end

function module_views_preloader._getResPathList(viewName)
	local resPathList = {}
	local viewSetting = ViewMgr.instance:getSetting(viewName)

	if viewSetting.mainRes then
		table.insert(resPathList, viewSetting.mainRes)
	end

	if viewSetting.otherRes then
		for _, resPath in pairs(viewSetting.otherRes) do
			table.insert(resPathList, resPath)
		end
	end

	if viewSetting.tabRes then
		for _, tabSetting in pairs(viewSetting.tabRes) do
			for _, tabResList in pairs(tabSetting) do
				for _, resPath in pairs(tabResList) do
					table.insert(resPathList, resPath)
				end
			end
		end
	end

	if viewSetting.anim and viewSetting.anim ~= ViewAnim.Default and string.find(viewSetting.anim, ".controller") then
		table.insert(resPathList, viewSetting.anim)
	end

	return resPathList
end

return module_views_preloader
