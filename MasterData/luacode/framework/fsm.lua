local FSM = strictclass("FSM")

function FSM:Ctor()
  FSM.Init(self)
  self._onStateEnter = nil
  self._onStateExit = nil
end

function FSM:Init()
  self._parameters = {}
  self._states = {}
  self._transGraphs = {}
  self._currentState = ""
  self._initialState = ""
  self._lastState = ""
  self._needCheck = true
end

function FSM:CheckError()
  local states = {}
  for i, state in ipairs(self._states) do
    if type(state) ~= "string" then
      error("FSM. State error .. " .. tostring(state))
    end
    states[state] = true
  end
  for name, value in pairs(self._parameters) do
    if type(value) ~= "boolean" and type(value) ~= "string" and type(value) ~= "number" then
      error("FSM. Parameter type error. parameterName = " .. tostring(name))
    end
  end
  for graphIndex, graph in ipairs(self._transGraphs) do
    if states[graph.from] == nil or states[graph.to] == nil then
      error("FSM. Graph error. graphIndex = " .. tostring(graphIndex) .. ". state not found! form = " .. tostring(graph.from) .. ", to = " .. tostring(graph.to))
    end
    for condIndex, cond in ipairs(graph.conditions) do
      if self._parameters[cond.parameterName] == nil then
        error("FSM. Graph condition error. graphIndex = " .. tostring(graphIndex) .. ". condIndex = " .. tostring(condIndex) .. ". parameter not found! name = " .. tostring(cond.parameterName) .. ".")
      end
      if type(self._parameters[cond.parameterName]) ~= type(cond.value) then
        error("FSM. Graph condition error. graphIndex = " .. tostring(graphIndex) .. ". condIndex = " .. tostring(condIndex) .. ". Cannot implicitly convert type '" .. type(cond.value) .. "' to '" .. type(self._parameters[cond.parameterName]) .. "'.")
      end
      if (type(cond.value) == "boolean" or type(cond.value) == "string") and cond.op ~= "eq" and cond.op ~= "ne" then
        error("FSM. Graph condition error. graphIndex = " .. tostring(graphIndex) .. ". condIndex = " .. tostring(condIndex) .. ". Operator cannot be applied to operands of type '" .. type(cond.value) .. "'")
      end
      if type(cond.value) == "number" and cond.op ~= "eq" and cond.op ~= "ne" and cond.op ~= "lt" and cond.op ~= "gt" and cond.op ~= "le" and cond.op ~= "ge" then
        error("FSM. Graph condition error. graphIndex = " .. tostring(graphIndex) .. ". condIndex = " .. tostring(condIndex) .. ". Operator cannot be applied to operands of type '" .. type(cond.value) .. "'")
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

function FSM:SetStateEnterCallBack(callback, instance)
  self._onStateEnter = {callback = callback, instance = instance}
end

function FSM:SetStateExitCallBack(callback, instance)
  self._onStateExit = {callback = callback, instance = instance}
end

function FSM:SetBoolean(name, value)
  value = value or false
  if self._parameters[name] ~= nil then
    if type(self._parameters[name]) == "boolean" and type(value) == "boolean" then
      self._parameters[name] = value
      self._needCheck = true
    else
      error("FSM. Cannot implicitly convert type '" .. type(value) .. "' to '" .. type(self._parameters[name]) .. "'.")
    end
  else
    error("'" .. tostring(self.__cname) .. "' does not contain a definition for 'self._parameters[" .. name .. "]'")
  end
end

function FSM:SetString(name, value)
  if self._parameters[name] ~= nil then
    if type(self._parameters[name]) == "string" and type(value) == "string" then
      self._parameters[name] = value
      self._needCheck = true
    else
      error("FSM. Cannot implicitly convert type '" .. type(value) .. "' to '" .. type(self._parameters[name]) .. "'.")
    end
  else
    error("'" .. tostring(self.__cname) .. "' does not contain a definition for 'self._parameters[" .. name .. "]'")
  end
end

function FSM:SetNumber(name, value)
  if self._parameters[name] ~= nil then
    if type(self._parameters[name]) == "number" and type(value) == "number" then
      self._parameters[name] = value
      self._needCheck = true
    else
      error("FSM. Cannot implicitly convert type '" .. type(value) .. "' to '" .. type(self._parameters[name]) .. "'.")
    end
  else
    error("'" .. tostring(self.__cname) .. "' does not contain a definition for 'self._parameters[" .. name .. "]'")
  end
end

function FSM:GetCurrentState()
  return self._currentState
end

function FSM:GetLastState()
  return self._lastState
end

function FSM:GetParameter(name)
  return self._parameters[name]
end

function FSM:Update()
  local num = 100
  while self._needCheck and 0 < num do
    num = num - 1
    if self._currentState == "" then
      self._currentState = self._initialState
      self:OnStateEnter(self._currentState, "")
    else
      local graph = self:getTransferGraph()
      if graph then
        self:OnStateExit(self._currentState, graph.to)
        self._currentState = graph.to
        self:OnStateEnter(self._currentState, graph.from)
      else
        self._needCheck = false
      end
    end
  end
  if self._needCheck then
    error("FSM. Infinite loop!")
  end
end

function FSM:getTransferGraph()
  for i, graph in ipairs(self._transGraphs) do
    if graph.from == self._currentState and self:checkCondition(graph.conditions) then
      return graph
    end
  end
end

function FSM:checkCondition(conditions)
  for i, cond in ipairs(conditions) do
    if cond.op == "eq" then
      if self._parameters[cond.parameterName] ~= cond.value then
        return false
      end
    elseif cond.op == "ne" then
      if self._parameters[cond.parameterName] == cond.value then
        return false
      end
    elseif cond.op == "lt" then
      if self._parameters[cond.parameterName] >= cond.value then
        return false
      end
    elseif cond.op == "gt" then
      if self._parameters[cond.parameterName] <= cond.value then
        return false
      end
    elseif cond.op == "le" then
      if self._parameters[cond.parameterName] > cond.value then
        return false
      end
    elseif cond.op == "ge" and self._parameters[cond.parameterName] < cond.value then
      return false
    end
  end
  return true
end

function FSM:OnStateEnter(currentState, lastState)
  if self._onStateEnter then
    self._lastState = lastState
    self._onStateEnter.callback(self._onStateEnter.instance, currentState, lastState)
  end
end

function FSM:OnStateExit(currentState, nextState)
  if self._onStateExit then
    self._onStateExit.callback(self._onStateExit.instance, currentState, nextState)
  end
end

return FSM
