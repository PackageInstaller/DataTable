-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cchoosepointevent.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CChoosePointEvent = dataclass("CChoosePointEvent", require("framework.net.protocol"))
CChoosePointEvent.ProtocolType = 2418
CChoosePointEvent.MaxSize = 65535
CChoosePointEvent.pointID = 0
CChoosePointEvent.eventIndex = 0
CChoosePointEvent.eventChoice = 0
CChoosePointEvent.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CChoosePointEvent
  ((CChoosePointEvent.super).Ctor)(self, client)
end

CChoosePointEvent.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pointID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.eventIndex) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.eventChoice) then
    return false
  end
  return true
end

CChoosePointEvent.Unmarshal = function(self, buffer)
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

return CChoosePointEvent

