-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/charge/creqchargehistory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReqChargeHistory = dataclass("CReqChargeHistory", require("framework.net.protocol"))
CReqChargeHistory.ProtocolType = 3903
CReqChargeHistory.MaxSize = 255
CReqChargeHistory.page = 0
CReqChargeHistory.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReqChargeHistory
  ((CReqChargeHistory.super).Ctor)(self, client)
end

CReqChargeHistory.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.page) then
    return false
  end
  return true
end

CReqChargeHistory.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReqChargeHistory

