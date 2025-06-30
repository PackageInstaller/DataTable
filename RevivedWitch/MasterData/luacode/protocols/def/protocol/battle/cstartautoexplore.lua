-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/cstartautoexplore.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CStartAutoExplore = dataclass("CStartAutoExplore", require("framework.net.protocol"))
CStartAutoExplore.ProtocolType = 1963
CStartAutoExplore.MaxSize = 65535
CStartAutoExplore.zoneId = 0
CStartAutoExplore.dungeonType = 0
CStartAutoExplore.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CStartAutoExplore
  ((CStartAutoExplore.super).Ctor)(self, client)
end

CStartAutoExplore.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.zoneId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.dungeonType) then
    return false
  end
  return true
end

CStartAutoExplore.Unmarshal = function(self, buffer)
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

return CStartAutoExplore

