-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/scenecontrollers/landscapecontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local LandscapeController = class("LandscapeController", SceneController)
local LandscapePortal = require("logic.scene.types.landscapeportal")
LandscapeController.Init = function(self)
  -- function num : 0_0 , upvalues : _ENV
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
        ;
        (LuaNotificationCenter.AddObserver)(self, self.OnMoveTypeChanged, Common.n_MoveTypeChange, nil)
      end
    end
  end
end

LandscapeController.OnDestroy = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.rockerdialog")
  ;
  (DialogManager.DestroySingletonDialog)("dungeon.touchlayer")
  for _,v in pairs(self._events) do
    (EventManager.RemoveEvent)(v:GetID())
  end
  self._events = nil
  for _,v in pairs(self._portals) do
    v:Destroy()
  end
  self._portals = nil
  ;
  (EventManager.ClearSceneEvents)()
end

LandscapeController.OnNavMeshBuildFinish = function(self)
  -- function num : 0_2 , upvalues : _ENV, LandscapeController
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerMove, Common.n_RockerMove, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  ;
  ((LandscapeController.super).OnNavMeshBuildFinish)(self)
  self:SetBornPosition()
  if not self:GetData("scrollinfo") then
    local scrollinfo = {}
  end
  self:LoadEvents(scrollinfo)
end

LandscapeController.LoadEvents = function(self, info)
  -- function num : 0_3 , upvalues : _ENV, LandscapePortal
  self._events = {}
  self._portals = {}
  local recorder = (BeanManager.GetTableByName)("timeline.cscrollscenetimeline")
  for _,i in pairs(recorder:GetAllIds()) do
    do
      local record = recorder:GetRecorder(i)
      if record.transTargetID == 0 then
        if record.isRepeat ~= 1 then
          do
            local event = (EventManager.CreateEvent)(record.sceneID ~= self:GetSceneID() or (info[i] == 1 and record.isRepeat ~= 1))
            local trigger = (TriggerManager.CreateTrigger)("collision", event:GetID(), tostring(record.triggerID))
            do
              local root = (EffectFactory.CreateComposedEffect)()
              root:AddEffect((EffectFactory.CreateTimelineEffect)(i))
              root:AddEffect((EffectFactory.CreateCustomEffect)(function()
    -- function num : 0_3_0 , upvalues : _ENV, i
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cchangescrollscenestate")
    req.id = i
    req:Send()
  end
))
              event:AddEffect(root)
              event:AddTrigger(trigger:GetType(), trigger)
              ;
              (EventManager.AddEvent)(event)
              -- DECOMPILER ERROR at PC75: Confused about usage of register: R12 in 'UnsetPending'

              ;
              (self._events)[i] = event
              -- DECOMPILER ERROR at PC81: Confused about usage of register: R9 in 'UnsetPending'

              ;
              (self._portals)[i] = (LandscapePortal.Create)(i)
            end
            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
  for _,v in pairs(self._portals) do
    v:Activate()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

LandscapeController.OnMoveTypeChanged = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
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

LandscapeController.StopWalking = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if self._enabled then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).StopWalking)(((self._sceneRef).actor).object)
  end
end

LandscapeController.MoveTowards = function(self, x, y, offset)
  -- function num : 0_6 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveTowards)(((self._sceneRef).actor).object, x, y, offset)
end

LandscapeController.OnMouseButtonDown = function(self, x, y)
  -- function num : 0_7 , upvalues : _ENV
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveToScreenPos)(((self._sceneRef).actor).object, x, y)
  ;
  (((self._sceneRef).actor).animator):Play("Blend Tree")
end

LandscapeController.MoveTowards = function(self, x, y, offset)
  -- function num : 0_8 , upvalues : _ENV
  ;
  ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).MoveTowards)(((self._sceneRef).actor).object, x, y, offset or 1)
end

LandscapeController.OnRockerMove = function(self, notification)
  -- function num : 0_9
  local axisVector = (notification.userInfo).axisVector
  if (notification.userInfo).axisOffset > 0.01 then
    self:MoveTowards(axisVector.x, axisVector.y, (notification.userInfo).axisOffset)
  end
  ;
  (((self._sceneRef).actor).animator):Play("Blend Tree")
end

LandscapeController.OnRockerEnd = function(self, notification)
  -- function num : 0_10
  self:StopWalking()
end

LandscapeController.SetBornPosition = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local pos = self:GetData("bornPosition")
  if pos then
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).FlyToWorldPos)(((self._sceneRef).actor).object, pos.x, pos.y, 0)
    ;
    ((((CS.PixelNeko).Lua).NavMeshStaticFunctions).SetActorOrientation)(((self._sceneRef).actor).object, pos.dir)
    self:SetData("bornPosition", nil)
  end
end

LandscapeController.GetPortal = function(self, id)
  -- function num : 0_12
  return (self._portals)[id]
end

LandscapeController.OnSScrollSceneInfo = function(self, protocol)
  -- function num : 0_13 , upvalues : _ENV
  self:SetData("scrollinfo", protocol.scrollSceneInfo)
  for id,state in pairs(protocol.scrollSceneInfo) do
    if state == 1 then
      (EventManager.RemoveEvent)(((self._events)[id]):GetID())
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (self._events)[id] = nil
    end
  end
end

return LandscapeController

