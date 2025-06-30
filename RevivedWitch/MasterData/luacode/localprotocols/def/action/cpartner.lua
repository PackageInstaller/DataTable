-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/localprotocols/def/action/cpartner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CPartner = dataclass("CPartner")
CPartner.ProtocolType = 32
CPartner.Ctor = function(self, client)
  -- function num : 0_0
end

CPartner.Marshal = function(self, data)
  -- function num : 0_1
end

CPartner.Unmarshal = function(self, data)
  -- function num : 0_2
  return true
end

CPartner.CheckVariable = function(self)
  -- function num : 0_3
  return true
end

return CPartner

