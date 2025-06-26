-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/sbattleresult.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SBattleResult = dataclass("SBattleResult")
SBattleResult.ProtocolType = 17
SBattleResult.type = 0
SBattleResult.isjoin = 0
SBattleResult.Ctor = function(self, client)
  -- function num : 0_0
end

SBattleResult.Marshal = function(self, data)
  -- function num : 0_1
  data.type = self.type
  data.isjoin = self.isjoin
end

SBattleResult.Unmarshal = function(self, data)
  -- function num : 0_2
  self.type = data.type
  self.isjoin = data.isjoin
  return true
end

SBattleResult.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  if type(self.isjoin) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.isjoin) = %s. number required.", type(self.isjoin))
    return false
  end
  return true
end

return SBattleResult

