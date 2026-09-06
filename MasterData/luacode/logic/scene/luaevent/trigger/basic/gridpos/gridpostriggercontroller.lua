local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local GridPosTriggerController = class("GridPosTriggerController", TriggerControllerBase)
local GridPosTrigger = require("logic.scene.luaevent.trigger.basic.gridpos.gridpostrigger")

function GridPosTriggerController:Ctor(...)
  GridPosTriggerController.super.Ctor(self, ...)
  self._x = 0
  self._y = 0
  self._dispersed = {}
  self._continuous = {}
end

function GridPosTriggerController:OnSceneChange()
  self._x = 0
  self._y = 0
end

function GridPosTriggerController:CreateTriggerInstance(id, eventid, poslist, oncepergrid)
  return GridPosTrigger.Create("gridpos", id, eventid, poslist, oncepergrid)
end

function GridPosTriggerController:OnCharacterMove(x, y)
  self._x = x
  self._y = y
  local prevx, prevy = NekoData.BehaviorManager.BM_Dungeon:GetActorPrevGridPos()
  local list = {}
  if prevx ~= x or prevy ~= y then
    for _, v in pairs(self._dispersed) do
      list[#list + 1] = v
    end
    for i = 1, #list do
      list[i]:Check(x, y)
      list[i] = nil
    end
  end
  for _, v in pairs(self._continuous) do
    list[#list + 1] = v
  end
  for _, v in pairs(list) do
    v:Check(x, y)
  end
end

function GridPosTriggerController:AddTrigger(trigger)
  if trigger:IsContinuous() then
    self._continuous[trigger:GetID()] = trigger
  else
    self._dispersed[trigger:GetID()] = trigger
  end
  self:OnTriggerAdd(trigger)
end

function GridPosTriggerController:RemoveTrigger(id)
  self._continuous[id] = nil
  self._dispersed[id] = nil
end

function GridPosTriggerController:GetTrigger(id)
  return self._continuous[id] or self._dispersed[id]
end

function GridPosTriggerController:OnTriggerAdd(trigger)
  trigger:Check(self._x, self._y)
end

return GridPosTriggerController
