-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sminidiscountactivityinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SMiniDiscountActivityInfo = dataclass("SMiniDiscountActivityInfo", require("framework.net.protocol"))
SMiniDiscountActivityInfo.ProtocolType = 2748
SMiniDiscountActivityInfo.MaxSize = 65535
SMiniDiscountActivityInfo.id = 0
SMiniDiscountActivityInfo.leftTime = 0
SMiniDiscountActivityInfo.redDot = 0
SMiniDiscountActivityInfo.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SMiniDiscountActivityInfo, _ENV
  ((SMiniDiscountActivityInfo.super).Ctor)(self, client)
  self.goodInfo = ((require("protocols.bean.protocol.shop.mixgoodinfo")).Create)()
end

SMiniDiscountActivityInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (self.goodInfo):Marshal(buffer) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.redDot) then
    return false
  end
  return true
end

SMiniDiscountActivityInfo.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  if not (self.goodInfo):Unmarshal(buffer) then
    return false
  end
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

return SMiniDiscountActivityInfo

