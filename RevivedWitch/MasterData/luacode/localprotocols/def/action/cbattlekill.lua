-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/cbattlekill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBattleKill = dataclass("CBattleKill")
CBattleKill.ProtocolType = 27
CBattleKill.type = 0
CBattleKill.Ctor = function(self, client)
  -- function num : 0_0
end

CBattleKill.Marshal = function(self, data)
  -- function num : 0_1
  data.type = self.type
end

CBattleKill.Unmarshal = function(self, data)
  -- function num : 0_2
  self.type = data.type
  return true
end

CBattleKill.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.type) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.type) = %s. number required.", type(self.type))
    return false
  end
  return true
end

return CBattleKill

