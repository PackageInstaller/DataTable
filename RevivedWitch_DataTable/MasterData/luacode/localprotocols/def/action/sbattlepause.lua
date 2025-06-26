-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sbattlepause.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattlePause = dataclass("SBattlePause")
SBattlePause.ProtocolType = 41
SBattlePause.pauseType = 0
SBattlePause.param = ""
SBattlePause.Ctor = function(self, client)
  -- function num : 0_0
end

SBattlePause.Marshal = function(self, data)
  -- function num : 0_1
  data.pauseType = self.pauseType
  data.param = self.param
end

SBattlePause.Unmarshal = function(self, data)
  -- function num : 0_2
  self.pauseType = data.pauseType
  self.param = data.param
  return true
end

SBattlePause.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.pauseType) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.pauseType) = %s. number required.", type(self.pauseType))
    return false
  end
  if type(self.param) ~= "string" then
    LogErrorFormat("LocalProtocols", "type error!type(self.param) = %s. string required.", type(self.param))
    return false
  end
  return true
end

return SBattlePause

