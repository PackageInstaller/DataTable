-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/battle/stouchislandevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local STouchIslandEvent = dataclass("STouchIslandEvent", require("framework.net.protocol"))
STouchIslandEvent.ProtocolType = 1984
STouchIslandEvent.MaxSize = 65535
STouchIslandEvent.islandId = 0
STouchIslandEvent.result = 0
STouchIslandEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : STouchIslandEvent
  ((STouchIslandEvent.super).Ctor)(self, client)
  self.awardItems = {}
end

STouchIslandEvent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions, _ENV
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.islandId) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.result) then
    return false
  end
  local length = (table.slen)(self.awardItems)
  if not (ProtocolBufferStaticFunctions.WriteCompactUInt32)(buffer, length) then
    return false
  end
  for i = 1, length do
    if not ((self.awardItems)[i]):Marshal(buffer) then
      return false
    end
  end
  return true
end

STouchIslandEvent.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions, _ENV
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  local length = 0
  ret = (ProtocolBufferStaticFunctions.ReadCompactUInt32)(buffer)
  if not ret then
    return ret
  end
  for i = 1, length do
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R8 in 'UnsetPending'

    (self.awardItems)[i] = ((require("protocols.bean.protocol.item.beans.iteminfo")).Create)()
    if not ((self.awardItems)[i]):Unmarshal(buffer) then
      return false
    end
  end
  return ret
end

return STouchIslandEvent

