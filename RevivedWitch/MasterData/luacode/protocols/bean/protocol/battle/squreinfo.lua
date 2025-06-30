-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/squreinfo.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SqureInfo = dataclass("SqureInfo")
SqureInfo.squreType = 0
SqureInfo.squreShow = 0
SqureInfo.eventID = ""
SqureInfo.rPos = 0
SqureInfo.lPos = 0
SqureInfo.north = 0
SqureInfo.sorth = 0
SqureInfo.east = 0
SqureInfo.west = 0
SqureInfo.squreState = 0
SqureInfo.Ctor = function(self)
  -- function num : 0_0
end

SqureInfo.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.squreType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.squreShow) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.eventID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rPos) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.lPos) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.north) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.sorth) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.east) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.west) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.squreState) then
    return false
  end
  return true
end

SqureInfo.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadProtocolString)(buffer)
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

return SqureInfo

