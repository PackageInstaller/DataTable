-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/ranking/creceiveweekaward.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CReceiveWeekAward = dataclass("CReceiveWeekAward", require("framework.net.protocol"))
CReceiveWeekAward.ProtocolType = 3522
CReceiveWeekAward.MaxSize = 65535
CReceiveWeekAward.id = 0
CReceiveWeekAward.stageId = 0
CReceiveWeekAward.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CReceiveWeekAward
  ((CReceiveWeekAward.super).Ctor)(self, client)
end

CReceiveWeekAward.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.id) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.stageId) then
    return false
  end
  return true
end

CReceiveWeekAward.Unmarshal = function(self, buffer)
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

return CReceiveWeekAward

