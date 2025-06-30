-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/good/creceiveshoppointreward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveShopPointReward = dataclass("CReceiveShopPointReward", require("framework.net.protocol"))
CReceiveShopPointReward.ProtocolType = 3411
CReceiveShopPointReward.MaxSize = 65535
CReceiveShopPointReward.id = 0
CReceiveShopPointReward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveShopPointReward
  ((CReceiveShopPointReward.super).Ctor)(self, client)
end

CReceiveShopPointReward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  return true
end

CReceiveShopPointReward.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CReceiveShopPointReward

