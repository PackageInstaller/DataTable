-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cmovesummerconstruction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CMoveSummerConstruction = dataclass("CMoveSummerConstruction", require("framework.net.protocol"))
CMoveSummerConstruction.ProtocolType = 2475
CMoveSummerConstruction.MaxSize = 65535
CMoveSummerConstruction.construction = 0
CMoveSummerConstruction.vertical = 0
CMoveSummerConstruction.abscissa = 0
CMoveSummerConstruction.RECLAIM = 999
CMoveSummerConstruction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CMoveSummerConstruction
  ((CMoveSummerConstruction.super).Ctor)(self, client)
end

CMoveSummerConstruction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.construction) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.vertical) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.abscissa) then
    return false
  end
  return true
end

CMoveSummerConstruction.Unmarshal = function(self, buffer)
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
  return ret
end

return CMoveSummerConstruction

