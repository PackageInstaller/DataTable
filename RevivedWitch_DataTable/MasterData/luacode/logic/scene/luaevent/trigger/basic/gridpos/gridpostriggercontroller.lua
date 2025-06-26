-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/gridpos/gridpostriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local GridPosTriggerController = class("GridPosTriggerController", TriggerControllerBase)
local GridPosTrigger = require("logic.scene.luaevent.trigger.basic.gridpos.gridpostrigger")
GridPosTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GridPosTriggerController
  ((GridPosTriggerController.super).Ctor)(self, ...)
  self._x = 0
  self._y = 0
  self._dispersed = {}
  self._continuous = {}
end

GridPosTriggerController.OnSceneChange = function(self)
  -- function num : 0_1
  self._x = 0
  self._y = 0
end

GridPosTriggerController.CreateTriggerInstance = function(self, id, eventid, poslist, oncepergrid)
  -- function num : 0_2 , upvalues : GridPosTrigger
  return (GridPosTrigger.Create)("gridpos", id, eventid, poslist, oncepergrid)
end

GridPosTriggerController.OnCharacterMove = function(self, x, y)
  -- function num : 0_3 , upvalues : _ENV
  self._x = x
  self._y = y
  local prevx, prevy = ((NekoData.BehaviorManager).BM_Dungeon):GetActorPrevGridPos()
  local list = {}
  if prevx ~= x or prevy ~= y then
    for _,v in pairs(self._dispersed) do
      list[#list + 1] = v
    end
    for i = 1, #list do
      (list[i]):Check(x, y)
      list[i] = nil
    end
  end
  do
    for _,v in pairs(self._continuous) do
      list[#list + 1] = v
    end
    for _,v in pairs(list) do
      v:Check(x, y)
    end
  end
end

GridPosTriggerController.AddTrigger = function(self, trigger)
  -- function num : 0_4
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if trigger:IsContinuous() then
    (self._continuous)[trigger:GetID()] = trigger
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self._dispersed)[trigger:GetID()] = trigger
  end
  self:OnTriggerAdd(trigger)
end

GridPosTriggerController.RemoveTrigger = function(self, id)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (self._continuous)[id] = nil
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._dispersed)[id] = nil
end

GridPosTriggerController.GetTrigger = function(self, id)
  -- function num : 0_6
  if not (self._continuous)[id] then
    return (self._dispersed)[id]
  end
end

GridPosTriggerController.OnTriggerAdd = function(self, trigger)
  -- function num : 0_7
  trigger:Check(self._x, self._y)
end

return GridPosTriggerController

