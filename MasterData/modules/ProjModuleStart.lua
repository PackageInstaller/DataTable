-- chunkname: @modules/ProjModuleStart.lua

module("modules.ProjModuleStart", package.seeall)

local ProjModuleStart = class("ProjModuleStart")

function ProjModuleStart:start()
	logNormal("ProjModuleStart:start()!!!")
	self:addCrashsightSceneData()
	self:init()
end

function ProjModuleStart:init()
	self:addCrashsightResCheckerV()
	logNormal("ProjModuleStart:init()!!!")
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resource_load)
	GameResMgr:InitAbDependencies(self.onAbDependenciesInited, self)
	BootLoadingView.instance:show(0.2, booterLang("loading_res"))
end

function ProjModuleStart:addCrashsightSceneData()
	local resourceName = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr

	CrashSightAgent.AddSceneData("K#resVersion", resourceName)
end

function ProjModuleStart:addCrashsightResCheckerV()
	local markVersion = ResCheckMgr.instance:GetOutVersion()

	if string.nilorempty(markVersion) then
		markVersion = "0"
	end

	CrashSightAgent.AddSceneData("K#resCheckerV", markVersion)
end

function ProjModuleStart:onAbDependenciesInited()
	logNormal("ProjModuleStart:onAbDependenciesInited()!!!")
	self:initFramework()
	self:initModuleLogic()
end

function ProjModuleStart:initFramework()
	addGlobalModule("framework.require_framework")
	addGlobalModule("modules.setting.require_proto")
	addGlobalModule("modules.setting.require_modules")
	TaskDispatcher.init()
	FrameworkExtend.init()
end

function ProjModuleStart:initModuleLogic()
	GameBranchMgr.instance:init()

	local moduleMvc = addGlobalModule("modules.setting.module_mvc", "module_mvc")

	ModuleMgr.instance:init(moduleMvc, self._onModuleIniFinish, self)
end

function ProjModuleStart:_onModuleIniFinish()
	if BootLoadingView.instance.hasClickFix then
		return
	end

	addGlobalModule("modules.setting.module_views_preloader", "module_views_preloader")

	local moduleViews = addGlobalModule("modules.setting.module_views", "module_views")

	ViewMgr.instance:init(moduleViews)
	FullScreenViewLimitMgr.instance:init()
	SLFramework.TimeWatch.Instance:Start()
	ConfigMgr.instance:init("configs/excel2json/json_", "modules.configs.excel2json.lua_", "configs/datacfg_")
	ConfigMgr.instance:loadConfigs(self._onAllConfigLoaded, self)
end

function ProjModuleStart:_onAllConfigLoaded()
	LangSettings.instance:init()
	LangSettings.instance:loadLangConfig(self._onLangConfigLoaded, self)
end

function ProjModuleStart:_onLangConfigLoaded()
	if BootLoadingView.instance.hasClickFix then
		return
	end

	local loadTypeStr = GameResMgr.IsFromEditorDir and "direct" or "bundle"
	local isAllToOne = ConfigMgr.instance._isAllToOne and "allToOne" or "oneToOne"

	logNormal(loadTypeStr .. " " .. isAllToOne .. " load configs cost time: " .. SLFramework.TimeWatch.Instance:Watch() .. " s")
	LangSettings.instance:init()
	SLFramework.LanguageMgr.Instance:Init(self._onLangSettingsInit, self)
end

function ProjModuleStart:_onLangSettingsInit()
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("_onLangSettingsInit, 多语言资源列表加载完成！")
	ConstResLoader.instance:startLoad(self._onConstResLoaded, self)
end

function ProjModuleStart:_onConstResLoaded()
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("OnConstResLoaded, 常驻内存的资源加载完毕了！")
	SLFramework.LanguageMgr.Instance:RegisterLangImageSetter(self._loadLangImage, self)
	SLFramework.LanguageMgr.Instance:RegisterLangSpriteSetImageSetter(self._loadLangSpriteSetImage, self)
	SLFramework.LanguageMgr.Instance:RegisterLangTxtSetter(self._loadLangTxt, self)
	SLFramework.LanguageMgr.Instance:RegisterLangCaptionsSetter(self._loadLangCaptions, self)
	AudioMgr.instance:init(self._onAudioInited, self)
end

function ProjModuleStart:_onAudioInited(ret)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	if not ret then
		logError("ProjModuleStart._onAudioInited ret = " .. tostring(ret))
	end

	AudioMgr.instance:initSoundVolume()
	AudioMgr.instance:changeEarMode()
	BootLoadingView.instance:show(0.99, booterLang("loading_res"))
	CameraMgr.instance:initCamera(self._onCameraInit, self)
end

function ProjModuleStart:_onCameraInit()
	if BootLoadingView.instance.hasClickFix then
		return
	end

	GameGlobalMgr.instance:initLangFont()
	VoiceChooseMgr.instance:start(self._onVoiceChoose, self)
end

function ProjModuleStart:_onVoiceChoose()
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("_onVoiceChoose！")
	self:startLogic()
end

function ProjModuleStart:_loadLangImage(singleImage, refPath)
	singleImage:LoadImage(refPath)
end

function ProjModuleStart:_loadLangSpriteSetImage(singleImage, refPath, refSpriteName)
	singleImage:LoadImage(refPath, refSpriteName)
end

function ProjModuleStart:_loadLangTxt(txtCom, langId)
	if txtCom and txtCom.text then
		txtCom.text = luaLang(langId)
	end
end

function ProjModuleStart:_loadLangCaptions(captionsCom, langType, needActiveLangList)
	if needActiveLangList then
		local curLang = LangSettings.instance:getCurLang()

		for i = 1, needActiveLangList.Length do
			if needActiveLangList[i - 1] == curLang then
				gohelper.setActive(captionsCom.gameObject, true)

				return
			end
		end
	end

	gohelper.setActive(captionsCom.gameObject, LangSettings.instance:langCaptionsActive())
end

function ProjModuleStart:startLogic()
	if BootLoadingView.instance.hasClickFix then
		return
	end

	local moduleCmds = addGlobalModule("modules.setting.module_cmd", "module_cmd")

	ServerTime.init()
	LuaSocketMgr.instance:init(system_cmd, moduleCmds)
	PreReciveLogicMsg.instance:init()
	GameSceneMgr.instance:init()
	GameGlobalMgr.instance:init()
	NavigateMgr.instance:init()
	ConnectAliveMgr.instance:init()
	IconMaterialMgr.instance:init()
	ActivityLiveMgr.instance:init()
	EnterActivityViewOnExitFightSceneHelper.activeExtend()
	ConnectAliveMgr.instance:setNonResendCmds({
		24032
	})
	BootLoadingView.instance:show(1, booterLang("loading_res_complete"))
	BootLoadingView.instance:addEventListeners()
	SDKDataTrackMgr.instance:trackResourceLoadFinishEvent(SDKDataTrackMgr.Result.success)
	StatViewController.instance:init()
	GameBranchMgr.instance:inject()
	BootLoadingView.instance:playClose()
	TaskDispatcher.runDelay(function()
		LoginController.instance:login()
	end, nil, 0.167)
end

ProjModuleStart.instance = ProjModuleStart.New()

ProjModuleStart.instance:start()

return ProjModuleStart
