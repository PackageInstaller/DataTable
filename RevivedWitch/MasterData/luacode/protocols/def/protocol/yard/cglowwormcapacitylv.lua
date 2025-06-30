-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/yard/cglowwormcapacitylv.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGlowwormCapacityLv = dataclass("CGlowwormCapacityLv", require("framework.net.protocol"))
CGlowwormCapacityLv.ProtocolType = 2340
CGlowwormCapacityLv.MaxSize = 65535
CGlowwormCapacityLv.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGlowwormCapacityLv
  ((CGlowwormCapacityLv.super).Ctor)(self, client)
end

CGlowwormCapacityLv.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CGlowwormCapacityLv.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CGlowwormCapacityLv

