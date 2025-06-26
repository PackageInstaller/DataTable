-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/trapcontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local AudioManager = ((CS.PixelNeko).Audio).AudioManager
local TrapHelper = (((CS.PixelNeko).P1).Scene).TrapHelper
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local LightStaticFunctions = ((CS.PixelNeko).Lua).LightStaticFunctions
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local UIInteraction = require("logic.scene.interaction.uiinteraction")
local NPCManager = require("logic.scene.npcmanager")
local NpcObj = require("logic.manager.experimental.types.npcobj")
local Chest = require("logic.scene.types.chest")
local StaticEvent = require("logic.scene.luaevent.event.staticevent")
local BuffManager = require("logic.scene.buffmanager")
local Monster = require("logic.scene.types.monster")
local Context = require("logic.scene.luaevent.effect.context")
local CSceneRandomreward = (BeanManager.GetTableByName)("scene.cscenerandomreward")
local SceneInfoTable = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local CActorLight = (BeanManager.GetTableByName)("scene.cactorlight")
local CSceneLightConfig = (BeanManager.GetTableByName)("scene.cscenelightconfig")
local CSceneFloatObjsConfig = (BeanManager.GetTableByName)("scene.cscenefloatobjsconfig")
local CSceneFloatObjs = (BeanManager.GetTableByName)("scene.cscenefloatobjs")
local CTimerSceneConfig = (BeanManager.GetTableByName)("trap.ctimersceneconfig")
local CTrapSceneConfig = (BeanManager.GetTableByName)("trap.ctrapsceneconfig")
local TrapController = class("TrapController", SceneController)
TrapController.Init = function(self)
  -- function num : 0_0 , upvalues : TrapController, _ENV, Context, UIInteraction, NPCManager, SceneInfoTable, StateEventTriggerHelper
  ((TrapController.super).Init)(self)
  self._bornPosition = nil
  self._stepEffectAssetBundleName = (EffectUtil.GetAssetBundleNameAndAssetName)(1010)
  self._stepID = 0
  self._manaMiniMapIconIDList = {}
  self._enemies = {}
  self._triggeredEvents = {}
  self._time = 0
  self._idleTime = 0
  self._trapTimerTime = 0
  self._context = (Context.Create)()
  self:PlaySceneBGM()
  self._moveType = ((NekoData.BehaviorManager).BM_Game):GetMoveTypeMobileMode()
  if self._moveType == "clickMobileMode" then
    local dialog = (DialogManager.GetDialog)("dungeon.touchlayer")
    if dialog then
      (dialog:GetRootWindow()):SetActive(true)
    else
      ;
      (DialogManager.CreateSingletonDialog)("dungeon.touchlayer")
    end
  else
    do
      do
        local dialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
        if dialog then
          (dialog:GetRootWindow()):SetActive(true)
        else
          ;
          (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
        end
        if self:GetSceneID() ~= 30006 then
          (UIInteraction.CreateUIHUD)()
        end
        ;
        (NPCManager.CreateNpcUI)()
        self._agentActive = true
        self._enabled = true
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnEnterDungeon, Common.n_EnterDungeon, nil)
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnActorGridPosUpdate, Common.n_ActorMoved, nil)
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnMoveTypeChanged, Common.n_MoveTypeChange, nil)
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnEquipChanged, Common.n_EquipChanged, nil)
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnTeamHPIsLow, Common.n_TeamHPIsLow, nil)
        ;
        (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_0_0 , upvalues : self
    self:IsPlayingTimeLine(true)
  end
, Common.n_TimelineStart, nil)
        ;
        (LuaNotificationCenter.AddObserver)(self, function()
    -- function num : 0_0_1 , upvalues : self
    self:IsPlayingTimeLine(false)
  end
, Common.n_TimelineStop, nil)
        local record = SceneInfoTable:GetRecorder(self:GetSceneID())
        ;
        ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).LoadGroundFile)(record.mapAssetBundle, record.assetGround)
        ;
        (StateEventTriggerHelper.AddAllAnimationEventListener)(((self._sceneRef).actor).object, self.OnAnimationEvent, self)
        local assetBundleName, assetName = self:GetSceneXMLAssetBundleAndAssetName()
        ;
        ((NekoData.BehaviorManager).BM_MiniMap):Init(self:GetSceneID(), assetBundleName, assetName, true)
        self:SetActorLight()
        self:GetCloudInfo()
      end
    end
  end
end

TrapController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV, UIInteraction, NPCManager
  self._randomItemPos = {}
  self._manaMiniMapIconIDList = {}
  self:StopWalking()
  for _,v in pairs((self._sceneRef).timelineObjects) do
    v:Stop()
  end
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneDestroy, self, self:GetSceneID())
  ;
  (EventManager.ClearSceneEvents)()
  ;
  (TrapManager.UnInit)()
  ;
  (SwitchManager.DestroySwitch)()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (TriggerManager.OnSceneChange)()
  ;
  (RandomItemManager.DestroyRandomItems)()
  self:HideUI()
  ;
  (UIInteraction.ClearActButton)()
  ;
  (UIInteraction.DestroyUIHUD)()
  ;
  (NPCManager.DestroyNpcUI)()
  ;
  ((((CS.PixelNeko).Animation).AnimationHelper).ReleaseAnimationAssets)()
  ;
  ((NekoData.DataManager).DM_NPC):Clear()
  ;
  (UIInteraction.ClearInteractiveObj)()
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).ReleaseGroundFile)()
  for _,v in pairs((self._sceneRef).portals) do
    v:Destroy()
  end
  do
    if not self._chests then
      for _,v in pairs({}) do
        v:Destroy()
      end
      ;
      (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
      ;
      (DialogManager.DestroySingletonDialog)("dungeon.touchlayer")
      self._transactions = nil
      if self._buffManager then
        (self._buffManager):Destroy()
        self._buffManager = nil
      end
      for _,v in pairs(self._enemies) do
        v:Destroy()
      end
      self._enemies = {}
      local ChaseDelegates = (((CS.PixelNeko).P1).Scene).ChaseDelegates
      ;
      (ChaseDelegates.SetEnterDelegate)(nil)
      ;
      (ChaseDelegates.SetLeaveRadiusDelegate)(nil)
      ;
      (ChaseDelegates.SetLeaveAreaDelegate)(nil)
      ;
      ((NekoData.BehaviorManager).BM_MiniMap):OnDestroy()
      ;
      (self._context):Destroy()
    end
  end
end

TrapController.SetActorLight = function(self)
  -- function num : 0_2 , upvalues : CSceneLightConfig, _ENV, CActorLight, LightStaticFunctions
  local sceneLightConfig = CSceneLightConfig:GetRecorder(self:GetSceneID())
  if sceneLightConfig == nil then
    return 
  end
  local lightGO = ((self._sceneRef).actor).light
  if lightGO == nil then
    return 
  end
  if sceneLightConfig.playerLight == 1 then
    if (SceneManager.IsInDay)() then
      lightGO:SetActive(false)
    else
      lightGO:SetActive(true)
      local actorLightRecord = CActorLight:GetRecorder(self:GetSceneID())
      if actorLightRecord then
        local light = (LightStaticFunctions.GetLight)(((self._sceneRef).actor).light)
        ;
        (LightStaticFunctions.SetColor)(light, actorLightRecord.colorR, actorLightRecord.colorG, actorLightRecord.colorB)
        ;
        (LightStaticFunctions.SetRange)(light, actorLightRecord.range)
        ;
        (LightStaticFunctions.SetIntensity)(light, actorLightRecord.intensity)
      end
    end
  end
end

TrapController.PlaySceneBGM = function(self)
  -- function num : 0_3 , upvalues : SceneInfoTable, _ENV
  local v = SceneInfoTable:GetRecorder(self:GetSceneID())
  if self._isDay or v.bgmNight == 0 then
    (LuaAudioManager.PlayBGM)(v.bgm)
  else
    ;
    (LuaAudioManager.PlayBGM)(v.bgmNight)
  end
end

TrapController.OnSceneRootGameObjectActiveChange = function(self, active)
  -- function num : 0_4
  if active then
    self._agentActive = true
    self:ShowUI()
  else
    self._agentActive = false
    self:HideUI()
  end
end

TrapController.OnNavMeshBuildFinish = function(self)
  -- function num : 0_5 , upvalues : _ENV, TrapController, BuffManager, StaticEvent, NPCManager, CTimerSceneConfig
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerMove, Common.n_RockerMove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  self._randomItemPos = {}
  ;
  ((TrapController.super).OnNavMeshBuildFinish)(self)
  self._buffManager = (BuffManager.Create)()
  if not self:GetData("buff") then
    (self._buffManager):Init(self:GetSceneID(), {})
    self:SetBornPosition()
    self:AddTrap()
    self:AddPortals()
    if not self:GetData("randomItems") then
      self:AddRandomItems({})
      if not self:GetData("npcObjects") then
        local npcList = {}
      end
      self:AddNPC(npcList)
      self:SetData("npcObjects", nil)
      self._trapStates = self:GetData("trapStates")
      local info = self:GetData("enemies")
      if info then
        self:InitEnemies(info)
      end
      info = self:GetData("modules")
      if info then
        self:InitModules(info)
        self:InitModuleIcon()
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnModuleProceed, Common.n_StoryBattleProceed, nil)
      end
      self:RestoreSceneObjects()
      self:InitChests(self:GetData("chests"))
      local dialog = (DialogManager.GetDialog)("dungeon.dungeonhud")
      if dialog then
        dialog:OnOpenOneChestYeah()
      end
      local lastinfo = self:GetData("lastBattleInfo")
      local currinfo = ((NekoData.BehaviorManager).BM_SEnterDungeon):GetCurBattleInfo()
      if lastinfo and lastinfo.battleid > 0 and (not currinfo or currinfo.battleid == 0) then
        local battleid = (((BeanManager.GetTableByName)("dungeonbattle.cdungeonbattleconfig")):GetRecorder(lastinfo.battleid)).BattleID
        ;
        (TriggerManager.OnBattleRewardEnd)(nil, {
userInfo = {battleId = battleid, battleResult = lastinfo.battleResult}
})
        local req = (LuaNetManager.CreateProtocol)("protocol.battle.cbattleendaction")
        req.battleid = lastinfo.battleid
        req:Send()
      end
      do
        self:AddMapIcon()
        self:SetManaMiniMapIconInOrOutFog()
        if self._moveType == "clickMobileMode" then
          self:SetActorRunning(true)
        end
        local striggleEventIdList = ((NekoData.BehaviorManager).BM_SEnterDungeon):GetSTriggleEventId()
        for _,id in ipairs(striggleEventIdList) do
          local event = (EventManager.RemoveByConfigID)(id)
          if event then
            event:Fire()
            if event:IsRepeateEvent() then
              (EventManager.AddEvent)((StaticEvent.CreateFromConfig)(event:GetConfigID()))
            end
          end
        end
        local root = (EffectFactory.CreateComposedEffect)()
        if self._trapStates then
          local list = (EffectFactory.CreateEffectList)()
          if not (self._trapStates).switches then
            list:AddEffect((SwitchManager.RestoreState)({}))
            if not (self._trapStates).traps then
              do
                list:AddEffect((TrapManager.RestoreState)({}))
                root:AddEffect(list)
                self._hintEvents = {}
                root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_5_0 , upvalues : self
    if not (self._trapStates).switches then
      self:RestoreSwitchHints({})
      self:RestoreChestHint(self:GetData("chests"))
      self:AddRangeHint()
    end
  end
))
                local reconnect = (((NekoData.BehaviorManager).BM_SEnterDungeon):GetRestoreEffectInfo())
                local reconnect_id = nil
                if reconnect.id and reconnect.type == 1 then
                  reconnect_id = reconnect.id
                end
                root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_5_1 , upvalues : self, reconnect_id
    self:LoadEvents(self:GetData("sceneStates"), reconnect_id)
  end
))
                root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_5_2 , upvalues : self, _ENV
    if self._transactions and (self._transactions).req then
      for _,v in pairs((self._transactions).req) do
        ((NekoData.BehaviorManager).BM_Dungeon):BeginTransaction(v.eventid, v.type)
      end
    end
  end
))
                root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_5_3 , upvalues : self
    self:RecoverTransaction()
    self._transactions = {}
  end
))
                if reconnect.id then
                  local effect = (EffectFactory.CreateComposedEffect)()
                  if reconnect.type == 1 then
                    effect:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_5_4 , upvalues : _ENV, reconnect, StaticEvent
    local event = (EventManager.RemoveByConfigID)(reconnect.id)
    print(reconnect.id, event, (debug.traceback)())
    if event then
      event:Fire()
      if event:IsRepeateEvent() then
        event:AddEffect((EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_5_4_0 , upvalues : _ENV, reconnect, StaticEvent, event
      (EventManager.RemoveByConfigID)(reconnect.id)
      ;
      (EventManager.AddEvent)((StaticEvent.CreateFromConfig)(event:GetConfigID()))
    end
))
      end
    end
  end
))
                  else
                    if reconnect.type == 2 then
                      local recorder = ((BeanManager.GetTableByName)("npc.cnpc")):GetRecorder(reconnect.id)
                      effect:AddEffect((NPCManager.BuildNPCInteractiveEffect)(recorder.effect_id))
                    else
                      do
                        if reconnect.type == 3 then
                          effect:AddEffect((StaticEvent.CreateInteractiveEffect)(reconnect.id))
                          local object = ((self:GetPathResolver()):GetSceneObject(reconnect.id)):GetObj()
                          effect:Bind(object)
                        end
                        do
                          do
                            if reconnect.type > 1 and effect then
                              effect:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_5_5 , upvalues : _ENV, reconnect
    ((NekoData.BehaviorManager).BM_Dungeon):CommitTransaction(reconnect.id, reconnect.type)
  end
))
                            end
                            if effect then
                              root:AddEffect(effect)
                            end
                            root:Run()
                            local record = CTimerSceneConfig:GetRecorder((self._sceneRef):GetSceneID())
                            if record then
                              self._trapCheckTime = record.time
                              self._trapTimerTime = 0
                            else
                              self._trapCheckTime = nil
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

TrapController.RestoreSwitchHints = function(self, states)
  -- function num : 0_6 , upvalues : _ENV
  local events = (SwitchManager.BuildHintEvent)(states)
  ;
  (table.insertto)(self._hintEvents, events)
  for _,v in pairs(events) do
    (EventManager.AddEvent)(v)
  end
end

TrapController.RestoreChestHint = function(self, states)
  -- function num : 0_7 , upvalues : _ENV
  for _,v in pairs(self._chests) do
    if not states[v:GetID()] then
      local area = v:GetHintRange()
      if area then
        local event = ((EventManager.Builder).BuildHintEvent)(area, 2, true, 2)
        -- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

        ;
        (self._hintEvents)[#self._hintEvents + 1] = event
        ;
        (EventManager.AddEvent)(event)
      end
    end
  end
end

TrapController.AddRangeHint = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local info = {}
  local cscenerolechatlist = (BeanManager.GetTableByName)("dialog.cscenerolechatlist")
  for _,i in pairs(cscenerolechatlist:GetAllIds()) do
    local recorder = cscenerolechatlist:GetRecorder(i)
    if recorder.Sceneid == self:GetSceneID() then
      if not info[recorder.Dialogid] then
        do
          info[recorder.Dialogid] = (string.split)(recorder.Zone, ",")
          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for i,v in pairs(info) do
    local event = ((EventManager.Builder).BuildHintEvent)({x = tonumber(v[1]), y = tonumber(v[2]), w = tonumber(v[3]), h = tonumber(v[4])}, i, false, 3)
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._hintEvents)[#self._hintEvents + 1] = event
    ;
    (EventManager.AddEvent)(event)
  end
end

TrapController.RestoreSceneObjects = function(self)
  -- function num : 0_9 , upvalues : _ENV, StaticEvent, UIInteraction
  if not self:GetData("interactive") then
    for _,v in pairs({}) do
      for _,object in pairs((self._sceneRef).statefulsceneobjects) do
        if v.id == object:GetID() then
          (object:ToState(v.state - 1)):Run()
          break
        end
      end
    end
    do
      if not self:GetData("disabled") then
        for _,i in pairs({}) do
          for _,obj in ipairs((self._sceneRef).sceneobjects) do
            if (obj.object):GetInteractiveId() == i then
              local effect = (StaticEvent.CreateInteractiveEffect)((obj.object):GetInteractiveId())
              effect:SetParam("runoninit", true)
              effect:Bind((obj.object):GetObj())
              effect:Run({init = true})
              ;
              (obj.object):SetState(1)
              if not (obj.object):IsRepeat() then
                (UIInteraction.RemoveSceneInteractiveObj)(i)
              end
            end
          end
        end
      end
    end
  end
end

TrapController.SetBornPosition = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local pos = self:GetData("bornPosition")
  if pos then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).FlyTo)(((self._sceneRef).actor).object, pos.x, pos.y)
    ;
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetActorOrientation)(((self._sceneRef).actor).object, pos.dir)
    self:SetData("bornPosition", nil)
  end
end

TrapController.IsActive = function(self)
  -- function num : 0_11
  return self._enabled
end

TrapController.RecoverTransaction = function(self)
  -- function num : 0_12 , upvalues : _ENV
  if not (self._transactions).res then
    for _,v in pairs({}) do
      (LuaNotificationCenter.PostNotification)(Common.n_DungeonTransactionStart, nil, v)
    end
  end
end

TrapController.OnDisable = function(self)
  -- function num : 0_13 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_RockerMove)
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_RockerEnd)
  self._enabled = false
  self._enableEvent = (EventManager.CreateEvent)()
  local trigger = (TriggerManager.CreateTrigger)("battleend", (self._enableEvent):GetID())
  ;
  (self._enableEvent):AddTrigger(trigger:GetType(), trigger)
  ;
  (self._enableEvent):AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_13_0 , upvalues : self
    self:RecoverTransaction()
  end
))
  ;
  (EventManager.AddEvent)(self._enableEvent)
  self._transactions = {}
  if self._buffManager then
    (self._buffManager):OnDisable()
  end
end

local fire_event = function(eventid)
  -- function num : 0_14 , upvalues : _ENV
  local event = (EventManager.FindByConfigID)(eventid)
  if not event then
    return 
  end
  if not event:IsRepeateEvent() then
    (EventManager.RemoveByConfigID)(eventid)
  end
  event:Fire()
end

TrapController.OnEnable = function(self)
  -- function num : 0_15 , upvalues : _ENV, StaticEvent, fire_event
  self._enabled = true
  if not self:IsNavMeshReady() then
    return 
  end
  for _,obj in ipairs((self._sceneRef).sceneobjects) do
    if (obj.object):GetState() == 1 then
      local effect = (StaticEvent.CreateInteractiveEffect)((obj.object):GetInteractiveId())
      for _,v in ipairs(effect) do
        v:SetParam("runoninit", true)
        v:Bind((obj.object):GetObj())
        v:Run({init = true})
      end
    end
  end
  for _,v in ipairs(self._triggeredEvents) do
    fire_event(v)
  end
  self._triggeredEvents = {}
  if not self._removedNpcs then
    for _,n in ipairs({}) do
      local result = ((NekoData.DataManager).DM_NPC):DeleteNpcInstanceWithId(n.id)
      if not result then
        LogWarning("snpcdisappear", "there is no npc with id " .. n.id .. " in this scene " .. self._id)
      end
    end
    self._removedNpcs = {}
    if not self:GetData("npcObjects") then
      local npcList = {}
    end
    self:AddNPC(npcList)
    self:SetData("npcObjects", nil)
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnRockerMove, Common.n_RockerMove, nil)
    ;
    (LuaNotificationCenter.AddObserver)(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  end
end

TrapController.OnSTriggleSuccess = function(self, eventid)
  -- function num : 0_16 , upvalues : fire_event
  if self._enabled then
    fire_event(eventid)
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._triggeredEvents)[#self._triggeredEvents + 1] = eventid
  end
end

TrapController.OnSNpcDisappear = function(self, npcs)
  -- function num : 0_17 , upvalues : _ENV
  if not self._removedNpcs then
    self._removedNpcs = {}
    for _,n in ipairs(npcs) do
      -- DECOMPILER ERROR at PC13: Confused about usage of register: R7 in 'UnsetPending'

      (self._removedNpcs)[#self._removedNpcs + 1] = n
    end
  end
end

TrapController.OnTransaction = function(self, value, kind)
  -- function num : 0_18 , upvalues : _ENV
  if not (self._transactions).res then
    (LuaNotificationCenter.PostNotification)(Common.n_DungeonTransactionStart, nil, {id = value, type = kind})
  else
    ;
    (table.insert)((self._transactions).res, {id = value, type = kind})
  end
end

TrapController.HideUI = function(self)
  -- function num : 0_19 , upvalues : NPCManager, UIInteraction, _ENV
  (NPCManager.HideNpcUI)()
  ;
  (UIInteraction.HideInteractiveUI)()
  ;
  (UIInteraction.HideUIHUD)()
  local dialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
  dialog = (DialogManager.GetDialog)("dungeon.touchlayer")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
end

TrapController.ShowUI = function(self)
  -- function num : 0_20 , upvalues : NPCManager, UIInteraction
  (NPCManager.ShowNpcUI)()
  self:OnMoveTypeChanged()
  ;
  (UIInteraction.ShowUIHUD)()
  ;
  (UIInteraction.ShowInteractiveUI)()
end

TrapController.OnEquipChanged = function(self, notification)
  -- function num : 0_21
  self:SetManaMiniMapIconInOrOutFog()
end

TrapController.StopWalking = function(self)
  -- function num : 0_22 , upvalues : _ENV
  if self._enabled then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).StopWalking)(((self._sceneRef).actor).object)
  end
end

TrapController.MoveTowards = function(self, x, y, offset)
  -- function num : 0_23 , upvalues : _ENV
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveTowards)(((self._sceneRef).actor).object, x, y, (math.min)(self._maxOffset or 1, offset))
end

TrapController.OnMouseButtonDown = function(self, x, y)
  -- function num : 0_24 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveToScreenPos)(((self._sceneRef).actor).object, x, y)
  ;
  (((self._sceneRef).actor).animator):Play("Blend Tree")
end

TrapController.OnRockerMove = function(self, notification)
  -- function num : 0_25
  local axisVector = (notification.userInfo).axisVector
  if (notification.userInfo).axisOffset > 0.01 then
    self:MoveTowards(axisVector.x, axisVector.y, (notification.userInfo).axisOffset)
  end
  ;
  (((self._sceneRef).actor).animator):Play("Blend Tree")
end

TrapController.OnEnterDungeon = function(self)
  -- function num : 0_26
  if self:IsNavMeshReady() then
    self:StopWalking()
  end
end

TrapController.OnRockerEnd = function(self, notification)
  -- function num : 0_27
  self:StopWalking()
end

TrapController.LoadEvents = function(self, info, reconnect)
  -- function num : 0_28 , upvalues : _ENV
  if not self._transactions then
    self._transactions = {
req = {}
, 
res = {}
}
    ;
    (EventManager.LoadSceneEvents)((self._sceneRef):GetSceneID(), info, reconnect)
    local recorder = (BeanManager.GetTableByName)("event.ceventconfig")
    for _,i in pairs(recorder:GetAllIds()) do
      local record = recorder:GetRecorder(i)
      if record.scene == self:GetSceneID() and record.isShowMinimapIcon == 1 then
        local event = (EventManager.FindByConfigID)(i)
        if event then
          local pos = event:GetMinimapPosition()
          do
            assert(pos, "no pos config found for event " .. i)
            local id = ((NekoData.BehaviorManager).BM_MiniMap):AddObject(event:GetMinimapIcon(), pos.y, pos.x, true)
            event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_28_0 , upvalues : _ENV, id
    ((NekoData.BehaviorManager).BM_MiniMap):RemoveObject(id)
  end
))
          end
        end
      end
    end
  end
end

TrapController.InitModules = function(self, info)
  -- function num : 0_29 , upvalues : _ENV
  if not self._modules then
    self._modules = {}
    local recorder = (BeanManager.GetTableByName)("event.ceventbattleconfig")
    local StoryBattle = require("logic.scene.luaevent.templates.storybattle")
    for _,i in pairs(recorder:GetAllIds()) do
      local record = recorder:GetRecorder(i)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

      if tonumber(record.scene) == self:GetSceneID() then
        (self._modules)[i] = (StoryBattle.Create)(i)
        ;
        ((self._modules)[i]):Init(info[i] or 0)
      end
    end
  end
end

TrapController.LoadModules = function(self, info)
  -- function num : 0_30 , upvalues : _ENV
  for k,v in pairs(info) do
    if k ~= 0 then
      ((self._modules)[k]):Load(v)
    end
  end
end

TrapController.InitModuleIcon = function(self)
  -- function num : 0_31 , upvalues : _ENV
  if not self._moduleIcons then
    self._moduleIcons = {}
    for id,module in pairs(self._modules) do
      if module:ShowInMinimap() then
        local pos = module:GetMinimapPosition()
        -- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (self._moduleIcons)[id] = ((NekoData.BehaviorManager).BM_MiniMap):AddObject(module:GetMinimapIcon(), pos.y, pos.x, true)
      end
    end
  end
end

TrapController.OnModuleProceed = function(self, notification)
  -- function num : 0_32 , upvalues : _ENV
  local id = notification.userInfo
  local module = (self._modules)[id]
  if module and not module:ShowInMinimap() then
    ((NekoData.BehaviorManager).BM_MiniMap):RemoveObject((self._moduleIcons)[id])
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._moduleIcons)[id] = nil
  end
end

TrapController.AddTrap = function(self)
  -- function num : 0_33 , upvalues : _ENV
  (TrapManager.OnSceneLoaded)(self:GetSceneID())
  ;
  (SwitchManager.OnSceneLoaded)(self:GetSceneID())
  local recorder = (BeanManager.GetTableByName)("trap.ctrapsceneconfig")
  local traps = require("data.dungeondata.trap.cswitchconfig")
  local combinations = {}
  local promptConditions = {}
  for _,i in ipairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.sceneid == self:GetSceneID() then
      do
        for _,v in pairs((traps[i])()) do
          combinations[#combinations + 1] = v
          promptConditions[#promptConditions + 1] = {promptCondition = record.promptCondition, priority = record.priority, promptEffect = record.promptEffect}
        end
      end
    end
  end
  local ctrapiconconfig = (BeanManager.GetTableByName)("trap.ctrapiconconfig")
  for _,v in pairs(combinations) do
    local switch = (SwitchManager.GetSwitch)(v:GetInstanceID(), v:GetID())
    if switch and switch:GetPath() ~= "-1" then
      local record = ctrapiconconfig:GetRecorder(switch:GetType())
      if record.display == 1 then
        local x, y, z = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetPosition)(v:GetObject())
        print("add switch to minimap", z / -0.56, x / 0.4, x, z)
        ;
        ((NekoData.BehaviorManager).BM_MiniMap):AddObject(record.imageId, (math.floor)(z / -0.56 + 0.5), (math.floor)(x / 0.4 + 0.5))
      end
    end
  end
  local TrapConditionTriggers = require("data.dungeondata.trap.ctrapconditionconfig")
  local TrapConditionEffects = require("data.dungeondata.trap.ctrapconditioneffectconfig")
  for index,v in pairs(promptConditions) do
    local event = (EventManager.CreateEvent)(true)
    if TrapConditionTriggers[v.promptCondition] then
      local trigger = (TrapConditionTriggers[v.promptCondition])(event:GetID())
      event:AddTrigger("trapopen", trigger)
      local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_33_0 , upvalues : _ENV, TrapConditionEffects, v
    local dialog = (DialogManager.GetDialog)("dungeon.dungeonhud")
    if dialog then
      dialog:ShowAndSetHelpBtn((TrapConditionEffects[v.promptEffect])())
    end
  end
)
      event:AddEffect(effect)
      ;
      (EventManager.AddEvent)(event)
    end
  end
end

TrapController.GetTraps = function(self)
  -- function num : 0_34
  return (self._sceneRef).trap
end

TrapController.GetSwitches = function(self)
  -- function num : 0_35
  return (self._sceneRef).switch
end

TrapController.GetSceneObjects = function(self)
  -- function num : 0_36
  return (self._sceneRef).sceneobjects
end

TrapController.GetObjects = function(self)
  -- function num : 0_37
  return (self._sceneRef).objects
end

TrapController.OnTrapDamage = function(self)
  -- function num : 0_38 , upvalues : _ENV
  ((((CS.PixelNeko).Animation).AnimationHelper).PlayAnimation)(((self._sceneRef).actor).object, "Map_Attacked")
end

TrapController.AddPortals = function(self)
  -- function num : 0_39 , upvalues : _ENV
  for _,v in pairs((self._sceneRef).portals) do
    v:Init()
  end
  for _,v in pairs((self._sceneRef).portals) do
    v:Activate()
  end
end

TrapController.GetPortals = function(self)
  -- function num : 0_40
  return (self._sceneRef).portals
end

TrapController.GetPortal = function(self, id)
  -- function num : 0_41 , upvalues : _ENV
  for _,v in pairs((self._sceneRef).portals) do
    if v:GetID() == id then
      return v
    end
  end
end

TrapController.RemovePortal = function(self, id)
  -- function num : 0_42 , upvalues : _ENV
  for k,v in pairs((self._sceneRef).portals) do
    v:Destroy()
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._sceneRef).portals)[k] = nil
  end
end

local add_patrol_points = function(object, battlecfg)
  -- function num : 0_43 , upvalues : _ENV, TrapHelper
  local cmonstermoveroute = (BeanManager.GetTableByName)("dungeonbattle.cmonstermoveroute")
  local xs = {}
  local ys = {}
  local speed = {}
  local wait = {}
  local initial = (string.split)(battlecfg.Situation, ",")
  for _,lineid in ipairs((string.split)(battlecfg.Lineid, ",")) do
    local id = tonumber(lineid)
    if id ~= 0 then
      local record = cmonstermoveroute:GetRecorder(id)
      for i,pt in ipairs(record.RouteID) do
        local ns = (string.split)(pt, ",")
        xs[#xs + 1] = tonumber(ns[1])
        ys[#ys + 1] = tonumber(ns[2])
        speed[#speed + 1] = tonumber((record.speed)[i])
        wait[#wait + 1] = (record.time)[i] / 1000
      end
      xs[#xs + 1] = tonumber(initial[1])
      ys[#ys + 1] = tonumber(initial[2])
      speed[#speed + 1] = tonumber(record.return_speed)
      wait[#wait + 1] = record.return_time / 1000
    end
  end
  if #xs ~= 0 then
    (TrapHelper.AddPatrolPoints)(object, xs, ys, speed, wait)
    ;
    (TrapHelper.StartPatrol)(object)
  end
end

TrapController.InitEnemies = function(self, info, no_check_scene, callback)
  -- function num : 0_44 , upvalues : _ENV, Monster
  self._enemies = {}
  self._enemypos = {}
  local cdungeonbattleconfig = (BeanManager.GetTableByName)("dungeonbattle.cdungeonbattleconfig")
  for i,v in pairs(info) do
    local battlecfg = cdungeonbattleconfig:GetRecorder(v.id)
    assert(battlecfg.Isimportant ~= 0 or (battlecfg.Sceneid ~= self:GetSceneID() and no_check_scene), v.id .. " scene config wrong")
    local monster = (Monster.Create)(v.id)
    monster:BuildObject({x = v.x, y = v.z}, (self._sceneRef):GetRootGameObject())
    monster:Activate()
    monster:SetTarget(((self._sceneRef).actor).object)
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self._enemies)[v.id] = monster
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R12 in 'UnsetPending'

    ;
    (self._enemypos)[v.id] = {}
  end
  local ChaseDelegates = (((CS.PixelNeko).P1).Scene).ChaseDelegates
  ;
  (ChaseDelegates.SetEnterDelegate)(function(id)
    -- function num : 0_44_0 , upvalues : self
    self:OnEnterChaseRadius(id)
  end
)
  ;
  (ChaseDelegates.SetLeaveRadiusDelegate)(function(id)
    -- function num : 0_44_1 , upvalues : self
    self:OnLeaveChaseRadius(id)
  end
)
  ;
  (ChaseDelegates.SetLeaveAreaDelegate)(function(id)
    -- function num : 0_44_2 , upvalues : self
    self:OnLeaveChaseArea(id)
  end
)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

TrapController.InitChests = function(self, state)
  -- function num : 0_45 , upvalues : _ENV, TrapHelper, Chest
  self._chests = {}
  local recorder = (BeanManager.GetTableByName)("sceneinteractive.cboxconfig")
  for _,i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.SceneID == self:GetSceneID() then
      local pos = (string.split)(record.position, ",")
      local x = tonumber(pos[1]) * 0.4
      local y = tonumber(pos[2]) * -0.56
      local object = (TrapHelper.CreateObject)(record.assetBundle, record.assetName, x, 0, y, (self._sceneRef):GetRootGameObject())
      local chest = (Chest.Create)(i, object)
      if state[i] then
        chest:RestoreState()
      else
        chest:Activate()
      end
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R14 in 'UnsetPending'

      ;
      (self._chests)[#self._chests + 1] = chest
    end
  end
end

TrapController.GetCameraFollowPoint = function(self)
  -- function num : 0_46
  return ((self._sceneRef).actor).camerafollow
end

TrapController.OnAnimationEvent = function(self, floatValue, intValue, stringValue, obj, clipName)
  -- function num : 0_47 , upvalues : AudioManager, _ENV, PrefabLoader, TransformStaticFunctions
  -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

  if stringValue == "GroundType" and (AudioManager.GetSoundNumPlayWithCollider)(((self._sceneRef).actor).object) == 0 then
    local x, y = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
    local selector = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetGroundMaterial)(x, y)
    ;
    (AudioManager.PlayAudioWithSelector)(stringValue, selector, intValue)
    if selector == "snow" then
      if self._stepID == 0 then
        self._stepID = 1
        local stepEffectLeft = (PrefabLoader.LoadAndInstantiatePrefab)(self._stepEffectAssetBundleName, self._stepEffectAssetName)
        ;
        (TransformStaticFunctions.SetParent)(stepEffectLeft.transform, ((self._sceneRef):GetRootGameObject()).transform, false)
        ;
        (TransformStaticFunctions.SetPosition)(stepEffectLeft, (TransformStaticFunctions.GetPosition)(((self._sceneRef).actor).leftStep))
        ;
        (TransformStaticFunctions.SetWorldEuler)(stepEffectLeft, (TransformStaticFunctions.GetWorldEuler)(((self._sceneRef).actor).leftStep))
      else
        do
          self._stepID = 0
          do
            local stepEffectRight = (PrefabLoader.LoadAndInstantiatePrefab)(self._stepEffectAssetBundleName, self._stepEffectAssetName)
            ;
            (TransformStaticFunctions.SetParent)(stepEffectRight.transform, ((self._sceneRef):GetRootGameObject()).transform, false)
            ;
            (TransformStaticFunctions.SetPosition)(stepEffectRight, (TransformStaticFunctions.GetPosition)(((self._sceneRef).actor).rightStep))
            ;
            (TransformStaticFunctions.SetWorldEuler)(stepEffectRight, (TransformStaticFunctions.GetWorldEuler)(((self._sceneRef).actor).rightStep))
            if stringValue == "GroundTypeOnlyStep" and (AudioManager.GetSoundNumPlayWithCollider)(((self._sceneRef).actor).object) == 0 then
              local x, y = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
              local selector = ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).GetGroundMaterial)(x, y)
              if selector == "snow" then
                if self._stepID == 0 then
                  self._stepID = 1
                  local stepEffectLeft = (PrefabLoader.LoadAndInstantiatePrefab)(self._stepEffectAssetBundleName, self._stepEffectAssetName)
                  ;
                  (TransformStaticFunctions.SetParent)(stepEffectLeft.transform, ((self._sceneRef):GetRootGameObject()).transform, false)
                  ;
                  (TransformStaticFunctions.SetPosition)(stepEffectLeft, (TransformStaticFunctions.GetPosition)(((self._sceneRef).actor).leftStep))
                  ;
                  (TransformStaticFunctions.SetWorldEuler)(stepEffectLeft, (TransformStaticFunctions.GetWorldEuler)(((self._sceneRef).actor).leftStep))
                else
                  do
                    self._stepID = 0
                    local stepEffectRight = (PrefabLoader.LoadAndInstantiatePrefab)(self._stepEffectAssetBundleName, self._stepEffectAssetName)
                    ;
                    (TransformStaticFunctions.SetParent)(stepEffectRight.transform, ((self._sceneRef):GetRootGameObject()).transform, false)
                    ;
                    (TransformStaticFunctions.SetPosition)(stepEffectRight, (TransformStaticFunctions.GetPosition)(((self._sceneRef).actor).rightStep))
                    ;
                    (TransformStaticFunctions.SetWorldEuler)(stepEffectRight, (TransformStaticFunctions.GetWorldEuler)(((self._sceneRef).actor).rightStep))
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

local RandomPosFunction = function(self, rx, ry, x, z)
  -- function num : 0_48 , upvalues : _ENV
  if ((self._randomItemPos)[x])[z] then
    local flag = true
    while flag do
      rx = (math.random)()
      ry = (math.random)()
      flag = false
      for _,rr in pairs(((self._randomItemPos)[x])[z]) do
        if rr.x == rx and rr.z == ry then
          flag = true
          break
        end
      end
    end
    do
      do
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z] + 1] = {x = rx, z = ry}
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((self._randomItemPos)[x])[z] = {}
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (((self._randomItemPos)[x])[z])[1] = {x = rx, z = ry}
        local gx, gy = nil, nil
        if ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).x > 0.5 then
          gx = x - ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).x + 0.5
          if ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).z > 0.5 then
            gy = z - ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).z + 0.5
          else
            gy = z + ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).z
          end
        else
          gx = x + ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).x
          if ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).z > 0.5 then
            gy = z - ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).z + 0.5
          else
            gy = z + ((((self._randomItemPos)[x])[z])[#((self._randomItemPos)[x])[z]]).z
          end
        end
        return gx, gy
      end
    end
  end
end

TrapController.AddRandomItems = function(self, items)
  -- function num : 0_49 , upvalues : _ENV, CSceneRandomreward, RandomPosFunction
  for _,v in pairs(items) do
    local cfg = CSceneRandomreward:GetRecorder(v.id)
    local type = cfg.type
    if type ~= (RandomItemManager.Type).Mana or v.status ~= 1 then
      if type == (RandomItemManager.Type).RecoverShrine or type == (RandomItemManager.Type).ManaCollector then
        ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).AddBlockingPoint)((self._sceneRef).builder, v.x, v.z, tonumber(cfg.crashCubeWidth), tonumber(cfg.crashCubeHeight))
      end
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

      if not (self._randomItemPos)[v.x] then
        (self._randomItemPos)[v.x] = {}
        local rx, ry = 0, 0
        local gx, gy = RandomPosFunction(self, rx, ry, v.x, v.z)
        local record = CSceneRandomreward:GetRecorder(v.id)
        local object = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateObject)(record.assetBundle, record.assetName, gx * 0.4, 0, gy * -0.56, (self._sceneRef):GetRootGameObject())
        do
          local item = (RandomItemManager.CreateRandomItem)(v, self._context)
          if item then
            item:Bind(object)
            item:Activate()
          end
          -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

TrapController.AddRandomItemsRandomly = function(self, items, parentX, parentY)
  -- function num : 0_50 , upvalues : _ENV, CSceneRandomreward, RandomPosFunction
  local keys = {}
  for _,v in pairs(items) do
    local cfg = CSceneRandomreward:GetRecorder(v.id)
    local type = cfg.type
    if type == (RandomItemManager.Type).RecoverShrine or type == (RandomItemManager.Type).ManaCollector then
      ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).AddBlockingPoint)((self._sceneRef).builder, v.x, v.z, tonumber(cfg.crashCubeWidth), tonumber(cfg.crashCubeHeight))
    end
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R12 in 'UnsetPending'

    if not (self._randomItemPos)[v.x] then
      (self._randomItemPos)[v.x] = {}
      local rx = (math.random)()
      local ry = (math.random)()
      local gx, gy = RandomPosFunction(self, rx, ry, v.x, v.z)
      local record = (CSceneRandomreward:GetRecorder(v.id))
      local object = nil
      if type == (RandomItemManager.Type).Mana then
        if parentX and parentY then
          object = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateObject)(record.assetBundle, record.assetName, parentX * 0.4, 0, parentY * -0.56, (self._sceneRef):GetRootGameObject())
          local manaMoveEffect = (EffectFactory.CreateMoveToWorldPosEffect)(nil, 1.5, gx * 0.4, 0, gy * -0.56, false)
          manaMoveEffect:Bind(object)
          manaMoveEffect:Run()
        else
          do
            object = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateObject)(record.assetBundle, record.assetName, gx * 0.4, 0, gy * -0.56, (self._sceneRef):GetRootGameObject())
            do
              local rItem = (RandomItemManager.CreateRandomItem)(v)
              if rItem then
                rItem:Bind(object)
                keys[#keys + 1] = rItem:GetKey()
              end
              object = (((((CS.PixelNeko).P1).Scene).TrapHelper).CreateObject)(record.assetBundle, record.assetName, gx * 0.4, 0, gy * -0.56, (self._sceneRef):GetRootGameObject())
              do
                local rItem = (RandomItemManager.CreateRandomItem)(v)
                if rItem then
                  rItem:Bind(object)
                  rItem:Activate(gx * 0.4, gy * -0.56)
                end
                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC163: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  if #keys ~= 0 then
    ((NekoData.BehaviorManager).BM_Dungeon):OnManaPick(keys)
  end
end

TrapController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_51 , upvalues : _ENV
  if not self:IsNavMeshReady() then
    return 
  end
  ;
  ((NekoData.BehaviorManager).BM_MiniMap):OnUpdate(deltaTime, unscaleDeltaTime)
  for i,v in pairs(self._enemies) do
    if v:CanPatrol() or v:CanChase() then
      local x, y = v:GetGridPos()
      if ((self._enemypos)[i]).x ~= x or ((self._enemypos)[i]).y ~= y then
        ((NekoData.BehaviorManager).BM_MiniMap):MoveObject(v:GetMinimapID(), y, x)
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R10 in 'UnsetPending'

        ;
        ((self._enemypos)[i]).x = x
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R10 in 'UnsetPending'

        ;
        ((self._enemypos)[i]).y = y
      end
    end
  end
  if self._cloudRecord then
    self:UpdateCloud(deltaTime)
  end
  local witchSkin = (((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(1)):GetDefaultFashion()
  if witchSkin == 900111 then
    self:SetGlassAnimator(deltaTime)
  end
  if self._buffManager then
    (self._buffManager):OnUpdate(deltaTime)
  end
  if self._trapCheckTime then
    self:TrapTimer(deltaTime)
  end
end

TrapController.OnActorGridPosUpdate = function(self)
  -- function num : 0_52 , upvalues : _ENV, TrapHelper
  local x, y = ((NekoData.BehaviorManager).BM_Dungeon):GetActorGridPosition()
  local prevx, prevy = ((NekoData.BehaviorManager).BM_Dungeon):GetActorPrevGridPos()
  if x ~= prevx or y ~= prevy then
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.crolemove")
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (req.position).x = x
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (req.position).y = y
    req.sceneid = self:GetSceneID()
    req:Send()
    LogInfoFormat("dungeon", "actor move to (%s, %s)", x, y)
    local enemies = {}
    local ids = {}
    for i,v in pairs(self._enemies) do
      if v:CanPatrol() or v:CanChase() then
        enemies[#enemies + 1] = v:GetObject()
        ids[#ids + 1] = i
      end
    end
    if #ids ~= 0 then
      req = (LuaNetManager.CreateProtocol)("protocol.battle.cmonstermove")
      local xs, ys = (TrapHelper.CurrentPatrolPositions)(enemies)
      for i,id in ipairs(ids) do
        local pt = (LuaNetManager.CreateBean)("protocol.battle.point")
        pt.x = (math.tointeger)((math.floor)(xs[i - 1] * 1000 + 0.5))
        pt.y = (math.tointeger)((math.floor)(ys[i - 1] * 1000 + 0.5))
        -- DECOMPILER ERROR at PC99: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (req.monsters)[id] = pt
      end
      req.sceneid = self:GetSceneID()
      req:Send()
    end
  end
end

TrapController.AddMapIcon = function(self)
  -- function num : 0_53 , upvalues : _ENV
  local recorder = (BeanManager.GetTableByName)("scene.cscenejump")
  local entrance = {}
  for _,id in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(id)
    for i,v in pairs(record.aimSceneID) do
      if v == self:GetSceneID() and not entrance[(record.aimPosition)[i]] then
        local area = (string.split)((record.aimPosition)[i], ",")
        print("add entrance to map", tonumber(area[2]), tonumber(area[1]))
        ;
        ((NekoData.BehaviorManager).BM_MiniMap):AddObject(10, tonumber(area[2]), tonumber(area[1]))
      end
    end
  end
  local record = recorder:GetRecorder(self:GetSceneID())
  if record then
    for i,v in pairs(record.exitSituation) do
      if (record.isShowInMap)[i] == 1 then
        local area = (string.split)(v, ",")
        print("add exit to map", tonumber(area[2]), tonumber(area[1]))
        ;
        ((NekoData.BehaviorManager).BM_MiniMap):AddObject(8, tonumber(area[2]), tonumber(area[1]))
      end
    end
  end
  do
    local manaPosList = (RandomItemManager.GetRandomItemPosListByType)((RandomItemManager.Type).ManaCollector)
    for k,v in pairs(manaPosList) do
      local manaIconID = ((NekoData.BehaviorManager).BM_MiniMap):AddObject(11, v.y, v.x, true)
      -- DECOMPILER ERROR at PC122: Confused about usage of register: R11 in 'UnsetPending'

      if manaIconID >= 0 then
        (self._manaMiniMapIconIDList)[v.key] = manaIconID
      end
    end
  end
end

TrapController.RemoveMapIcon = function(self, type, key)
  -- function num : 0_54 , upvalues : _ENV
  if type == (RandomItemManager.Type).ManaCollector then
    local icon = (self._manaMiniMapIconIDList)[key]
    ;
    ((NekoData.BehaviorManager).BM_MiniMap):RemoveObject(icon)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (self._manaMiniMapIconIDList)[key] = nil
    print("remove icon", icon, key, (debug.traceback)())
  end
end

TrapController.AddNPC = function(self, npcList)
  -- function num : 0_55 , upvalues : _ENV, NpcObj, StaticEvent
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon)
  for _,v in pairs(npcList) do
    local position = {x = v.x, y = v.z}
    local npcIns = (NpcObj.Create)(v.id, controller:GetSceneID(), position)
    local success = ((NekoData.DataManager).DM_NPC):SetNpcInstance(npcIns)
    if success then
      npcIns:AddEvent()
    end
    if v.state == 0 and npcIns:ShouldShowBubble() then
      npcIns:AddSimpleBubble()
    end
    if v.state ~= 1 or v.state == 2 then
      local id = (((BeanManager.GetTableByName)("npc.cnpc")):GetRecorder(v.id)).effect_id
      if id ~= 0 then
        local effect = (StaticEvent.CreateNPCEffect)(id)
        effect:SetParam("runoninit", true)
        effect:Run({init = true})
      end
    end
  end
end

TrapController.SetManaMiniMapIconInOrOutFog = function(self)
  -- function num : 0_56 , upvalues : _ENV
  local hasSkill = (EquipSkillUtil.HasEquipSkill)(20046)
  local result = not hasSkill
  local bm_miniMap = (NekoData.BehaviorManager).BM_MiniMap
  for k,v in pairs(self._manaMiniMapIconIDList) do
    bm_miniMap:SetObjectInOrOutFog(v, result)
  end
end

TrapController.OpenAccountDialogWhenCompleteZone = function(self)
  -- function num : 0_57 , upvalues : _ENV
  self.accountDialogKey = {}
  local firstAward = ((NekoData.BehaviorManager).BM_Game):GetFirstAwardFromDungeon()
  local nextFloorId = (((NekoData.BehaviorManager).BM_Game):GetNextFloorId())
  -- DECOMPILER ERROR at PC12: Overwrote pending register: R3 in 'AssignReg'

  local dialog = .end
  if nextFloorId < 5000 then
    if #firstAward ~= 0 then
      dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonfirstawarddialog")
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

      if dialog then
        (self.accountDialogKey)[1] = dialog._dialogKey
      else
        dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonaccountdialog")
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

        if dialog then
          (self.accountDialogKey)[2] = dialog._dialogKey
        end
      end
    else
      dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonaccountdialog")
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R4 in 'UnsetPending'

      if dialog then
        (self.accountDialogKey)[2] = dialog._dialogKey
      end
    end
  else
    dialog = (DialogManager.CreateSingletonDialog)("mainline.branchline.branchlinefinishidialog")
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R4 in 'UnsetPending'

    if dialog then
      (self.accountDialogKey)[3] = dialog._dialogKey
    end
  end
  if dialog then
    (LuaNotificationCenter.AddObserver)(self, self.OnAccountDialogDestroy, Common.n_DialogWillDestroy, nil)
  end
end

TrapController.OnAccountDialogDestroy = function(self, notification)
  -- function num : 0_58 , upvalues : _ENV
  local key = (notification.userInfo)._dialogKey
  if (self.accountDialogKey)[1] and key == (self.accountDialogKey)[1] then
    local dialog = (DialogManager.CreateSingletonDialog)("dungeon.dungeonaccountdialog")
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    if dialog then
      (self.accountDialogKey)[2] = dialog._dialogKey
    end
  else
    do
      if (self.accountDialogKey)[2] and key == (self.accountDialogKey)[2] then
        local curFloorId = ((NekoData.BehaviorManager).BM_Game):GetCurPassZoneId()
        local nextFloorId = ((NekoData.BehaviorManager).BM_Game):GetNextFloorId()
        local list = (((NekoData.BehaviorManager).BM_Game):GetDungeonList())
        local data = nil
        for key,world in pairs(list) do
          for _,floor in ipairs(world.floorDetail) do
            if nextFloorId == floor.floor then
              data = world
              break
            end
          end
        end
        if not data then
          return 
        end
        local firstPass = #((NekoData.BehaviorManager).BM_Game):GetFirstAwardFromDungeon() > 0
        if firstPass and ((NekoData.BehaviorManager).BM_Game):GetFloorIsNeedToBack(curFloorId) then
          local effect = (EffectFactory.CreateJumpBackEffect)()
          effect:Run()
          ;
          ((EffectFactory.CreateThawEffect)()):Run()
        else
          local three = {
data = {}
, curZone = nil}
          three.curZone = data.curZone
          three.worldId = data.worldId
          three.clearZones = data.clearZones
          three.totalZones = data.totalZones
          three.isReceived = data.isReceived
          for _,d in ipairs(data.floorDetail) do
            local temp = {}
            temp.id = d.floor
            temp.spirit = d.spirit
            temp.firstGet = d.firstGet
            temp.isReceived = d.isReceived
            temp.openedBoxes = d.openedBoxes
            temp.totalBoxes = d.totalBoxes
            temp.checkPointOpenBoxex = d.checkPointOpenBoxex
            temp.checkPointTotalBoxes = d.checkPointTotalBoxes
            temp.autoExplore = d.autoExplore
            temp.smallPoint = d.smallPoint
            ;
            (table.insert)(three.data, temp)
          end
          ;
          (table.sort)(three.data, function(a, b)
    -- function num : 0_58_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
          ;
          ((DialogManager.CreateSingletonDialog)("dungeon.dungeonnextfloordialog")):SetData(three, curFloorId, firstPass)
        end
        ;
        (LuaNotificationCenter.RemoveObserver)(self)
      elseif (self.accountDialogKey)[3] and key == (self.accountDialogKey)[3] then
        local nextFloorId = ((NekoData.BehaviorManager).BM_Game):GetNextFloorId()
        local list = ((NekoData.BehaviorManager).BM_Game):GetBranchLineList()
        local data = {}
        for worldId,world in pairs(list) do
          for id,_ in pairs(world.questInfo) do
            if nextFloorId == id then
              data.chapterId = worldId
              break
            end
          end
        end
        if not data.chapterId then
          return 
        end
        ;
        ((DialogManager.CreateSingletonDialog)("dungeon.branchlinenextfloordialog")):Init(data)
        ;
        (LuaNotificationCenter.RemoveObserver)(self)
      end
      -- DECOMPILER ERROR: 9 unprocessed JMP targets
    end
  end
end

TrapController.OnMoveTypeChanged = function(self, notification)
  -- function num : 0_59 , upvalues : _ENV
  self._moveType = ((NekoData.BehaviorManager).BM_Game):GetMoveTypeMobileMode()
  if self._moveType == "clickMobileMode" then
    local dialog = (DialogManager.GetDialog)("dungeon.touchlayer")
    if dialog then
      (dialog:GetRootWindow()):SetActive(true)
    else
      ;
      (DialogManager.CreateSingletonDialog)("dungeon.touchlayer")
    end
    ;
    (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
    self:SetActorRunning(true)
  else
    do
      local dialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
      if dialog then
        (dialog:GetRootWindow()):SetActive(true)
      else
        ;
        (DialogManager.CreateSingletonDialog)("dungeon.rockerdialog")
      end
      ;
      (DialogManager.DestroySingletonDialog)("dungeon.touchlayer")
    end
  end
end

TrapController.SetActorRunning = function(self, flag)
  -- function num : 0_60 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetRunning)(((self._sceneRef).actor).object, flag)
  if flag then
    self._maxOffset = 1
  else
    self._maxOffset = 0.5
  end
end

TrapController.OnTeamHPIsLow = function(self)
  -- function num : 0_61 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):SendMessageById(100030)
end

TrapController.BeginTransaction = function(self, eventid, type)
  -- function num : 0_62 , upvalues : _ENV
  print(eventid, type, (self._transactions).req, (debug.traceback)())
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  if (self._transactions).req then
    ((self._transactions).req)[#(self._transactions).req + 1] = {eventid = eventid, type = type}
    print("begin transaction in", (debug.traceback)())
  else
    ;
    ((NekoData.BehaviorManager).BM_Dungeon):BeginTransaction(eventid, type)
  end
end

TrapController.PlayPortalTimeline = function(self, portal)
  -- function num : 0_63 , upvalues : PrefabLoader, _ENV
  local args = {Actor = ((self._sceneRef).actor).object, Transmit = portal}
  if not self._portalTimeline then
    self._portalTimeline = (PrefabLoader.LoadAndInstantiatePrefab)("sceneobjects/base.storyprefabs.assetbundle", "Transmit")
    self._portalTimelineDirector = (self._portalTimeline):GetComponent("PlayableDirector")
  end
  ;
  (((((CS.PixelNeko).P1).TimeLine).TimelineManager).PlayTimelineBindObjectDynamically)(self._portalTimeline, args)
end

TrapController.GetPortalTimelineDirector = function(self)
  -- function num : 0_64
  return self._portalTimelineDirector
end

TrapController.GetCloudInfo = function(self)
  -- function num : 0_65 , upvalues : CSceneFloatObjsConfig, _ENV, GlobalCameras
  local record = CSceneFloatObjsConfig:GetRecorder(self:GetSceneID())
  if record then
    self._cloudRecord = {}
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._cloudRecord).objList = {}
    for i,v in ipairs(record.objList) do
      (table.insert)((self._cloudRecord).objList, tonumber(v))
    end
    local reg = "(%-?%d+%.*%d*)"
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cloudRecord).spawnPosition = {}
    for v in (string.gmatch)(record.spawnPosition, reg) do
      v = tonumber(v)
      ;
      (table.insert)((self._cloudRecord).spawnPosition, v)
    end
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cloudRecord).spawnScale = {}
    for v in (string.gmatch)(record.spawnScale, reg) do
      v = tonumber(v)
      ;
      (table.insert)((self._cloudRecord).spawnScale, v)
    end
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cloudRecord).speed = {}
    for v in (string.gmatch)(record.speed, reg) do
      v = tonumber(v)
      ;
      (table.insert)((self._cloudRecord).speed, v)
    end
    -- DECOMPILER ERROR at PC92: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cloudRecord).spawnTime = record.spawnTime
    -- DECOMPILER ERROR at PC95: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cloudRecord).maxDistance = record.maxDistance
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._cloudRecord).maxCount = record.maxCount
    self._cloudData = {}
    self._mainCamera = (GlobalCameras.GetCamera)("Main")
  end
end

TrapController.UpdateCloud = function(self, deltaTime)
  -- function num : 0_66 , upvalues : TransformStaticFunctions, _ENV, CSceneFloatObjs, PrefabLoader
  self._time = self._time + deltaTime
  local mainCameraPos = {}
  mainCameraPos.x = (TransformStaticFunctions.GetPosition)(((self._mainCamera).gameObject).transform)
  if (self._cloudRecord).spawnTime <= self._time and #self._cloudData < (self._cloudRecord).maxCount then
    self._time = 0
    -- DECOMPILER ERROR at PC28: Overwrote pending register: R5 in 'AssignReg'

    -- DECOMPILER ERROR at PC29: Overwrote pending register: R5 in 'AssignReg'

    local index = (math.random)(1, R5_PC9)
    -- DECOMPILER ERROR at PC32: Overwrote pending register: R5 in 'AssignReg'

    local cloudAsset = CSceneFloatObjs:GetRecorder(((self._cloudRecord).objList)[index])
    -- DECOMPILER ERROR at PC37: Overwrote pending register: R5 in 'AssignReg'

    R5_PC9 = R5_PC9(cloudAsset.assetBundle, cloudAsset.name)
    local cloud = nil
    ;
    (TransformStaticFunctions.SetParent)(cloud.transform, ((self._sceneRef):GetRootGameObject()).transform, false)
    local scale = (math.random)(((self._cloudRecord).spawnScale)[1] * 100, ((self._cloudRecord).spawnScale)[2] * 100) / 100
    ;
    (TransformStaticFunctions.SetLocalScale)(cloud.transform, scale, scale, scale)
    local x = mainCameraPos.x + ((self._cloudRecord).spawnPosition)[1]
    local y = mainCameraPos.y + ((self._cloudRecord).spawnPosition)[2]
    local z = mainCameraPos.z + ((self._cloudRecord).spawnPosition)[3]
    ;
    (TransformStaticFunctions.SetPosition)(cloud, x, y, z)
    ;
    (table.insert)(self._cloudData, cloud)
  end
  do
    for i,cloud in ipairs(self._cloudData) do
      local x = ((self._cloudRecord).speed)[1] * deltaTime
      local y = ((self._cloudRecord).speed)[2] * deltaTime
      local z = ((self._cloudRecord).speed)[3] * deltaTime
      ;
      (TransformStaticFunctions.TranslateRelativeToWorld)(cloud.transform, x, y, z)
    end
    for i = #self._cloudData, 1, -1 do
      local cloud = (self._cloudData)[i]
      local cloudPos = {}
      cloudPos.x = (TransformStaticFunctions.GetPosition)(cloud.transform)
      local distance = GetDistance(mainCameraPos, cloudPos)
      if (self._cloudRecord).maxDistance < distance then
        ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(cloud)
        ;
        (table.remove)(self._cloudData, i)
      end
    end
  end
end

TrapController.SetGlassAnimator = function(self, deltaTime)
  -- function num : 0_67 , upvalues : _ENV
  local isRunning = (((self._sceneRef).actor).animator):GetBool("running")
  local isSkate = (((self._sceneRef).actor).animator):GetInteger("skate") == 1
  local name = ""
  if ((((self._sceneRef).actor).animator):GetCurrentAnimatorClipInfo(0)).Length > 0 then
    name = ((((((self._sceneRef).actor).animator):GetCurrentAnimatorClipInfo(0))[0]).clip).name
  end
  if isSkate or (DialogManager.GetDialog)("freezedialog") or (DialogManager.GetDialog)("dungeon.thrower.throwerlayer") or (DialogManager.GetDialog)("npcchat.npcchatmaindialog") then
    self._idleTime = 0
  elseif (string.find)(name, "Idle") then
    self._idleTime = self._idleTime + deltaTime
  end
  if self._idleTime > 5 then
    (((self._sceneRef).actor).animator):Play("SunGlass")
    self._idleTime = 0
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

GetDistance = function(position1, position2)
  -- function num : 0_68 , upvalues : _ENV
  return (math.sqrt)(position1.x - position2.x ^ 2 + position1.y - position2.y ^ 2 + position1.z - position2.z ^ 2)
end

TrapController.GetBuffManager = function(self)
  -- function num : 0_69
  return self._buffManager
end

TrapController.OnEnterChaseRadius = function(self, id)
  -- function num : 0_70
  ((self._enemies)[id]):OnEnterArea()
end

TrapController.OnLeaveChaseRadius = function(self, id)
  -- function num : 0_71
  ((self._enemies)[id]):OnLeaveRadius()
end

TrapController.OnLeaveChaseArea = function(self, id)
  -- function num : 0_72
  ((self._enemies)[id]):OnLeaveArea()
end

TrapController.GetMonster = function(self, id)
  -- function num : 0_73
  return (self._enemies)[id]
end

TrapController.GetMonsters = function(self)
  -- function num : 0_74
  return self._enemies
end

TrapController.OnMonsterBattle = function(self, id)
  -- function num : 0_75 , upvalues : _ENV
  for i,v in pairs(self._enemies) do
    if i ~= id and v:CanChase() and v:GetChaseState() == 2 then
      v:PauseChase()
      v:PausePatrol()
    end
  end
end

TrapController.OnMonsterDestroy = function(self, id)
  -- function num : 0_76 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._enemies)[id] = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._enemypos)[id] = nil
  if not self._enemies then
    for _,v in pairs({}) do
      if v:CanChase() then
        v:ResumeChase()
        v:ResumePatrol()
      end
    end
  end
end

TrapController.TrapTimer = function(self, deltaTime)
  -- function num : 0_77 , upvalues : _ENV
  if self:CheckUI() and self._enabled and not self._isPlayingTimeLine and not self._isHelpBtnActive and not self._dontPop then
    self._trapTimerTime = self._trapTimerTime + deltaTime
    if self._trapCheckTime <= self._trapTimerTime then
      self._trapTimerTime = 0
      ;
      (TriggerManager.OnCheckTrap)()
    end
  end
end

TrapController.CheckUI = function(self)
  -- function num : 0_78 , upvalues : _ENV
  local lenth1 = ((DialogManager.GetGroup)("Battle")):GetDialogGroupLen()
  local lenth2 = ((DialogManager.GetGroup)("Modal")):GetDialogGroupLen()
  local lenth3 = ((DialogManager.GetGroup)("ModalFrame")):GetDialogGroupLen()
  local lenth4 = ((DialogManager.GetGroup)("SecondConfirm")):GetDialogGroupLen()
  local lenth5 = ((DialogManager.GetGroup)("Tip")):GetDialogGroupLen()
  local lenth6 = ((DialogManager.GetGroup)("Guide")):GetDialogGroupLen()
  local lenth7 = ((DialogManager.GetGroup)("BrokenLine")):GetDialogGroupLen()
  if lenth1 > 0 or lenth2 > 0 or lenth3 > 0 or lenth4 > 0 or lenth5 > 0 or lenth6 > 0 or lenth7 > 0 then
    return false
  end
  return true
end

TrapController.IsPlayingTimeLine = function(self, flg)
  -- function num : 0_79
  self._isPlayingTimeLine = flg
end

TrapController.SetHelpBtnActive = function(self, flg)
  -- function num : 0_80
  self._isHelpBtnActive = flg
end

TrapController.DontPop = function(self, flg)
  -- function num : 0_81
  self._dontPop = flg
end

TrapController.GetChestList = function(self)
  -- function num : 0_82
  return self._chests
end

return TrapController

