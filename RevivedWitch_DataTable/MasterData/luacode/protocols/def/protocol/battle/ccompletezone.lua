-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ccompletezone.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CCompleteZone = dataclass("CCompleteZone", require("framework.net.protocol"))
CCompleteZone.ProtocolType = 1957
CCompleteZone.MaxSize = 65535
CCompleteZone.floorId = 0
CCompleteZone.outPoint = 0
CCompleteZone.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CCompleteZone
  ((CCompleteZone.super).Ctor)(self, client)
end

CCompleteZone.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.floorId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.outPoint) then
    return false
  end
  return true
end

CCompleteZone.Unmarshal = function(self, buffer)
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

return CCompleteZone

