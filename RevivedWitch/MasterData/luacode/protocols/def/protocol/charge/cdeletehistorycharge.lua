-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/charge/cdeletehistorycharge.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CDeleteHistoryCharge = dataclass("CDeleteHistoryCharge", require("framework.net.protocol"))
CDeleteHistoryCharge.ProtocolType = 3905
CDeleteHistoryCharge.MaxSize = 255
CDeleteHistoryCharge.gameorderid = 0
CDeleteHistoryCharge.currentpage = 0
CDeleteHistoryCharge.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CDeleteHistoryCharge
  ((CDeleteHistoryCharge.super).Ctor)(self, client)
end

CDeleteHistoryCharge.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.gameorderid) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.currentpage) then
    return false
  end
  return true
end

CDeleteHistoryCharge.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CDeleteHistoryCharge

