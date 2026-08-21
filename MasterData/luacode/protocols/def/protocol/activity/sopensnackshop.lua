-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopensnackshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenSnackShop = dataclass("SOpenSnackShop", require("framework.net.protocol"))
SOpenSnackShop.ProtocolType = 2503
SOpenSnackShop.MaxSize = 65535
SOpenSnackShop.isOpen = 0
SOpenSnackShop.leftTime = 0
SOpenSnackShop.waiter = 0
SOpenSnackShop.snack = 0
SOpenSnackShop.used = 0
SOpenSnackShop.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenSnackShop
  ((SOpenSnackShop.super).Ctor)(self, client)
end

SOpenSnackShop.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.isOpen) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.leftTime) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.waiter) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.snack) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.used) then
    return false
  end
  return true
end

SOpenSnackShop.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
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

return SOpenSnackShop

