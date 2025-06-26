-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cinterruptsweep.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CInterruptSweep = dataclass("CInterruptSweep", require("framework.net.protocol"))
CInterruptSweep.ProtocolType = 4138
CInterruptSweep.MaxSize = 65535
CInterruptSweep.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CInterruptSweep
  ((CInterruptSweep.super).Ctor)(self, client)
end

CInterruptSweep.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CInterruptSweep.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CInterruptSweep

