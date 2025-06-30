-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/good/saddshoppoints.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SAddShopPoints = dataclass("SAddShopPoints", require("framework.net.protocol"))
SAddShopPoints.ProtocolType = 3410
SAddShopPoints.MaxSize = 65535
SAddShopPoints.addScore = 0
SAddShopPoints.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SAddShopPoints
  ((SAddShopPoints.super).Ctor)(self, client)
end

SAddShopPoints.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.addScore) then
    return false
  end
  return true
end

SAddShopPoints.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SAddShopPoints

