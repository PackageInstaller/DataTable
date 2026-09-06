local SceneController = require("logic.scene.scenecontrollers.scenecontroller")
local LandscapeController = class("LandscapeController", SceneController)
local LandscapePortal = require("logic.scene.types.landscapeportal")

function LandscapeController:Init()
  self._moveType = NekoData.BehaviorManager.BM_Game:GetMoveTypeMobileMode()
  if self._moveType == "clickMobileMode" then
    local dialog = DialogManager.GetDialog("dungeon.touchlayer")
    if dialog then
      dialog:GetRootWindow():SetActive(true)
    else
      DialogManager.CreateSingletonDialog("dungeon.touchlayer")
    end
  else
    local dialog = DialogManager.GetDialog("dungeon.rockerdialog")
    if dialog then
      dialog:GetRootWindow():SetActive(true)
    else
      DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
    end
  end
  LuaNotificationCenter.AddObserver(self, self.OnMoveTypeChanged, Common.n_MoveTypeChange, nil)
end

function LandscapeController:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
  DialogManager.DestroySingletonDialog("dungeon.touchlayer")
  for _, v in pairs(self._events) do
    EventManager.RemoveEvent(v:GetID())
  end
  self._events = nil
  for _, v in pairs(self._portals) do
    v:Destroy()
  end
  self._portals = nil
  EventManager.ClearSceneEvents()
end

function LandscapeController:OnNavMeshBuildFinish()
  LuaNotificationCenter.AddObserver(self, self.OnRockerMove, Common.n_RockerMove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRockerEnd, Common.n_RockerEnd, nil)
  LandscapeController.super.OnNavMeshBuildFinish(self)
  self:SetBornPosition()
  local scrollinfo = self:GetData("scrollinfo") or {}
  self:LoadEvents(scrollinfo)
end

function LandscapeController:LoadEvents(info)
  self._events = {}
  self._portals = {}
  local recorder = BeanManager.GetTableByName("timeline.cscrollscenetimeline")
  for _, i in pairs(recorder:GetAllIds()) do
    local record = recorder:GetRecorder(i)
    if record.sceneID == self:GetSceneID() and (info[i] ~= 1 or record.isRepeat == 1) then
      if record.transTargetID == 0 then
        local event = EventManager.CreateEvent(record.isRepeat == 1)
        local trigger = TriggerManager.CreateTrigger("collision", event:GetID(), tostring(record.triggerID))
        local root = EffectFactory.CreateComposedEffect()
        root:AddEffect(EffectFactory.CreateTimelineEffect(i))
        root:AddEffect(EffectFactory.CreateCustomEffect(function()
          local req = LuaNetManager.CreateProtocol("protocol.battle.cchangescrollscenestate")
          req.id = i
          req:Send()
        end))
        event:AddEffect(root)
        event:AddTrigger(trigger:GetType(), trigger)
        EventManager.AddEvent(event)
        self._events[i] = event
      else
        self._portals[i] = LandscapePortal.Create(i)
      end
    end
  end
  for _, v in pairs(self._portals) do
    v:Activate()
  end
end

function LandscapeController:OnMoveTypeChanged(notification)
  self._moveType = NekoData.BehaviorManager.BM_Game:GetMoveTypeMobileMode()
  if self._moveType == "clickMobileMode" then
    local dialog = DialogManager.GetDialog("dungeon.touchlayer")
    if dialog then
      dialog:GetRootWindow():SetActive(true)
    else
      DialogManager.CreateSingletonDialog("dungeon.touchlayer")
    end
    DialogManager.DestroySingletonDialog("dungeon.rockerdialog")
    self:SetActorRunning(true)
  else
    local dialog = DialogManager.GetDialog("dungeon.rockerdialog")
    if dialog then
      dialog:GetRootWindow():SetActive(true)
    else
      DialogManager.CreateSingletonDialog("dungeon.rockerdialog")
    end
    DialogManager.DestroySingletonDialog("dungeon.touchlayer")
  end
end

function LandscapeController:StopWalking()
  if self._enabled then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.StopWalking(self._sceneRef.actor.object)
  end
end

function LandscapeController:MoveTowards(x, y, offset)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveTowards(self._sceneRef.actor.object, x, y, offset)
end

function LandscapeController:OnMouseButtonDown(x, y)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveToScreenPos(self._sceneRef.actor.object, x, y)
  self._sceneRef.actor.animator:Play("Blend Tree")
end

function LandscapeController:MoveTowards(x, y, offset)
  CS.PixelNeko.Lua.NavMeshStaticFunctions.MoveTowards(self._sceneRef.actor.object, x, y, offset or 1)
end

function LandscapeController:OnRockerMove(notification)
  local axisVector = notification.userInfo.axisVector
  if notification.userInfo.axisOffset > 0.01 then
    self:MoveTowards(axisVector.x, axisVector.y, notification.userInfo.axisOffset)
  end
  self._sceneRef.actor.animator:Play("Blend Tree")
end

function LandscapeController:OnRockerEnd(notification)
  self:StopWalking()
end

function LandscapeController:SetBornPosition()
  local pos = self:GetData("bornPosition")
  if pos then
    CS.PixelNeko.Lua.NavMeshStaticFunctions.FlyToWorldPos(self._sceneRef.actor.object, pos.x, pos.y, 0)
    CS.PixelNeko.Lua.NavMeshStaticFunctions.SetActorOrientation(self._sceneRef.actor.object, pos.dir)
    self:SetData("bornPosition", nil)
  end
end

function LandscapeController:GetPortal(id)
  return self._portals[id]
end

function LandscapeController:OnSScrollSceneInfo(protocol)
  self:SetData("scrollinfo", protocol.scrollSceneInfo)
  for id, state in pairs(protocol.scrollSceneInfo) do
    if state == 1 then
      EventManager.RemoveEvent(self._events[id]:GetID())
      self._events[id] = nil
    end
  end
end

return LandscapeController
