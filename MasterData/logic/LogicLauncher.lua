-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/LogicLauncher.lua

module("logic.LogicLauncher", package.seeall)
setglobal("isInEditorMode", Astral.OSDef.isEditor)

local M = class("LogicLauncher", LogicLauncherBase)

function M:initFramework()
	M.super.initFramework(self)
	KeycodeListener.instance:start()
end

function M:onManifestLoaded()
	M.super.onManifestLoaded(self)
	usingnow("logic.setting.ExtIds")
	NativeBridge.instance:setGameObject("AstralUnityStarter")
	InternationalLogicMgr.replaceLogic()
	self:buildAdditionalExtensions()
	CommonPreloader.instance:loadBasic(self._onLoadedBasic, self, self._onLoadedProgress)
	LanguageMgr.instance:init()
	CriwareUtil.InitVoiceLocalize()
	NetSecProtectMgr.instance:init()
end

function M:_onLoadedBasic()
	BootstrapLoadingView.instance:setAniCall(self._beginLogin, self)
	Astral.GameUpdateHelper.Instance:ClearListeners()

	if Astral.OSDef.RunOS == Astral.OSDef.Android and SDKManager.isZhSdk() then
		NotificationMgr.clearNotificationBar()
	end
end

function M:initViewMgr()
	ViewMgr.instance:init(ViewMgrSpacexImpl)
end

function M:_onLoadedProgress(loadedCount, totalCount)
	BootstrapLoadingView.instance:showLoadPercent(loadedCount, totalCount)
end

function M:_beginLogin()
	CriwareAudioFacade.instance:initCriware()
	TextUtils.SetTextSettings(CommonPreloader.instance:getAsset(CommonResPath.TextSettings))

	local floatItemPrefab = CommonPreloader.instance:getAsset(CommonResPath.FloatItem)

	FloatWordMgr.instance:init(floatItemPrefab)
	BattleTestUtil.init()
	PlayerLocalStorgeModel.instance:setMusic(true)
	PlayerLocalStorgeModel.instance:setSoundEff(true)

	local starterGO = goutil.find("AstralUnityStarter")

	goutil.addComponentOnce(starterGO, typeof(Astral.GameApplicationState))
	goutil.addComponentOnce(starterGO, typeof(SpaceX.CustomLightSetup))
	Astral.GameApplicationState.Instance:AddStateListener(self._onApplicationState, self)

	local ui3dCameraGO = goutil.find("UI3DCamera")

	if ui3dCameraGO then
		local camera = ui3dCameraGO:GetComponent(ComponentType.Camera)

		camera.enabled = false

		CameraUtils.setUI3DCamera(camera)
	end

	local offsetWidth = MainSettingModel.instance:getAdaptationOffsetWidth()

	AdaptationUtils.SetDefaultOffsetSize(offsetWidth)
	self:_onLoadedAdditional()

	if enableDebug then
		SRPBatcherProfiler.Get(starterGO)
	end

	self:_startClockMgr()
end

function M:_startClockMgr()
	ClockMgr.instance:addTask(ClockRegularCheckTask.New())
	ClockMgr.instance:addTask(ClockTimeOfDayCheckTask:createGameRefreshTask(5, 0, 0))
	ClockMgr.instance:start()
end

function M:_onLoadedAdditional()
	PhotoCacheMgr.instance:init()

	local photoCache = Astral.PhotoProducerCache.Instance

	photoCache:SetPhotoMaterial(CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.PhotoMat_Additive))
	photoCache:SetCullingLayer(Astral.LayerUtil.NameToLayer(SceneLayer.UI3D))

	local register = UsualEventRegister.Instance

	register:Init()
	register:SetFetchPhotoProducerListener(self._onFetchPhoto, self)
	ConstDefExtender.extend()
	ServerTimeExtend.extend()
	LoadingFacade.instance:init()
	MainPlayerInputFacade.instance:init()
	UIReflectionFacade.instance:init()

	SceneStateBgmAmb.instance = SceneStateBgmAmb.New()

	self:_startUIByScene()
	IconLoader.bindSpriteAtlas(IconType.Skinlib)
	StoryController.instance:preCreate()
	GainItemController.instance:preCreate()
	MemoryMgr.instance:init()
	Gfx.instance:init()
end

function M:_onApplicationState(state)
	if state == 1 then
		GlobalDispatcher:dispatchEvent(EventType.APPLICATION_PAUSE)
	elseif state == 2 then
		if isInEditorMode then
			Gfx.instance:init()
		end

		GlobalDispatcher:dispatchEvent(EventType.APPLICATION_QUIT)
	elseif state == 4 then
		GlobalDispatcher:dispatchEvent(EventType.APPLICATION_RESUME)
	end
end

function M:_startUIByScene()
	local curSceneName = SceneUtil.getActiveSceneName()

	if curSceneName == "Starter" then
		LoginFacade.instance:init()
		LoginFacade.instance:showLogin()
		ViewMgr.instance:openSpecialView(ViewName.MainHackViewPresentor)

		if MainUIModel.instance:getUIDetectVisible() then
			ViewMgr.instance:openSpecialView(ViewName.MainUIDetectView)
		end
	elseif curSceneName == "story_preview" then
		SceneFace.instance:onInit()
		ViewMgr.instance:open(ViewName.StoryPreviewDialogView)
	elseif curSceneName == "HouseEditor" then
		ViewMgr.instance:open(ViewName.HousePerformEditor)
	elseif curSceneName == "EchoEffectEditor" then
		local echoIdPath = Astral.FileUtils.DirectRootPath .. "../../EditorExportedFiles/Temp/echoId.txt"

		Astral.FileUtils.Instance:CheckDirExistsForFile(echoIdPath)

		local file = assert(io.open(echoIdPath, "r"))
		local echoId = file:read("*line")

		file:close()

		local info = {}

		if echoId then
			info.echoItemId = tonumber(echoId)
		else
			info.echoItemId = 1303002
		end

		local echoItemData = ItemUtil.createItemData({
			itemId = info.echoItemId
		})

		if not echoItemData then
			printError("残响id非法:", info.echoItemId)

			return
		end

		EchoItemMainController.instance:setSelectedEchoItem(echoItemData)

		local params = {
			echoTestView = true,
			index = EchoItemMainViewNew.SubViewType.Detail
		}

		ViewMgr.instance:open(ViewName.EchoItemMainViewNew, params)
	end

	SceneUtil.setBaseSceneName(curSceneName)
	settimer(0.5, function()
		BootstrapLauncher.instance:destroyFlow()
	end, self, false)
end

function M:_onFetchPhoto(width, height, rtFormat, antiAliasing)
	if isInEditorMode then
		PhotoCacheMgr.instance:checkPhotoCached(width, height, rtFormat, antiAliasing)
	end
end

M.instance = M.New()

M.instance:start()

return M
