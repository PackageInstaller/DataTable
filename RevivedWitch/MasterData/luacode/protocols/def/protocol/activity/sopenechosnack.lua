-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenechosnack.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenEchoSnack = dataclass("SOpenEchoSnack", require("framework.net.protocol"))
SOpenEchoSnack.ProtocolType = 2709
SOpenEchoSnack.MaxSize = 65535
SOpenEchoSnack.isOpen = 0
SOpenEchoSnack.leftTime = 0
SOpenEchoSnack.waiter = 0
SOpenEchoSnack.snack = 0
SOpenEchoSnack.used = 0
SOpenEchoSnack.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenEchoSnack
  ((SOpenEchoSnack.super).Ctor)(self, client)
end

SOpenEchoSnack.Marshal = function(self, buffer)
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

SOpenEchoSnack.Unmarshal = function(self, buffer)
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

return SOpenEchoSnack

