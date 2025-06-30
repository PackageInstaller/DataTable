-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/spartner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SPartner = dataclass("SPartner")
SPartner.ProtocolType = 33
SPartner.count = 0
SPartner.Ctor = function(self, client)
  -- function num : 0_0
end

SPartner.Marshal = function(self, data)
  -- function num : 0_1
  data.count = self.count
end

SPartner.Unmarshal = function(self, data)
  -- function num : 0_2
  self.count = data.count
  return true
end

SPartner.CheckVariable = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if type(self.count) ~= "number" then
    LogErrorFormat("LocalProtocols", "type error!type(self.count) = %s. number required.", type(self.count))
    return false
  end
  return true
end

return SPartner

