-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/sopenchristmasdinner.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SOpenChristmasDinner = dataclass("SOpenChristmasDinner", require("framework.net.protocol"))
SOpenChristmasDinner.ProtocolType = 2531
SOpenChristmasDinner.MaxSize = 65535
SOpenChristmasDinner.isOpen = 0
SOpenChristmasDinner.leftTime = 0
SOpenChristmasDinner.waiter = 0
SOpenChristmasDinner.snack = 0
SOpenChristmasDinner.used = 0
SOpenChristmasDinner.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SOpenChristmasDinner
  ((SOpenChristmasDinner.super).Ctor)(self, client)
end

SOpenChristmasDinner.Marshal = function(self, buffer)
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

SOpenChristmasDinner.Unmarshal = function(self, buffer)
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

return SOpenChristmasDinner

