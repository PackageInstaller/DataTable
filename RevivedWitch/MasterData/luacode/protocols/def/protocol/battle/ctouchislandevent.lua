-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/ctouchislandevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CTouchIslandEvent = dataclass("CTouchIslandEvent", require("framework.net.protocol"))
CTouchIslandEvent.ProtocolType = 1983
CTouchIslandEvent.MaxSize = 65535
CTouchIslandEvent.islandID = 0
CTouchIslandEvent.event = 0
CTouchIslandEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CTouchIslandEvent
  ((CTouchIslandEvent.super).Ctor)(self, client)
end

CTouchIslandEvent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.islandID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.event) then
    return false
  end
  return true
end

CTouchIslandEvent.Unmarshal = function(self, buffer)
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

return CTouchIslandEvent

