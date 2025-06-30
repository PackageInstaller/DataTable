-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/csimplerank.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CSimpleRank = dataclass("CSimpleRank", require("framework.net.protocol"))
CSimpleRank.ProtocolType = 3517
CSimpleRank.MaxSize = 65535
CSimpleRank.rankType = 0
CSimpleRank.rankId = 0
CSimpleRank.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CSimpleRank
  ((CSimpleRank.super).Ctor)(self, client)
end

CSimpleRank.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rankType) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.rankId) then
    return false
  end
  return true
end

CSimpleRank.Unmarshal = function(self, buffer)
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

return CSimpleRank

