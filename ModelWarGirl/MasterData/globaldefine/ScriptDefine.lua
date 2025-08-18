-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/GlobalDefine\\ScriptDefine.lua

local _RegionConst = require("Localization/RegionConst")

if not IsGLDeclared("RegionConst") or not RegionConst then
	GLDeclare("RegionConst", _RegionConst)
end

local _RegionUtils = require("System/RegionUtils")

if not IsGLDeclared("RegionUtils") or not RegionUtils then
	GLDeclare("RegionUtils", _RegionUtils)
end

local _Lang = require("Common/Lang")

if not IsGLDeclared("Lang") or not Lang then
	GLDeclare("Lang", _Lang)
end

local _Const = require("Const")

if not IsGLDeclared("Const") or not Const then
	GLDeclare("Const", _Const)
end

local _VersionUtils = require("System/VersionUtils")

if not IsGLDeclared("VersionUtils") or not VersionUtils then
	GLDeclare("VersionUtils", _VersionUtils)
end

local _BattleConst = require("Common/FrameBattle/BattleConst")

if not IsGLDeclared("BattleConst") or not BattleConst then
	GLDeclare("BattleConst", _BattleConst)
end

GLDeclare("CurAvatar", nil)
GLDeclare("HotfixMD5", "")
require("Framework/Functor")
require("Common/utils")
require("System/ConditionLimitManager")
require("System/LimitManager")

local _RedDotManager = require("UI/RedDotManager")

if not IsGLDeclared("RedDotManager") or not RedDotManager then
	GLDeclare("RedDotManager", _RedDotManager)
end

local _CHATRPC = require("Framework/CHATRPC")

if not IsGLDeclared("CHATRPC") or not CHATRPC then
	GLDeclare("CHATRPC", _CHATRPC)
end

require("UI/UIControls")

local _UIManager = require("UI/UIManager")

if not IsGLDeclared("UIManager") or not UIManager then
	GLDeclare("UIManager", _UIManager)
end

local _SceneManager = require("System/SceneManager")

if not IsGLDeclared("SceneManager") or not SceneManager then
	GLDeclare("SceneManager", _SceneManager)
end

local _MsgManager = require("System/MsgManager")

if not IsGLDeclared("MsgManager") or not MsgManager then
	GLDeclare("MsgManager", _MsgManager)
end

local _LoadManager = require("System/Load/LoadManager")

if not IsGLDeclared("LoadManager") or not LoadManager then
	GLDeclare("LoadManager", _LoadManager)
end

local _GameFsm = require("GameFsm/GameFsm")

if not IsGLDeclared("GameFsm") or not GameFsm then
	GLDeclare("GameFsm", _GameFsm)
end

local _EffectManager = require("System/EffectManager")

if not IsGLDeclared("EffectManager") or not EffectManager then
	GLDeclare("EffectManager", _EffectManager())
end

local _CueManager = require("System/CueManager")

if not IsGLDeclared("CueManager") or not CueManager then
	GLDeclare("CueManager", _CueManager)
end

local _ClientUtils = require("System/ClientUtils")

if not IsGLDeclared("ClientUtils") or not ClientUtils then
	GLDeclare("ClientUtils", _ClientUtils)
end

local _JumpGuideManager = require("System/JumpGuideManager")

if not IsGLDeclared("JumpGuideManager") or not JumpGuideManager then
	GLDeclare("JumpGuideManager", _JumpGuideManager)
end

local _BeginnerManager = require("Logic/Beginner/BeginnerManager")

if not IsGLDeclared("BeginnerManager") or not BeginnerManager then
	GLDeclare("BeginnerManager", _BeginnerManager)
end

local _ClientTimerManager = require("System/ClientTimerManager")

if not IsGLDeclared("ClientTimerManager") or not ClientTimerManager then
	GLDeclare("ClientTimerManager", _ClientTimerManager)
end

local _SDKAgent = require("SDK/SDKAgent")

if not IsGLDeclared("SDKAgent") or not SDKAgent then
	GLDeclare("SDKAgent", _SDKAgent)
end

local _SvrListManager = require("System/SvrListManager")

if not IsGLDeclared("SvrListManager") or not SvrListManager then
	GLDeclare("SvrListManager", _SvrListManager)
end

local _ModelStageManager = require("System/ModelStageManager")

if not IsGLDeclared("ModelStageManager") or not ModelStageManager then
	GLDeclare("ModelStageManager", _ModelStageManager)
end

local _DynamicSceneManager = require("System/DynamicSceneManager")

if not IsGLDeclared("DynamicSceneManager") or not DynamicSceneManager then
	GLDeclare("DynamicSceneManager", _DynamicSceneManager)
end

local _ServerDownloadUtils = require("System/ServerDownloadUtils")

if not IsGLDeclared("ServerDownloadUtils") or not ServerDownloadUtils then
	GLDeclare("ServerDownloadUtils", _ServerDownloadUtils)
end

local _ResColor = require("ClientData/ResColor")

if not IsGLDeclared("ResColor") or not ResColor then
	GLDeclare("ResColor", _ResColor)
end

local _TouchManager = require("System/TouchManager")

if not IsGLDeclared("TouchManager") or not TouchManager then
	GLDeclare("TouchManager", _TouchManager)
end

local _RentMsgManager = require("System/RentMsgManager")

if not IsGLDeclared("RentMsgManager") or not RentMsgManager then
	GLDeclare("RentMsgManager", _RentMsgManager)
end

local _HttpHelper = require("Network/HttpHelper")

if not IsGLDeclared("HttpHelper") or not HttpHelper then
	GLDeclare("HttpHelper", _HttpHelper)
end

local _RemoteConfig = require("Helper/RemoteConfig")

if not IsGLDeclared("RemoteConfig") or not RemoteConfig then
	GLDeclare("RemoteConfig", _RemoteConfig)
end

local _ChannelUtil = require("SDK/ChannelUtil")

if not IsGLDeclared("ChannelUtil") or not ChannelUtil then
	GLDeclare("ChannelUtil", _ChannelUtil)
end

local _GameConfig = require("Helper/GameConfig")

if not IsGLDeclared("GameConfig") or not GameConfig then
	GLDeclare("GameConfig", _GameConfig)
end

local _Analytics = require("SDK/Analytics")

if not IsGLDeclared("Analytics") or not Analytics then
	GLDeclare("Analytics", _Analytics)
end

local _ServerSection = require("Network/ServerSection")

if not IsGLDeclared("ServerSection") or not ServerSection then
	GLDeclare("ServerSection", _ServerSection)
end
