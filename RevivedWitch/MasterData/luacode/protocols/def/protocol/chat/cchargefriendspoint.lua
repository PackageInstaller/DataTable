-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/chat/cchargefriendspoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChargeFriendsPoint = dataclass("CChargeFriendsPoint", require("framework.net.protocol"))
CChargeFriendsPoint.ProtocolType = 1156
CChargeFriendsPoint.MaxSize = 65535
CChargeFriendsPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChargeFriendsPoint
  ((CChargeFriendsPoint.super).Ctor)(self, client)
end

CChargeFriendsPoint.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CChargeFriendsPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CChargeFriendsPoint

