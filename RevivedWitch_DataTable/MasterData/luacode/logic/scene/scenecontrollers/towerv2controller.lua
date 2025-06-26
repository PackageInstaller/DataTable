-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/towerv2controller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local TowerV2Controller = class("TowerV2Controller", SceneController)
local TowerStair = require("logic.scene.types.towerstair")
local TimelineManager = (((CS.PixelNeko).P1).TimeLine).TimelineManager
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local Context = require("logic.scene.luaevent.effect.context")
local cstairvarcfg = (BeanManager.GetTableByName)("dungeonselect.cstairvarcfg")
local event_spawn_time = tonumber((cstairvarcfg:GetRecorder(3)).value)
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local bm_towerv2 = (NekoData.BehaviorManager).BM_TowerV2
TowerV2Controller.Init = function(self)
  -- function num : 0_0 , upvalues : TowerStair, _ENV, cstairvarcfg
  self._stairs = {current = nil, 
running = {}
, 
hidden = {}
, count = 0}
  self._startStairs = {}
  self._currentStartStair = nil
  self._time = 0
  self._paused = true
  self._blockStatus = ""
  ;
  (TowerStair.SetSpeed)(tonumber((cstairvarcfg:GetRecorder(4)).value))
  local dir = (string.sub)((cstairvarcfg:GetRecorder(7)).value, 2, -2)
  dir = (string.split)(dir, ",")
  ;
  (TowerStair.SetVelocity)({x = tonumber(dir[1]), y = tonumber(dir[2]), z = tonumber(dir[3])})
  self._dialog = (DialogManager.CreateSingletonDialog)("towerv2.scene.towerv2scenedialog")
  ;
  (self._dialog):Init(self)
  self._currentInfo = self:GetData("floorinfo")
  self._runningStairIndex = 1
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBattleRewardEnd, Common.n_BattleRewardEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStairFinish, Common.n_TowerV2Response, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAutoExploreChange, Common.n_TowerV2AutoExplore)
  self:PlaySceneBGM()
  self:Start()
end

TowerV2Controller.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  if self._dialog then
    (self._dialog):Destroy()
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  for _,l in pairs(self._startStairs) do
    l:Destroy()
  end
  for _,l in pairs((self._stairs).hidden) do
    for _,v in pairs(l) do
      v:Destroy()
    end
  end
  for _,v in pairs((self._stairs).running) do
    v:Destroy()
  end
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  if self._eventTimer then
    (GameTimer.RemoveTask)(self._eventTimer)
  end
  if self._context then
    (self._context):Destroy()
  end
  ;
  ((NekoData.DataManager).DM_Dungeon):SetMode()
end

TowerV2Controller.GetMainCamera = function(self)
  -- function num : 0_2
  return (self._sceneRef).mainCamera
end

TowerV2Controller.PrepareStair = function(self, typeid)
  -- function num : 0_3 , upvalues : TowerStair
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if not ((self._stairs).hidden)[typeid] then
    ((self._stairs).hidden)[typeid] = {}
    local object = (((self._stairs).hidden)[typeid])[1]
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

    if not object then
      (self._stairs).count = (self._stairs).count + 1
      object = (TowerStair.Create)((self._stairs).count, typeid, self)
      object:BuildObject((self._sceneRef).spawnPoint)
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (((self._stairs).hidden)[typeid])[#((self._stairs).hidden)[typeid] + 1] = object
    end
    return object:GetID(), object
  end
end

TowerV2Controller.PrepareStartStair = function(self, typeid)
  -- function num : 0_4 , upvalues : TowerStair
  do
    if not (self._startStairs)[typeid] then
      local object = (TowerStair.Create)((self._stairs).count, typeid, self)
      ;
      (TowerStair.Create)(typeid * -1, typeid, self)
      object:BuildObject((self._sceneRef).startPoint)
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (self._startStairs)[typeid] = object
      object:SetType("nullary")
    end
    return (self._startStairs)[typeid]
  end
end

TowerV2Controller.RecycleStair = function(self, typeid)
  -- function num : 0_5 , upvalues : _ENV
  local index, object = nil, nil
  for i,v in ipairs((self._stairs).running) do
    if v:GetTypeID() == typeid then
      index = i
      object = v
      break
    end
  end
  do
    if not object then
      LogErrorFormat("tower stair", "recycle invalid stair type %d", typeid)
      return 
    end
    ;
    (((self._stairs).running)[index]):Hide()
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((self._stairs).hidden)[typeid])[#((self._stairs).hidden)[typeid] + 1] = ((self._stairs).running)[index]
    ;
    (table.remove)((self._stairs).running, index)
    return object
  end
end

TowerV2Controller.SpawnStair = function(self, typeid, stairtype)
  -- function num : 0_6 , upvalues : _ENV
  local object = (((self._stairs).hidden)[typeid])[1]
  if not object then
    LogErrorFormat("tower stair", "no %d stair to spawn", typeid)
    return 
  end
  object:SetType(stairtype)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((self._stairs).running)[#(self._stairs).running + 1] = object
  ;
  (table.remove)(((self._stairs).hidden)[typeid], 1)
  return object
end

TowerV2Controller.NextNormalStair = function(self, typeid, stairtype)
  -- function num : 0_7
  local id, object = self:PrepareStair(typeid)
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._stairs).current = object
  self:SpawnStair(typeid, stairtype)
end

local cstairlevelcfg_typeID_to_stairtype = {"unary", "binary", "ternary", "unary"}
TowerV2Controller.Start = function(self)
  -- function num : 0_8 , upvalues : bm_towerv2
  local state = bm_towerv2:GetState()
  if state == "retreat" then
    self:RetreatAndRestart()
  else
    if state == "fresh" then
      self:FreshStart()
    else
      if state == "continue" then
        self:Continue()
      else
        if state == "finished" then
          self:FinishCurrentGroup()
        else
          if state == "complete" then
            self:Complete()
          else
            if state == "reset" then
              self:Reset()
            else
              if state == "buffchoose" then
                self:BuffChoose()
              end
            end
          end
        end
      end
    end
  end
  self._state = "start"
end

local reset_actor_animator = function(actor)
  -- function num : 0_9 , upvalues : AnimationHelper
  (AnimationHelper.PlayAnimation2)(actor, "New State", 0, 0)
end

TowerV2Controller.PrepareInit = function(self, id)
  -- function num : 0_10 , upvalues : _ENV, reset_actor_animator
  for _,v in pairs(self._startStairs) do
    v:Hide()
  end
  local obj = self:PrepareStartStair(id)
  self._currentStartStair = obj
  obj:SetType("nullary")
  ;
  (obj:Appear2()):Run()
  self:Pause()
  ;
  (self._dialog):Freeze()
  reset_actor_animator(((self._sceneRef).actor).object)
end

TowerV2Controller.GetState = function(self)
  -- function num : 0_11
  return self._state
end

TowerV2Controller.FreshStart = function(self)
  -- function num : 0_12 , upvalues : bm_towerv2, _ENV
  self:PrepareInit(bm_towerv2:GetStartStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = (EffectFactory.CreateComposedEffect)()
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 0)
  effect:Bind(((self._sceneRef).actor).object)
  root:AddEffect(effect)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_12_0 , upvalues : self, _ENV, bm_towerv2
    (self._dialog):Thaw()
    ;
    (self._dialog):Refresh()
    ;
    (self._dialog):MoveMid((math.max)(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
  end
))
  root:Run()
end

TowerV2Controller.Continue = function(self)
  -- function num : 0_13 , upvalues : bm_towerv2, _ENV
  self:PrepareInit(bm_towerv2:GetStartStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = (EffectFactory.CreateComposedEffect)()
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 1)
  effect:Bind(((self._sceneRef).actor).object)
  root:AddEffect(effect)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_13_0 , upvalues : self, _ENV, bm_towerv2
    (self._dialog):Thaw()
    ;
    (self._dialog):Refresh()
    ;
    (self._dialog):ShowContinue()
    ;
    (self._dialog):MoveMid((math.max)(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
    local id, buff = bm_towerv2:GetLastBuffCandidates()
    if id and id < bm_towerv2:GetCurrentFloorID() then
      ((DialogManager.CreateSingletonDialog)("towerv2.towerv2buffchoosedialog")):SetData(id, buff, self)
    end
  end
))
  root:Run()
end

TowerV2Controller.RetreatAndRestart = function(self)
  -- function num : 0_14 , upvalues : bm_towerv2, _ENV
  self:Clear()
  self:PrepareInit(bm_towerv2:GetRetreatStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = (EffectFactory.CreateComposedEffect)()
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 1)
  effect:Bind(((self._sceneRef).actor).object)
  root:AddEffect(effect)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_14_0 , upvalues : self, _ENV, bm_towerv2
    (self._dialog):Thaw()
    ;
    (self._dialog):Refresh()
    ;
    (self._dialog):ShowContinue()
    ;
    (self._dialog):MoveMid((math.max)(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
  end
))
  root:Run()
end

TowerV2Controller.RetreatAndWait = function(self)
  -- function num : 0_15 , upvalues : bm_towerv2, _ENV
  self:Clear()
  self:PrepareInit(bm_towerv2:GetRetreatStair(bm_towerv2:GetCurrentFloorID()))
  self:ResetBackground()
  local root = (EffectFactory.CreateComposedEffect)()
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 2, "DefeatIdle", 2)
  effect:Bind(((self._sceneRef).actor).object)
  root:AddEffect(effect)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_15_0 , upvalues : self, _ENV, bm_towerv2
    (self._dialog):ShowRetreat()
    ;
    (self._dialog):MoveMid((math.max)(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
    ;
    (self._dialog):Freeze()
    local dialog = (DialogManager.CreateSingletonDialog)("towerv2.scene.towerv2defeatdialog")
    dialog:Refresh()
    ;
    (LuaNotificationCenter.AddObserver)(self, function(observer, notification)
      -- function num : 0_15_0_0 , upvalues : dialog, _ENV, self
      if (notification.userInfo)._dialogKey == dialog._dialogKey then
        (LuaNotificationCenter.RemoveObserver)(self, Common.n_DialogWillDestroy)
        ;
        (self._dialog):Thaw()
        ;
        (self._dialog):Refresh()
      end
    end
, Common.n_DialogWillDestroy, nil)
  end
))
  root:Run()
  self._state = "retreatandwait"
end

TowerV2Controller.FinishCurrentGroup = function(self)
  -- function num : 0_16 , upvalues : bm_towerv2, _ENV
  self:Clear()
  self:PrepareInit(bm_towerv2:GetFinishStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = (EffectFactory.CreateComposedEffect)()
  local info = bm_towerv2:GetCurrentFloorInfo()
  local world = tonumber(info.world)
  if (((self._sceneRef).worldtimeline).director)[world] then
    root:AddEffect((EffectFactory.CreateTimelineEffect)((((self._sceneRef).worldtimeline).director)[world]))
  end
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 1)
  effect:Bind(((self._sceneRef).actor).object)
  root:AddEffect(effect)
  local show_reward = function()
    -- function num : 0_16_0 , upvalues : _ENV, bm_towerv2, self
    local dialog = (DialogManager.CreateSingletonDialog)("towerv2.scene.towerv2rewarddialog")
    dialog:SetData(bm_towerv2:GetLastRewards())
    ;
    (LuaNotificationCenter.AddObserver)(self, function(observer, notification)
      -- function num : 0_16_0_0 , upvalues : dialog, _ENV, self
      if (notification.userInfo)._dialogKey == dialog._dialogKey then
        (LuaNotificationCenter.RemoveObserver)(self, Common.n_DialogWillDestroy)
        ;
        (self._dialog):Thaw()
        ;
        (self._dialog):Refresh()
      end
    end
, Common.n_DialogWillDestroy, nil)
  end

  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_16_1 , upvalues : bm_towerv2, _ENV, self, show_reward
    local id, buff = bm_towerv2:GetLastBuffCandidates()
    if id then
      local dialog = (DialogManager.CreateSingletonDialog)("towerv2.towerv2buffchoosedialog")
      dialog:SetData(id, buff, self)
    else
      do
        show_reward()
      end
    end
  end
))
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_16_2 , upvalues : bm_towerv2, _ENV
    if bm_towerv2:IsInAutoExplore() then
      (DialogManager.CreateSingletonDialog)("towerv2.towerv2autoconfirmdialog")
    end
  end
))
  root:Run()
end

TowerV2Controller.Complete = function(self)
  -- function num : 0_17 , upvalues : bm_towerv2, _ENV
  self:Clear()
  self:PrepareInit(bm_towerv2:GetFinishStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = (EffectFactory.CreateComposedEffect)()
  local info = bm_towerv2:GetCurrentFloorInfo()
  local world = tonumber(info.world)
  if (((self._sceneRef).worldtimeline).director)[world] then
    root:AddEffect((EffectFactory.CreateTimelineEffect)((((self._sceneRef).worldtimeline).director)[world]))
  end
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 1)
  effect:Bind(((self._sceneRef).actor).object)
  root:AddEffect(effect)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_17_0 , upvalues : _ENV, bm_towerv2, self
    local dialog = (DialogManager.CreateSingletonDialog)("towerv2.scene.towerv2completedialog")
    dialog:SetData(bm_towerv2:GetLastRewards())
    ;
    (LuaNotificationCenter.AddObserver)(self, function(observer, notification)
      -- function num : 0_17_0_0 , upvalues : dialog, _ENV, self
      if (notification.userInfo)._dialogKey == dialog._dialogKey then
        (LuaNotificationCenter.RemoveObserver)(self, Common.n_DialogWillDestroy)
        ;
        (self._dialog):Thaw()
        ;
        (self._dialog):Refresh()
      end
    end
, Common.n_DialogWillDestroy, nil)
  end
))
  root:Run()
end

TowerV2Controller.Reset = function(self)
  -- function num : 0_18 , upvalues : bm_towerv2, _ENV
  self:PrepareInit(bm_towerv2:GetStartStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = (EffectFactory.CreateComposedEffect)()
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 1)
  effect:Bind(((self._sceneRef).actor).object)
  root:AddEffect(effect)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_18_0 , upvalues : self, _ENV, bm_towerv2
    (self._dialog):Thaw()
    ;
    (self._dialog):Refresh()
    ;
    (self._dialog):MoveMid((math.max)(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
    ;
    (DialogManager.CreateSingletonDialog)("towerv2.towerv2revertdialog")
  end
))
  root:Run()
end

TowerV2Controller.BuffChoose = function(self)
  -- function num : 0_19 , upvalues : bm_towerv2, _ENV
  self:PrepareInit(bm_towerv2:GetStartStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = (EffectFactory.CreateComposedEffect)()
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "state", 1)
  effect:Bind(((self._sceneRef).actor).object)
  root:AddEffect(effect)
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_19_0 , upvalues : self, _ENV, bm_towerv2
    (self._dialog):Thaw()
    ;
    (self._dialog):Refresh()
    ;
    (self._dialog):MoveMid((math.max)(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
    local candidates = ((NekoData.BehaviorManager).BM_TowerV2):GetInitBuffCandidates()
    ;
    ((DialogManager.CreateSingletonDialog)("towerv2.towerv2buffchoosedialog")):SetData(nil, candidates, self, bm_towerv2:GetInitBuffProgress())
  end
))
  root:Run()
end

TowerV2Controller.Clear = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local typeids = (table.select)((self._stairs).running, function(v, k)
    -- function num : 0_20_0
    return v:GetTypeID()
  end
)
  for _,v in pairs(typeids) do
    self:RecycleStair(v)
  end
  for _,v in pairs(self._startStairs) do
    v:Hide()
  end
end

TowerV2Controller.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_21 , upvalues : _ENV
  local count = #(self._stairs).running
  if self._currentStartStair and (self._currentStartStair):GetState() == "running" and not self._paused then
    (self._currentStartStair):OnUpdate(deltaTime, unscaleDeltaTime)
  end
  for i,v in ipairs((self._stairs).running) do
    local state = v:GetState()
    if state == "approach" or state == "appear" or not self._paused then
      v:OnUpdate(deltaTime, unscaleDeltaTime)
    end
    for c = 3, 0, -1 do
      v:SetSortingOrder(c, (count - i + 1) * 3 + c - 3 - 64)
    end
  end
end

TowerV2Controller.OnDisable = function(self)
  -- function num : 0_22
  if not self._backgrounds then
    self._backgrounds = {}
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._backgrounds).time = (((self._sceneRef).background).director).time
  end
end

TowerV2Controller.OnEnable = function(self)
  -- function num : 0_23
  if self._backgrounds and (self._backgrounds).time then
    (((self._sceneRef).background).director):Play()
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((self._sceneRef).background).director).time = (self._backgrounds).time
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self._backgrounds).time = nil
    self:PauseBackground()
  end
end

TowerV2Controller.Pause = function(self)
  -- function num : 0_24
  self._paused = true
end

TowerV2Controller.Resume = function(self)
  -- function num : 0_25
  self._paused = false
  self._time = 0
end

local run_after_dialog = function(func)
  -- function num : 0_26 , upvalues : _ENV
  return (EffectFactory.CreateDelayedWrapper)(function()
    -- function num : 0_26_0 , upvalues : _ENV, func
    return (EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_26_0_0 , upvalues : _ENV, func
      local dlg = nil
      for _,v in pairs({"towerv2.towerv2rewardpreviewdialog", "towerv2.towerv2buffdialog", "towerv2.towerv2tipdialog", "character.newcharacterinfodialog"}) do
        dlg = (DialogManager.GetDialog)(v)
        if dlg then
          (LuaNotificationCenter.AddObserver)(func, function(observer, notification)
        -- function num : 0_26_0_0_0 , upvalues : dlg, _ENV, func
        if (notification.userInfo)._dialogKey == dlg._dialogKey then
          (LuaNotificationCenter.RemoveObserver)(func, Common.n_DialogWillDestroy)
          func()
        end
      end
, Common.n_DialogWillDestroy, nil)
          break
        end
      end
      do
        if not dlg then
          func()
        end
      end
    end
)
  end
)
end

TowerV2Controller.StartChasing = function(self, timeout, instantrun)
  -- function num : 0_27 , upvalues : _ENV, run_after_dialog, bm_towerv2
  if not timeout then
    timeout = 2
  end
  self:Resume()
  local root = (EffectFactory.CreateComposedEffect)()
  if self._state == "retreatandwait" then
    root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_27_0 , upvalues : self
    self:SetActorRunning(true)
  end
))
  end
  self._blockStatus = "Start"
  local start, continuation = self:BuildStartSteps(5)
  root:AddEffect(start)
  continuation:AddEffect(self:BuildEventAppearStep())
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_27_1 , upvalues : self
    self._blockStatus = "End"
  end
))
  root:AddEffect(run_after_dialog(function()
    -- function num : 0_27_2 , upvalues : _ENV, self
    (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
  end
))
  root:Run()
  self:MoveBackground()
  self._state = "running"
  ;
  (self._dialog):MoveMid(bm_towerv2:GetCurrentFloorIndex(), false)
end

TowerV2Controller.SetActorRunning = function(self, running)
  -- function num : 0_28 , upvalues : AnimationHelper
  local state = nil
  if running then
    state = 4
  else
    state = 1
  end
  ;
  (AnimationHelper.SetAnimatorInteger2)(((self._sceneRef).actor).object, "state", state)
end

local attach = function(object, events, index, point)
  -- function num : 0_29
  local event = events[index]
  object:Attach(point, event.assetBundle, event.assetName)
  if event.alterAssetBundle then
    object:Attach(point, event.alterAssetBundle, event.alterAssetName)
  end
end

TowerV2Controller.ShowEventStair = function(self)
  -- function num : 0_30 , upvalues : bm_towerv2, attach
  local info = bm_towerv2:GetCurrentFloorInfo()
  if info.type == 1 then
    attach((self._stairs).current, info.events, 1, 2)
  else
    if info.type == 2 then
      attach((self._stairs).current, info.events, 1, 1)
      attach((self._stairs).current, info.events, 2, 3)
    else
      if info.type == 3 then
        for i = 1, 3 do
          attach((self._stairs).current, info.events, i, i)
        end
      else
        do
          if info.type == 4 then
            attach((self._stairs).current, info.events, 1, 0)
          end
        end
      end
    end
  end
end

TowerV2Controller.OnBattleStair = function(self, index, info)
  -- function num : 0_31 , upvalues : bm_towerv2, _ENV
  bm_towerv2:ChooseEvent(bm_towerv2:GetCurrentFloorID(), index - 1, 0)
  self._battleFloor = bm_towerv2:GetCurrentFloorID()
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_TowerV2Response)
  ;
  (self._dialog):Freeze()
end

TowerV2Controller.OnChestStair = function(self, index, info)
  -- function num : 0_32 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("towerv2.towerv2chestdialog")
  dialog:SetData(info.id, index, 3, self)
end

TowerV2Controller.OnBuffStair = function(self, index, info)
  -- function num : 0_33 , upvalues : bm_towerv2
  bm_towerv2:ChooseEvent(bm_towerv2:GetCurrentFloorID(), index - 1, 0)
end

TowerV2Controller.OnBestQualityChestStair = function(self, index, info)
  -- function num : 0_34 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("towerv2.towerv2chestdialog")
  dialog:SetData(info.id, index, 5, self)
end

TowerV2Controller.OnEventStair = function(self, index, info)
  -- function num : 0_35 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("towerv2.towerv2eventdialog")
  dialog:SetData(index, info.id, self)
  ;
  (LuaNotificationCenter.RemoveObserver)(self, Common.n_TowerV2Response)
end

TowerV2Controller.OnShrineStair = function(self, index, info)
  -- function num : 0_36 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("towerv2.towerv2shrinedialog")
  dialog:SetData(info.id, index, self)
end

local handler = {[1] = TowerV2Controller.OnBattleStair, [2] = TowerV2Controller.OnBattleStair, [3] = TowerV2Controller.OnChestStair, [4] = TowerV2Controller.OnBattleStair, [5] = TowerV2Controller.OnBestQualityChestStair, [6] = TowerV2Controller.OnEventStair, [7] = TowerV2Controller.OnBattleStair, [8] = TowerV2Controller.OnShrineStair, [9] = TowerV2Controller.OnBuffStair}
TowerV2Controller.OnStairClick = function(self, object)
  -- function num : 0_37 , upvalues : bm_towerv2, run_after_dialog
  if not self._choosing then
    return 
  end
  local f = function()
    -- function num : 0_37_0 , upvalues : bm_towerv2, self, object
    local info = bm_towerv2:GetCurrentFloorInfo()
    local event_index, child_index = self:ObjectToEventIndex(object)
    if (info.events)[event_index] and not self._clicked then
      (self._dialog):Freeze(true)
      local effect = self:RunEvent(event_index, child_index)
      effect:Run()
      effect:Then(function()
      -- function num : 0_37_0_0 , upvalues : self
      (self._dialog):Thaw()
    end
)
    end
  end

  ;
  (run_after_dialog(f)):Run()
end

TowerV2Controller.ObjectToEventIndex = function(self, object)
  -- function num : 0_38 , upvalues : _ENV, bm_towerv2
  (((self._stairs).current):GetType())
  local stairtype = nil
  local event_index, child_index = nil, nil
  if stairtype == "unary" then
    event_index = 1
  else
    if stairtype == "nullary" then
      return 
    else
      child_index = ((self._stairs).current):MapChildren(object)
      if child_index == -1 then
        LogErrorFormat("towerv2", "invalid child click %d at event %d", child_index, bm_towerv2:GetCurrentFloorID())
        return 
      end
      if stairtype == "binary" then
        if child_index == 1 then
          event_index = 1
        else
          if child_index == 3 then
            event_index = 2
          else
            LogErrorFormat("towerv2", "invalid child click %d at binary event %d", child_index, bm_towerv2:GetCurrentFloorID())
            return 
          end
        end
      else
        if stairtype == "ternary" then
          event_index = child_index
        end
      end
    end
  end
  return event_index, child_index
end

TowerV2Controller.EventIDToChildIndex = function(self, eventid)
  -- function num : 0_39
  local index = self:EventIDToEventIndex(eventid)
  return self:EventIndexToChildIndex(index)
end

TowerV2Controller.EventIDToEventIndex = function(self, id)
  -- function num : 0_40 , upvalues : bm_towerv2, _ENV
  local info = bm_towerv2:GetCurrentFloorInfo()
  return (table.first)(info.events, function(k, v)
    -- function num : 0_40_0 , upvalues : id
    do return v.id == id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

TowerV2Controller.EventIndexToChildIndex = function(self, index)
  -- function num : 0_41
  local stairtype = ((self._stairs).current):GetType()
  if stairtype == "unary" then
    return 1, 1
  else
    if stairtype == "binary" then
      if index == 1 then
        return 1, 1
      else
        if index == 2 then
          return 2, 3
        end
      end
    else
      if stairtype == "ternary" then
        return index, index
      end
    end
  end
end

TowerV2Controller.RunEvent = function(self, event_index, child_index)
  -- function num : 0_42 , upvalues : _ENV, bm_towerv2, handler
  if self._clicked then
    return (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_42_0
  end
)
  end
  local info = bm_towerv2:GetCurrentFloorInfo()
  local stairtype = ((self._stairs).current):GetType()
  self:Pause()
  self._clicked = true
  if stairtype == "unary" then
    return (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_42_1 , upvalues : handler, info, event_index, self
    (handler[((info.events)[event_index]).type])(self, event_index, (info.events)[event_index])
  end
)
  else
    self:BindClickTimeline((self._stairs).current, child_index)
    ;
    (self._dialog):SetChoiceEffectActive(((self._stairs).current):GetType(), false)
    local root = (EffectFactory.CreateComposedEffect)()
    root:AddEffect((EffectFactory.CreateTimelineEffect)(((self._sceneRef).clicktimeline).director))
    root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_42_2 , upvalues : handler, info, event_index, self
    (handler[((info.events)[event_index]).type])(self, event_index, (info.events)[event_index])
  end
))
    return root
  end
end

TowerV2Controller.OnDialogDestroy = function(self, event_index)
  -- function num : 0_43
  self:ClearClickTimeline()
  ;
  ((self._stairs).current):SetAttachmentActive(true)
  self._clicked = false
end

TowerV2Controller.OnStairFinish = function(self, notification)
  -- function num : 0_44 , upvalues : _ENV, AnimationHelper, bm_towerv2
  self._choosing = false
  local protocol = (notification.userInfo).protocol
  if protocol.EventID == -1 then
    return 
  end
  local current = (self._stairs).current
  if not current then
    LogErrorFormat("towerv2", "no current stair on finish")
    return 
  end
  local hpchange = (notification.userInfo).hpchange
  ;
  (self._dialog):HideChooseText()
  self._clicked = false
  self._state = "running"
  ;
  (self._dialog):Refresh()
  local root, continuation = nil, nil
  root = (EffectFactory.CreateComposedEffect)()
  self._blockStatus = "Start"
  if hpchange == -1 then
    (AnimationHelper.SetAnimatorTrigger2)(((self._sceneRef).actor).object, "onDebuff")
  else
    if hpchange == 1 then
      (AnimationHelper.SetAnimatorTrigger2)(((self._sceneRef).actor).object, "onHeal")
    end
  end
  if current:GetType() == "unary" then
    current:DetachAll()
    local steps = nil
    steps = self:BuildStartSteps(5)
    root:AddEffect(steps)
  else
    do
      local _, index = self:EventIndexToChildIndex(protocol.pointIndex + 1)
      local steps = nil
      -- DECOMPILER ERROR at PC73: Overwrote pending register: R6 in 'AssignReg'

      steps = self:BuildEventApproachStep(index)
      root:AddEffect(steps)
      do
        local effect, continuation2 = self:BuildEmptySteps(5)
        continuation:AddEffect(effect)
        -- DECOMPILER ERROR at PC84: Overwrote pending register: R6 in 'AssignReg'

        continuation:AddEffect(self:BuildEventAppearStep())
        root:Run()
        self:MoveBackground()
        ;
        (self._dialog):MoveMid(bm_towerv2:GetCurrentFloorIndex(), false)
      end
    end
  end
end

TowerV2Controller.OnBattleRewardEnd = function(self, notification)
  -- function num : 0_45 , upvalues : _ENV, bm_towerv2
  (self._dialog):Thaw()
  self._clicked = false
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnStairFinish, Common.n_TowerV2Response, nil)
  if (notification.userInfo).battleResult == 0 then
    self:RetreatAndWait()
  else
    if (notification.userInfo).battleResult == 1 then
      local info = nil
      if self._battleFloor then
        info = bm_towerv2:GetFloorInfoByID(self._battleFloor)
      else
        info = bm_towerv2:GetCurrentFloorInfo()
      end
      if #info.buff ~= 0 then
        (self._dialog):SetExploreTextActive(false)
        ;
        (self._dialog):SetChooseTextActive(true)
        ;
        ((DialogManager.CreateSingletonDialog)("towerv2.towerv2buffchoosedialog")):SetData(info.id, {info.buff}, self)
      else
        if info.type == 4 then
          self._state = "start"
          local state = bm_towerv2:GetState()
          if state == "complete" then
            self:Complete()
          else
            self:FinishCurrentGroup()
          end
        else
          do
            do
              local data = self:GetData("schoosepointevent")
              if data then
                self:OnStairFinish({userInfo = data})
              end
              self._choosing = false
            end
          end
        end
      end
    end
  end
end

TowerV2Controller.OnBuffChooseFinish = function(self, id)
  -- function num : 0_46 , upvalues : bm_towerv2, _ENV
  if not id then
    return 
  end
  local info = bm_towerv2:GetFloorInfoByID(id)
  if info.type == 4 then
    do
      if not (DialogManager.GetDialog)("towerv2.scene.towerv2rewarddialog") then
        local root = (self._dialog):ShowEffect()
        root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_46_0 , upvalues : bm_towerv2, self
    local state = bm_towerv2:GetState()
    if state == "complete" then
      self:Complete()
    else
      self:FinishCurrentGroup()
    end
  end
))
        root:Run()
      end
      self._state = "start"
      if (self._stairs).current then
        local data = self:GetData("schoosepointevent")
        if data then
          self:OnStairFinish({userInfo = data})
        else
          print("no schoosepointevent after buff choose finish", (debug.traceback)())
        end
      end
    end
  end
end

TowerV2Controller.OnEventDialogDestroy = function(self)
  -- function num : 0_47 , upvalues : _ENV
  (LuaNotificationCenter.AddObserver)(self, self.OnStairFinish, Common.n_TowerV2Response, nil)
  local data = self:GetData("schoosepointevent")
  if data then
    self:OnStairFinish({userInfo = data})
  end
end

TowerV2Controller.OnNewStairs = function(self, notification)
  -- function num : 0_48 , upvalues : bm_towerv2, _ENV
  self:SetBackground()
  local state = bm_towerv2:GetState()
  if state == "fresh" then
    self:Start()
  else
    self:PlaySceneBGM()
    ;
    (self._dialog):Thaw()
    ;
    (self._dialog):HideButton()
    ;
    (DialogManager.DestroySingletonDialog)("towerv2.scene.towerv2defeatdialog")
    self:StartChasing(nil, self._state == "retreatandwait")
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TowerV2Controller.OnStairAwards = function(self, notification)
  -- function num : 0_49
end

local bind = function(stair, binding, index)
  -- function num : 0_50
  local child = stair:GetChild(index)
  binding["Idle_" .. index] = child.object
  binding["Hiden_" .. index] = child.object
end

TowerV2Controller.BindClickTimeline = function(self, stair, index)
  -- function num : 0_51 , upvalues : _ENV, bind, TimelineManager
  local stairtype = stair:GetType()
  local binding = {}
  if stairtype == "unary" then
    LogErrorFormat("towerv2", "unary stair (%d@%d, %s) should not bind click timeline", index, stair:GetID(), stair:GetObject())
  else
    if stairtype == "binary" then
      if index == 1 then
        bind(stair, binding, 3)
      else
        if index == 3 then
          bind(stair, binding, 1)
        end
      end
    else
      if stair == "ternary" then
        for i = 1, 3 do
          if i ~= index then
            bind(stair, binding, i)
          end
        end
      end
    end
  end
  do
    ;
    (TimelineManager.BindTimeline)(((self._sceneRef).clicktimeline).object, binding)
  end
end

TowerV2Controller.BindWorldTimeline = function(self)
  -- function num : 0_52
end

TowerV2Controller.ClearClickTimeline = function(self)
  -- function num : 0_53 , upvalues : TimelineManager
  (TimelineManager.Stop)(((self._sceneRef).clicktimeline).object)
end

TowerV2Controller.BindClickFinishTimeline = function(self, stair, index)
  -- function num : 0_54 , upvalues : _ENV, bind, TimelineManager
  local stairtype = stair:GetType()
  local binding = {}
  if stairtype == "unary" then
    LogErrorFormat("towerv2", "unary stair (%d@%d, %s) should not bind finish timeline", index, stair:GetID(), stair:GetObject())
  else
    for i = 1, 3 do
      if i ~= index then
        bind(stair, binding, i)
      end
    end
  end
  do
    ;
    (TimelineManager.BindTimeline)(((self._sceneRef).approachtimeline).object, binding)
  end
end

TowerV2Controller.OnAutoExploreChange = function(self)
  -- function num : 0_55 , upvalues : bm_towerv2, _ENV
  if not bm_towerv2:IsInAutoExplore() and self._eventTimer then
    (GameTimer.RemoveTask)(self._eventTimer)
  end
  if self._choosing then
    self:AutoChooseEvent()
  end
end

TowerV2Controller.AutoChooseEvent = function(self)
  -- function num : 0_56 , upvalues : _ENV, bm_towerv2
  if self._eventTimer then
    (GameTimer.RemoveTask)(self._eventTimer)
  end
  self._eventTimer = (self._context):AddTask(2, 0, function()
    -- function num : 0_56_0 , upvalues : bm_towerv2, self, _ENV
    local info = bm_towerv2:GetCurrentFloorInfo()
    local selected = bm_towerv2:PickEventByPriority(info.events)
    local event_index, child_index = self:EventIDToChildIndex(selected.id)
    print(event_index, child_index, ((self._stairs).current):GetType())
    ;
    (self:RunEvent(event_index, child_index)):Run()
  end
)
end

local spawn = function(self)
  -- function num : 0_57 , upvalues : bm_towerv2
  return function()
    -- function num : 0_57_0 , upvalues : bm_towerv2, self
    local info = bm_towerv2:GetCurrentFloorInfo()
    local typeid = ((info.cfg).roadAssetList)[self._runningStairIndex]
    local stairtype = "nullary"
    self._runningStairIndex = self._runningStairIndex % #(info.cfg).roadAssetList + 1
    local id, object = self:PrepareStair(typeid)
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._stairs).current = object
    self:SpawnStair(typeid, stairtype)
  end

end

TowerV2Controller.BuildEmptySteps = function(self, step)
  -- function num : 0_58 , upvalues : _ENV, spawn
  local root = (EffectFactory.CreateComposedEffect)()
  local prev = root
  for i = 1, step do
    local proot = (EffectFactory.CreateEffectList)()
    local appear = (EffectFactory.CreateComposedEffect)()
    appear:AddEffect((EffectFactory.CreateCustomEffect)(spawn(self)))
    appear:AddEffect((EffectFactory.CreateDelayedWrapper)(function()
    -- function num : 0_58_0 , upvalues : self
    return ((self._stairs).current):Appear2()
  end
))
    appear:AddEffect((EffectFactory.CreateDelayedWrapper)(function()
    -- function num : 0_58_1 , upvalues : self
    return ((self._stairs).current):Forward2()
  end
))
    local post = (EffectFactory.CreateComposedEffect)()
    post:AddEffect((EffectFactory.CreateDelayEffect)(1, self._context))
    proot:AddEffect(appear)
    proot:AddEffect(post)
    prev:AddEffect(proot)
    prev = post
  end
  return root, prev
end

TowerV2Controller.BuildStartSteps = function(self, step)
  -- function num : 0_59 , upvalues : _ENV, Context, spawn
  local root = (EffectFactory.CreateComposedEffect)()
  local prev = root
  if not self._context then
    self._context = (Context.Create)()
    for i = 1, step do
      local proot = (EffectFactory.CreateEffectList)()
      local appear = (EffectFactory.CreateComposedEffect)()
      appear:AddEffect((EffectFactory.CreateCustomEffect)(spawn(self)))
      appear:AddEffect((EffectFactory.CreateDelayedWrapper)(function()
    -- function num : 0_59_0 , upvalues : _ENV, self
    local seq = (EffectFactory.CreateComposedEffect)()
    seq:AddEffect(((self._stairs).current):Appear2())
    seq:AddEffect(((self._stairs).current):Forward2())
    return seq
  end
))
      if i == 1 then
        if self._currentStartStair then
          appear:AddEffect((self._currentStartStair):Forward2())
        end
        if (self._stairs).current then
          appear:AddEffect(((self._stairs).current):Forward2())
        end
        appear:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_59_1 , upvalues : self
    self:Resume()
    self:SetActorRunning(true)
  end
))
      end
      proot:AddEffect(appear)
      prev:AddEffect(proot)
      local post = (EffectFactory.CreateComposedEffect)()
      post:AddEffect((EffectFactory.CreateDelayEffect)(1, self._context))
      proot:AddEffect(post)
      prev = post
    end
    return root, prev
  end
end

TowerV2Controller.BuildEventAppearStep = function(self)
  -- function num : 0_60 , upvalues : _ENV, bm_towerv2, cstairlevelcfg_typeID_to_stairtype, run_after_dialog
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_60_0 , upvalues : bm_towerv2, cstairlevelcfg_typeID_to_stairtype, self
    local info = bm_towerv2:GetCurrentFloorInfo()
    local typeid = (info.cfg).objectAsset
    local stairtype = cstairlevelcfg_typeID_to_stairtype[(info.cfg).typeID]
    local id, object = self:PrepareStair(typeid)
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._stairs).current = object
    self:SpawnStair(typeid, stairtype)
    self:ShowEventStair()
  end
))
  root:AddEffect((EffectFactory.CreateDelayedWrapper)(function()
    -- function num : 0_60_1 , upvalues : _ENV, self, run_after_dialog, bm_towerv2
    local seq = (EffectFactory.CreateComposedEffect)()
    seq:AddEffect(((self._stairs).current):Appear2())
    if ((self._stairs).current):GetType() == "unary" then
      seq:AddEffect(((self._stairs).current):Approach2())
      seq:AddEffect((EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_60_1_0 , upvalues : self
      self:Pause()
      self:SetActorRunning(false)
    end
))
      seq:AddEffect((EffectFactory.CreateDelayEffect)(1, self._context))
      seq:AddEffect((EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_60_1_1 , upvalues : self
      self._choosing = true
      self._state = "choosing"
      self:OnStairClick()
    end
))
    else
      seq:AddEffect((EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_60_1_2 , upvalues : self, run_after_dialog, _ENV, bm_towerv2
      self:Pause()
      self:SetActorRunning(false)
      self._choosing = true
      self._state = "choosing"
      self._blockStatus = "End"
      ;
      (run_after_dialog(function()
        -- function num : 0_60_1_2_0 , upvalues : _ENV, self
        (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
      end
)):Run()
      ;
      (self._dialog):Refresh()
      if bm_towerv2:IsInAutoExplore() then
        self:AutoChooseEvent()
      else
        ;
        (self._dialog):SetChoiceEffectActive(((self._stairs).current):GetType(), true)
      end
    end
))
    end
    seq:AddEffect((EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_60_1_3 , upvalues : self
      self:PauseBackground()
    end
))
    return seq
  end
))
  return root
end

TowerV2Controller.BuildEventApproachStep = function(self, index)
  -- function num : 0_61 , upvalues : _ENV
  local root = (EffectFactory.CreateComposedEffect)()
  root:AddEffect((EffectFactory.CreateDelayedWrapper)(function()
    -- function num : 0_61_0 , upvalues : _ENV, self, index
    return (EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_61_0_0 , upvalues : self, index
      self:ClearClickTimeline()
      self:BindClickFinishTimeline((self._stairs).current, index)
      ;
      ((self._stairs).current):DetachAll()
    end
)
  end
))
  root:AddEffect((EffectFactory.CreateTimelineEffect)(((self._sceneRef).approachtimeline).director))
  local proot = (EffectFactory.CreateEffectList)()
  proot:AddEffect((EffectFactory.CreateDelayedWrapper)(function()
    -- function num : 0_61_1 , upvalues : _ENV, self
    local seq = (EffectFactory.CreateComposedEffect)()
    seq:AddEffect(((self._stairs).current):Approach2())
    seq:AddEffect(((self._stairs).current):Forward2())
    seq:AddEffect((EffectFactory.CreateDelayEffect)(0.5, self._context))
    seq:AddEffect((EffectFactory.CreateCustomEffect)(function()
      -- function num : 0_61_1_0 , upvalues : self
      self:Resume()
      self:SetActorRunning(true)
    end
))
    return seq
  end
))
  local continuation = (EffectFactory.CreateComposedEffect)()
  proot:AddEffect(continuation)
  root:AddEffect(proot)
  return root, continuation
end

TowerV2Controller.PlayTimeline = function(self, director)
  -- function num : 0_62
  director:Play()
end

TowerV2Controller.IgnoreSpeed = function(self)
  -- function num : 0_63
  return true
end

TowerV2Controller.PlaySceneBGM = function(self)
  -- function num : 0_64 , upvalues : bm_towerv2, _ENV
  local bgm = bm_towerv2:GetBGM()
  if self._bgm and self._bgm ~= bgm then
    (LuaAudioManager.StopBGM)(self._bgm)
  end
  self._bgm = bgm
  ;
  (LuaAudioManager.PlayBGM)(self._bgm)
end

TowerV2Controller.SetBackground = function(self)
  -- function num : 0_65 , upvalues : bm_towerv2, _ENV, PrefabLoader, TransformStaticFunctions, TimelineManager
  local changed = false
  local bgs = bm_towerv2:GetBackgrounds()
  if not self._backgrounds then
    self._backgrounds = {}
    for i,v in ipairs(bgs) do
      if not (self._backgrounds)[i] or ((self._backgrounds)[i]).id ~= v.id then
        if (self._backgrounds)[i] then
          (((CS.UnityEngine).GameObject).Destroy)(((self._backgrounds)[i]).object)
        end
        -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (self._backgrounds)[i] = {id = v.id, object = (PrefabLoader.LoadAndInstantiatePrefab)(v.assetbundle, v.assetname)}
        print("background", ((self._backgrounds)[i]).id, ((self._backgrounds)[i]).object, (((self._sceneRef).background).node)[i], i, v)
        ;
        (TransformStaticFunctions.SetParent)((((self._backgrounds)[i]).object).transform, ((((self._sceneRef).background).node)[i]).transform)
        changed = true
      end
    end
    if changed then
      (((self._sceneRef).background).director):Play()
    end
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (((self._sceneRef).background).director).time = 0
    ;
    (TimelineManager.Pause)(((self._sceneRef).background).object)
  end
end

TowerV2Controller.ResetBackground = function(self)
  -- function num : 0_66 , upvalues : TimelineManager
  (((self._sceneRef).background).director):Play()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((self._sceneRef).background).director).time = 0
  ;
  (TimelineManager.Pause)(((self._sceneRef).background).object)
end

TowerV2Controller.MoveBackground = function(self)
  -- function num : 0_67 , upvalues : TimelineManager
  (TimelineManager.Resume)(((self._sceneRef).background).object)
end

TowerV2Controller.PauseBackground = function(self)
  -- function num : 0_68 , upvalues : TimelineManager
  (TimelineManager.Pause)(((self._sceneRef).background).object)
end

return TowerV2Controller

