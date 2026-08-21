-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/fsm.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FSM = strictclass("FSM")
FSM.Ctor = function(self)
  -- function num : 0_0 , upvalues : FSM
  (FSM.Init)(self)
  self._onStateEnter = nil
  self._onStateExit = nil
end

FSM.Init = function(self)
  -- function num : 0_1
  self._parameters = {}
  self._states = {}
  self._transGraphs = {}
  self._currentState = ""
  self._initialState = ""
  self._lastState = ""
  self._needCheck = true
end

FSM.CheckError = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local states = {}
  for i,state in ipairs(self._states) do
    if type(state) ~= "string" then
      error("FSM. State error .. " .. tostring(state))
    end
    states[state] = true
  end
  for name,value in pairs(self._parameters) do
    if type(value) ~= "boolean" and type(value) ~= "string" and type(value) ~= "number" then
      error("FSM. Parameter type error. parameterName = " .. tostring(name))
    end
  end
  for graphIndex,graph in ipairs(self._transGraphs) do
    if states[graph.from] == nil or states[graph.to] == nil then
      error("FSM. Graph error. graphIndex = " .. tostring(graphIndex) .. ". state not found! form = " .. tostring(graph.from) .. ", to = " .. tostring(graph.to))
    end
    for condIndex,cond in ipairs(graph.conditions) do
      if (self._parameters)[cond.parameterName] == nil then
        error("FSM. Graph condition error. graphIndex = " .. tostring(graphIndex) .. ". condIndex = " .. tostring(condIndex) .. ". parameter not found! name = " .. tostring(cond.parameterName) .. ".")
      end
      if type((self._parameters)[cond.parameterName]) ~= type(cond.value) then
        error("FSM. Graph condition error. graphIndex = " .. tostring(graphIndex) .. ". condIndex = " .. tostring(condIndex) .. ". Cannot implicitly convert type \'" .. type(cond.value) .. "\' to \'" .. type((self._parameters)[cond.parameterName]) .. "\'.")
      end
      if (type(cond.value) == "boolean" or type(cond.value) == "string") and cond.op ~= "eq" and cond.op ~= "ne" then
        error("FSM. Graph condition error. graphIndex = " .. tostring(graphIndex) .. ". condIndex = " .. tostring(condIndex) .. ". Operator cannot be applied to operands of type \'" .. type(cond.value) .. "\'")
      end
      if type(cond.value) == "number" and cond.op ~= "eq" and cond.op ~= "ne" and cond.op ~= "lt" and cond.op ~= "gt" and cond.op ~= "le" and cond.op ~= "ge" then
        error("FSM. Graph condition error. graphIndex = " .. tostring(graphIndex) .. ". condIndex = " .. tostring(condIndex) .. ". Operator cannot be applied to operands of type \'" .. type(cond.value) .. "\'")
      end
    end
  end
  if states[self._initialState] == nil then
    error("FSM. initialState not exist.")
  end
  if states[self._currentState] == nil and self._currentState ~= "" then
    error("FSM. currentState error.")
  end
end

FSM.SetStateEnterCallBack = function(self, callback, instance)
  -- function num : 0_3
  self._onStateEnter = {callback = callback, instance = instance}
end

FSM.SetStateExitCallBack = function(self, callback, instance)
  -- function num : 0_4
  self._onStateExit = {callback = callback, instance = instance}
end

FSM.SetBoolean = function(self, name, value)
  -- function num : 0_5 , upvalues : _ENV
  if not value then
    value = false
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  if (self._parameters)[name] ~= nil then
    if type((self._parameters)[name]) == "boolean" and type(value) == "boolean" then
      (self._parameters)[name] = value
      self._needCheck = true
    else
      error("FSM. Cannot implicitly convert type \'" .. type(value) .. "\' to \'" .. type((self._parameters)[name]) .. "\'.")
    end
  else
    error("\'" .. tostring(self.__cname) .. "\' does not contain a definition for \'self._parameters[" .. name .. "]\'")
  end
end

FSM.SetString = function(self, name, value)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if (self._parameters)[name] ~= nil then
    if type((self._parameters)[name]) == "string" and type(value) == "string" then
      (self._parameters)[name] = value
      self._needCheck = true
    else
      error("FSM. Cannot implicitly convert type \'" .. type(value) .. "\' to \'" .. type((self._parameters)[name]) .. "\'.")
    end
  else
    error("\'" .. tostring(self.__cname) .. "\' does not contain a definition for \'self._parameters[" .. name .. "]\'")
  end
end

FSM.SetNumber = function(self, name, value)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if (self._parameters)[name] ~= nil then
    if type((self._parameters)[name]) == "number" and type(value) == "number" then
      (self._parameters)[name] = value
      self._needCheck = true
    else
      error("FSM. Cannot implicitly convert type \'" .. type(value) .. "\' to \'" .. type((self._parameters)[name]) .. "\'.")
    end
  else
    error("\'" .. tostring(self.__cname) .. "\' does not contain a definition for \'self._parameters[" .. name .. "]\'")
  end
end

FSM.GetCurrentState = function(self)
  -- function num : 0_8
  return self._currentState
end

FSM.GetLastState = function(self)
  -- function num : 0_9
  return self._lastState
end

FSM.GetParameter = function(self, name)
  -- function num : 0_10
  return (self._parameters)[name]
end

FSM.Update = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local num = 100
  while 1 do
    while 1 do
      while 1 do
        if self._needCheck and num > 0 then
          num = num - 1
          if self._currentState == "" then
            self._currentState = self._initialState
            self:OnStateEnter(self._currentState, "")
            -- DECOMPILER ERROR at PC16: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC16: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC16: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC16: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      local graph = self:getTransferGraph()
      if graph then
        self:OnStateExit(self._currentState, graph.to)
        self._currentState = graph.to
        self:OnStateEnter(self._currentState, graph.from)
        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    self._needCheck = false
  end
  do
    if self._needCheck then
      error("FSM. Infinite loop!")
    end
  end
end

FSM.getTransferGraph = function(self)
  -- function num : 0_12 , upvalues : _ENV
  for i,graph in ipairs(self._transGraphs) do
    if graph.from == self._currentState and self:checkCondition(graph.conditions) then
      return graph
    end
  end
end

FSM.checkCondition = function(self, conditions)
  -- function num : 0_13 , upvalues : _ENV
  for i,cond in ipairs(conditions) do
    -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

    if cond.op == "eq" and (self._parameters)[cond.parameterName] ~= cond.value then
      return false
    end
    -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P1

    if cond.op == "ne" and (self._parameters)[cond.parameterName] == cond.value then
      return false
    end
    -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

    if cond.op == "lt" and cond.value <= (self._parameters)[cond.parameterName] then
      return false
    end
    -- DECOMPILER ERROR at PC50: Unhandled construct in 'MakeBoolean' P1

    if cond.op == "gt" and (self._parameters)[cond.parameterName] <= cond.value then
      return false
    end
    -- DECOMPILER ERROR at PC62: Unhandled construct in 'MakeBoolean' P1

    if cond.op == "le" and cond.value < (self._parameters)[cond.parameterName] then
      return false
    end
    if cond.op == "ge" and (self._parameters)[cond.parameterName] < cond.value then
      return false
    end
  end
  return true
end

FSM.OnStateEnter = function(self, currentState, lastState)
  -- function num : 0_14
  if self._onStateEnter then
    self._lastState = lastState
    ;
    ((self._onStateEnter).callback)((self._onStateEnter).instance, currentState, lastState)
  end
end

FSM.OnStateExit = function(self, currentState, nextState)
  -- function num : 0_15
  if self._onStateExit then
    ((self._onStateExit).callback)((self._onStateExit).instance, currentState, nextState)
  end
end

return FSM

