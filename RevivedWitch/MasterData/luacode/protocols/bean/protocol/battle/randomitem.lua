-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/randomitem.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local RandomItem = dataclass("RandomItem")
RandomItem.id = 0
RandomItem.key = 0
RandomItem.x = 0
RandomItem.z = 0
RandomItem.status = 0
RandomItem.Ctor = function(self)
  -- function num : 0_0
end

RandomItem.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.x) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.z) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.status) then
    return false
  end
  return true
end

RandomItem.Unmarshal = function(self, buffer)
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

return RandomItem

