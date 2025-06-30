-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/rolestatus/rolestatustriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local RoleStatusTrigger = require("logic.scene.luaevent.trigger.basic.rolestatus.rolestatustrigger")
local RoleStatusTriggerController = class("RoleStatusTriggerController", TriggerControllerBase)
RoleStatusTriggerController.Type = {}
-- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).ActorLevel = 1
-- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).OtherLevel = 2
-- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).TeamCount = 3
-- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).ItemId = 4
-- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).RoleKey = 5
-- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).RoleId = 6
-- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).BreakLevel = 7
-- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).FavorLevel = 8
-- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).IsActor = 9
-- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).HasProperty = 10
-- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).PropertyValue = 11
-- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

;
(RoleStatusTriggerController.Type).ExploreSkills = 12
RoleStatusTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RoleStatusTriggerController
  ((RoleStatusTriggerController.super).Ctor)(self, ...)
end

RoleStatusTriggerController.CreateTriggerInstance = function(self, id, eventid, list)
  -- function num : 0_1 , upvalues : RoleStatusTrigger
  return (RoleStatusTrigger.Create)("rolestatus", id, eventid, list)
end

RoleStatusTriggerController.OnRoleStatusChange = function(self, type)
  -- function num : 0_2 , upvalues : _ENV
  if not self:CheckType(type) then
    LogError("RoleStatusTriggerController", "please use the Type in RoleStatusTriggerController")
    return 
  end
  if not (self._triggers)[type] then
    LogError("RoleStatusTriggerController", "there is no trigger for this type")
    return 
  end
  for _,v in pairs((self._triggers)[type]) do
    local value = self:GetCheckValue(type, v)
    v:Check(value)
  end
end

RoleStatusTriggerController.AddTrigger = function(self, trigger)
  -- function num : 0_3 , upvalues : _ENV
  local type = (trigger:GetTriList()).type
  if not self:CheckType(type) then
    LogError("RoleStatusTriggerController", "please use the Type in RoleStatusTriggerController")
    return 
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  if not (self._triggers)[type] then
    (self._triggers)[type] = {}
  end
  ;
  (table.insert)((self._triggers)[type], trigger)
  if self.OnTriggerAdd then
    self:OnTriggerAdd(trigger)
  end
end

RoleStatusTriggerController.RemoveTrigger = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  for type,oneType in pairs(self._triggers) do
    for i,trigger in pairs(oneType) do
      -- DECOMPILER ERROR at PC14: Confused about usage of register: R12 in 'UnsetPending'

      if trigger:GetID() == id then
        ((self._triggers)[type])[i] = nil
        return true
      end
    end
  end
  return false
end

RoleStatusTriggerController.GetTrigger = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in pairs(self._triggers) do
    for _,trigger in pairs(v) do
      if trigger:GetID() == id then
        return trigger
      end
    end
  end
end

RoleStatusTriggerController.CheckType = function(self, type)
  -- function num : 0_6 , upvalues : _ENV
  for _,v in pairs(self.Type) do
    if type == v then
      return true
    end
  end
  return false
end

RoleStatusTriggerController.GetCheckValue = function(self, type, trigger)
  -- function num : 0_7 , upvalues : _ENV
  local value = nil
  local triList = trigger:GetTriList()
  local needID = true
  for _,v in pairs(((NekoData.BehaviorManager).BM_AllRoles):GetRoleList()) do
    -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

    if type == (self.Type).ActorLevel and v:GetIsLeader() == 1 then
      value = v:GetLevel()
      break
    end
    -- DECOMPILER ERROR at PC39: Unhandled construct in 'MakeBoolean' P1

    if type == (self.Type).IsActor and v:GetIsLeader() == 1 then
      value = {v:GetRoleId(), v:GetId()}
      break
    end
    if type == (self.Type).RoleKey then
      if not value then
        value = {}
      end
      ;
      (table.insert)(value, v:GetRoleId())
      needID = false
    else
      if type == (self.Type).RoleId then
        if not value then
          value = {}
        end
        value[v:GetId()] = v:GetId()
        needID = false
      end
    end
    if needID and not triList.id then
      LogError("RoleStatusTriggerController", "this type need role id")
    end
    -- DECOMPILER ERROR at PC92: Unhandled construct in 'MakeBoolean' P1

    if type == (self.Type).OtherLevel and v:GetId() == triList.id then
      value = v:GetLevel()
      break
    end
    -- DECOMPILER ERROR at PC106: Unhandled construct in 'MakeBoolean' P1

    if type == (self.Type).BreakLevel and v:GetId() == triList.id then
      value = v:GetBreakLv()
      break
    end
    if (type ~= (self.Type).FavorLevel or type == (self.Type).HasProperty) and v:GetId() == triList.id then
      value = {}
      for id,v in pairs(v:GetProperties()) do
        (table.insert)(value, R18_PC134)
      end
      break
    end
    if type == (self.Type).PropertyValue and v:GetId() == triList.id then
      value = (v:GetProperties())[triList.proId]
      break
    end
  end
  do
    if type == (self.Type).TeamCount then
      if not triList.id then
        LogError("RoleStatusTriggerController", "no team id")
        return 
      end
      local team = (((NekoData.BehaviorManager).BM_Team):GetTeamsInfo())[triList.id]
      if not team then
        LogErrorFormat("RoleStatusTriggerController", "no team found, maybe wrong team id %d", triList.id)
        return 
      end
      local roleList = team.roles
      value = 0
      for _,v in pairs(roleList) do
        if v and v ~= 0 then
          value = value + 1
        end
      end
    else
    end
    do
      if type == (self.Type).ItemId then
        return value
      end
    end
  end
end

return RoleStatusTriggerController

