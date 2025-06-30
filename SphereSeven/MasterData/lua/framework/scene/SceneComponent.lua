--[[
-- added by wsh @ 2017-12-15
-- 场景管理系统：调度和控制场景异步加载以及进度管理，展示loading界面和更新进度条数据，GC、卸载未使用资源等
-- 注意：
-- 1、资源预加载放各个场景类中自行控制
-- 2、场景loading的UI窗口这里统一管理，由于这个窗口很简单，更新进度数据时直接写Model层
--]]

BaseScene = import(".Base.BaseScene")
SceneConfig = require "Scenes.Config.SceneConfig"

local SceneComponent = BaseClass("SceneComponent", Component)
local base = Component

-- 构造函数
local function Awake(self)
	base.Awake(self)
	-- 成员变量
	-- 当前场景
	self.current_scene = nil
	-- 是否忙
	self.busing = false
	-- 场景对象
	self.scenes = {}

	UIUtil.ClearSpriteTab()
end

-- 切换场景：内部使用协程
local function CoInnerSwitchScene(self, scene_config)
	-- 打开loading界面
	local uimgr_instance = UIManager:GetInstance()
	uimgr_instance:OpenWindow(UIWindowNames.UILoading)
	local window = uimgr_instance:GetWindow(UIWindowNames.UILoading)
	local model = window.Model
	model.value = 0
	Logger.Log("==================OpenLoading"..Time.realtimeSinceStartup) -- 46.07
	coroutine.waitforframes(1)
	-- 等待资源管理器加载任务结束，否则很多Unity版本在切场景时会有异常，甚至在真机上crash
	-- coroutine.waitwhile(function()
	-- 	return ResourcesManager:GetInstance():IsProsessRunning()
	-- end)
	
	-- 清理旧场景
	if self.current_scene then
		self.current_scene:OnLeave()
	end
	model.value = model.value + 0.01
	coroutine.waitforframes(2)

	Logger.Log("==================DestroyWindowExceptLayer"..Time.realtimeSinceStartup) -- 46.13
	-- 清理UI
	uimgr_instance:DestroyWindowExceptLayer({UILayers.UILoading, UILayers.UILoad})
	model.value = model.value + 0.01
	coroutine.waitforframes(1)

	-- 清理资源缓存
	Logger.Log("=================BeginGC"..Time.realtimeSinceStartup) -- 46.14
	GameObjectPool:GetInstance():Cleanup(true)
	model.value = model.value + 0.01
	coroutine.waitforframes(1)
	
	ResourcesManager:GetInstance():Cleanup()
	model.value = model.value + 0.01
	coroutine.waitforframes(1)

	-- 同步加载loading场景
	local scene_mgr = CS.UnityEngine.SceneManagement.SceneManager
	local resources = CS.UnityEngine.Resources
	scene_mgr.LoadScene(SceneConfig.LoadingScene.Level)
	model.value = model.value + 0.01
	coroutine.waitforframes(1)

	-- GC：交替重复2次，清干净一点
	collectgarbage("collect")
	CS.System.GC.Collect()
	collectgarbage("collect")
	CS.System.GC.Collect()
	local cur_progress = model.value
	--IOS真机打包会对Unity引擎代码裁剪，这里需要防止对UnityEngine.AsyncOperation这个的裁剪，不然progress为nil，也不会往下走
	coroutine.waitforasyncop(resources.UnloadUnusedAssets(), function(co, progress)
		assert(progress <= 1.0, "What's the funck!!!")
		model.value = cur_progress + 0.1 * progress
	end)
	model.value = cur_progress + 0.1
	coroutine.waitforframes(1)

	-- 初始化目标场景
	local logic_scene = self.scenes[scene_config.Name]
	if logic_scene == nil then
		logic_scene = scene_config.Type.New(scene_config)
		self.scenes[scene_config.Name] = logic_scene
	end
	assert(logic_scene ~= nil)
	logic_scene:OnEnter()
	model.value = model.value + 0.02
	coroutine.waitforframes(1)

	-- 异步加载目标场景
	print("--开始加载场景")
	cur_progress = model.value
	coroutine.waitforasyncop(scene_mgr.LoadSceneAsync(scene_config.Level), function(co, progress)
		assert(progress <= 1.0, "What's the fuck!!!")
		model.value = cur_progress + 0.15 * progress
	end)
	model.value = cur_progress + 0.15
	coroutine.waitforframes(1)
	
	-- 准备工作：预加载资源等
	-- 说明：现在的做法是不热更场景（都是空场景），所以主要的加载时间会放在场景资源的prefab上，这里给65%的进度时间
	cur_progress = model.value
	Logger.Log("==================beginLoad"..Time.realtimeSinceStartup) -- 46.29
	coroutine.yieldstart(logic_scene.CoOnPrepare, function(co, progress)
		assert(progress <= 1.0, "Progress should be normalized value!!!")
		model.value = cur_progress + 0.65 * progress
	end, logic_scene)
	model.value = cur_progress + 0.65

	coroutine.waitforframes(1)
	Logger.Log("==================Loaded"..Time.realtimeSinceStartup) -- 48.17
	coroutine.waitforframes(1)
	logic_scene:OnComplete()
	model.value = 1.0

	coroutine.waitforframes(3)
	-- 加载完成，关闭loading界面
	uimgr_instance:DestroyWindow(UIWindowNames.UILoading)
	self.current_scene = logic_scene
	self.loadingScene = nil
	self.busing = false
	DataManager:GetInstance():Broadcast(DataMessageNames.ON_SCENE_CHG);
end

-- 切换场景
local function SwitchScene(self, scene_config)
	assert(scene_config ~= SceneConfig.LaunchScene and scene_config ~= SceneConfig.LoadingScene)
	assert(scene_config.Type ~= nil)
	if self.busing then 
		return
	end
	if self.current_scene and self.current_scene.scene_config.Name == scene_config.Name then
		return
	end
	
	self.loadingScene = scene_config
	self.busing = true
	coroutine.start(CoInnerSwitchScene, self, scene_config)
end

local function IsLoadingScene(self)
	return self.busing or (self.current_scene and self.current_scene.scene_config.Name == SceneConfig.LoadingScene.Name)
end

local function IsBattleScene(self)
	return self.current_scene and self.current_scene.scene_config.Name == SceneConfig.BattleScene.Name
end

local function IsLoginScene(self)
	return self.current_scene and self.current_scene.scene_config.Name == SceneConfig.LoginScene.Name
end

local function GetLoadingScene(self)
	return self.busing and self.loadingScene.Name or nil
end

local function GetCurrentScene(self)
	return not self.busing and self.current_scene.scene_config.Name or nil
end

-- 析构函数
local function Dispose(self)
	base.Dispose(self)
	for _, scene in pairs(self.scenes) do
		scene:Delete()
	end
end

SceneComponent.Awake = Awake
SceneComponent.SwitchScene = SwitchScene
SceneComponent.IsLoadingScene = IsLoadingScene
SceneComponent.IsLoginScene = IsLoginScene
SceneComponent.IsBattleScene = IsBattleScene
SceneComponent.GetLoadingScene = GetLoadingScene
SceneComponent.GetCurrentScene = GetCurrentScene
SceneComponent.Dispose = Dispose

return SceneComponent