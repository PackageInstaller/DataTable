-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/srougetowerchoicebuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local SRougeTowerChoiceBuff = dataclass("SRougeTowerChoiceBuff", require("framework.net.protocol"))
SRougeTowerChoiceBuff.ProtocolType = 2449
SRougeTowerChoiceBuff.MaxSize = 65535
SRougeTowerChoiceBuff.pointID = 0
SRougeTowerChoiceBuff.choiceBuff = 0
SRougeTowerChoiceBuff.choiceResult = 0
SRougeTowerChoiceBuff.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : SRougeTowerChoiceBuff
  ((SRougeTowerChoiceBuff.super).Ctor)(self, client)
end

SRougeTowerChoiceBuff.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pointID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.choiceBuff) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.choiceResult) then
    return false
  end
  return true
end

SRougeTowerChoiceBuff.Unmarshal = function(self, buffer)
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

return SRougeTowerChoiceBuff

