-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/schangeanimatorstate.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SChangeAnimatorState = dataclass("SChangeAnimatorState")
SChangeAnimatorState.ProtocolType = 55
SChangeAnimatorState.animatorType = 0
SChangeAnimatorState.param = ""
SChangeAnimatorState.value = 0
SChangeAnimatorState.Ctor = function(self, client)
  -- function num : 0_0
end

SChangeAnimatorState.Marshal = function(self, data)
  -- function num : 0_1
  data.animatorType = self.animatorType
  data.param = self.param
  data.value = self.value
end

SChangeAnimatorState.Unmarshal = function(self, data)
  -- function num : 0_2
  self.animatorType = data.animatorType
  self.param = data.param
  self.value = data.value
  return true
end

SChangeAnimatorState.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.animatorType) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.animatorType) = %s. number required.", type(self.animatorType))
    return false
  end
  if type(self.param) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.param) = %s. string required.", type(self.param))
    return false
  end
  if type(self.value) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.value) = %s. number required.", type(self.value))
    return false
  end
  return true
end

return SChangeAnimatorState

