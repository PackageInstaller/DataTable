-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/cuserlineupdata.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUserLineupData = dataclass("CUserLineupData", require("framework.net.protocol"))
CUserLineupData.ProtocolType = 3505
CUserLineupData.MaxSize = 65535
CUserLineupData.uniqueId = 0
CUserLineupData.rankType = 0
CUserLineupData.rankId = ""
CUserLineupData.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUserLineupData
  ((CUserLineupData.super).Ctor)(self, client)
end

CUserLineupData.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt64)(buffer, self.uniqueId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rankType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteProtocolString)(buffer, self.rankId) then
    return false
  end
  return true
end

CUserLineupData.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt64)(buffer)
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
  return ret
end

return CUserLineupData

