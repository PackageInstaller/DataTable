local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local RoleStatusTrigger = require("logic.scene.luaevent.trigger.basic.rolestatus.rolestatustrigger")
local RoleStatusTriggerController = class("RoleStatusTriggerController", TriggerControllerBase)
RoleStatusTriggerController.Type = {}
RoleStatusTriggerController.Type.ActorLevel = 1
RoleStatusTriggerController.Type.OtherLevel = 2
RoleStatusTriggerController.Type.TeamCount = 3
RoleStatusTriggerController.Type.ItemId = 4
RoleStatusTriggerController.Type.RoleKey = 5
RoleStatusTriggerController.Type.RoleId = 6
RoleStatusTriggerController.Type.BreakLevel = 7
RoleStatusTriggerController.Type.FavorLevel = 8
RoleStatusTriggerController.Type.IsActor = 9
RoleStatusTriggerController.Type.HasProperty = 10
RoleStatusTriggerController.Type.PropertyValue = 11
RoleStatusTriggerController.Type.ExploreSkills = 12

function RoleStatusTriggerController:Ctor(...)
  RoleStatusTriggerController.super.Ctor(self, ...)
end

function RoleStatusTriggerController:CreateTriggerInstance(id, eventid, list)
  return RoleStatusTrigger.Create("rolestatus", id, eventid, list)
end

function RoleStatusTriggerController:OnRoleStatusChange(type)
  if not self:CheckType(type) then
    LogError("RoleStatusTriggerController", "please use the Type in RoleStatusTriggerController")
    return
  end
  if not self._triggers[type] then
    LogError("RoleStatusTriggerController", "there is no trigger for this type")
    return
  end
  for _, v in pairs(self._triggers[type]) do
    local value = self:GetCheckValue(type, v)
    v:Check(value)
  end
end

function RoleStatusTriggerController:AddTrigger(trigger)
  local type = trigger:GetTriList().type
  if not self:CheckType(type) then
    LogError("RoleStatusTriggerController", "please use the Type in RoleStatusTriggerController")
    return
  end
  if not self._triggers[type] then
    self._triggers[type] = {}
  end
  table.insert(self._triggers[type], trigger)
  if self.OnTriggerAdd then
    self:OnTriggerAdd(trigger)
  end
end

function RoleStatusTriggerController:RemoveTrigger(id)
  for type, oneType in pairs(self._triggers) do
    for i, trigger in pairs(oneType) do
      if trigger:GetID() == id then
        self._triggers[type][i] = nil
        return true
      end
    end
  end
  return false
end

function RoleStatusTriggerController:GetTrigger(id)
  for _, v in pairs(self._triggers) do
    for _, trigger in pairs(v) do
      if trigger:GetID() == id then
        return trigger
      end
    end
  end
end

function RoleStatusTriggerController:CheckType(type)
  for _, v in pairs(self.Type) do
    if type == v then
      return true
    end
  end
  return false
end

function RoleStatusTriggerController:GetCheckValue(type, trigger)
  local value
  local triList = trigger:GetTriList()
  local needID = true
  for _, v in pairs(NekoData.BehaviorManager.BM_AllRoles:GetRoleList()) do
    if type == self.Type.ActorLevel then
      if v:GetIsLeader() == 1 then
        value = v:GetLevel()
        break
      end
    elseif type == self.Type.IsActor then
      if v:GetIsLeader() == 1 then
        value = {
          v:GetRoleId(),
          v:GetId()
        }
        break
      end
    elseif type == self.Type.RoleKey then
      value = value or {}
      table.insert(value, v:GetRoleId())
      needID = false
    elseif type == self.Type.RoleId then
      value = value or {}
      value[v:GetId()] = v:GetId()
      needID = false
    end
    if needID and not triList.id then
      LogError("RoleStatusTriggerController", "this type need role id")
    end
    if type == self.Type.OtherLevel then
      if v:GetId() == triList.id then
        value = v:GetLevel()
        break
      end
    elseif type == self.Type.BreakLevel then
      if v:GetId() == triList.id then
        value = v:GetBreakLv()
        break
      end
    elseif type == self.Type.FavorLevel then
    elseif type == self.Type.HasProperty and v:GetId() == triList.id then
      value = {}
      for id, v in pairs(v:GetProperties()) do
        table.insert(value, id)
      end
      break
    end
    if type == self.Type.PropertyValue and v:GetId() == triList.id then
      value = v:GetProperties()[triList.proId]
      break
    end
  end
  if type == self.Type.TeamCount then
    if not triList.id then
      LogError("RoleStatusTriggerController", "no team id")
      return
    end
    local team = NekoData.BehaviorManager.BM_Team:GetTeamsInfo()[triList.id]
    if not team then
      LogErrorFormat("RoleStatusTriggerController", "no team found, maybe wrong team id %d", triList.id)
      return
    end
    local roleList = team.roles
    value = 0
    for _, v in pairs(roleList) do
      if v and v ~= 0 then
        value = value + 1
      end
    end
  elseif type == self.Type.ItemId then
  end
  return value
end

return RoleStatusTriggerController
