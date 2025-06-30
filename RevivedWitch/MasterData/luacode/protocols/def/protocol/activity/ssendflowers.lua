-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/ssendflowers.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SSendFlowers = dataclass("SSendFlowers", require("framework.net.protocol"))
SSendFlowers.ProtocolType = 2601
SSendFlowers.MaxSize = 65535
SSendFlowers.rewardType = 0
SSendFlowers.flowerScore = 0
SSendFlowers.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SSendFlowers
  ((SSendFlowers.super).Ctor)(self, client)
end

SSendFlowers.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.flowerScore) then
    return false
  end
  return true
end

SSendFlowers.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SSendFlowers

