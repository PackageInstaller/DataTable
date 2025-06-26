-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/bean/protocol/battle/exploreawardrecord.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local ExploreAwardRecord = dataclass("ExploreAwardRecord")
ExploreAwardRecord.id = 0
ExploreAwardRecord.key = 0
ExploreAwardRecord.num = 0
ExploreAwardRecord.way = 0
ExploreAwardRecord.BOX = 1
ExploreAwardRecord.BATTLE = 2
ExploreAwardRecord.TASK = 3
ExploreAwardRecord.GROUND = 4
ExploreAwardRecord.Ctor = function(self)
  -- function num : 0_0
end

ExploreAwardRecord.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.num) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.way) then
    return false
  end
  return true
end

ExploreAwardRecord.Unmarshal = function(self, buffer)
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
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return ExploreAwardRecord

