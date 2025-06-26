-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/creceivetaskshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveTaskShop = dataclass("CReceiveTaskShop", require("framework.net.protocol"))
CReceiveTaskShop.ProtocolType = 2699
CReceiveTaskShop.MaxSize = 65535
CReceiveTaskShop.activityId = 0
CReceiveTaskShop.rewardID = 0
CReceiveTaskShop.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveTaskShop
  ((CReceiveTaskShop.super).Ctor)(self, client)
end

CReceiveTaskShop.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.activityId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rewardID) then
    return false
  end
  return true
end

CReceiveTaskShop.Unmarshal = function(self, buffer)
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

return CReceiveTaskShop

