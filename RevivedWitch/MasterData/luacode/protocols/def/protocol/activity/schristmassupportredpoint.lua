-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/schristmassupportredpoint.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SChristmasSupportRedPoint = dataclass("SChristmasSupportRedPoint", require("framework.net.protocol"))
SChristmasSupportRedPoint.ProtocolType = 2572
SChristmasSupportRedPoint.MaxSize = 65535
SChristmasSupportRedPoint.STAGE = 1
SChristmasSupportRedPoint.TOTAL_CALL = 2
SChristmasSupportRedPoint.RANKING = 3
SChristmasSupportRedPoint.FREE_GOOD = 4
SChristmasSupportRedPoint.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SChristmasSupportRedPoint
  ((SChristmasSupportRedPoint.super).Ctor)(self, client)
  self.state = {}
end

SChristmasSupportRedPoint.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : _ENV, ProtocolBufferStaticFunctions
  local length = (table.slen)(self.state)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, (self.state)[i]) then
      return false
    end
  end
  return true
end

SChristmasSupportRedPoint.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

    ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
    if not ret then
      return ret
    end
  end
  return ret
end

return SChristmasSupportRedPoint

