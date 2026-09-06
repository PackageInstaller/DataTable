local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local MissionConfig = BeanManager.GetTableByName("mission.cmissionconfig")
local PreTaskTrigger = class("PreTaskTrigger", TriggerBase)

function PreTaskTrigger:Ctor(id, eventid, taskid)
  PreTaskTrigger.super.Ctor(self, "pretask", id, eventid)
  self._taskid = taskid
  self._checkedID = nil
  self._option = nil
  self._choice = {}
  self._unlock = nil
  self._conditionList = {}
  self:GetTaskCondition()
end

local function createConditionList(self, str)
  for v in string.gmatch(str, "%d*") do
    v = tonumber(v)
    table.insert(self._conditionList, v)
  end
end

function PreTaskTrigger:GetTaskCondition()
  local u = MissionConfig:GetRecorder(self._taskid)
  if u then
    self._unlock = u.unlockcondition
  else
    LogErrorFormat("PreTaskTrigger ", "there is no task id %d in missionConfig", self._taskid)
  end
  createConditionList(self, self._unlock)
end

local function isexist(self, param)
  if type(param) == "string" or type(param) == "number" then
    local p = {}
    if type(param) == "string" then
      p = string.split(param, ";")
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
      for _, v in ipairs(self._choice) do
        if v.taskid == p[1] then
          if not p[2] then
            return true
          end
          for _, c in ipairs(v.choices) do
            if p[2] == c then
              return true
            end
          end
        end
      end
    end
  elseif type(param) == "boolean" then
    return param
  end
  return false
end

local function create_trigger_root(self)
  local e = {
    _and = function(...)
      for _, v in ipairs({
        ...
      }) do
        if not isexist(self, v) then
          return false
        end
      end
      return true
    end,
    _or = function(...)
      for _, v in ipairs({
        ...
      }) do
        if isexist(self, v) then
          return true
        end
      end
      return false
    end
  }
  return load("return " .. self._unlock, "pretasktrigger" .. self._taskid, "t", e)()
end

function PreTaskTrigger:OnCheck(choice, id, option)
  print(self._taskid)
  self._choice = choice
  self._checkedID = id
  self._option = option
  local condition
  if self._unlock then
    if string.find(self._unlock, "_and") or string.find(self._unlock, "_or") then
      condition = create_trigger_root(self)
    else
      condition = self._unlock
    end
  end
  if type(condition) == "boolean" then
    return condition
  else
    return isexist(self, condition)
  end
end

function PreTaskTrigger:GetTaskId()
  return self._taskid
end

function PreTaskTrigger:GetCondition()
  return self._conditionList
end

return PreTaskTrigger
