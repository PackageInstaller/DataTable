-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/creceivesweep.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveSweep = dataclass("CReceiveSweep", require("framework.net.protocol"))
CReceiveSweep.ProtocolType = 4137
CReceiveSweep.MaxSize = 65535
CReceiveSweep.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveSweep
  ((CReceiveSweep.super).Ctor)(self, client)
end

CReceiveSweep.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CReceiveSweep.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CReceiveSweep

