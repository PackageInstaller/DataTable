-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/autotrapcontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local AutoTrapController = class("AutoTrapController", SceneController)
local TrapHelper = (((CS.PixelNeko).P1).Scene).TrapHelper
local cdungeonbattleconfig = (BeanManager.GetTableByName)("dungeonbattle.cdungeonbattleconfig")
local cresourcedungeonstage = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CHEXAGONBATTLECONFIG = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
local CHEXAGONFUNCTION = (BeanManager.GetTableByName)("activity.chexagonfunction")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CLoverInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cvalentineinterfacefunction")
local CAnniversarylevel = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel")
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local CSRResourceDungeonStage = (BeanManager.GetTableByName)("activity.csrresourcedungeonstage")
local cnpcshape = (BeanManager.GetTableByName)("npc.cnpcshape")
local DungeonType = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
AutoTrapController.Init = function(self)
  -- function num : 0_0 , upvalues : AutoTrapController, _ENV, DungeonType, cresourcedungeonstage, CStarrymirrorlevel, CHEXAGONFUNCTION, CHEXAGONBATTLECONFIG, CInterfaceFunction, CLoverInterfaceFunction, CAnniversarylevel, CSRFunction, CSRResourceDungeonStage, cdungeonbattleconfig
  ((AutoTrapController.super).Init)(self)
  ;
  ((NekoData.DataManager).DM_Dungeon):SetMode("auto")
  self._enemy = nil
  self._canPause = true
  self._battleSceneId = ((NekoData.BehaviorManager).BM_Dungeon):GetAutoExploreBattleSceneId()
  local info = (((NekoData.BehaviorManager).BM_Dungeon):GetDungeonInfo()).rangeInfo
  self._zoneID = info.id
  self._type = info.type
  local cautoexplore = (BeanManager.GetTableByName)("dungeonselect.cautoexplore")
  self._cfg = cautoexplore:GetRecorder(self._zoneID)
  for _,i in pairs(cautoexplore:GetAllIds()) do
    self._cfg = cautoexplore:GetRecorder(i)
  end
  do
    if (self._cfg).sectionID ~= self._zoneID or (self._cfg).dungeontype ~= self._type then
      self:SetForeground()
      self:PlaySceneBGM()
      local battles = self:GetData("enemies")
      local next = 1
      self._battles = {}
      if self._type == DungeonType.RESOURCE then
        for i,v in ipairs(battles) do
          local temp = {}
          local recorder = cresourcedungeonstage:GetRecorder(v.key)
          temp.id = recorder.id
          temp.Monsterid = recorder.shapeID
          -- DECOMPILER ERROR at PC85: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (self._battles)[i] = temp
          if v.value ~= 0 then
            next = next + 1
          end
        end
      else
        do
          if self._type == DungeonType.ACTIVITY then
            for i,v in ipairs(battles) do
              local temp = {}
              local recorder = CStarrymirrorlevel:GetRecorder(v.key)
              if recorder then
                temp.id = recorder.id
                temp.Monsterid = recorder.monsterformid
                LogErrorFormat("AutoTrapController", "--- id = %s, monsterformid = %s ---", recorder.id, recorder.monsterformid)
              else
                if CHEXAGONFUNCTION:GetRecorder(v.key) then
                  local battleID = (CHEXAGONFUNCTION:GetRecorder(v.key)).battleID
                  recorder = CHEXAGONBATTLECONFIG:GetRecorder(battleID)
                  temp.id = v.key
                  temp.Monsterid = recorder.monsterformid
                  LogErrorFormat("AutoTrapController", "--- id = %s, monsterformid = %s ---", recorder.id, recorder.monsterformid)
                else
                  do
                    if CInterfaceFunction:GetRecorder(v.key) then
                      local battleID = (CInterfaceFunction:GetRecorder(v.key)).battleID
                      recorder = CHEXAGONBATTLECONFIG:GetRecorder(battleID)
                      temp.id = v.key
                      temp.Monsterid = recorder.monsterformid
                      LogErrorFormat("AutoTrapController", "--- id = %s, monsterformid = %s ---", recorder.id, recorder.monsterformid)
                    else
                      do
                        if CLoverInterfaceFunction:GetRecorder(v.key) then
                          local battleID = (CLoverInterfaceFunction:GetRecorder(v.key)).battleID
                          recorder = CHEXAGONBATTLECONFIG:GetRecorder(battleID)
                          temp.id = v.key
                          temp.Monsterid = recorder.monsterformid
                          LogErrorFormat("AutoTrapController", "--- id = %s, monsterformid = %s ---", recorder.id, recorder.monsterformid)
                        else
                          do
                            if CAnniversarylevel:GetRecorder(v.key) then
                              recorder = CAnniversarylevel:GetRecorder(v.key)
                              temp.id = recorder.id
                              temp.Monsterid = recorder.monsterformid
                              LogErrorFormat("AutoTrapController", "--- id = %s, monsterformid = %s ---", recorder.id, recorder.monsterformid)
                            else
                              if CSRFunction:GetRecorder(v.key) then
                                local levelId = (CSRFunction:GetRecorder(v.key)).levelID
                                recorder = CSRResourceDungeonStage:GetRecorder(levelId)
                                temp.id = v.key
                                temp.Monsterid = recorder.monsterformid
                                LogErrorFormat("AutoTrapController", "--- id = %s, monsterformid = %s ---", recorder.id, recorder.monsterformid)
                              end
                            end
                            do
                              do
                                -- DECOMPILER ERROR at PC249: Confused about usage of register: R12 in 'UnsetPending'

                                ;
                                (self._battles)[i] = temp
                                if v.value ~= 0 then
                                  next = next + 1
                                end
                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out DO_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out DO_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out IF_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out DO_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out IF_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out DO_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out IF_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                -- DECOMPILER ERROR at PC254: LeaveBlock: unexpected jumping out IF_STMT

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
          else
            for i,v in ipairs(battles) do
              -- DECOMPILER ERROR at PC266: Confused about usage of register: R10 in 'UnsetPending'

              (self._battles)[i] = cdungeonbattleconfig:GetRecorder(v.key)
              if v.value ~= 0 then
                next = next + 1
              end
            end
          end
          do
            local currinfo = ((NekoData.BehaviorManager).BM_SEnterDungeon):GetCurBattleInfo()
            if currinfo.battleid ~= 0 and next > 1 then
              next = next - 1
            end
            self._progress = {next = next, total = #battles}
            self._battleEvents = {}
            self._hud = (DialogManager.CreateSingletonDialog)("dungeon.autoexploredialog")
            ;
            (self._hud):SetData((math.max)(0, (self._progress).next - 1), (self._progress).total)
            ;
            (LuaNotificationCenter.AddObserver)(self, self.OnAccount, Common.n_AutoExploreAccount, nil)
            local isFinishi = ((NekoData.BehaviorManager).BM_Game):IsAutoFinishing()
            local lastinfo = ((NekoData.BehaviorManager).BM_Game):GetBattleResult()
            if isFinishi and lastinfo and lastinfo.result == 1 and (self._progress).total < (self._progress).next then
              self._status = "account"
              self:OnBattleWin()
            else
              if isFinishi and lastinfo and lastinfo.result == -1 then
                self._status = "account"
                self:OnBattleLose()
              else
                if currinfo.battleid ~= 0 then
                  self._status = "battle"
                  self:AddBattleEvent()
                else
                  self._running = true
                  self._status = "running"
                  ;
                  (self._hud):StartCountDown()
                end
              end
            end
          end
        end
      end
    end
  end
end

AutoTrapController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : AutoTrapController, _ENV
  ((AutoTrapController.super).OnDestroy)(self)
  ;
  ((NekoData.DataManager).DM_Dungeon):SetMode()
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_SceneDestroy, self, self:GetSceneID())
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
  end
  ;
  (EventManager.ClearSceneEvents)()
  ;
  (TriggerManager.OnSceneChange)()
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.autoexploredialog")
  self._hud = nil
end

AutoTrapController.OnSceneRootGameObjectActiveChange = function(self, active)
  -- function num : 0_2
  if self._hud then
    (self._hud):SetActive(active)
  end
end

AutoTrapController.Update = function(self, deltaTime, unscaleDeltaTime)
  -- function num : 0_3 , upvalues : _ENV
  if not self._running then
    return 
  end
  self._time = (self._time or 0) + deltaTime
  if self._status == "running" then
    if self._time < tonumber((((BeanManager.GetTableByName)("battle.cbattleconstcfg")):GetRecorder(75)).attr) then
      self:StartWalking()
      local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "enemyState", 0)
      effect:Bind(((self._sceneRef).enemy).root)
      effect:Run()
    else
      do
        self._status = "appearing"
        self:StopWalking()
        self._time = 0
        if self._status == "appearing" and not self._enemy then
          self:NextEnemy()
        end
        if self._status == "battle" then
          if #self._battleEvents == 0 then
            self:AddBattleEvent()
          end
          self._time = 0
          self._running = false
        end
      end
    end
  end
end

AutoTrapController.PlaySceneBGM = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (LuaAudioManager.PlayBGM)((self._cfg).bmgId)
end

AutoTrapController.SetForeground = function(self)
  -- function num : 0_5 , upvalues : _ENV
  self._foreground = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self._sceneRef):GetRootGameObject(), (self._cfg).foreGround)
  ;
  ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetActive)(self._foreground, true)
  self._background = ((((CS.PixelNeko).Lua).TransformStaticFunctions).GetChild)((self._sceneRef):GetRootGameObject(), (self._cfg).backGround)
  ;
  ((((CS.PixelNeko).Lua).TransformStaticFunctions).SetActive)(self._background, true)
end

AutoTrapController.NextEnemy = function(self)
  -- function num : 0_6 , upvalues : cnpcshape, TrapHelper, _ENV
  local battlecfg = (self._battles)[(self._progress).next]
  local shape = cnpcshape:GetRecorder(battlecfg.Monsterid)
  self._enemy = (TrapHelper.CreateObject)(shape.assetBundleName, shape.prefabName, 1.8, -1.2, 0.2, ((self._sceneRef).enemy).point)
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "enemyState", 1)
  effect:Bind(((self._sceneRef).enemy).root)
  effect:Then(function()
    -- function num : 0_6_0 , upvalues : self
    self:NextBattle()
    self._status = "battle"
    self._time = 0
  end
)
  self._canPause = false
  effect:Run()
end

AutoTrapController.NextBattle = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local record = (self._battles)[(self._progress).next]
  ;
  ((EffectFactory.CreateBattleEffect)(record.id, nil, true, self._type, self._battleSceneId)):Run()
end

AutoTrapController.AddBattleEvent = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local event = (EventManager.CreateEvent)()
  do
    local trigger = (TriggerManager.CreateTrigger)("battleend", (event:GetID()), nil, "Success", "AfterReturn")
    event:AddTrigger(trigger:GetType(), trigger)
    event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_8_0 , upvalues : self
    self:OnBattleWin()
    self._time = 0
    self._canPause = true
  end
))
    ;
    (EventManager.AddEvent)(event)
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._battleEvents)[1] = event
    local event = (EventManager.CreateEvent)()
    local trigger = (TriggerManager.CreateTrigger)("battleend", (event:GetID()), nil, "Fail", "AfterReturn")
    event:AddTrigger(trigger:GetType(), trigger)
    event:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_8_1 , upvalues : self
    self:OnBattleLose()
    self._time = 0
  end
))
    ;
    (EventManager.AddEvent)(event)
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._battleEvents)[2] = event
  end
end

local run = function(self, v)
  -- function num : 0_9 , upvalues : _ENV
  local effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "exploreState", v)
  effect:Bind((self._sceneRef).actor)
  effect:Run()
  effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "bgStop", v)
  effect:Bind(self._background)
  effect:Run()
end

local stop = function(self, v)
  -- function num : 0_10 , upvalues : _ENV
  local root = (EffectFactory.CreateComposedEffect)()
  local effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_10_0 , upvalues : _ENV, self
    if ((NekoData.BehaviorManager).BM_Game):IsFinishiAllExplore() then
      (DialogManager.DestroySingletonDialog)("dungeon.autoexploredialog")
      self._hud = nil
    end
  end
)
  root:AddEffect(effect)
  effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "exploreState", 1)
  effect:Bind((self._sceneRef).actor)
  root:AddEffect(effect)
  effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "exploreState", v)
  effect:Bind((self._sceneRef).actor)
  root:AddEffect(effect)
  effect = (EffectFactory.CreateAnimatorStateChangeEffect)(nil, "stageState", 1)
  effect:Bind((self._sceneRef).stage)
  root:AddEffect(effect)
  effect = (EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_10_1 , upvalues : self
    self._running = true
    if self._status == "account" then
      self:OnExploreEnd()
    else
      self._status = "account"
    end
  end
)
  root:AddEffect(effect)
  self._running = false
  root:Run()
  effect = (EffectFactory.CreateAnimatorStateChangeEffect)("", "bgStop", 1)
  effect:Bind(self._background)
  return effect
end

AutoTrapController.OnBattleWin = function(self)
  -- function num : 0_11 , upvalues : _ENV, stop
  ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._enemy)
  self._enemy = nil
  for _,v in pairs(self._battleEvents) do
    (EventManager.RemoveEvent)(v:GetID())
  end
  self._battleEvents = {}
  ;
  (self._hud):SetData((math.min)((self._progress).total, (self._progress).next), (self._progress).total)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._progress).next = (self._progress).next + 1
  if (self._progress).total < (self._progress).next then
    self._running = false
    local effect = (self._hud):PlayEndEffect()
    effect:Run()
    effect:Then(function()
    -- function num : 0_11_0 , upvalues : stop, self
    (stop(self, 3)):Run()
  end
)
  else
    do
      self._status = "running"
      self._running = true
    end
  end
end

AutoTrapController.OnBattleLose = function(self)
  -- function num : 0_12 , upvalues : _ENV, stop
  ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)(self._enemy)
  self._enemy = nil
  for _,v in pairs(self._battleEvents) do
    (EventManager.RemoveEvent)(v:GetID())
  end
  self._battleEvents = {}
  self._running = false
  ;
  (stop(self, 2)):Run()
  self._lose = true
end

AutoTrapController.OnAccount = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  ((NekoData.DataManager).DM_Game):OnAutoExploreFinishiOnce()
  self:OnExploreEnd()
end

AutoTrapController.OnExploreEnd = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):IsFinishiAllExplore() or self._lose then
    local protocolCatch = ((NekoData.BehaviorManager).BM_Game):GetAutoExploreProtocol()
    local type = (LuaNetManager.CreateBean)("protocol.battle.dungeontype")
    if self._type == type.ACTIVITY then
      local CEVENTLIST = (BeanManager.GetTableByName)("dungeonselect.ceventlist")
      local summeractivityEvents = (CEVENTLIST:GetRecorder((DataCommon.Activities).SwimSuit)).levenid
      local summerEchoesactivityEvents = (CEVENTLIST:GetRecorder((DataCommon.Activities).SummerEchoes)).levenid
      if (table.contain)(summeractivityEvents, self._zoneID) and ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(21) then
        ((LuaNetManager.CreateProtocol)("protocol.battle.cfinishautoexplorewithoutback")):Send()
        local req = (LuaNetManager.CreateProtocol)("protocol.activity.cgetsummeractivityinfo")
        req:Send()
        ;
        ((NekoData.DataManager).DM_Game):ClearAutoExploreData()
        return 
      else
        do
          do
            if (table.contain)(summerEchoesactivityEvents, self._zoneID) and ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(161) then
              ((LuaNetManager.CreateProtocol)("protocol.battle.cfinishautoexplorewithoutback")):Send()
              ;
              (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID)):SendCGetSummerEchoInfo()
              ;
              ((NekoData.DataManager).DM_Game):ClearAutoExploreData()
              return 
            end
            ;
            ((NekoData.DataManager).DM_Game):ClearAutoExploreData()
            do
              local req = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
              req:Send()
              ;
              (((NekoData.BehaviorManager).BM_Game):GetAutoExploreProtocol()):Send()
            end
          end
        end
      end
    end
  end
end

AutoTrapController.StopWalking = function(self)
  -- function num : 0_15 , upvalues : run
  run(self, 1)
end

AutoTrapController.StartWalking = function(self)
  -- function num : 0_16 , upvalues : run
  run(self, 0)
end

AutoTrapController.CanPause = function(self)
  -- function num : 0_17
  return self._canPause
end

AutoTrapController.Pause = function(self)
  -- function num : 0_18
  self._running = false
end

AutoTrapController.Resume = function(self)
  -- function num : 0_19
  self._running = true
end

return AutoTrapController

