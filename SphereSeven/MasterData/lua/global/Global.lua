--[[
-- added by wsh @ 2017-11-30
-- 1、加载全局模块，所有全局性的东西都在这里加载，好集中管理
-- 2、模块定义时一律用local再return，模块是否是全局模块由本脚本决定，在本脚本加载的一律为全局模块
-- 3、对必要模块执行初始化
-- 注意：
-- 1、全局的模块和被全局模块持有的引用无法GC，除非显式设置为nil
-- 2、除了单例类、通用的工具类、逻辑上的静态类以外，所有逻辑模块不要暴露到全局命名空间
-- 3、Unity侧导出所有接口到CS命名空间，访问cs侧函数一律使用CS.xxx，命名空间再cs代码中给了，这里不需要处理
-- 4、这里的全局模块是相对与游戏框架或者逻辑而言，lua语言层次的全局模块放Common.Main中导出
--]]

UNITY_EDITOR = CS.UnityEngine.Application.isEditor
PLATFORM_IPHONE = CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.IPhonePlayer
PLATFORM_ANDROID = CS.UnityEngine.Application.platform == CS.UnityEngine.RuntimePlatform.Android

-- 加载全局模块
require "Framework.Common.BaseClass"
require "Framework.Common.DataClass"
require "Framework.Common.ConstClass"
require "Config.ExcelConfig"

-- 创建全局模块
Config = require "Global.Config"
Singleton = require "Framework.Common.Singleton"
Updatable = require "Framework.Common.Updatable"
UpdatableSingleton = require "Framework.Common.UpdatableSingleton"
SortingLayerNames = require "Global.SortingLayerNames"
Logger = require "Framework.Logger.Logger"
require "Framework.Updater.Coroutine"
require "Common.State.FsmMachine"
require "Common.State.BaseState"

-- 渠道
ChannelManager = require "Channel.ChannelManager"
BaseChannel = require "Channel.BaseChannel"
TestChannel = require "Channel.TestChannel"
HKQooChannel = require "Channel.HKQooChannel"
JAChannel = require "Channel.JAChannel"
AsiaChannel = require "Channel.AsiaChannel"
TestQooChannel = require "Channel.TestQooChannel"

-- game data
require "DataCenter.Config.DataMessageNames"
DataManager = require "DataCenter.DataManager"
ClientData = require "DataCenter.ClientData.ClientData"
ServerData = require "DataCenter.ServerData.ServerData"
UIData = require "DataCenter.UIData.UIData"
TaskData = require "DataCenter.UIData.TaskData"
FriendTestData =  require "DataCenter.UIData.FriendTestData"
DMBannerData =  require "DataCenter.DMBannerData.DMBannerData"

Authority = require "Global.Authority"

-- game config
---@type LangUtil
LangUtil = require "Common.LangUtil"
PathUtil = require "Common.PathUtil"
EventCenter = require "Handler.EventCenter"
--
TimeUtil = require "Common.TimeUtil"
GMUtil = require "Common.GMUtil"
GameUtil = require "GameLogic.Util.GameUtil"
-- ui base
---@type UI.Util.UIUtil
UIUtil = require "Framework.UI.Util.UIUtil"
UIPublic = require "Framework.UI.Util.UIPublic"
VerticalScroll = require "Framework.UI.Util.VerticalScroll"
UILandlady = require "Framework.UI.Util.UILandlady"
UIDrawing = require "Framework.UI.Util.UIDrawing"
---@type PublicRequest
PublicRequest = require "Framework.UI.Util.PublicRequest"
UIBaseModel = require "Framework.UI.Base.UIBaseModel"
UIBaseCtrl = require "Framework.UI.Base.UIBaseCtrl"
UIBaseComponent = require "Framework.UI.Base.UIBaseComponent"
UIBaseContainer = require "Framework.UI.Base.UIBaseContainer"
UIBaseView = require "Framework.UI.Base.UIBaseView"
UIBattelModeInfo = require "Framework.UI.Util.UIBattelModeInfo"
UIActivityData = require "Framework.UI.Util.UIActivityData"

-- ui component
UILayer = require "Framework.UI.Component.UILayer"
UICanvas = require "Framework.UI.Component.UICanvas"

UIText = require "Framework.UI.Component.UIText"
UIImage = require "Framework.UI.Component.UIImage"
UISlider = require "Framework.UI.Component.UISlider"
UIInput = require "Framework.UI.Component.UIInput"
UIButton = require "Framework.UI.Component.UIButton"
UIToggleButton = require "Framework.UI.Component.UIToggleButton"
UIWrapComponent = require "Framework.UI.Component.UIWrapComponent"
UITabGroup = require "Framework.UI.Component.UITabGroup"
UIButtonGroup = require "Framework.UI.Component.UIButtonGroup"
UIWrapGroup = require "Framework.UI.Component.UIWrapGroup"

UIItemClass = require "Framework.UI.Component.UIItem"
UIEventHandler = require "Framework.UI.Component.UIEventHandler"

UIEffect = require "Framework.UI.Component.UIEffect"


LibStringSearch = require "Sensitive.src.string_search"

GameObject = CS.UnityEngine.GameObject
LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
Transform = CS.UnityEngine.Transform
UE_UI = CS.UnityEngine.UI
ReferenceCollector = CS.ReferenceCollector
Material = CS.UnityEngine.Material
RectTransform = CS.UnityEngine.RectTransform
LayerMask = CS.UnityEngine.LayerMask
Camera = CS.UnityEngine.Camera
Screen = CS.UnityEngine.Screen
Input = CS.UnityEngine.Input
DOTween = CS.DG.Tweening.DOTween
Ease = CS.DG.Tweening.Ease
LoopType=CS.DG.Tweening.LoopType
AnimationEvent = CS.UnityEngine.AnimationEvent
SkinnedMeshRenderer = CS.UnityEngine.SkinnedMeshRenderer
Sprite = CS.UnityEngine.Sprite
Texture2D = CS.UnityEngine.Texture2D
Rect = CS.UnityEngine.Rect
AudioSource = CS.UnityEngine.AudioSource
AudioClip = CS.UnityEngine.AudioClip
PlayerPrefs = CS.UnityEngine.PlayerPrefs
RuntimeAnimatorController=CS.UnityEngine.RuntimeAnimatorController
EventSystem=CS.UnityEngine.EventSystems.EventSystem
PointerEventData=CS.UnityEngine.EventSystems.PointerEventData
RaycastResult=CS.UnityEngine.EventSystems.RaycastResult
Canvas = CS.UnityEngine.Canvas
ParticleSystemRenderer = CS.UnityEngine.ParticleSystemRenderer
ICanvasRaycastFilter = CS.UnityEngine.ICanvasRaycastFilter
RectTransformUtility =CS.UnityEngine.RectTransformUtility
-- ui window
UILayers = require "Framework.UI.UILayers"
UIWindow = require "Framework.UI.UIWindow"
UIManager = require "Framework.UI.UIManager"
require "Framework.UI.Message.UIMessageNames"
require "UI.Config.UIWindowNames"
UIConfig = require "UI.Config.UIConfig"

-- res
ResourcesManager = require "Framework.Resource.ResourcesManager"
GameObjectPool = require "Framework.Resource.GameObjectPool"

-- update & time
Timer = require "Framework.Updater.Timer"
TimerManager = require "Framework.Updater.TimerManager"
UpdateManager = require "Framework.Updater.UpdateManager"
--LogicUpdater = require "GameLogic.Main.LogicUpdater"

-- scenes
--BaseScene = require "Framework.Scene.Base.BaseScene"
--SceneManager = require "Framework.Scene.SceneManager"
--SceneConfig = require "Scenes.Config.SceneConfig"

-- atlas
AtlasConfig = require "Resource.Config.AtlasConfig"
AtlasManager = require "Framework.Resource.AtlasManager"

-- effect
EffectConfig = require "Resource.Config.EffectConfig"
BaseEffect = require "Framework.Resource.Effect.Base.BaseEffect"
EffectManager = require "Framework.Resource.Effect.EffectManager"

-- FreeECS
Registry = require("Framework.FreeECS.Registry")
Entity = require("Framework.FreeECS.Entity")
Component = require("Framework.FreeECS.Component")

require("Game")

pb = require ('pb')
cjson = require("rapidjson")

Queue = require("Framework.Collection.Queue")
Stack = require("Framework.Collection.Stack")

--HUDText = require("GameLogic.Battle.Entity.HUDText")
ZZBase64 = require("DataCenter.ZZBase64")

--tools
CSUtil = CS.UIUtil;
DoTweenManager = CS.DoTweenManager;
EventTriggerListener = CS.EventTriggerListener;
ButtonListener = CS.ButtonEventTriggerListener;
TimerHelper = CS.TimerHelper;
ObjectPool = CS.ObjectPool;
BindData = CS.BindData;
TapDB = CS.TapDB
LongPress = require "Framework.UI.Util.LongPress";
ListChildPool = require "Framework.UI.UIListChildPool";
CountDown = require "Framework.Updater.CountDown";
HomeSceneItemPath = "UI/Prefabs/View/Items";

-- 单例类初始化
UIManager:GetInstance()
DataManager:GetInstance()
ResourcesManager:GetInstance()
UpdateManager:GetInstance()
--SceneManager:GetInstance()
AtlasManager:GetInstance()
--LogicUpdater:GetInstance()

if true then
    MockManager = require "_Mock.MockManager"
end

require "GameLogic.Battle.Common.BattleGlobal"

print("--加载完Global.lua")