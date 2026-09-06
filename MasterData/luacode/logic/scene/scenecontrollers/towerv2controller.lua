local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local TowerV2Controller = class("TowerV2Controller", SceneController)
local TowerStair = require("logic.scene.types.towerstair")
local TimelineManager = CS.PixelNeko.P1.TimeLine.TimelineManager
local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local Context = require("logic.scene.luaevent.effect.context")
local cstairvarcfg = BeanManager.GetTableByName("dungeonselect.cstairvarcfg")
local event_spawn_time = tonumber(cstairvarcfg:GetRecorder(3).value)
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2Controller:Init()
  self._stairs = {
    current = nil,
    running = {},
    hidden = {},
    count = 0
  }
  self._startStairs = {}
  self._currentStartStair = nil
  self._time = 0
  self._paused = true
  self._blockStatus = ""
  TowerStair.SetSpeed(tonumber(cstairvarcfg:GetRecorder(4).value))
  local dir = string.sub(cstairvarcfg:GetRecorder(7).value, 2, -2)
  dir = string.split(dir, ",")
  TowerStair.SetVelocity({
    x = tonumber(dir[1]),
    y = tonumber(dir[2]),
    z = tonumber(dir[3])
  })
  self._dialog = DialogManager.CreateSingletonDialog("towerv2.scene.towerv2scenedialog")
  self._dialog:Init(self)
  self._currentInfo = self:GetData("floorinfo")
  self._runningStairIndex = 1
  LuaNotificationCenter.AddObserver(self, self.OnNewStairs, Common.n_TowerV2Refresh, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBattleRewardEnd, Common.n_BattleRewardEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnStairFinish, Common.n_TowerV2Response, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAutoExploreChange, Common.n_TowerV2AutoExplore)
  self:PlaySceneBGM()
  self:Start()
end

function TowerV2Controller:OnDestroy()
  if self._dialog then
    self._dialog:Destroy()
  end
  LuaNotificationCenter.RemoveObserver(self)
  for _, l in pairs(self._startStairs) do
    l:Destroy()
  end
  for _, l in pairs(self._stairs.hidden) do
    for _, v in pairs(l) do
      v:Destroy()
    end
  end
  for _, v in pairs(self._stairs.running) do
    v:Destroy()
  end
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  if self._eventTimer then
    GameTimer.RemoveTask(self._eventTimer)
  end
  if self._context then
    self._context:Destroy()
  end
  NekoData.DataManager.DM_Dungeon:SetMode()
end

function TowerV2Controller:GetMainCamera()
  return self._sceneRef.mainCamera
end

function TowerV2Controller:PrepareStair(typeid)
  self._stairs.hidden[typeid] = self._stairs.hidden[typeid] or {}
  local object = self._stairs.hidden[typeid][1]
  if not object then
    self._stairs.count = self._stairs.count + 1
    object = TowerStair.Create(self._stairs.count, typeid, self)
    object:BuildObject(self._sceneRef.spawnPoint)
    self._stairs.hidden[typeid][#self._stairs.hidden[typeid] + 1] = object
  end
  return object:GetID(), object
end

function TowerV2Controller:PrepareStartStair(typeid)
  if not self._startStairs[typeid] then
    local object = TowerStair.Create(self._stairs.count, typeid, self)
    TowerStair.Create(typeid * -1, typeid, self)
    object:BuildObject(self._sceneRef.startPoint)
    self._startStairs[typeid] = object
    object:SetType("nullary")
  end
  self._rightChildObject = TransformStaticFunctions.GetChild(self._startStairs[typeid]:GetObject(), "Row_11")
  if not self._rightChildObject then
    self._rightChildObject = TransformStaticFunctions.GetChild(self._startStairs[typeid]:GetObject(), "Row_10")
  end
  return self._startStairs[typeid]
end

function TowerV2Controller:RecycleStair(typeid)
  local index, object
  for i, v in ipairs(self._stairs.running) do
    if v:GetTypeID() == typeid then
      index = i
      object = v
      break
    end
  end
  if not object then
    LogErrorFormat("tower stair", "recycle invalid stair type %d", typeid)
    return
  end
  self._stairs.running[index]:Hide()
  self._stairs.hidden[typeid][#self._stairs.hidden[typeid] + 1] = self._stairs.running[index]
  table.remove(self._stairs.running, index)
  return object
end

function TowerV2Controller:SpawnStair(typeid, stairtype)
  local object = self._stairs.hidden[typeid][1]
  if not object then
    LogErrorFormat("tower stair", "no %d stair to spawn", typeid)
    return
  end
  object:SetType(stairtype)
  self._stairs.running[#self._stairs.running + 1] = object
  table.remove(self._stairs.hidden[typeid], 1)
  return object
end

local cstairlevelcfg_typeID_to_stairtype = {
  "unary",
  "binary",
  "ternary",
  "unary"
}

function TowerV2Controller:Start()
  local state = bm_towerv2:GetState()
  if state == "retreat" then
    self:RetreatAndRestart()
  elseif state == "fresh" then
    self:FreshStart()
  elseif state == "continue" then
    self:Continue()
  elseif state == "finished" then
    self:FinishCurrentGroup()
  elseif state == "complete" then
    self:Complete()
  elseif state == "reset" then
    self:Reset()
  elseif state == "buffchoose" then
    self:BuffChoose()
  end
  self._state = "start"
end

local function reset_actor_animator(actor)
  AnimationHelper.PlayAnimation2(actor, "New State", 0, 0)
end

function TowerV2Controller:PrepareInit(id)
  for _, v in pairs(self._startStairs) do
    v:Hide()
  end
  local obj = self:PrepareStartStair(id)
  self._currentStartStair = obj
  obj:SetType("nullary")
  obj:Appear2():Run()
  self:Pause()
  self._dialog:Freeze()
  reset_actor_animator(self._sceneRef.actor.object)
end

function TowerV2Controller:GetState()
  return self._state
end

function TowerV2Controller:FreshStart()
  self:PrepareInit(bm_towerv2:GetStartStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = EffectFactory.CreateComposedEffect()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 0)
  effect:Bind(self._sceneRef.actor.object)
  root:AddEffect(effect)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    self._dialog:Thaw()
    self._dialog:Refresh()
    self._dialog:MoveMid(math.max(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
  end))
  root:Run()
end

function TowerV2Controller:Continue()
  self:PrepareInit(bm_towerv2:GetStartStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = EffectFactory.CreateComposedEffect()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 1)
  effect:Bind(self._sceneRef.actor.object)
  root:AddEffect(effect)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    self._dialog:Thaw()
    self._dialog:Refresh()
    self._dialog:ShowContinue()
    self._dialog:MoveMid(math.max(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
    local id, buff = bm_towerv2:GetLastBuffCandidates()
    if id and id < bm_towerv2:GetCurrentFloorID() then
      DialogManager.CreateSingletonDialog("towerv2.towerv2buffchoosedialog"):SetData(id, buff, self)
    end
  end))
  root:Run()
end

function TowerV2Controller:RetreatAndRestart()
  self:Clear()
  self:PrepareInit(bm_towerv2:GetRetreatStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = EffectFactory.CreateComposedEffect()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 1)
  effect:Bind(self._sceneRef.actor.object)
  root:AddEffect(effect)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    self._dialog:Thaw()
    self._dialog:Refresh()
    self._dialog:ShowContinue()
    self._dialog:MoveMid(math.max(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
  end))
  root:Run()
end

function TowerV2Controller:RetreatAndWait()
  self:Clear()
  self:PrepareInit(bm_towerv2:GetRetreatStair(bm_towerv2:GetCurrentFloorID()))
  self:ResetBackground()
  local root = EffectFactory.CreateComposedEffect()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 2, "DefeatIdle", 2)
  effect:Bind(self._sceneRef.actor.object)
  root:AddEffect(effect)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    self._dialog:ShowRetreat()
    self._dialog:MoveMid(math.max(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
    self._dialog:Freeze()
    local dialog = DialogManager.CreateSingletonDialog("towerv2.scene.towerv2defeatdialog")
    dialog:Refresh()
    LuaNotificationCenter.AddObserver(self, function(observer, notification)
      if notification.userInfo._dialogKey == dialog._dialogKey then
        LuaNotificationCenter.RemoveObserver(self, Common.n_DialogWillDestroy)
        self._dialog:Thaw()
        self._dialog:Refresh()
      end
    end, Common.n_DialogWillDestroy, nil)
  end))
  root:Run()
  self._state = "retreatandwait"
end

function TowerV2Controller:FinishCurrentGroup()
  self:Clear()
  self:PrepareInit(bm_towerv2:GetFinishStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = EffectFactory.CreateComposedEffect()
  local info = bm_towerv2:GetCurrentFloorInfo()
  local world = tonumber(info.world)
  if self._sceneRef.worldtimeline.director[world] then
    root:AddEffect(EffectFactory.CreateTimelineEffect(self._sceneRef.worldtimeline.director[world]))
  end
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 1)
  effect:Bind(self._sceneRef.actor.object)
  root:AddEffect(effect)
  
  local function show_reward()
    local dialog = DialogManager.CreateSingletonDialog("towerv2.scene.towerv2rewarddialog")
    dialog:SetData(bm_towerv2:GetLastRewards())
    LuaNotificationCenter.AddObserver(self, function(observer, notification)
      if notification.userInfo._dialogKey == dialog._dialogKey then
        LuaNotificationCenter.RemoveObserver(self, Common.n_DialogWillDestroy)
        self._dialog:Thaw()
        self._dialog:Refresh()
      end
    end, Common.n_DialogWillDestroy, nil)
  end
  
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    local id, buff = bm_towerv2:GetLastBuffCandidates()
    if id then
      local dialog = DialogManager.CreateSingletonDialog("towerv2.towerv2buffchoosedialog")
      dialog:SetData(id, buff, self)
    else
      show_reward()
    end
  end))
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    if bm_towerv2:IsInAutoExplore() then
      DialogManager.CreateSingletonDialog("towerv2.towerv2autoconfirmdialog")
    end
  end))
  root:Run()
end

function TowerV2Controller:Complete()
  self:Clear()
  self:PrepareInit(bm_towerv2:GetFinishStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = EffectFactory.CreateComposedEffect()
  local info = bm_towerv2:GetCurrentFloorInfo()
  local world = tonumber(info.world)
  if self._sceneRef.worldtimeline.director[world] then
    root:AddEffect(EffectFactory.CreateTimelineEffect(self._sceneRef.worldtimeline.director[world]))
  end
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 1)
  effect:Bind(self._sceneRef.actor.object)
  root:AddEffect(effect)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    local dialog = DialogManager.CreateSingletonDialog("towerv2.scene.towerv2completedialog")
    dialog:SetData(bm_towerv2:GetLastRewards())
    LuaNotificationCenter.AddObserver(self, function(observer, notification)
      if notification.userInfo._dialogKey == dialog._dialogKey then
        LuaNotificationCenter.RemoveObserver(self, Common.n_DialogWillDestroy)
        self._dialog:Thaw()
        self._dialog:Refresh()
      end
    end, Common.n_DialogWillDestroy, nil)
  end))
  root:Run()
end

function TowerV2Controller:Reset()
  self:PrepareInit(bm_towerv2:GetStartStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = EffectFactory.CreateComposedEffect()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 1)
  effect:Bind(self._sceneRef.actor.object)
  root:AddEffect(effect)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    self._dialog:Thaw()
    self._dialog:Refresh()
    self._dialog:MoveMid(math.max(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
    DialogManager.CreateSingletonDialog("towerv2.towerv2revertdialog")
  end))
  root:Run()
end

function TowerV2Controller:BuffChoose()
  self:PrepareInit(bm_towerv2:GetStartStair(bm_towerv2:GetCurrentFloorID()))
  self:SetBackground()
  local root = EffectFactory.CreateComposedEffect()
  local effect = EffectFactory.CreateAnimatorStateChangeEffect(nil, "state", 1)
  effect:Bind(self._sceneRef.actor.object)
  root:AddEffect(effect)
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    self._dialog:Thaw()
    self._dialog:Refresh()
    self._dialog:MoveMid(math.max(0, bm_towerv2:GetCurrentFloorIndex() - 1), true)
    local candidates = NekoData.BehaviorManager.BM_TowerV2:GetInitBuffCandidates()
    DialogManager.CreateSingletonDialog("towerv2.towerv2buffchoosedialog"):SetData(nil, candidates, self, bm_towerv2:GetInitBuffProgress())
  end))
  root:Run()
end

function TowerV2Controller:Clear()
  local typeids = table.select(self._stairs.running, function(v, k)
    return v:GetTypeID()
  end)
  for _, v in pairs(typeids) do
    self:RecycleStair(v)
  end
  for _, v in pairs(self._startStairs) do
    v:Hide()
  end
end

function TowerV2Controller:Update(deltaTime, unscaleDeltaTime)
  local count = #self._stairs.running
  local isMoveEnd = true
  for i, v in ipairs(self._stairs.running) do
    local state = v:GetState()
    if state == "approach" or state == "appear" then
      v:OnUpdate(deltaTime, unscaleDeltaTime)
    end
    if state == "show" or state == "reach" or state == "running" then
    else
      isMoveEnd = false
    end
    for c = 3, 0, -1 do
      v:SetSortingOrder(c, (count - i + 1) * 3 + c - 3 - 64)
    end
  end
  if isMoveEnd and self._currentStartStair and self._currentStartStair:GetState() == "running" and not self._paused then
    self:SetActorRunning(true)
    self._currentStartStair:OnMoveUpdate(deltaTime, unscaleDeltaTime)
    for i, v in ipairs(self._stairs.running) do
      v:OnMoveUpdate(deltaTime, unscaleDeltaTime)
    end
    if self._stairs.running[#self._stairs.running - 1] then
      local currentRolePos = CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(self._sceneRef.actor.object))
      local targetRolePos = CS.UnityEngine.Vector3(TransformStaticFunctions.GetPosition(self._stairs.running[#self._stairs.running - 1]:GetObject()))
      local distance = CS.UnityEngine.Vector3.Distance(currentRolePos, targetRolePos)
      if distance < 0.1 then
        self:OnRoleMoveToTarget()
      end
    end
  end
end

function TowerV2Controller:OnDisable()
  self._backgrounds = self._backgrounds or {}
  self._backgrounds.time = self._sceneRef.background.director.time
end

function TowerV2Controller:OnEnable()
  if self._backgrounds and self._backgrounds.time then
    self._sceneRef.background.director:Play()
    self._sceneRef.background.director.time = self._backgrounds.time
    self._backgrounds.time = nil
    self:PauseBackground()
  end
end

function TowerV2Controller:OnRoleMoveToTarget()
  self:Pause()
  self:SetActorRunning(false)
  self._choosing = true
  self._state = "choosing"
end

function TowerV2Controller:Pause()
  self._paused = true
end

function TowerV2Controller:Resume()
  self._paused = false
  self._time = 0
end

local function run_after_dialog(func)
  return EffectFactory.CreateDelayedWrapper(function()
    return EffectFactory.CreateCustomEffect(function()
      local dlg
      for _, v in pairs({
        "towerv2.towerv2rewardpreviewdialog",
        "towerv2.towerv2buffdialog",
        "towerv2.towerv2tipdialog",
        "character.newcharacterinfodialog"
      }) do
        dlg = DialogManager.GetDialog(v)
        if dlg then
          LuaNotificationCenter.AddObserver(func, function(observer, notification)
            if notification.userInfo._dialogKey == dlg._dialogKey then
              LuaNotificationCenter.RemoveObserver(func, Common.n_DialogWillDestroy)
              func()
            end
          end, Common.n_DialogWillDestroy, nil)
          break
        end
      end
      if not dlg then
        func()
      end
    end)
  end)
end

function TowerV2Controller:StartChasing(timeout, instantrun)
  timeout = timeout or 2
  self:Resume()
  local root = EffectFactory.CreateComposedEffect()
  if self._state == "retreatandwait" then
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      self._timer = GameTimer.AddTask(1, 0, function()
        self:SetActorRunning(true)
      end, nil)
    end))
  end
  self._blockStatus = "Start"
  local start, continuation = self:BuildStartSteps(2)
  root:AddEffect(start)
  continuation:AddEffect(self:BuildEventAppearStep())
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    self._blockStatus = "End"
  end))
  root:AddEffect(run_after_dialog(function()
    LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
  end))
  root:Run()
  self:MoveBackground()
  self._state = "running"
  self._dialog:MoveMid(bm_towerv2:GetCurrentFloorIndex(), false)
end

function TowerV2Controller:SetActorRunning(running)
  local state
  if running then
    state = 4
  else
    state = 1
  end
  AnimationHelper.SetAnimatorInteger2(self._sceneRef.actor.object, "state", state)
end

local function attach(object, events, index, point)
  local event = events[index]
  object:Attach(point, event.assetBundle, event.assetName)
  if event.alterAssetBundle then
    object:Attach(point, event.alterAssetBundle, event.alterAssetName)
  end
end

function TowerV2Controller:ShowEventStair()
  local info = bm_towerv2:GetCurrentFloorInfo()
  if info.type == 1 then
    attach(self._stairs.current, info.events, 1, 2)
  elseif info.type == 2 then
    attach(self._stairs.current, info.events, 1, 1)
    attach(self._stairs.current, info.events, 2, 3)
  elseif info.type == 3 then
    for i = 1, 3 do
      attach(self._stairs.current, info.events, i, i)
    end
  elseif info.type == 4 then
    attach(self._stairs.current, info.events, 1, 0)
  end
end

function TowerV2Controller:OnBattleStair(index, info)
  bm_towerv2:ChooseEvent(bm_towerv2:GetCurrentFloorID(), index - 1, 0)
  self._battleFloor = bm_towerv2:GetCurrentFloorID()
  LuaNotificationCenter.RemoveObserver(self, Common.n_TowerV2Response)
  self._dialog:Freeze()
end

function TowerV2Controller:OnChestStair(index, info)
  local dialog = DialogManager.CreateSingletonDialog("towerv2.towerv2chestdialog")
  dialog:SetData(info.id, index, 3, self)
end

function TowerV2Controller:OnBuffStair(index, info)
  bm_towerv2:ChooseEvent(bm_towerv2:GetCurrentFloorID(), index - 1, 0)
end

function TowerV2Controller:OnBestQualityChestStair(index, info)
  local dialog = DialogManager.CreateSingletonDialog("towerv2.towerv2chestdialog")
  dialog:SetData(info.id, index, 5, self)
end

function TowerV2Controller:OnEventStair(index, info)
  local dialog = DialogManager.CreateSingletonDialog("towerv2.towerv2eventdialog")
  dialog:SetData(index, info.id, self)
  LuaNotificationCenter.RemoveObserver(self, Common.n_TowerV2Response)
end

function TowerV2Controller:OnShrineStair(index, info)
  local dialog = DialogManager.CreateSingletonDialog("towerv2.towerv2shrinedialog")
  dialog:SetData(info.id, index, self)
end

local handler = {
  [1] = TowerV2Controller.OnBattleStair,
  [2] = TowerV2Controller.OnBattleStair,
  [3] = TowerV2Controller.OnChestStair,
  [4] = TowerV2Controller.OnBattleStair,
  [5] = TowerV2Controller.OnBestQualityChestStair,
  [6] = TowerV2Controller.OnEventStair,
  [7] = TowerV2Controller.OnBattleStair,
  [8] = TowerV2Controller.OnShrineStair,
  [9] = TowerV2Controller.OnBuffStair
}

function TowerV2Controller:OnStairClick(object)
  if not self._choosing then
    return
  end
  
  local function f()
    local info = bm_towerv2:GetCurrentFloorInfo()
    local event_index, child_index = self:ObjectToEventIndex(object)
    if info.events[event_index] and not self._clicked then
      self._dialog:Freeze(true)
      local effect = self:RunEvent(event_index, child_index)
      effect:Run()
      effect:Then(function()
        self._dialog:Thaw()
      end)
    end
  end
  
  run_after_dialog(f):Run()
end

function TowerV2Controller:ObjectToEventIndex(object)
  local stairtype = self._stairs.current:GetType()
  local event_index, child_index
  if stairtype == "unary" then
    event_index = 1
  elseif stairtype == "nullary" then
    return
  else
    child_index = self._stairs.current:MapChildren(object)
    if child_index == -1 then
      LogErrorFormat("towerv2", "invalid child click %d at event %d", child_index, bm_towerv2:GetCurrentFloorID())
      return
    end
    if stairtype == "binary" then
      if child_index == 1 then
        event_index = 1
      elseif child_index == 3 then
        event_index = 2
      else
        LogErrorFormat("towerv2", "invalid child click %d at binary event %d", child_index, bm_towerv2:GetCurrentFloorID())
        return
      end
    elseif stairtype == "ternary" then
      event_index = child_index
    end
  end
  return event_index, child_index
end

function TowerV2Controller:EventIDToChildIndex(eventid)
  local index = self:EventIDToEventIndex(eventid)
  return self:EventIndexToChildIndex(index)
end

function TowerV2Controller:EventIDToEventIndex(id)
  local info = bm_towerv2:GetCurrentFloorInfo()
  return table.first(info.events, function(k, v)
    return v.id == id
  end)
end

function TowerV2Controller:EventIndexToChildIndex(index)
  local stairtype = self._stairs.current:GetType()
  if stairtype == "unary" then
    return 1, 1
  elseif stairtype == "binary" then
    if index == 1 then
      return 1, 1
    elseif index == 2 then
      return 2, 3
    end
  elseif stairtype == "ternary" then
    return index, index
  end
end

function TowerV2Controller:RunEvent(event_index, child_index)
  if self._clicked then
    return EffectFactory.CreateCustomEffect(function()
    end)
  end
  local info = bm_towerv2:GetCurrentFloorInfo()
  local stairtype = self._stairs.current:GetType()
  self:Pause()
  self._clicked = true
  if stairtype == "unary" then
    return EffectFactory.CreateCustomEffect(function()
      handler[info.events[event_index].type](self, event_index, info.events[event_index])
    end)
  else
    self:BindClickTimeline(self._stairs.current, child_index)
    self._dialog:SetChoiceEffectActive(self._stairs.current:GetType(), false)
    local root = EffectFactory.CreateComposedEffect()
    root:AddEffect(EffectFactory.CreateTimelineEffect(self._sceneRef.clicktimeline.director))
    root:AddEffect(EffectFactory.CreateCustomEffect(function()
      handler[info.events[event_index].type](self, event_index, info.events[event_index])
    end))
    return root
  end
end

function TowerV2Controller:OnDialogDestroy(event_index)
  self:ClearClickTimeline()
  self._stairs.current:SetAttachmentActive(true)
  self._clicked = false
end

function TowerV2Controller:OnStairFinish(notification)
  self._choosing = false
  local protocol = notification.userInfo.protocol
  if protocol.EventID == -1 then
    return
  end
  local current = self._stairs.current
  if not current then
    LogErrorFormat("towerv2", "no current stair on finish")
    return
  end
  local hpchange = notification.userInfo.hpchange
  self._dialog:HideChooseText()
  self._clicked = false
  self._state = "running"
  self._dialog:Refresh()
  local root, continuation
  root = EffectFactory.CreateComposedEffect()
  self._blockStatus = "Start"
  if hpchange == -1 then
    AnimationHelper.SetAnimatorTrigger2(self._sceneRef.actor.object, "onDebuff")
  elseif hpchange == 1 then
    AnimationHelper.SetAnimatorTrigger2(self._sceneRef.actor.object, "onHeal")
  end
  if current:GetType() == "unary" then
    current:DetachAll()
    local steps
    steps, continuation = self:BuildStartSteps(2)
    root:AddEffect(steps)
  else
    local _, index = self:EventIndexToChildIndex(protocol.pointIndex + 1)
    local steps
    steps, continuation = self:BuildEventApproachStep(index)
    root:AddEffect(steps)
    local effect, continuation2 = self:BuildEmptySteps(2)
    continuation:AddEffect(effect)
    continuation = continuation2
  end
  continuation:AddEffect(self:BuildEventAppearStep())
  root:Run()
  self:MoveBackground()
  self._dialog:MoveMid(bm_towerv2:GetCurrentFloorIndex(), false)
end

function TowerV2Controller:OnBattleRewardEnd(notification)
  self._dialog:Thaw()
  self._clicked = false
  LuaNotificationCenter.AddObserver(self, self.OnStairFinish, Common.n_TowerV2Response, nil)
  if notification.userInfo.battleResult == 0 then
    self:RetreatAndWait()
  elseif notification.userInfo.battleResult == 1 then
    local info
    if self._battleFloor then
      info = bm_towerv2:GetFloorInfoByID(self._battleFloor)
    else
      info = bm_towerv2:GetCurrentFloorInfo()
    end
    if #info.buff ~= 0 then
      self._dialog:SetExploreTextActive(false)
      self._dialog:SetChooseTextActive(true)
      DialogManager.CreateSingletonDialog("towerv2.towerv2buffchoosedialog"):SetData(info.id, {
        info.buff
      }, self)
    elseif info.type == 4 then
      self._state = "start"
      local state = bm_towerv2:GetState()
      if state == "complete" then
        self:Complete()
      else
        self:FinishCurrentGroup()
      end
    else
      local data = self:GetData("schoosepointevent")
      if data then
        self:OnStairFinish({userInfo = data})
      end
    end
    self._choosing = false
  end
end

function TowerV2Controller:OnBuffChooseFinish(id)
  if not id then
    return
  end
  local info = bm_towerv2:GetFloorInfoByID(id)
  if info.type == 4 then
    if not DialogManager.GetDialog("towerv2.scene.towerv2rewarddialog") then
      local root = self._dialog:ShowEffect()
      root:AddEffect(EffectFactory.CreateCustomEffect(function()
        local state = bm_towerv2:GetState()
        if state == "complete" then
          self:Complete()
        else
          self:FinishCurrentGroup()
        end
      end))
      root:Run()
    end
    self._state = "start"
  elseif self._stairs.current then
    local data = self:GetData("schoosepointevent")
    if data then
      self:OnStairFinish({userInfo = data})
    else
      print("no schoosepointevent after buff choose finish", debug.traceback())
    end
  end
end

function TowerV2Controller:OnEventDialogDestroy()
  LuaNotificationCenter.AddObserver(self, self.OnStairFinish, Common.n_TowerV2Response, nil)
  local data = self:GetData("schoosepointevent")
  if data then
    self:OnStairFinish({userInfo = data})
  end
end

function TowerV2Controller:OnNewStairs(notification)
  self:SetBackground()
  local state = bm_towerv2:GetState()
  if state == "fresh" then
    self:Start()
    self._dialog:Thaw()
  else
    self:PlaySceneBGM()
    self._dialog:Thaw()
    self._dialog:HideButton()
    DialogManager.DestroySingletonDialog("towerv2.scene.towerv2defeatdialog")
    self:StartChasing(nil, self._state == "retreatandwait")
  end
end

function TowerV2Controller:OnStairAwards(notification)
end

local function bind(stair, binding, index)
  local child = stair:GetChild(index)
  binding["Idle_" .. index] = child.object
  binding["Hiden_" .. index] = child.object
end

function TowerV2Controller:BindClickTimeline(stair, index)
  local stairtype = stair:GetType()
  local binding = {}
  if stairtype == "unary" then
    LogErrorFormat("towerv2", "unary stair (%d@%d, %s) should not bind click timeline", index, stair:GetID(), stair:GetObject())
  elseif stairtype == "binary" then
    if index == 1 then
      bind(stair, binding, 3)
    elseif index == 3 then
      bind(stair, binding, 1)
    end
  elseif stair == "ternary" then
    for i = 1, 3 do
      if i ~= index then
        bind(stair, binding, i)
      end
    end
  end
  TimelineManager.BindTimeline(self._sceneRef.clicktimeline.object, binding)
end

function TowerV2Controller:BindWorldTimeline()
end

function TowerV2Controller:ClearClickTimeline()
  TimelineManager.Stop(self._sceneRef.clicktimeline.object)
end

function TowerV2Controller:BindClickFinishTimeline(stair, index)
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
  TimelineManager.BindTimeline(self._sceneRef.approachtimeline.object, binding)
end

function TowerV2Controller:OnAutoExploreChange()
  if not bm_towerv2:IsInAutoExplore() then
    if self._eventTimer then
      GameTimer.RemoveTask(self._eventTimer)
    end
  elseif self._choosing then
    self:AutoChooseEvent()
  end
end

function TowerV2Controller:AutoChooseEvent()
  if self._eventTimer then
    GameTimer.RemoveTask(self._eventTimer)
  end
  self._eventTimer = self._context:AddTask(2, 0, function()
    local info = bm_towerv2:GetCurrentFloorInfo()
    local selected = bm_towerv2:PickEventByPriority(info.events)
    local event_index, child_index = self:EventIDToChildIndex(selected.id)
    print(event_index, child_index, self._stairs.current:GetType())
    self:RunEvent(event_index, child_index):Run()
  end)
end

local function spawn(self)
  return function()
    local info = bm_towerv2:GetCurrentFloorInfo()
    local typeid = info.cfg.roadAssetList[self._runningStairIndex]
    local stairtype = "nullary"
    self._runningStairIndex = self._runningStairIndex % #info.cfg.roadAssetList + 1
    local id, object = self:PrepareStair(typeid)
    self._stairs.current = object
    self:SpawnStair(typeid, stairtype)
  end
end

function TowerV2Controller:BuildEmptySteps(step)
  local root = EffectFactory.CreateComposedEffect()
  local prev = root
  for i = 1, step do
    local proot = EffectFactory.CreateEffectList()
    local appear = EffectFactory.CreateComposedEffect()
    appear:AddEffect(EffectFactory.CreateCustomEffect(spawn(self)))
    appear:AddEffect(EffectFactory.CreateDelayedWrapper(function()
      return self._stairs.current:Appear2()
    end))
    local post = EffectFactory.CreateComposedEffect()
    post:AddEffect(EffectFactory.CreateDelayEffect(1, self._context))
    proot:AddEffect(appear)
    proot:AddEffect(post)
    prev:AddEffect(proot)
    prev = post
  end
  return root, prev
end

function TowerV2Controller:BuildStartSteps(step)
  local root = EffectFactory.CreateComposedEffect()
  local prev = root
  self._context = self._context or Context.Create()
  for i = 1, step do
    local proot = EffectFactory.CreateEffectList()
    local appear = EffectFactory.CreateComposedEffect()
    appear:AddEffect(EffectFactory.CreateCustomEffect(spawn(self)))
    appear:AddEffect(EffectFactory.CreateDelayedWrapper(function()
      local seq = EffectFactory.CreateComposedEffect()
      seq:AddEffect(self._stairs.current:Appear2())
      return seq
    end))
    if i == step then
      if self._currentStartStair then
        appear:AddEffect(self._currentStartStair:Forward2())
      end
      appear:AddEffect(EffectFactory.CreateCustomEffect(function()
        self:Resume()
      end))
    end
    proot:AddEffect(appear)
    prev:AddEffect(proot)
    local post = EffectFactory.CreateComposedEffect()
    post:AddEffect(EffectFactory.CreateDelayEffect(1, self._context))
    proot:AddEffect(post)
    prev = post
  end
  return root, prev
end

function TowerV2Controller:BuildEventAppearStep()
  local root = EffectFactory.CreateComposedEffect()
  root:AddEffect(EffectFactory.CreateCustomEffect(function()
    local info = bm_towerv2:GetCurrentFloorInfo()
    local typeid = info.cfg.objectAsset
    local stairtype = cstairlevelcfg_typeID_to_stairtype[info.cfg.typeID]
    local id, object = self:PrepareStair(typeid)
    self._stairs.current = object
    self:SpawnStair(typeid, stairtype)
    self:ShowEventStair()
  end))
  root:AddEffect(EffectFactory.CreateDelayedWrapper(function()
    local seq = EffectFactory.CreateComposedEffect()
    seq:AddEffect(self._stairs.current:Appear2())
    if self._stairs.current:GetType() == "unary" then
      seq:AddEffect(self._stairs.current:Approach2())
      seq:AddEffect(EffectFactory.CreateCustomEffect(function()
      end))
      seq:AddEffect(EffectFactory.CreateDelayEffect(1, self._context))
      seq:AddEffect(EffectFactory.CreateCustomEffect(function()
        self:OnStairClick()
      end))
    else
      seq:AddEffect(EffectFactory.CreateCustomEffect(function()
        self._blockStatus = "End"
        run_after_dialog(function()
          LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
        end):Run()
        self._dialog:Refresh()
        if bm_towerv2:IsInAutoExplore() then
          self:AutoChooseEvent()
        else
          self._dialog:SetChoiceEffectActive(self._stairs.current:GetType(), true)
        end
      end))
    end
    seq:AddEffect(EffectFactory.CreateCustomEffect(function()
      self:PauseBackground()
    end))
    return seq
  end))
  return root
end

function TowerV2Controller:BuildEventApproachStep(index)
  local root = EffectFactory.CreateComposedEffect()
  root:AddEffect(EffectFactory.CreateDelayedWrapper(function()
    return EffectFactory.CreateCustomEffect(function()
      self:ClearClickTimeline()
      self:BindClickFinishTimeline(self._stairs.current, index)
      self._stairs.current:DetachAll()
    end)
  end))
  root:AddEffect(EffectFactory.CreateTimelineEffect(self._sceneRef.approachtimeline.director))
  local proot = EffectFactory.CreateEffectList()
  proot:AddEffect(EffectFactory.CreateDelayedWrapper(function()
    local seq = EffectFactory.CreateComposedEffect()
    seq:AddEffect(self._stairs.current:Approach2())
    seq:AddEffect(EffectFactory.CreateDelayEffect(1, self._context))
    seq:AddEffect(EffectFactory.CreateCustomEffect(function()
      self:Resume()
    end))
    return seq
  end))
  local continuation = EffectFactory.CreateComposedEffect()
  proot:AddEffect(continuation)
  root:AddEffect(proot)
  return root, continuation
end

function TowerV2Controller:PlayTimeline(director)
  director:Play()
end

function TowerV2Controller:IgnoreSpeed()
  return true
end

function TowerV2Controller:PlaySceneBGM()
  local bgm = bm_towerv2:GetBGM()
  if self._bgm and self._bgm ~= bgm then
    LuaAudioManager.StopBGM(self._bgm)
  end
  self._bgm = bgm
  LuaAudioManager.PlayBGM(self._bgm)
end

function TowerV2Controller:SetBackground()
  local changed = false
  local bgs = bm_towerv2:GetBackgrounds()
  self._backgrounds = self._backgrounds or {}
  for i, v in ipairs(bgs) do
    if not self._backgrounds[i] or self._backgrounds[i].id ~= v.id then
      if self._backgrounds[i] then
        CS.UnityEngine.GameObject.Destroy(self._backgrounds[i].object)
      end
      self._backgrounds[i] = {
        id = v.id,
        object = PrefabLoader.LoadAndInstantiatePrefab(v.assetbundle, v.assetname)
      }
      print("background", self._backgrounds[i].id, self._backgrounds[i].object, self._sceneRef.background.node[i], i, v)
      TransformStaticFunctions.SetParent(self._backgrounds[i].object.transform, self._sceneRef.background.node[i].transform)
      changed = true
    end
  end
  if changed then
    self._sceneRef.background.director:Play()
  end
  self._sceneRef.background.director.time = 0
  if self._sceneRef.background.object then
    local graph = self._sceneRef.background.director.playableGraph
    if graph:IsValid() then
      TimelineManager.Pause(self._sceneRef.background.object)
    end
  end
end

function TowerV2Controller:ResetBackground()
  self._sceneRef.background.director:Play()
  self._sceneRef.background.director.time = 0
  if self._sceneRef.background.object then
    local graph = self._sceneRef.background.director.playableGraph
    if graph:IsValid() then
      TimelineManager.Pause(self._sceneRef.background.object)
    end
  end
  for i = 1, 3 do
    local origPos = self._sceneRef.background.nodeOrigPos[i]
    TransformStaticFunctions.SetPosition(self._sceneRef.background.node[i], origPos.x, origPos.y, origPos.z)
  end
end

function TowerV2Controller:MoveBackground()
  if self._sceneRef.background.object then
    local graph = self._sceneRef.background.director.playableGraph
    if graph:IsValid() then
      TimelineManager.Resume(self._sceneRef.background.object)
    end
  end
end

function TowerV2Controller:PauseBackground()
  if self._sceneRef.background.object then
    local graph = self._sceneRef.background.director.playableGraph
    if graph:IsValid() then
      TimelineManager.Pause(self._sceneRef.background.object)
    end
  end
end

return TowerV2Controller
