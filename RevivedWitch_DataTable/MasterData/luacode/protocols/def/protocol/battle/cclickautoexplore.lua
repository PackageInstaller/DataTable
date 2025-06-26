-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cclickautoexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CClickAutoExplore = dataclass("CClickAutoExplore", require("framework.net.protocol"))
CClickAutoExplore.ProtocolType = 4122
CClickAutoExplore.MaxSize = 65535
CClickAutoExplore.zoneId = 0
CClickAutoExplore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CClickAutoExplore
  ((CClickAutoExplore.super).Ctor)(self, client)
end

CClickAutoExplore.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.zoneId) then
    return false
  end
  return true
end

CClickAutoExplore.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CClickAutoExplore

