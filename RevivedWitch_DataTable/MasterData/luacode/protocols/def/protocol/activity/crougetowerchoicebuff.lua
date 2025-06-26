-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/crougetowerchoicebuff.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CRougeTowerChoiceBuff = dataclass("CRougeTowerChoiceBuff", require("framework.net.protocol"))
CRougeTowerChoiceBuff.ProtocolType = 2448
CRougeTowerChoiceBuff.MaxSize = 65535
CRougeTowerChoiceBuff.pointID = 0
CRougeTowerChoiceBuff.buffChoice = 0
CRougeTowerChoiceBuff.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CRougeTowerChoiceBuff
  ((CRougeTowerChoiceBuff.super).Ctor)(self, client)
end

CRougeTowerChoiceBuff.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.pointID) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.buffChoice) then
    return false
  end
  return true
end

CRougeTowerChoiceBuff.Unmarshal = function(self, buffer)
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

return CRougeTowerChoiceBuff

