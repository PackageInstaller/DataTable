-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cunlockhigh.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUnlockHigh = dataclass("CUnlockHigh", require("framework.net.protocol"))
CUnlockHigh.ProtocolType = 2403
CUnlockHigh.MaxSize = 65535
CUnlockHigh.WaitProtocol = "protocol.notify.scancelloading"
CUnlockHigh.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUnlockHigh
  ((CUnlockHigh.super).Ctor)(self, client)
end

CUnlockHigh.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CUnlockHigh.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CUnlockHigh

