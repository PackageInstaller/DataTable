-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/UrlEntry.lua

local function UpdateTable(dest, src)
	if src == nil then
		return dest
	end

	if dest == nil then
		dest = {}
	end

	for k, v in pairs(src) do
		dest[k] = v
	end

	return dest
end

UrlEntry = class("UrlEntry", objectlua.Object, _M)
_SceneName = {}
_SceneName.mainScene = "mainUIScene"
_SceneName.battleScene = "battleScene"
_SceneName.crossDefense = "crossdefenseScene"
_SceneType = {}
_SceneType.push = "push"
_SceneType.switch = "switch"
_SceneType.popup = "popup"

function UrlEntry:initialize()
	super.initialize(self)
end

function UrlEntry:checkEnabled(context, params)
	return true
end

function UrlEntry:newEvent(urlParams, extraData)
	assert(false, "override me")
end

ViewAreaEntry = class("ViewAreaEntry", UrlEntry, _M)

function ViewAreaEntry:initialize(viewName, data)
	super.initialize(self)

	self.viewName = viewName
	self._need_run_at_scene = nil
	self._path = nil
	self.data = data
end

local kExtResponseMap = {
	shopView = {
		instanceName = "ShopSystem",
		entry = ViewAreaEntry:new("shopView")
	},
	BagView = {
		instanceName = "BagSystem",
		entry = ViewAreaEntry:new("BagView")
	},
	arenaView = {
		switch = "fn_arena_normal",
		instanceName = "ArenaSystem",
		entry = ViewAreaEntry:new("ArenaNewView")
	},
	ClubView = {
		switch = "fn_guild",
		instanceName = "ClubSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("ClubView")
	},
	FriendMainView = {
		instanceName = "FriendSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("FriendMainView")
	},
	relationInfo = {
		targetInstance = "HeroSystem",
		instanceName = "DevelopSystem",
		funcName = "requestHeroRelation",
		entry = ViewAreaEntry:new("relationInfo")
	},
	HeroShowMainView = {
		funcCheck = "checkEnabledMain",
		instanceName = "DevelopSystem",
		funcName = "tryEnterShowMain",
		targetInstance = "HeroSystem",
		entry = ViewAreaEntry:new("HeroShowMainView")
	},
	MasterMainView = {
		targetInstance = "MasterSystem",
		instanceName = "DevelopSystem",
		entry = ViewAreaEntry:new("MasterMainView")
	},
	HeroStrengthLevelView = {
		funcCheck = "checkEnabledLevel",
		instanceName = "DevelopSystem",
		funcName = "tryEnterLevel",
		targetInstance = "HeroSystem",
		entry = ViewAreaEntry:new("HeroStrengthLevelView")
	},
	HeroStrengthQualityView = {
		funcCheck = "checkEnabledQuality",
		instanceName = "DevelopSystem",
		funcName = "tryEnterQuality",
		targetInstance = "HeroSystem",
		entry = ViewAreaEntry:new("HeroStrengthQualityView")
	},
	equipMainView = {
		targetInstance = "EquipSystem",
		instanceName = "DevelopSystem",
		entry = ViewAreaEntry:new("equipMainView")
	},
	ActivityView = {
		instanceName = "ActivitySystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("ActivityView")
	},
	CarnivalView = {
		funcName = "tryEnterCarnival",
		instanceName = "ActivitySystem",
		funcCheck = "checkCarnival",
		entry = ViewAreaEntry:new("CarnivalView")
	},
	ActivityBlockView = {
		funcName = "complexActivityTryEnter",
		instanceName = "ActivitySystem",
		funcCheck = "checkComplexActivity",
		entry = ViewAreaEntry:new("ActivityBlockView")
	},
	ActivityBlockSupportView = {
		funcName = "complexActivityTryEnter",
		instanceName = "ActivitySystem",
		funcCheck = "checkComplexActivity",
		entry = ViewAreaEntry:new("ActivityBlockSupportView")
	},
	ActivityBlockHalloweenView = {
		funcName = "complexActivityTryEnter",
		instanceName = "ActivitySystem",
		funcCheck = "checkComplexActivity",
		entry = ViewAreaEntry:new("ActivityBlockHalloweenView")
	},
	ActivityBlockMonsterShopView = {
		funcName = "tryEnterBlockMonsterShopView",
		instanceName = "ActivitySystem",
		funcCheck = "checkComplexActivity",
		entry = ViewAreaEntry:new("ActivityBlockMonsterShopView")
	},
	ActivityBlockSummerView = {
		funcName = "complexActivityTryEnter",
		instanceName = "ActivitySystem",
		funcCheck = "checkComplexActivity",
		entry = ViewAreaEntry:new("ActivityBlockSummerView")
	},
	ExploreView = {
		switch = "fn_train_explore",
		instanceName = "ExploreSystem",
		entry = ViewAreaEntry:new("ExploreView")
	},
	GalleryMainView = {
		instanceName = "GallerySystem",
		entry = ViewAreaEntry:new("GalleryMainView")
	},
	GalleryBookView = {
		instanceName = "GallerySystem",
		entry = ViewAreaEntry:new("GalleryBookView")
	},
	RecruitView = {
		instanceName = "RecruitSystem",
		entry = ViewAreaEntry:new("RecruitView")
	},
	PetRaceView = {
		switch = "fn_arena_pet_race",
		instanceName = "PetRaceSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("PetRaceView")
	},
	TaskView = {
		instanceName = "TaskSystem",
		entry = ViewAreaEntry:new("TaskView")
	},
	StagePracticeEnterView = {
		switch = "fn_train_practice",
		instanceName = "StagePracticeSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("StagePracticeEnterView")
	},
	SpStageMainView = {
		switch = "fn_train_stage",
		instanceName = "SpStageSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("SpStageMainView")
	},
	SpStageMainViewWithTimes = {
		funcName = "tryEnter",
		instanceName = "SpStageSystem",
		funcCheck = "checkEnabledWithTimes",
		entry = ViewAreaEntry:new("SpStageMainViewWithTimes")
	},
	CommonStageMainView = {
		instanceName = "StageSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("CommonStageMainView")
	},
	CommonStageChapterView = {
		funcName = "enterChapterViewAndPoint",
		instanceName = "StageSystem",
		funcCheck = "checkChapterViewAndPointEnable",
		entry = ViewAreaEntry:new("CommonStageChapterView")
	},
	MazeEventMainView = {
		instanceName = "MazeSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("MazeEventMainView")
	},
	chatMainView = {
		instanceName = "ChatSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("chatMainView")
	},
	HeroStoryEnterView = {
		funcName = "tryEnterHeroStory",
		instanceName = "StageSystem",
		funcCheck = "checkHeroStoryEnable",
		entry = ViewAreaEntry:new("HeroStoryEnterView")
	},
	BuildingView = {
		instanceName = "BuildingSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("BuildingView")
	},
	BuildingBuyDecorateView = {
		instanceName = "BuildingSystem",
		funcName = "tryEnterBuyDecorate",
		entry = ViewAreaEntry:new("BuildingBuyDecorateView")
	},
	BuildingOverviewView = {
		instanceName = "BuildingSystem",
		funcName = "tryEnterOverview",
		entry = ViewAreaEntry:new("BuildingOverviewView")
	},
	CrusadeView = {
		switch = "fn_train_crusade",
		instanceName = "CrusadeSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("CrusadeView")
	},
	TowerView = {
		switch = "fn_train_tower",
		instanceName = "TowerSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("TowerView")
	},
	NewCurrencyBuyView = {
		instanceName = "CurrencySystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("NewCurrencyBuyView")
	},
	BuildingGetResView = {
		funcCheck = "checkGetExpEnable",
		instanceName = "BuildingSystem",
		funcName = "tryEnterGetResView",
		entry = ViewAreaEntry:new("BuildingGetResView")
	},
	ActivityBlockHolidayView = {
		funcName = "complexActivityTryEnter",
		instanceName = "ActivitySystem",
		funcCheck = "checkComplexActivity",
		entry = ViewAreaEntry:new("ActivityBlockHolidayView")
	},
	ActivityBlockMusicView = {
		funcName = "complexActivityTryEnter",
		instanceName = "ActivitySystem",
		funcCheck = "checkComplexActivity",
		entry = ViewAreaEntry:new("ActivityBlockMusicView")
	},
	RTPKMainView = {
		switch = "fn_arena_rtpk",
		instanceName = "RTPKSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("RTPKMainView")
	},
	LeadStageArenaMainView = {
		switch = "fn_arena_leadStage",
		instanceName = "LeadStageArenaSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("LeadStageArenaMainView")
	},
	ShopCoopExchangeView = {
		instanceName = "ActivitySystem",
		funcName = "tryEnterCoopExchangeView",
		entry = ViewAreaEntry:new("ShopCoopExchangeView")
	},
	PassMainView = {
		switch = "fn_pass",
		instanceName = "PassSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("PassMainView")
	},
	ActivityListiew = {
		instanceName = "ActivitySystem",
		funcName = "tryEnterActivityCalendar",
		entry = ViewAreaEntry:new("ActivityListiew")
	},
	DartsView = {
		switch = "fn_MiniGame_Darts",
		instanceName = "MiniGameSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("DartsView")
	},
	CooperateBossMainView = {
		switch = "fn_arena_cooperate_boss",
		instanceName = "CooperateBossSystem",
		funcName = "enterCooperateBoss",
		entry = ViewAreaEntry:new("CooperateBossMainView")
	},
	RecruitNewDrawCardView = {
		instanceName = "RecruitSystem",
		funcName = "tryEnterActivityRecruit",
		entry = ViewAreaEntry:new("RecruitNewDrawCardView")
	},
	RecruitNewTSDrawCardView = {
		instanceName = "RecruitSystem",
		funcName = "tryEnterActivityRecruitTS",
		entry = ViewAreaEntry:new("RecruitNewTSDrawCardView")
	},
	ActivityTaskView = {
		funcName = "complexActivityTaskTryEnter",
		instanceName = "ActivitySystem",
		funcCheck = "checkComplexActivity",
		entry = ViewAreaEntry:new("ActivityTaskView")
	},
	DreamHouseMainView = {
		switch = "fn_train_dreamhouse",
		instanceName = "DreamHouseSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("DreamHouseMainView")
	},
	ActivityMailView = {
		instanceName = "ActivitySystem",
		funcName = "tryEnterActivityMailView",
		entry = ViewAreaEntry:new("ActivityMailView")
	},
	ActivityTrialRoadView = {
		instanceName = "ActivitySystem",
		funcName = "tryEnterTrialRoadMainView",
		entry = ViewAreaEntry:new("ActivityTrialRoadView")
	},
	JumpView = {
		switch = "fn_MiniGame_Jump",
		instanceName = "MiniGameSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("JumpView")
	},
	FlyView = {
		switch = "fn_MiniGame_Plane",
		instanceName = "MiniGameSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("FlyView")
	},
	ArenaNewView = {
		instanceName = "ArenaNewSystem",
		funcName = "tryEnter",
		entry = ViewAreaEntry:new("ArenaNewView")
	},
	ActivityBentoView = {
		instanceName = "ActivitySystem",
		funcName = "tryEnterBentoView",
		entry = ViewAreaEntry:new("ActivityBentoView")
	},
	ActivityWorldBossView = {
		instanceName = "ActivitySystem",
		funcName = "enterWorldBossView",
		entry = ViewAreaEntry:new("ActivityWorldBossView")
	},
	EggView = {
		instanceName = "ActivitySystem",
		funcName = "enterEasterEgg",
		entry = ViewAreaEntry:new("EggView")
	}
}

function ViewAreaEntry:response(context, params)
	local data = self.data ~= nil and table.deepcopy(self.data) or nil

	if params ~= nil and next(params) ~= nil then
		data = UpdateTable(data, params)
	end

	if self._need_run_at_scene ~= nil then
		if self.__need_run_at_scene ~= context:getInjector():getInstance("currentSceneMediator"):getViewName() then
			if data == nil then
				data = {}
			end

			data.params = params
			data.sceneName = self._need_run_at_scene
			data.viewName = self.viewName
			data.viewType = params.viewType

			local sceneEvent = SceneEvent:new(EVT_SWITCH_SCENE, data)

			context:dispatch(sceneEvent)
		end
	elseif kExtResponseMap[self.viewName] then
		local config = kExtResponseMap[self.viewName]

		if config then
			if config.switch and not CommonUtils.GetSwitch(config.switch) then
				context:dispatch(ShowTipEvent({
					tip = Strings:get("HEROS_UI14")
				}))

				return
			end

			local instance = context:getInjector():getInstance(config.instanceName)

			if not config.funcName then
				if instance and config.funcName then
					if config.targetInstance then
						local name = "get" .. config.targetInstance

						instance = instance[name](instance)
					end

					instance[config.funcName](instance, data)
				end
			end
		end
	else
		local view = context:getInjector():getInstance(self.viewName)

		if params.viewType ~= nil then
			local viewEvent

			if params.viewType == "switch" then
				viewEvent = ViewEvent:new(EVT_SWITCH_VIEW, view, nil, data)

				if self.viewName == "homeView" then
					viewEvent = Event:new(EVT_POP_TO_TARGETVIEW, {
						viewName = "homeView",
						viewData = data
					})
				end
			elseif params.viewType == "push" then
				viewEvent = ViewEvent:new(EVT_PUSH_VIEW, view, nil, data)
			elseif params.viewType == "popup" then
				viewEvent = ViewEvent:new(EVT_SHOW_POPUP, view, nil, data)
			end

			if viewEvent then
				context:dispatch(viewEvent)
			end
		end
	end
end

local URLMappingEntries

local function getURLMappingEntries()
	if URLMappingEntries ~= nil then
		return URLMappingEntries
	end

	local t = {}

	t["view://HeroShowListView"] = ViewAreaEntry:new("HeroShowListView")
	t["view://buyCurrencyView"] = ViewAreaEntry:new("CurrencyBuyPopView")
	t["view://newBuyCurrencyView"] = ViewAreaEntry:new("NewCurrencyBuyPopView")
	t["view://homeView"] = ViewAreaEntry:new("homeView")
	URLMappingEntries = t

	return URLMappingEntries
end

UrlEntryManage = {}

function UrlEntryManage.processNextParam(params, paramString)
	local p = "^[%?&]([^=]+)=([^&]+)"
	local mr = {
		string.find(paramString, p)
	}

	if #mr < 2 then
		return nil
	end

	local key = mr[3]
	local value = mr[4]

	if string.find(value, "^%d+$") ~= nil or string.find(value, "^%d+%.%d+$") ~= nil then
		value = tonumber(value)
	end

	params[key] = value

	if mr[2] >= #paramString then
		return nil
	else
		return string.sub(paramString, mr[2] + 1)
	end
end

function UrlEntryManage.resolveUrlWithUserData(urlString)
	if not urlString then
		return nil
	end

	if type(urlString) == "table" and urlString.param then
		urlString = urlString.param
	end

	local pattern = "^(view://([%w_-%./]+))(.*)$"

	urlString = string.gsub(urlString, "^%s*(.-)%s*$", "%1")

	local matchResult = {
		string.find(urlString, pattern)
	}

	if #matchResult < 2 then
		return nil
	end

	local page = matchResult[3]
	local mapping = getURLMappingEntries()
	local entry = mapping[page]

	if not entry then
		print(page)

		local viewName = string.gsub(page, "view://", "")

		entry = kExtResponseMap[viewName].entry
	end

	assert(entry, string.format(" URL %s not found", page))

	local urlParams = {}
	local paramString = matchResult[5]

	while paramString ~= nil do
		paramString = UrlEntryManage.processNextParam(urlParams, paramString)
	end

	return entry, urlParams
end

function UrlEntryManage.checkEnabledWithUserData(urlString)
	if urlString == nil then
		return nil
	end

	local pattern = "^(view://([%w_-%./]+))(.*)$"

	urlString = string.gsub(urlString, "^%s*(.-)%s*$", "%1")

	local matchResult = {
		string.find(urlString, pattern)
	}

	if #matchResult < 2 then
		return nil
	end

	local page = matchResult[3]
	local urlParams = {}
	local paramString = matchResult[5]

	while paramString ~= nil do
		paramString = UrlEntryManage.processNextParam(urlParams, paramString)
	end

	local viewName = string.gsub(page, "view://", "")
	local config = kExtResponseMap[viewName]

	if config then
		local instance = DmGame:getInstance()._injector:getInstance(config.instanceName)

		if instance then
			if config.targetInstance then
				local name = "get" .. config.targetInstance

				instance = instance[name](instance)
			end

			if not config.funcCheck then
				local funcCheck = "checkEnabled"

				if instance[funcCheck] then
					local unlock, tip = instance[funcCheck](instance, urlParams)

					if not unlock then
						return false, tip
					end
				end
			end
		end
	end

	return true
end

function UrlEntryManage.checkLeftTimesWithUserData(urlString)
	if urlString == nil then
		return nil
	end

	local pattern = "^(view://([%w_-%./]+))(.*)$"

	urlString = string.gsub(urlString, "^%s*(.-)%s*$", "%1")

	local matchResult = {
		string.find(urlString, pattern)
	}

	if #matchResult < 2 then
		return nil
	end

	local page = matchResult[3]
	local urlParams = {}
	local paramString = matchResult[5]

	while paramString ~= nil do
		paramString = UrlEntryManage.processNextParam(urlParams, paramString)
	end

	local viewName = string.gsub(page, "view://", "")
	local config = kExtResponseMap[viewName]

	if config then
		local instance = DmGame:getInstance()._injector:getInstance(config.instanceName)

		if instance then
			if config.targetInstance then
				local name = "get" .. config.targetInstance

				instance = instance[name](instance)
			end

			if not config.funcCheckleftTime then
				local funcCheck = "checkLeftCount"

				if instance[funcCheck] then
					local leftCount, tip = instance[funcCheck](instance, urlParams)

					return leftCount, tip
				end
			end
		end
	end

	return nil, viewName
end
