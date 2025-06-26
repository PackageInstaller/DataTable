-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenbackgift.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenBackGift = dataclass("SOpenBackGift", require("framework.net.protocol"))
SOpenBackGift.ProtocolType = 2554
SOpenBackGift.MaxSize = 65535
SOpenBackGift.leftTime = 0
SOpenBackGift.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenBackGift, _ENV
  ((SOpenBackGift.super).Ctor)(self, client)
  self.goodInfo = ((require("protocols.bean.protocol.activity.goodinfo")).Create)()
end

SOpenBackGift.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (self.goodInfo):Marshal(buffer) then
    return false
  end
  return true
end

SOpenBackGift.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  if not (self.goodInfo):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SOpenBackGift

