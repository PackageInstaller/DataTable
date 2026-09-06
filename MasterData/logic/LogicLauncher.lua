-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/LogicLauncher.lua

module("logic.LogicLauncher", package.seeall)

local LogicLauncher = class("LogicLauncher", LogicLauncherBase)
local VERSION_ANDROID_20240709 = 810
local VERSION_IOS_20240709 = 810

function LogicLauncher:ctor()
	LogicLauncher.super.ctor(self)

	self._isAdditionalLoaded = false
end

function LogicLauncher:start()
	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if not Framework.OSDef.isEditor and Framework.OSDef.RunOS == Framework.OSDef.Android and (versionCode == 220 or versionCode == 221) then
		local versionFile = Framework.FileUtils.LocalResRootPath .. "version"

		Framework.FileUtils.Instance:DeleteFile(versionFile)
		Framework.FileUtils.Instance:DeleteFile("file://" .. versionFile)
	end

	if rescache.isLuaBundle then
		self:loadLuaBundles()
	else
		self:_restart()
	end
end

function LogicLauncher:_restart()
	forcePrint(LogTag.BOOTSTRAP, "LogicLauncher _restart")
	usingnow("logic.setting.modulepath_logic")()
	PreLogicInitializer.instance:init()
	usingnow("logic.setting.import_logic")()
	LogicLauncher.super.start(self)
	HardwareQuality.initAndRestoreByUserSettings()
	NativeBridge.instance:registerListener("key_sdk_screen_changed", function(result)
		self:_onScreenChanged(result)
	end)

	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode > GameEnum.VERSION_ANDROID_20240513 or Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode > GameEnum.VERSION_IOS_20240513 or Framework.OSDef.isEditor then
		UnityEngine.Application.backgroundLoadingPriority = UnityEngine.ThreadPriority.High
		UnityEngine.QualitySettings.asyncUploadBufferSize = 16
		UnityEngine.QualitySettings.asyncUploadTimeSlice = 20
	end

	function trycall_51(func, ...)
		local a, b, c, d, e, f, g, h, i, j = ...
		local len = select("#", ...)

		if len > 0 then
			return xpcall(function()
				if len == 1 then
					return func(a)
				elseif len == 2 then
					return func(a, b)
				elseif len == 3 then
					return func(a, b, c)
				elseif len == 4 then
					return func(a, b, c, d)
				elseif len == 5 then
					return func(a, b, c, d, e)
				elseif len == 6 then
					return func(a, b, c, d, e, f)
				elseif len == 7 then
					return func(a, b, c, d, e, f, g)
				elseif len == 8 then
					return func(a, b, c, d, e, f, g, h)
				elseif len == 9 then
					return func(a, b, c, d, e, f, g, h, i)
				elseif len == 10 then
					return func(a, b, c, d, e, f, g, h, i, j)
				else
					printError(">>>>>>>>>>>>>>>>>>>>>>>>错误调用：参数超10个！！")
				end
			end, __G__TRACKBACK__)
		else
			return xpcall(func, __G__TRACKBACK__)
		end
	end

	function trycall_dir(func, ...)
		return xpcall(func, __G__TRACKBACK__, ...)
	end

	function tryChangeXPCall(param)
		if param ~= nil then
			setglobal("trycall", trycall_dir)
		else
			setglobal("trycall", trycall_51)
		end
	end

	trycall_dir(tryChangeXPCall, 1)
end

local canUse64Path = Framework.OSDef.RunOS == Framework.OSDef.Android and checknumber(BootstrapUtil.getGameVersionCode()) >= 210

if canUse64Path then
	if Framework.OSDef.is64Cpu then
		local var_0_0 = Framework.FileUtils.LuaBundleRootDir_64

		if not Framework.FileUtils.LuaBundleRootDir_64 then
			var_0_0 = Framework.FileUtils.LuaBundleRootDir_32

			if not Framework.FileUtils.LuaBundleRootDir_32 then
				local forCpuDir = Framework.FileUtils.LuaBundleRootDir

				function LogicLauncher:loadLuaBundles()
					forcePrint(LogTag.BOOTSTRAP, "LogicLauncher loadLuaBundles", tostring(canUse64Path), forCpuDir)

					self._luaBundles = {
						forCpuDir .. "/logicconfig",
						forCpuDir .. "/logiccommon",
						forCpuDir .. "/logicscene",
						forCpuDir .. "/logicstarter"
					}
					self._luaBundlesCount = #self._luaBundles
					self._luaBundlesLoaded = 0
					self._luaBundlesSucc = 0

					for i = 1, self._luaBundlesCount do
						getres(self._luaBundles[i], self._onLuaBundleLoaded, self, nil, true)
					end
				end

				function LogicLauncher:_onLuaBundleLoaded(res)
					printInfo(LogTag.BOOTSTRAP, "LogicLauncher _onLuaBundleLoaded", res.ResPath, res.IsSuccess)

					if res.IsSuccess then
						self._luaBundlesSucc = self._luaBundlesSucc + 1

						local abName = string.sub(res.ResPath, string.len(forCpuDir .. "/") + 1)

						res:Retain()
						rescache:AddLuaBundle(abName, res.assetBundle)
						res:Retain()
					end

					self._luaBundlesLoaded = self._luaBundlesLoaded + 1

					if self._luaBundlesLoaded >= self._luaBundlesCount and self._luaBundlesSucc == self._luaBundlesLoaded then
						forcePrint(LogTag.BOOTSTRAP, "游戏业务lua的ab已经加载完毕，开始启动游戏业务(LogicLauncher 启动模块外加载lua ab)")
						self:_restart()
					end
				end

				function LogicLauncher:loadMainManifest()
					forcePrint(LogTag.BOOTSTRAP, "LogicLauncherBase loadMainManifest")

					local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

					if Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode >= VERSION_ANDROID_20240709 or Framework.OSDef.RunOS == Framework.OSDef.IOS and versionCode >= VERSION_IOS_20240709 or Framework.OSDef.isEditor then
						BootstrapLoadingView.startLoadingProgress("初始化中:%d%%")
						forcePrint(LogTag.BOOTSTRAP, "LoadMainManifestWithBin")
						rescache:LoadMainManifestWithBin("main_manifest", self.onManifestLoaded, self)
					else
						BootstrapLoadingView.startLoadingProgress("资源解析:%d%%")
						forcePrint(LogTag.BOOTSTRAP, "LoadMainManifest")
						rescache:LoadMainManifest("main_manifest", self.onManifestLoaded, self)
					end
				end

				function LogicLauncher:onManifestProgress(cur, total)
					local progress = cur / total

					BootstrapLoadingView.setProgressPersentVal(progress)
				end

				function LogicLauncher:onManifestLoaded()
					LogicLauncher.super.onManifestLoaded(self)
					ViewMgr.instance:setMaskColor("#000000C0")
					BootstrapLoadingView.setProgressPersentVal(1)
					BootstrapLoadingView.stopLoadingProgress()
					self:_initExt()

					local rcdTime = os.clock()

					printInfo(LogTag.BOOTSTRAP, "LogicLauncher onManifestLoaded----------")
					LanguageMgr.instance:init(self._onLanguagePkgLoaded, self)
					printInfo(LogTag.BOOTSTRAP, "LogicLauncher onManifestLoaded----------OK-----UseTime:" .. os.clock() - rcdTime)
				end

				function LogicLauncher:_onLoadLodCfg(res)
					if res and res.IsDone and res.IsSuccess then
						local txt = res:GetMainAsset().text

						printInfo("lowprefabs:" .. txt)
						Framework.LodUtil.Instance:Init(txt)
					end

					if res then
						GameUtil.unloadResource(res)
					end
				end

				function LogicLauncher:_onLanguagePkgLoaded()
					printInfo(LogTag.BOOTSTRAP, "LogicLauncher onLanguagePkgLoaded--------------------")
					self:buildAdditionalExtensions()
				end

				function LogicLauncher:buildAdditionalExtensions()
					local rcdTime = os.clock()

					ExtensionMgr.instance:buildAllExtensionsWithCallBack(function()
						GlobalDispatcher:dispatch(GlobalNotify.AllExtensionsLoaded)
						CommonPreloader.instance:loadBasic(self._onBasicPreloaded, self)
						GMModel.instance:initData()
						printInfo(LogTag.BOOTSTRAP, "LogicLauncher onLanguagePkgLoaded---------OK-----------UseTime:" .. os.clock() - rcdTime)
					end)
				end

				function LogicLauncher:_initExt()
					local unitCameraGO = goutil.find("UnitCamera")

					if unitCameraGO then
						local unitCameraTarget = CameraTarget.Get(unitCameraGO)

						CameraTargetMgr.instance:addTarget(unitCameraTarget)
					end

					local groundCameraGO = goutil.find("GroundCamera")

					if groundCameraGO then
						local groundCameraTarget = CameraTarget.Get(groundCameraGO)

						CameraTargetMgr.instance:addTarget(groundCameraTarget)
					end

					UnitTagExtend.extend()
					UnitNotifyExtend.extend()
				end

				function LogicLauncher:_onBasicPreloaded()
					if not enableDebug then
						NetConnMgr.instance:ignoreLog(1, 1)
						NetConnMgr.instance:ignoreLog(4, 9)
						NetConnMgr.instance:ignoreLog(4, 10)
					end

					self:handleChinaLogicUrl()

					if Framework.OSDef.RunOS == Framework.OSDef.Android and not Framework.OSDef.isEditor and Framework.OSDef.RunOS == Framework.OSDef.Android then
						NativeBridge.instance:invoke("com.baitian.unity.LayoutParamsRefreshUtil", "SetIsStartUpFinishInitedTrue")
					end

					ReConnectionMgr.instance:init()

					local waitingPrefab = CommonPreloader.instance:getSkinlibAsset(CommonResPath.WaitingView)

					WaitingView.instance:init(waitingPrefab)
					WaitingView.instance:show("tip_login_prepare")

					local floatItemPrefab = CommonPreloader.instance:getSkinlibAsset(CommonResPath.FloatItem)

					FloatWordMgr.instance:init(floatItemPrefab)
					MsgFlowMgr.instance:init()
					NetConnMgrExt.init()
					TimeHelper.Init()

					local _Time = getmetatable(Time)

					function _Time.__newindex(t, k, v)
						if k == "timeScale" then
							_Time.timeScale = v

							TimeHelper.SetTimeScale(v)

							return 0
						else
							return og_newindex(t, k, v)
						end
					end

					CommonObjectMgr.instance:init()

					AMPlayer.takeWithBundle = rescache.resLoadMode ~= Framework.ResourceLoadMode.Direct

					local starterGO = goutil.find("AoUnityStarter")
					local starter = PjaqmStarter.Get(starterGO)

					starter:AddApplicationStateChangeListener(self._onApplicationStateChange, self)
					KeycodeListener.Get(starterGO)

					local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

					if not Framework.OSDef.isEditor and Framework.OSDef.RunOS == Framework.OSDef.Android and (versionCode == 220 or versionCode == 221) then
						local versionFile = Framework.FileUtils.LocalResRootPath .. "version"

						Framework.FileUtils.Instance:DeleteFile(versionFile)
						Framework.FileUtils.Instance:DeleteFile("file://" .. versionFile)
					end

					ConfigurationChecker.instance:checkConfigurations()
					VersionCrtl.instance:init()
					VersionCrtl.instance:addLowMemoryListener(self._onLowMemory, self)
					VersionCrtl.instance:addTrimMemoryListener(self._onTrimMemory, self)
					VideoMgr.Get(starterGO)
					VideoMgr.Instance:Init("movie", ".mp4")

					local photoCache = Framework.PhotoProducerCache.Instance
					local additivePhotoMat = CommonPreloader.instance:getSkinlibAsset(CommonResPath.PhotoMat_Additive)

					photoCache:SetPhotoMaterial(additivePhotoMat)
					PhotoCacheMgr.instance:init()
					ConstConfig.instance:init()
					SurveyController.instance:init()

					if BootstrapPjaqGameConfigMgr.isReview then
						local forbiddenAsset = CommonPreloader.instance:getConfigAsset("config/forbidden_words.txt")
						local forbiddenAssetForName = CommonPreloader.instance:getConfigAsset("config/forbidden_name_words.txt")
						local t2sAsset = CommonPreloader.instance:getConfigAsset("config/chinese_dict.txt")

						DirtyWordMgr.instance:init(forbiddenAsset, forbiddenAssetForName, t2sAsset)
					end

					CommonPreloader.instance:loadAdditional()
					self:_onAdditionalPreloaded()
					CommonPreloader.instance:preCreateFrequentViews()
				end

				function LogicLauncher:handleChinaLogicUrl()
					if not BootstrapPjaqGameConfigMgr.isReview and CSGameUtil.GetGameConfigUrlType() == 2 then
						BootstrapPjaqGameConfigMgr.ReverseWebUrls = {}
						BootstrapPjaqGameConfigMgr.ReverseWebUrls[0] = "https://bak-service-gf-pjaqm.100bt.com/"
						BootstrapPjaqGameConfigMgr.ReverseWebUrls.Length = 1
					end
				end

				function LogicLauncher:_onAdditionalPreloaded()
					self._isAdditionalLoaded = true

					self:_checkPreloadDone()
				end

				function LogicLauncher:isPreloadDone()
					return self._isAdditionalLoaded
				end

				function LogicLauncher:_checkPreloadDone()
					if self._isAdditionalLoaded then
						GlobalDispatcher:dispatch(GlobalNotify.PreloadDone)
						BootstrapLauncher.instance:handleResPreLoadMgrFinish()
						ViewMgr.instance:open(ViewName.Login)
					end
				end

				function LogicLauncher:_onApplicationStateChange(state)
					if state == 1 then
						GlobalDispatcher:dispatch(GlobalNotify.ApplicationPause)
					elseif state == 2 then
						GlobalDispatcher:dispatch(GlobalNotify.ApplicationResume)
						settimer(0.1, self._onApplicationPauseDelay, self, false)
						NetConnMgrExt.markHeartBeatRespont()
						ResGcMgr.instance:gc()
					elseif state == 3 then
						local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

						if not Framework.OSDef.isEditor and Framework.OSDef.RunOS == Framework.OSDef.Android and (versionCode == 220 or versionCode == 221) then
							Framework.HotUpdate.VersionMgr.Instance:DeleteAllLocal()
						end

						GlobalDispatcher:dispatch(GlobalNotify.ApplicationQuit)
					elseif state == 4 then
						forcePrint("尝试重置eventSystem")
						GlobalModel.instance.eventSystem:SetActive(false)
						GlobalModel.instance.eventSystem:SetActive(true)
					end
				end

				function LogicLauncher:_onApplicationPauseDelay()
					removetimer(self._onApplicationPauseDelay, self)

					if Framework.OSDef.RunOS == Framework.OSDef.Android and not Framework.OSDef.isEditor and Framework.OSDef.RunOS == Framework.OSDef.Android then
						NativeBridge.instance:invoke("com.baitian.unity.LayoutParamsRefreshUtil", "RefreshLayoutParamsLua")
					end
				end

				LogicLauncher.MemoryLevel = {
					TRIM_MEMORY_RUNNING_MODERATE = 5,
					TRIM_MEMORY_RUNNING_CRITICAL = 15,
					TRIM_MEMORY_RUNNING_LOW = 10,
					TRIM_MEMORY_MODERATE = 60,
					TRIM_MEMORY_COMPLETE = 80,
					TRIM_MEMORY_BACKGROUND = 40,
					TRIM_MEMORY_UI_HIDDEN = 20
				}

				function LogicLauncher:_onLowMemory()
					if Framework.OSDef.RunOS == Framework.OSDef.Android then
						print("memory: _onLowMemory: Android")
						self:_destroyCommonRes()
					elseif Framework.OSDef.RunOS == Framework.OSDef.IOS then
						print("memory: _onLowMemory: IOS")
						self:_destroyCommonRes()
					else
						print("memory: _onLowMemory: RunOS:", Framework.OSDef.RunOS)
					end
				end

				function LogicLauncher:_onTrimMemory(level, _isGM)
					print("memory: _onTrimMemory 111 Framework.OSDef.RunOS", Framework.OSDef.RunOS, ", level:", level, ", _isGM = ", _isGM)

					if not level then
						return
					end

					level = checknumber(level)

					if level >= LogicLauncher.MemoryLevel.TRIM_MEMORY_BACKGROUND then
						self:_destroyCommonRes(level)
						ResGcMgr.instance:gc()
					else
						print("memory: _onTrimMemory 222 Framework.OSDef.RunOS", Framework.OSDef.RunOS, ", level:", level)

						if level == TRIM_MEMORY_UI_HIDDEN then
							print("memory: _onTrimMemory 222 Framework.OSDef.RunOS", Framework.OSDef.RunOS, "----gc----")
							ResGcMgr.instance:gc()
						end
					end
				end

				function LogicLauncher:_destroyCommonRes(level)
					if CommonResPath.unLoadForMemory then
						for i = 1, #CommonResPath.unLoadForMemory do
							local _vName = CommonResPath.unLoadForMemory[i]

							if _vName and not ViewMgr.instance:isOpen(_vName) then
								ViewMgr.instance:destroy(_vName)
							end

							if level then
								print("memory: _destroyCommonRes level:", level, ", destroy view:", _vName, ", runos:", Framework.OSDef.RunOS)
							else
								print("memory: _destroyCommonRes destroy view:", _vName, ", runos:", Framework.OSDef.RunOS)
							end
						end
					end

					local _viewCloseTimeDict = ViewLifetimeMgr.instance._viewCloseTimeDict

					if _viewCloseTimeDict then
						for k, _ in pairs(_viewCloseTimeDict) do
							if k and _viewCloseTimeDict[k] and _viewCloseTimeDict[k] > 1 then
								_viewCloseTimeDict[k] = 1
							end
						end
					end

					self:_clearBattleSceneCache()
				end

				function LogicLauncher:_clearBattleSceneCache()
					BattleStagesMgr.instance:removeUnusedStages()
				end

				function LogicLauncher:_onSignalStrength()
					GlobalDispatcher:dispatch(GlobalNotify.OnSignalStrength)
				end

				function LogicLauncher:_onScreenChanged(result)
					if self:_isCanUseAdapter() then
						SceneAdapterUtil.Adapter(result.screenWidth, result.screenHeight)
					end

					HardwareQuality._adaptLRSide()

					if GlobalDispatcher and GlobalDispatcher.dispatch then
						GlobalDispatcher:dispatch(GlobalNotify.SceneResolutionChange)
					end

					local scene = SceneMgr.instance:getCurScene()
					local stage = scene and scene.stage
					local camera = scene and scene.camera

					if stage then
						if stage.updateDetectors then
							stage:updateDetectors()
						end

						if stage.wholeScene and stage.wholeScene.ForceDetect then
							stage.wholeScene:ForceDetect()
						end
					end

					if camera and camera.updateCameraParams then
						camera:updateCameraParams()
					end

					if BootstrapAdaptationoverlayview then
						BootstrapAdaptationoverlayview.updatePos()
					end

					if CameraAdaptiveMgr and CameraAdaptiveMgr.instance then
						CameraAdaptiveMgr.instance:adaptiveResolution()
					end
				end

				function LogicLauncher:_isCanUseAdapter()
					local vc = checknumber(BootstrapUtil.getGameVersionCode())

					if Framework.OSDef.RunOS == Framework.OSDef.Android and vc < 970 then
						return false
					elseif Framework.OSDef.RunOS == Framework.OSDef.IOS and vc < 970 then
						return false
					else
						return true
					end
				end

				function gmetatable.__newindex(_, key, value)
					if key ~= "framework" and key ~= "frameworkext" and key ~= "bootstrap" and key ~= "logic" and key ~= "logicconfig" and key ~= "logiccommon" and key ~= "logicscene" and key ~= "logicstarter" then
						error("set global vairable directly is not allowed,please use setglobal instead!,key=" .. key)
					end
				end

				setmetatable(_G, gmetatable)

				local IS_UNITY_CACHE_ENABLE_KEY = "IS_UNITY_CACHE_ENABLE_KEY"
				local GameUtil = {}

				function GameUtil.isUnityCacheEnable()
					printInfo(LogTag.BOOTSTRAP, "LogicLauncher GameUtil.isUnityCacheEnable()")

					local status = Framework.LocalStorage.Instance:GetInt(IS_UNITY_CACHE_ENABLE_KEY, -1)

					if status == 0 then
						return false
					else
						return true
					end
				end

				setglobal("GameUtil", GameUtil)

				LogicLauncher.instance = LogicLauncher.New()

				LogicLauncher.instance:start()

				return LogicLauncher
			end
		end
	end
end
