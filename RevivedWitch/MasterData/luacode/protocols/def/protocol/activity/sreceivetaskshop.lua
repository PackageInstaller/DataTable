-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sreceivetaskshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SReceiveTaskShop = dataclass("SReceiveTaskShop", require("framework.net.protocol"))
SReceiveTaskShop.ProtocolType = 2700
SReceiveTaskShop.MaxSize = 65535
SReceiveTaskShop.activityId = 0
SReceiveTaskShop.rewardID = 0
SReceiveTaskShop.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SReceiveTaskShop
  ((SReceiveTaskShop.super).Ctor)(self, client)
end

SReceiveTaskShop.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardID) then
    return false
  end
  return true
end

SReceiveTaskShop.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return SReceiveTaskShop

