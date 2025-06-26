-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/pretask/pretasktrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local MissionConfig = (BeanManager.GetTableByName)("mission.cmissionconfig")
local PreTaskTrigger = class("PreTaskTrigger", TriggerBase)
PreTaskTrigger.Ctor = function(self, id, eventid, taskid)
  -- function num : 0_0 , upvalues : PreTaskTrigger
  ((PreTaskTrigger.super).Ctor)(self, "pretask", id, eventid)
  self._taskid = taskid
  self._checkedID = nil
  self._option = nil
  self._choice = {}
  self._unlock = nil
  self._conditionList = {}
  self:GetTaskCondition()
end

local createConditionList = function(self, str)
  -- function num : 0_1 , upvalues : _ENV
  for v in (string.gmatch)(str, "%d*") do
    v = tonumber(v)
    ;
    (table.insert)(self._conditionList, v)
  end
end

PreTaskTrigger.GetTaskCondition = function(self)
  -- function num : 0_2 , upvalues : MissionConfig, _ENV, createConditionList
  local u = MissionConfig:GetRecorder(self._taskid)
  if u then
    self._unlock = u.unlockcondition
  else
    LogErrorFormat("PreTaskTrigger ", "there is no task id %d in missionConfig", self._taskid)
  end
  createConditionList(self, self._unlock)
end

local isexist = function(self, param)
  -- function num : 0_3 , upvalues : _ENV
  if type(param) == "string" or type(param) == "number" then
    local p = {}
    if type(param) == "string" then
      p = (string.split)(param, ";")
      p[1] = tonumber(p[1])
    else
      p[1] = param
    end
    if p[1] == 0 or #p == 0 then
      return true
    end
    if p[1] == self._id and (p[2] == self._option or not p[2]) then
      return true
    end
    if #self._choice ~= 0 then
      for _,v in ipairs(self._choice) do
        if v.taskid == p[1] then
          if not p[2] then
            return true
          end
          for _,c in ipairs(v.choices) do
            if p[2] == c then
              return true
            end
          end
        end
      end
    end
  else
    do
      if type(param) == "boolean" then
        return param
      end
      return false
    end
  end
end

local create_trigger_root = function(self)
  -- function num : 0_4 , upvalues : _ENV, isexist
  local e = {_and = function(...)
    -- function num : 0_4_0 , upvalues : _ENV, isexist, self
    for _,v in ipairs({...}) do
      if not isexist(self, v) then
        return false
      end
    end
    return true
  end
, _or = function(...)
    -- function num : 0_4_1 , upvalues : _ENV, isexist, self
    for _,v in ipairs({...}) do
      if isexist(self, v) then
        return true
      end
    end
    return false
  end
}
  return (load("return " .. self._unlock, "pretasktrigger" .. self._taskid, "t", e))()
end

PreTaskTrigger.OnCheck = function(self, choice, id, option)
  -- function num : 0_5 , upvalues : _ENV, create_trigger_root, isexist
  print(self._taskid)
  self._choice = choice
  self._checkedID = id
  self._option = option
  local condition = nil
  if self._unlock and ((string.find)(self._unlock, "_and") or (string.find)(self._unlock, "_or")) then
    condition = create_trigger_root(self)
  else
    condition = self._unlock
  end
  if type(condition) == "boolean" then
    return condition
  else
    return isexist(self, condition)
  end
end

PreTaskTrigger.GetTaskId = function(self)
  -- function num : 0_6
  return self._taskid
end

PreTaskTrigger.GetCondition = function(self)
  -- function num : 0_7
  return self._conditionList
end

return PreTaskTrigger

