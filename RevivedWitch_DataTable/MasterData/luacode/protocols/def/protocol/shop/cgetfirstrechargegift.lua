-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/shop/cgetfirstrechargegift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CGetFirstRechargeGift = dataclass("CGetFirstRechargeGift", require("framework.net.protocol"))
CGetFirstRechargeGift.ProtocolType = 3631
CGetFirstRechargeGift.MaxSize = 65535
CGetFirstRechargeGift.gainGiftID = 0
CGetFirstRechargeGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CGetFirstRechargeGift
  ((CGetFirstRechargeGift.super).Ctor)(self, client)
end

CGetFirstRechargeGift.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.gainGiftID) then
    return false
  end
  return true
end

CGetFirstRechargeGift.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CGetFirstRechargeGift

