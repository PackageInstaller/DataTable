-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/good/sreceiveshoppointreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveShopPointReward = dataclass("SReceiveShopPointReward", require("framework.net.protocol"))
SReceiveShopPointReward.ProtocolType = 3412
SReceiveShopPointReward.MaxSize = 65535
SReceiveShopPointReward.id = 0
SReceiveShopPointReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveShopPointReward
  ((SReceiveShopPointReward.super).Ctor)(self, client)
end

SReceiveShopPointReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

SReceiveShopPointReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveShopPointReward

