-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luamain.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
NEKO_RELEASE = not global_var_debug
LocalProtocolDebug = false
require("threadsafepipe")
require("thread")
local p1, p2 = 0, 0
local threadId = 0
require("luacodeversion")
require("framework.linq")
GameTimer = require("framework.utils.gametimer")
ServerGameTimer = require("framework.utils.servergametimer")
require("framework.utils.generateuniqueid")
require("pcg")
xLuaUtil = require("xlua.util")
require("fixedpoint")
fixedpoint_zero = fixedpoint(0)
Common = require("luacommon")
LuaNotificationCenter = require("framework.utils.luanotificationcenter")
BeanManager = require("framework.utils.beanmanager")
DataCommon = require("luadatacommon")
LuaNetManager = require("logic.net.luanetmanager")
BehaviorManager = require("framework.utils.behaviormanager")
EffectUtil = require("framework.utils.effectutil")
EquipSkillUtil = require("framework.utils.equipskillutil")
Tween = require("framework.tween")
BattleClientProtocolManager = require("localprotocols.localprotocolmanager")
BattleECS = require("logic.newbattle.battleecs")
BattleFSM = require("logic.fsm.battlefsm")
GameFSM = require("logic.fsm.gamefsm")
BaseMainFSM = require("logic.fsm.basemainfsm")
YardFSM = require("logic.fsm.yardfsm")
ReconnectFSM = require("logic.fsm.reconnectfsm")
;
((((CS.PixelNeko).UI).UIManager).InitLuaWindows)(require("framework.ui.wrappers"))
;
((((CS.PixelNeko).UI).UIManager).SetDefaultImageAsset)((DataCommon.DefaultImageAsset).assetBundle, (DataCommon.DefaultImageAsset).assetName)
Dialog = require("framework.ui.dialog")
DialogManager = require("framework.ui.dialogmanager")
UIBackManager = require("framework.ui.uibackmanager")
GameScene = require("logic.scene.gamescene")
LuaAudioManager = require("logic.manager.luaaudiomanager")
;
(LuaAudioManager.Init)()
LuaTimelineManager = require("logic.manager.luatimelinemanager")
SceneManager = require("logic.scene.newscenemanager")
NekoData = require("logic.manager.experimental.nekodata")
;
(NekoData.CreateAll)()
TextManager = require("logic.manager.textmanager")
;
(TextManager.Init)()
NumberManager = require("logic.manager.numbermanager")
;
(NumberManager.Init)()
TriggerManager = require("logic.scene.luaevent.trigger.triggermanager")
;
(TriggerManager.Init)()
EventManager = require("logic.scene.luaevent.event.eventmanager")
;
(EventManager.Init)()
EffectFactory = require("logic.scene.luaevent.effect.effectfactory")
local EffectRunner = require("logic.scene.luaevent.effect.effectrunner")
TrapManager = require("logic.scene.trap.trapmanager")
SwitchManager = require("logic.scene.trap.switchmanager")
RandomItemManager = require("logic.scene.types.randomitemmanager")
Layers = require("logic.scene.layers")
;
(Layers.Init)()
Live2DManager = require("logic.manager.live2dmanager")
;
(Live2DManager.Init)()
LuaSqlProtocalManager = ((require("logic.sql.luasqlprotocalmanager")).Create)()
local OnStateEnter = function(instance, currentState, lastState)
  -- function num : 0_0 , upvalues : _ENV
  ((require("logic.fsm.gamefsm." .. (string.lower)(currentState))).OnEnter)(lastState)
end

local OnStateExit = function(instance, currentState, nextState)
  -- function num : 0_1 , upvalues : _ENV
  ((require("logic.fsm.gamefsm." .. (string.lower)(currentState))).OnExit)(nextState)
end

GlobalGameFSM = (GameFSM.Create)()
GlobalGameFSM:Init()
GlobalGameFSM:SetStateEnterCallBack(OnStateEnter, GlobalGameFSM)
GlobalGameFSM:SetStateExitCallBack(OnStateExit, GlobalGameFSM)
;
(math.randomseed)((os.time)())
for i = 1, 5 do
  (math.random)()
end
local FixedUpdate = function()
  -- function num : 0_2 , upvalues : _ENV
  (EventManager.OnFixedUpdate)()
  ;
  ((NekoData.BehaviorManager).BM_Dungeon):OnFixedUpdate()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_FixedUpdate, nil, nil)
end

local update_data = {deltaTime = 0, unscaledDeltaTime = 0}
local Update = function(deltaTime, unscaledDeltaTime)
  -- function num : 0_3 , upvalues : _ENV, EffectRunner, update_data
  (GameTimer.OnUpdate)(deltaTime, unscaledDeltaTime)
  ;
  (ServerGameTimer.OnClientUpdate)(unscaledDeltaTime)
  ;
  (LuaNetManager.Update)(unscaledDeltaTime)
  ;
  ((NekoData.BehaviorManager).BM_RedPoint):HandleCacheNotifications()
  ;
  (SceneManager.Update)(deltaTime, unscaledDeltaTime)
  ;
  (TriggerManager.OnUpdate)(deltaTime)
  ;
  (TrapManager.OnUpdate)(deltaTime)
  ;
  (EffectRunner.OnUpdate)(deltaTime)
  GlobalGameFSM:Update()
  LuaSqlProtocalManager:Update()
  ;
  ((require("logic.fsm.gamefsm." .. (string.lower)(GlobalGameFSM:GetCurrentState()))).Update)()
  update_data.deltaTime = deltaTime
  update_data.unscaledDeltaTime = unscaledDeltaTime
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_Update, nil, update_data)
  if ((((CS.PixelNeko).UI).NekoEventSystem).InputProvider).GetKeyDown and (((((CS.PixelNeko).UI).NekoEventSystem).InputProvider).GetKeyDown)(((CS.UnityEngine).KeyCode).Escape) then
    local openGameExitDialog = true
    if SdkManager.IsOverseas then
      openGameExitDialog = DialogManager:HandleBackPressed()
    end
    if openGameExitDialog then
      if (((CS.PixelNeko).LuaManager).GetSystemType)() ~= (require("protocols.bean.protocol.common.systemtype")).UNITY or not (LuaNetManager.GetMainConnect)() or ((((CS.PixelNeko).P1).PlatformManager).IsNeedOpenGameExitDialog)() then
        LogInfo("luamain", "open secondconfirmdialog quit or not?")
        local dialog = (DialogManager.CreateSingletonDialog)("net.secondconfirmdialog")
        dialog:PushDialogSetting(101, nil, function()
    -- function num : 0_3_0 , upvalues : _ENV
    (SdkManager.Quit)()
  end
, {}, nil, {})
      else
        do
          do
            LogInfo("luamain", "SdkManager.Quit!")
            ;
            (SdkManager.Quit)()
            LogInfo("luamain", "inputKeyDown is Escape")
            ;
            (LuaUpdateManager.CheckLocalResNewVersion)()
          end
        end
      end
    end
  end
end

local LateUpdate = function(deltaTime, unscaledDeltaTime)
  -- function num : 0_4 , upvalues : _ENV, update_data
  (DialogManager.OnLateUpdate)(deltaTime, unscaledDeltaTime)
  update_data.deltaTime = deltaTime
  update_data.unscaledDeltaTime = unscaledDeltaTime
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_LateUpdate, nil, update_data)
end

local Destroy = function()
  -- function num : 0_5 , upvalues : _ENV, p1, threadId, p2
  pcall(NekoData.ClearAll)
  if p1 > 0 then
    (threadsafepipe.write)(p1, "exit")
    ;
    (thread.join)(threadId)
    threadId = 0
    p1 = 0
  end
end

local OnApplicationFocus = function(focus)
  -- function num : 0_6 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_ApplicationFocus, nil, focus)
  LogInfoFormat("luamain", "ApplicationFocus = %s", focus)
end

local OnApplicationPause = function(pause)
  -- function num : 0_7 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_ApplicationPause, nil, pause)
  LogInfoFormat("luamain", "ApplicationPause = %s", pause)
  if pause then
    if (((CS.PixelNeko).P1).DeepLink).SetInfo then
      ((((CS.PixelNeko).P1).DeepLink).SetInfo)("")
    end
    if (((CS.PixelNeko).P1).DeepLink).ClearDeeplinkJsonString then
      ((((CS.PixelNeko).P1).DeepLink).ClearDeeplinkJsonString)()
    end
    ;
    ((NekoData.BehaviorManager).BM_Login):ClearGameOpenFromDeepLinkTag()
  else
    ;
    ((NekoData.BehaviorManager).BM_Login):SetGameOpenFromDeepLinkTag()
    if ((NekoData.BehaviorManager).BM_Login):GetGameOpenFromDeepLinkTag() then
      local req = (LuaNetManager.CreateProtocol)("protocol.activity.crefreshdeeplink")
      req:Send()
    end
  end
end

local OnCharacterMove = function(x, y)
  -- function num : 0_8 , upvalues : _ENV
  (TriggerManager.OnWorldPosChange)(x, y)
  ;
  ((NekoData.DataManager).DM_Dungeon):SetActorWorldPosition(x, y)
  x = (math.floor)(x / 0.4 + 0.5)
  y = (math.floor)(y / -0.56 + 0.5)
  ;
  ((NekoData.DataManager).DM_Dungeon):SetActorGridPosition(x, y)
  ;
  (TriggerManager.OnGridPosChange)(x, y)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ActorMoved, {}, nil)
end

local OnDirectionChange = function(dir)
  -- function num : 0_9 , upvalues : _ENV
  ((NekoData.DataManager).DM_Dungeon):SetActorOrientation(dir)
  ;
  (TriggerManager.OnDirectionChange)(dir)
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_ActorDirChanged, {}, nil)
end

local OnNavMeshBuildFinish = function()
  -- function num : 0_10 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_NavMeshBuildFinish, {}, nil)
end

local OnCollision = function(id)
  -- function num : 0_11 , upvalues : _ENV
  print("collision id", id, (debug.traceback)())
  ;
  (TriggerManager.OnCollision)(id)
end

local ScreenPixelChange = function()
  -- function num : 0_12 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_ScreenPixelChanged, nil, nil)
  LogInfo("luamain", "ScreenPixelChanged")
end

;
(((CS.PixelNeko).LuaManager).SetLuaFixedUpdateDelegate)(FixedUpdate)
;
(((CS.PixelNeko).LuaManager).SetLuaUpdateDelegate)(Update)
;
(((CS.PixelNeko).LuaManager).SetLuaLateUpdateDelegate)(LateUpdate)
;
(((CS.PixelNeko).LuaManager).SetLuaDestroyDelegate)(Destroy)
;
(((CS.PixelNeko).LuaManager).SetLuaOnApplicationFocusDelegate)(OnApplicationFocus)
;
(((CS.PixelNeko).LuaManager).SetLuaOnApplicationPauseDelegate)(OnApplicationPause)
;
(((CS.PixelNeko).LuaManager).SetLuaOnCharacterMoveDelegate)(OnCharacterMove)
;
(((CS.PixelNeko).LuaManager).SetLuaOnDirectionChangeDelegate)(OnDirectionChange)
;
(((CS.PixelNeko).LuaManager).SetLuaOnNavMeshBuildFinishDelegate)(OnNavMeshBuildFinish)
;
(((CS.PixelNeko).LuaManager).SetLuaOnCollisionDelegate)(OnCollision)
;
((((CS.PixelNeko).UI).UIManager).SetLuaScreenPixelChangeDelegate)(ScreenPixelChange)
;
(LuaAudioManager.SetLuaAudioTable)()
;
(LuaAudioManager.SetGroundMaterialList)()
;
(LuaAudioManager.SetWalkAnimationClipNameList)()
;
((NekoData.BehaviorManager).BM_Login):SetGameOpenFromDeepLinkTag()
LogInfo("LuaMain", ((require("lsqlite3")).version)())
local ret = -1
ret = (threadsafepipe.open)("sqlite")
do
  if ret == 0 then
    local newLuaState = (((CS.PixelNeko).LuaManager).NewLuaState)("luasqlthread")
    threadId = (thread.newthread)(newLuaState, "errfunction", "update", p1, p2)
    LuaSqlProtocalManager:Init(p1, p2)
  end
  local EventPointManager = (((CS.PixelNeko).P1).EventPoint).EventPointManager
  ;
  (EventPointManager.TriggerEvent)(EventPointManager.Test_LuaInit, ((((CS.PixelNeko).P1).EventPoint).EventPointPlatform).UMeng)
end

