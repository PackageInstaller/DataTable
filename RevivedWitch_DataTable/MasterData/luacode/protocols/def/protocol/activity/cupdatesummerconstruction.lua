-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cupdatesummerconstruction.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUpdateSummerConstruction = dataclass("CUpdateSummerConstruction", require("framework.net.protocol"))
CUpdateSummerConstruction.ProtocolType = 2471
CUpdateSummerConstruction.MaxSize = 65535
CUpdateSummerConstruction.ID = 0
CUpdateSummerConstruction.vertical = 0
CUpdateSummerConstruction.abscissa = 0
CUpdateSummerConstruction.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUpdateSummerConstruction
  ((CUpdateSummerConstruction.super).Ctor)(self, client)
end

CUpdateSummerConstruction.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.ID) then
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

CUpdateSummerConstruction.Unmarshal = function(self, buffer)
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

return CUpdateSummerConstruction

