-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/suserlineupdata.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SUserLineupData = dataclass("SUserLineupData", require("framework.net.protocol"))
SUserLineupData.ProtocolType = 3506
SUserLineupData.MaxSize = 65535
SUserLineupData.uniqueId = 0
SUserLineupData.rankType = 0
SUserLineupData.rankId = ""
SUserLineupData.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SUserLineupData, _ENV
  ((SUserLineupData.super).Ctor)(self, client)
  self.lineup = ((require("protocols.bean.protocol.ranking.lineup")).Create)()
end

SUserLineupData.Marshal = function(self, buffer)
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
  if not (self.lineup):Marshal(buffer) then
    return false
  end
  return true
end

SUserLineupData.Unmarshal = function(self, buffer)
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
  if not (self.lineup):Unmarshal(buffer) then
    return false
  end
  return ret
end

return SUserLineupData

